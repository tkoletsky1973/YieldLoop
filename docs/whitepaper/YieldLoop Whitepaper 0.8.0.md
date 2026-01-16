# YieldLoop Protocol
## Developer Specification (MasterVault + SubVault Strategy System)

**Document Type:** Engineering Whitepaper / Build Specification  
**Status:** Draft (Dev-Ready)  
**Version:** v0.8.0  
**Date:** January 15, 2026  
**Author:** Todd Koletsky  

---

## Protocol Identity (Canonical Summary)

YieldLoop is a **non-custodial, user-owned vault protocol** on **BNB Smart Chain (BSC)** that attempts to generate **realized stablecoin profit** by executing two complementary strategy classes:

1) **Dynamic Band / Grid Trading** (volatility harvesting)  
2) **Cross-DEX Arbitrage** between **PancakeSwap (PCS)** and **BiSwap**

User funds are tracked through a **MasterVault → SubVault** accounting model:

- **MasterVault (UserAccountVault)** holds the user’s stablecoin balance, idle cash buffer, and end-of-cycle settlement ledger.
- **SubVaults (StrategyVaultBuckets)** are internal strategy allocations (asset + strategy mode + config hash) used to execute trades and attribute realized profit/loss.

The protocol operates in a **deterministic fixed 30-day cycle**. Profit is only counted when it is:
- realized in stablecoin
- net of execution costs
- stored in the Profit Buffer
- settled deterministically at cycle end

YieldLoop does **not** promise returns, does **not** smooth yield, and does **not** claim profit that is not realized.

---

## System Scope (Hard Constraints)

### Chain + execution venues
- **Chain:** BNB Smart Chain (BSC)
- **DEX venues:** PancakeSwap (PCS), BiSwap (only)
- **Execution type:** Spot swaps only (no leverage, no perps)

### Traded assets (allowlisted BEP-20 only)
The protocol may trade only Governance/Admin allowlisted BEP-20 assets, including:

- BTC (BTCB)
- ETH (Binance-Peg ETH)
- XRP (BEP-20)
- BNB
- SOL (BEP-20)

> Symbols are used for readability. Implementation MUST reference exact contract addresses and allowlisted pool/router pairs only.

### Deposit + allocation rules
- Deposit asset: allowlisted stablecoin (e.g., USDT/USDC)
- **Minimum MasterVault deposit:** $250
- **Minimum per SubVault allocation:** $100
- Unallocated funds remain in the **MasterVault Cash Buffer**

---

## Key Modules (High-Level)

- MasterVault (UserAccountVault)
- SubVault (StrategyVaultBucket)
- Strategy Router
- Grid/Band Trading Engine
- Cross-DEX Arbitrage Engine
- Oracle Adapter (Price Sanity)
- Execution Guardrails / Circuit Breakers
- Profit Buffer
- Fee Router
- Settlement Engine
- Genesis Program (Founding Depositor System)
- Referral Program (GenesisBadge-Gated)
- MarketingRewardsVault (Referral Funding Pool)
- Event Log / Proof Dashboard Hooks

---

## Table of Contents (Simplified — Full)

1. Executive Overview (Engineering Brief)
2. Protocol Scope + Non-Negotiable Invariants
3. System Architecture Overview (MasterVault → SubVault Model)
4. Contract Suite (Modules + Responsibilities)
5. Lifecycle State Machine (Fixed 30-Day Cycle)

6. MasterVault Specification
7. SubVault Specification
8. Strategy Router Specification

9. Trading Engines
   - 9.1 Grid/Band Engine
   - 9.2 Cross-DEX Arbitrage Engine

10. Oracle + Price Sanity
11. Execution Guardrails + Safety Controls
12. Profit Accounting (Realized Profit Only) + Profit Buffer
13. Fees + Fee Routing

14. Settlement Engine (End-of-Cycle Accounting)
15. User Claims, Compounding, and Withdrawals

16. Governance/Admin Controls (Allowlists, Bounds, Emergency)
17. Genesis Program (Founding Depositor System)
18. Referral Program (GenesisBadge-Gated)

19. Events, Proof, and Observability (Auditability Hooks)
20. Security Considerations (Threat Model + Failure Modes)

---

# 1. Executive Overview (Engineering Brief)

YieldLoop is a **non-custodial, user-owned vault protocol** deployed on **BNB Smart Chain (BSC)**. The protocol attempts to generate **realized stablecoin profit** by executing two controlled strategy classes on allowlisted BEP-20 assets:

1) **Dynamic Band / Grid Trading (Primary Engine)**  
2) **Cross-DEX Arbitrage between PancakeSwap (PCS) and BiSwap (Secondary Engine)**

This document is not marketing. It is an engineering build spec intended to be sufficiently explicit for:
- smart contract implementation
- keeper/executor implementation
- protocol QA and invariant testing
- third-party audit review

The protocol is intentionally designed to be:

- **Deterministic:** fixed-cycle settlement and auditable accounting outputs  
- **Conservative:** profit is not credited unless realized in stablecoin  
- **Safety-first:** trades revert or skip; protocol is allowed to do nothing  
- **Upgradeable safely:** all configurable parameters are bound-checked  
- **Observable:** event-first design enables proof dashboards and monitoring  

YieldLoop uses a **MasterVault → SubVault** architecture:

- **MasterVault (UserAccountVault)** is the canonical ledger for user principal, allocations, and settlement.
- **SubVaults (StrategyVaultBuckets)** are isolated strategy buckets used to execute trades and attribute profit/loss outcomes back to the MasterVault ledger.

The protocol runs a **fixed 30-day cycle**. During the active cycle:
- user allocations are locked
- principal cannot be withdrawn
- no “instant yield” is claimable
- accounting is finalized only during end-of-cycle settlement

YieldLoop does not promise returns. It does not emit token rewards to simulate yield. It does not smooth yield across users. If market conditions are unfavorable, the protocol may:
- execute fewer trades
- execute zero trades
- produce a low-yield month
- produce a zero-yield month

This is expected behavior and is required to preserve accounting integrity.

---

# 2. Protocol Scope + Non-Negotiable Invariants

## 2.1 Chain + venue restrictions

YieldLoop is constrained to:

- **Chain:** BNB Smart Chain (BSC)
- **DEX execution venues:** PancakeSwap (PCS) and BiSwap only
- **Execution type:** spot swaps only
- **No leverage, no borrowing, no perps, no margin**
- **No cross-chain execution in v0.8.0**

All swap execution MUST occur through allowlisted router contracts and allowlisted liquidity pools.

## 2.2 Allowlisted assets only (BEP-20)

YieldLoop trades only Governance/Admin allowlisted BEP-20 assets. This spec references assets by symbol for readability, but implementation MUST use contract addresses and a strict allowlist registry.

Initial asset universe target:

- BTC (BTCB)
- ETH (Binance-Peg ETH)
- XRP (BEP-20)
- BNB
- SOL (BEP-20)

**Hard rule:** any token, pool, or router not allowlisted MUST revert.

## 2.3 Deposit and allocation rules

### Deposit asset
Deposits are made in allowlisted stablecoin assets (e.g., USDT/USDC).

### Minimums
- **Minimum MasterVault deposit:** $250 (or stable-equivalent)
- **Minimum allocation per SubVault:** $100

Unallocated stablecoin remains in the MasterVault as **Idle Cash Buffer**.

### Allocation timing constraint
Allocation MUST occur only:
- at initial deposit time (if user is not in active cycle), OR
- during the post-settlement window (cycle boundary)

Mid-cycle reallocations are disallowed in the baseline design because they:
- complicate deterministic settlement
- create gaming opportunities
- increase keeper execution complexity

## 2.4 Accounting and truth rules (invariants)

These invariants define what is “true” in protocol accounting.

### Invariant A — Realized Profit Only
Profit is only considered profit when:

- stablecoin is realized (swap closed)
- proceeds exceed basis + execution costs
- profit is isolated in a dedicated accounting compartment (Profit Buffer)
- profit is finalized in settlement output

Unrealized gains and token inventory appreciation are NOT “profit.”

### Invariant B — No Yield Smoothing
YieldLoop MUST NOT:
- credit profit that was not realized
- average profit across users
- pay users using other user principal
- fabricate APY

### Invariant C — Negative-EV Trades Must Not Execute
A trade attempt MUST NOT execute unless the protocol simulates:

`ExpectedProfitStable ≥ MinNetProfitThreshold`

Where expected profit includes:
- DEX fees
- slippage / price impact
- gas costs
- routing costs (if any)

### Invariant D — Deterministic Settlement
At cycle end, each user MUST be able to produce:
- a deterministic accounting summary of principal and realized profits
- fee routing only based on realized profit
- a final claimable profit amount

Settlement must be repeatable, auditable, and event logged.

### Invariant E — Safety Overrides Strategy
If strategy selection conflicts with safety constraints, safety wins.
The correct output is:
- NO_TRADE
- PAUSE
- DISABLE_ASSET
- SETTLEMENT_ONLY

not forced execution.

---

# 3. Actors and System Roles

YieldLoop defines explicit roles so engineers can reason about permissions, trust boundaries, and the intended threat model.

## 3.1 User (Depositor / Vault Owner)

The user is the only party who:
- provides principal capital
- approves deposit and allocation choices
- chooses cycle actions (claim/compound/withdraw)

The user interacts through:
- UI frontend (off-chain)
- MasterVault on-chain functions (deposit/allocate/claim)

During an active cycle the user CANNOT:
- withdraw principal
- rebalance between SubVaults
- force the protocol to execute trades

## 3.2 Keeper / Executor (Trade Caller)

The keeper is an external actor that performs periodic calls such as:
- `execute()` (trade attempts)
- `settle()` (cycle settlement attempt)
- `harvest()` or `unwind()` (if defined)

A keeper:
- has NO custody authority
- cannot withdraw user funds
- cannot redirect funds to arbitrary addresses
- can only trigger protocol-defined functions which enforce invariants

YieldLoop assumes keeper calls can be adversarial or unreliable, therefore:
- execution must be permissionless or permissioned-with-redundancy
- all calls must validate guardrails on-chain
- no off-chain keeper decision may bypass on-chain rules

## 3.3 Governance / Admin (Parameter + Allowlist Authority)

Governance/Admin controls:
- allowlisted assets and pools
- router allowlists
- strategy configuration bounds
- emergency pause controls
- upgrade paths

Because governance can be compromised or vote-captured, the protocol must enforce:
- parameter bounds (min/max)
- rate limits (where applicable)
- timelocks (recommended)
- emergency overrides with transparent event logs

Governance/Admin MUST NOT be able to:
- seize user funds
- redirect user funds

## 3.4 Oracle Sources / Price Sanity Layer

YieldLoop uses oracle logic as a **sanity filter**, not as a discretionary trading signal.

Oracle inputs may include:
- TWAP calculations from PCS/BiSwap pools
- median-of-venues price estimates
- outlier rejection windows
- stale price rejection windows

Oracle failures MUST default to:
- NO_TRADE
- settlement-safe behavior

not forced execution.

## 3.5 External DEX Venues

PancakeSwap and BiSwap are treated as:
- external systems
- hostile execution environments (MEV risk exists)
- variable liquidity environments

Therefore every swap must enforce:
- max slippage constraints
- minimum expected output constraints
- allowlist pool routing only

---

# 4. System Architecture Overview (MasterVault → SubVault Model)

## 4.1 Architectural objective

YieldLoop’s design objective is to support multi-asset, multi-strategy execution while maintaining:

- deterministic accounting
- bounded complexity
- safety-first execution
- predictable settlement behavior
- ability to add assets over time without rewriting the protocol

This is accomplished via a MasterVault accounting layer and SubVault execution buckets.

## 4.2 MasterVault (UserAccountVault)

The MasterVault is the canonical user ledger contract.

### MasterVault responsibilities
- accept stablecoin deposits
- enforce minimum deposit amount
- maintain principal ledger (per user)
- maintain cash buffer ledger
- maintain SubVault allocation ledger
- lock allocations for the active cycle
- receive credited realized profit from SubVaults
- expose end-of-cycle claim functions
- produce settlement events and reportable data

### MasterVault does NOT:
- trade
- route swaps directly
- hold non-allowlisted assets
- accept non-allowlisted deposits

### MasterVault accounting compartments
MasterVault maintains at minimum:
- `PrincipalBalance`
- `IdleCashBuffer`
- `AllocatedToSubVaults[assetId][mode]`
- `ProfitBuffer`
- `ClaimedProfitHistory`
- `CycleState`

These compartments support strict separation of:
- principal
- active deployed capital
- realized profits

## 4.3 SubVaults (StrategyVaultBuckets)

SubVaults are strategy execution buckets that represent:
- a specific asset target (BTC/ETH/XRP/BNB/SOL)
- a specific execution mode (GRID / ARB / AUTO)
- a configuration hash/ID (governance-approved parameters)

SubVaults execute trading operations and report outcomes.

### SubVault responsibilities
- execute swaps via allowlisted routers/pools only
- enforce exposure caps and safety rules
- track basis/inventory for grid execution
- compute realized stablecoin profit from completed trades
- send realized profit to MasterVault ProfitBuffer (or credit via accounting call)
- emit trade events for audit/proof

### Minimum allocation constraint
Each SubVault must hold allocation ≥ $100.
Allocations below minimum MUST revert.

This prevents:
- dust
- gas bleed
- meaningless micro-trading
- unbounded allocation fragmentation

## 4.4 Strategy Router (Engine Selector)

The StrategyRouter selects the trade path given current conditions.

### Router inputs
- user risk mode
- SubVault states
- oracle sanity flags
- liquidity snapshots
- gas constraints
- configured thresholds

### Router outputs
- `GRID_MODE(assetId, tradeSize, params)`
- `ARB_MODE(assetId, tradeSize, params)`
- `NO_TRADE`

**Important:** NO_TRADE is not failure. It is correct behavior when expected value is insufficient or safety conditions are not met.

## 4.5 Why this model (and why not single-asset-only vaults)

A pure “one vault per asset” design is simpler on-chain, but produces:
- poor UX (multiple deposits, multiple cycles)
- fragmented idle cash
- redundant settlement processes

The MasterVault/SubVault model enables:
- a single deposit entry point
- controlled allocation into multiple strategies
- deterministic cycle settlement across a portfolio
- scalable future addition of allowlisted assets

## 4.6 Scalability rule: add assets safely

To add additional assets over time, the protocol MUST NOT rely on symbol-based assumptions.
Instead, governance adds:

- token contract address
- PCS pool address(s)
- BiSwap pool address(s)
- approved router addresses
- per-asset slippage limits
- per-asset minimum liquidity thresholds
- per-asset max trade sizing constraints

This prevents:
- fake token attacks
- thin-liquidity traps
- governance misconfiguration blowups

---

# 5. Contract Suite (Modules + Responsibilities)

This section defines the contract/module architecture at the level required for implementation, auditing, and test planning.

YieldLoop is designed as a **modular contract suite** where:
- user accounting is centralized in the **MasterVault**
- execution is performed inside **SubVaults**
- decision logic is isolated in **StrategyRouter**
- safety constraints are enforced via **OracleAdapter** + **ExecutionGuardrails**
- fee logic is handled by a dedicated **FeeRouter**
- deterministic month-end accounting is produced by **SettlementEngine**
- Genesis/Referral programs are isolated from core trading logic

> **Design rule:** Core trading logic MUST NOT be polluted by marketing programs.  
> Genesis and referrals integrate via clean interfaces so they cannot corrupt accounting truth.

---

## 5.1 MasterVault (UserAccountVault)

### Purpose
MasterVault is the canonical state and accounting contract for a user.

### Responsibilities
MasterVault MUST:

- accept allowlisted stablecoin deposits
- enforce minimum deposit rules
- maintain principal ledger
- maintain allocation ledger across SubVaults
- manage Idle Cash Buffer
- manage Profit Buffer (realized stablecoin only)
- enforce cycle lock rules (no mid-cycle reallocation)
- expose claim/compound/withdraw functions
- emit settlement outputs and accounting events

### Non-responsibilities
MasterVault MUST NOT:
- trade
- perform swaps
- route swaps
- accept non-allowlisted tokens

### Key state
At minimum, MasterVault stores:

- `principalBalance`
- `idleCashBalance`
- `profitBufferBalance`
- `allocations[subVaultId]`
- `cycleState`
- `cycleStartTimestamp`
- `cycleEndTimestamp`
- `lastSettlementTimestamp`
- `userPreferences` (compound/withdraw options)

### Key functions (high-level)
- `deposit(amount, stableToken)`
- `allocate(subVaultId, amount)`
- `startCycle()` (explicit or implicit)
- `claimProfit()`
- `rollProfitIntoPrincipal()` (compound)
- `withdrawPrincipal()` (cycle boundary only)
- `settle()` (callable by keeper)
- `getSettlementReport()`

---

## 5.2 SubVault (StrategyVaultBucket)

### Purpose
A SubVault executes a defined strategy on an allowlisted asset under strict risk bounds.

A SubVault is defined by a tuple:
- `assetId`
- `mode` (GRID / ARB / AUTO)
- `configHash` (governance-approved parameter set)
- `venueAccess` (PCS + BiSwap allowlist)

### Responsibilities
SubVault MUST:
- receive allocation from MasterVault
- perform swaps using allowlisted routers/pools only
- enforce per-asset slippage limits
- enforce max exposure / max inventory rules
- enforce cooldown/gas discipline
- maintain position basis accounting (required for grid)
- send realized stablecoin profit back to MasterVault Profit Buffer
- emit events for each trade and outcome

### SubVault internal accounting
Each SubVault MUST track:
- `allocatedStable`
- `deployedStable`
- `tokenInventory`
- `weightedBasis`
- `realizedProfitStable`
- `unrealizedPosition` (non-claimable)
- `exposureRatio`
- `cooldownUntil`

### Key functions (high-level)
- `executeTrade(action)` (keeper-called)
- `simulateTrade(action)` (view; optional)
- `harvestProfit()` (push realized stable to MasterVault)
- `unwindForSettlement()` (if settlement requires)
- `pause()` / `resume()` (admin)

---

## 5.3 StrategyRouter

### Purpose
StrategyRouter selects whether the system should trade, and if so:
- which engine
- which asset bucket
- what size and parameters

It acts as a decision layer, but MUST be constrained by hard safety rules.

### Responsibilities
Router MUST:
- evaluate oracle sanity
- evaluate venue liquidity conditions
- evaluate gas conditions
- evaluate existing inventory exposure
- ensure expected net profit thresholds are met
- output a bounded action or NO_TRADE

### Outputs
Router MUST output exactly one of:
- `GRID_MODE(assetId, tradeSize, params)`
- `ARB_MODE(assetId, tradeSize, params)`
- `NO_TRADE`

### Router cannot override
Router MUST NOT be able to override:
- allowlist restrictions
- guardrail checks
- exposure caps
- slippage caps

Guardrails win over router.

---

## 5.4 Grid/Band Engine

### Purpose
Execute bounded volatility harvesting for allowlisted assets.

### Responsibilities
Grid engine MUST implement:
- band calculation
- buy/sell trigger checks
- minimum net profit thresholds
- inventory caps
- trend-break protection
- cooldown rules

### Notes
Grid does not require venue divergence.
Grid requires careful drawdown handling, therefore:
- buy behavior MUST pause in breakdown states
- exposure MUST be capped
- settlement MUST be able to unwind safely

---

## 5.5 Arbitrage Engine (PCS ↔ BiSwap)

### Purpose
Capture net positive spread between PancakeSwap and BiSwap.

### Responsibilities
Arbitrage engine MUST:
- compute buy quote on venue A
- compute sell quote on venue B
- simulate full trade net of:
  - swap fees
  - price impact
  - slippage bounds
  - gas cost
- execute only if net profit threshold is satisfied

### Hard rule
Arbitrage engine MUST NOT execute if:
- spread is insufficient after costs
- quotes fail oracle sanity
- liquidity is below minimum thresholds

---

## 5.6 OracleAdapter (Price Sanity Layer)

### Purpose
OracleAdapter is a sanity filter to prevent manipulation and stale inputs.

### Responsibilities
OracleAdapter MUST:
- reject stale pricing windows
- reject outlier price deviations
- optionally compute TWAP for allowlisted pools
- optionally compute median price across venues

### Failure behavior
Oracle failure MUST default to:
- `NO_TRADE`
- settlement-safe behavior

Oracle must never force a trade.

---

## 5.7 ExecutionGuardrails

### Purpose
Universal enforcement layer that ensures unsafe trades cannot execute.

### Responsibilities
Guardrails MUST include:
- max slippage limits per asset
- minimum liquidity thresholds per pool
- max gas spend per attempt
- max trade size per asset
- cooldown enforcement
- circuit breaker triggers

### Circuit breakers (examples)
- oracle deviation too high
- slippage too high
- repeated failed trades
- gas spikes beyond allowed cap
- pool liquidity collapse
- suspicious price movement

---

## 5.8 FeeRouter

### Purpose
FeeRouter takes protocol fees only from **realized profit**, then routes them to configured destinations.

### Responsibilities
- compute fee only when profit is realized
- route fees deterministically
- emit fee events

### Hard rule
Fees MUST NOT be taken from principal.

---

## 5.9 Profit Buffer

### Purpose
Profit Buffer is the compartment holding realized stablecoin profit prior to claim/compound.

### Rules
- profit enters buffer only after realized stablecoin outcomes
- buffer is claimable only after settlement finalization
- buffer is segregated from principal

---

## 5.10 SettlementEngine

### Purpose
At cycle end, SettlementEngine produces deterministic accounting outputs and finalizes claimable profit.

### Responsibilities
- validate settlement preconditions
- harvest/unwind where required
- compute realized profit totals
- trigger fee routing
- finalize claimable balances
- emit settlement report events

---

## 5.11 Governance/Admin Config

### Purpose
Single source of truth for:
- allowlists
- parameter bounds
- enable/disable flags
- upgrade references

### Governance must manage allowlists for:
- token contracts
- pool addresses
- router contracts
- per-asset limits:
  - slippage
  - max trade size
  - min liquidity
  - cooldown intervals

---

## 5.12 GenesisProgram (Founding Depositor System)

### Purpose
GenesisProgram manages the “founding depositor” onboarding program WITHOUT contaminating trading logic.

### Responsibilities
- track Genesis eligibility window/cap (example: first 2,500 wallets)
- mint GenesisBadge (or register Genesis status)
- apply Genesis issuance bonuses (if any)
- bind lifetime discount to wallet (if applicable)
- emit Genesis events

### Hard rule
GenesisProgram MUST NOT:
- mint or credit profits
- affect Profit Buffer logic
- modify core settlement truth

---

## 5.13 ReferralProgram (GenesisBadge-Gated)

### Purpose
ReferralProgram credits referral bonuses only under strict qualification rules.

### Responsibilities
- assign referral codes to Genesis wallets
- attribute referred deposits
- enforce qualification:
  - deposit ≥ $250
  - active for 30 days
  - one-time referred eligibility
- enforce caps:
  - max rewards per month per wallet (ex: 25)
- execute reward credit only if funded

### Hard rule
ReferralProgram MUST pay from:
- MarketingRewardsVault ONLY
and never:
- MasterVault principal
- Profit Buffer
- Reserve

---

## 5.14 MarketingRewardsVault

### Purpose
Funding pool for referral payments.

### Responsibilities
- hold stablecoin dedicated to referral rewards
- expose spend interface callable only by ReferralProgram
- enforce pause-if-empty (no IOUs)

---

# 6. Lifecycle State Machine (Fixed 30-Day Cycle)

YieldLoop operates as a deterministic state machine to prevent:
- fake yield
- mid-cycle manipulation
- inconsistent accounting outcomes
- ambiguous claims

---

## 6.1 Cycle concept

Each user MasterVault participates in sequential cycles of fixed duration:

- **Cycle Duration:** 30 days
- **Cycle Boundaries:** explicit and event logged
- **Settlement:** deterministic and reproducible

---

## 6.2 States

The user vault MUST exist in one of the following canonical states:

1) `IDLE`
2) `ALLOCATING`
3) `ACTIVE`
4) `SETTLEMENT_PENDING`
5) `SETTLED`
6) `CLAIMED` (optional terminal marker for the cycle)

---

## 6.3 State definitions

### `IDLE`
Vault is not in an active trading cycle.
- deposits allowed
- allocations allowed
- withdrawals allowed (subject to protocol rules)
- no trading occurs

### `ALLOCATING`
Temporary staging state (optional implementation):
- user has deposited and is selecting allocations
- SubVault allocations must satisfy minimums
- cycle start may be user-triggered or auto-triggered

### `ACTIVE`
Cycle is running.
- allocations locked
- principal withdrawals disallowed
- trading allowed only through router + guardrails
- profits realized during cycle accumulate into Profit Buffer staging

### `SETTLEMENT_PENDING`
Cycle has ended or is near end.
- execution halts or becomes settlement-only
- harvest/unwind actions may occur
- final accounting is prepared

### `SETTLED`
Settlement complete.
- fee routing finalized
- claimable profit amount finalized
- user may claim/compound/withdraw

### `CLAIMED` (optional)
User has executed a cycle action:
- claim profit
- compound into principal
- withdraw principal
Vault returns to IDLE when complete.

---

## 6.4 Cycle timing rules

- Cycle start timestamp must be recorded.
- Cycle end timestamp must be deterministic.
- Protocol must avoid variable “rolling windows” that create ambiguity.

Recommended definition:
- `cycleEnd = cycleStart + 30 days`

---

## 6.5 Allowed actions by state

| Action | IDLE | ALLOCATING | ACTIVE | SETTLEMENT_PENDING | SETTLED |
|---|---:|---:|---:|---:|---:|
| Deposit | ✅ | ✅ | ❌* | ❌ | ✅ |
| Allocate/Reallocate | ✅ | ✅ | ❌ | ❌ | ✅ |
| Execute Trades | ❌ | ❌ | ✅ | ❌** | ❌ |
| Settle | ❌ | ❌ | ✅*** | ✅ | ✅ |
| Claim Profit | ❌ | ❌ | ❌ | ❌ | ✅ |
| Withdraw Principal | ✅ | ✅ | ❌ | ❌ | ✅ |

\* Deposits during ACTIVE may be allowed only if treated as “next cycle cash buffer,” but baseline v0.8.0 assumes deposits occur outside ACTIVE for deterministic behavior.  
\** Settlement may include unwind/harvest actions, but not new speculative trades.  
\*** Settlement can be triggered at end-of-cycle; implementation may allow settlement call near the cycle end block.

---

## 6.6 Deterministic settlement rule

Settlement MUST:
- produce the same outcome regardless of who calls it
- not depend on subjective keeper behavior
- emit a settlement report event that includes:
  - principal
  - realized profit
  - fee amounts
  - final claimable balance

If settlement cannot safely execute (oracle invalid, liquidity failure):
- settlement MUST revert or delay
- protocol MUST not fabricate an output

---

## 6.7 Failure handling

Failures are expected. The system must treat failures as safe states.

### Execution failures
- revert trade
- set cooldown
- emit failure event
- potentially trigger circuit breaker

### Oracle failures
- NO_TRADE
- settlement-safe behavior only

### Liquidity failures
- disable asset if persistent
- pause affected SubVault
- prevent repeated gas waste

---

## 6.8 Re-entry into next cycle

After SETTLED:
- user may choose:
  - `CLAIM_PROFIT`
  - `COMPOUND_PROFIT`
  - `WITHDRAW_PRINCIPAL`
  - `ROLLOVER` into next cycle
- allocations may be edited only at cycle boundary
- new cycle begins only after boundary actions conclude

---

# 7. MasterVault Specification (UserAccountVault)

MasterVault is the canonical user vault and accounting contract. It is the only contract that:

- holds the user’s stablecoin principal and idle cash buffer
- maintains allocation balances into SubVaults
- maintains realized profit balances (Profit Buffer)
- enforces the 30-day cycle lock rules
- produces deterministic settlement outputs

MasterVault MUST NOT execute swaps directly.

---

## 7.1 MasterVault Design Goals

MasterVault exists to enforce these realities:

1) **Users deposit once** (single master deposit UX).
2) Users may allocate across multiple strategies/assets without spawning separate independent vaults.
3) Accounting remains deterministic and auditable.
4) Profit claims are only possible once profit is realized and settled.

---

## 7.2 MasterVault State Variables (Minimum Required)

MasterVault MUST store at minimum:

### User balances
- `principalBalanceStable`  
  The user’s current principal (stablecoin) participating in the protocol.

- `idleCashBufferStable`  
  Unallocated stablecoin sitting idle (not traded).

- `profitBufferStable`  
  Realized stablecoin profit pending claim/compound, not yet withdrawn.

### Allocation ledger
- `allocations[subVaultId] -> allocatedStable`  
  Stablecoin allocated into each SubVault bucket.

- `activeSubVaults[]`  
  List of currently active SubVault allocations.

### Cycle state
- `cycleState`  
  Enum: `IDLE | ALLOCATING | ACTIVE | SETTLEMENT_PENDING | SETTLED`

- `cycleStartTimestamp`
- `cycleEndTimestamp`
- `lastSettlementTimestamp`

### Preferences / user settings
- `cycleActionPreference`  
  Enum: `COMPOUND_ALL | COMPOUND_PARTIAL | WITHDRAW_PROFIT | WITHDRAW_ALL`

- `compoundPercentBps`  
  For partial compound (0–10000 bps).

---

## 7.3 MasterVault Hard Rules (Non-Negotiable)

### Rule A — Deposit minimum
MasterVault MUST reject deposits below:
- **$250 stable equivalent**

### Rule B — Allocation minimum
Any SubVault allocation MUST be ≥:
- **$100 stable equivalent**

### Rule C — Idle buffer is valid state
Users may choose to allocate only part of their funds.
Unallocated balance MUST remain in idle buffer and MUST NOT be force-allocated.

### Rule D — No mid-cycle withdraws
During `ACTIVE` and `SETTLEMENT_PENDING`:
- withdrawal of principal MUST revert

### Rule E — No mid-cycle reallocation
During `ACTIVE` and `SETTLEMENT_PENDING`:
- allocation changes MUST revert

---

## 7.4 MasterVault Allowed Actions (By State)

### IDLE
- deposit ✅
- allocate ✅
- withdraw principal ✅
- start cycle ✅

### ALLOCATING
- allocate ✅
- finalize allocations ✅
- start cycle ✅

### ACTIVE
- execute trades (keeper) ✅
- claim profit ❌
- withdraw principal ❌
- reallocate ❌

### SETTLEMENT_PENDING
- settlement (keeper) ✅
- claim profit ❌
- withdraw principal ❌
- reallocate ❌

### SETTLED
- claim profit ✅
- compound ✅
- withdraw principal ✅
- edit allocations for next cycle ✅

---

## 7.5 Deposit Flow (deposit())

### Function goal
Credit stablecoin into the user’s MasterVault.

### Inputs
- `token` (stablecoin address)
- `amount`

### Preconditions
- `token` is allowlisted stablecoin
- `amount >= 250 stable equivalent` OR
  - if deposits are cumulative, then:
  - `principalBalanceStable + idleCashBufferStable + amount >= 250`

### State constraints
Recommended baseline:
- deposits allowed only in `IDLE` or `ALLOCATING`
- deposits during `ACTIVE` are either:
  - disallowed, OR
  - credited into a **NextCycleBuffer** compartment

### Effects
- transfer stablecoin from user to MasterVault
- update balances:
  - `idleCashBufferStable += amount`

### Events
- `Deposit(user, token, amount, timestamp)`

---

## 7.6 Allocation Flow (allocate())

### Function goal
Move funds from idle cash buffer to a specific SubVault.

### Inputs
- `subVaultId`
- `amount`

### Preconditions
- `cycleState in {IDLE, ALLOCATING, SETTLED}`
- `subVaultId` is allowlisted
- `amount >= 100 stable equivalent`
- `idleCashBufferStable >= amount`

### Dynamic max active sub-vault rule
To prevent fragmentation, MasterVault enforces:

maxActive = min(globalMaxActiveSubVaults, floor(totalStableBalance / subVaultMin))

Where:
- `totalStableBalance = principalBalanceStable + idleCashBufferStable + sum(allocations)`
- `subVaultMin = 100`

If allocation opens a new SubVault and exceeds maxActive:
- allocation MUST revert

### Effects
- `idleCashBufferStable -= amount`
- `allocations[subVaultId] += amount`
- update `activeSubVaults` set

### Events
- `Allocate(user, subVaultId, amount, timestamp)`

---

## 7.7 Start Cycle Flow (startCycle())

### Function goal
Transition into ACTIVE cycle and lock allocations.

### Preconditions
- `cycleState in {IDLE, ALLOCATING, SETTLED}`
- total active allocations > 0 OR governance allows 100% idle mode
- any allocation must still satisfy minimums

### Effects
- `cycleState = ACTIVE`
- `cycleStartTimestamp = now`
- `cycleEndTimestamp = now + 30 days`
- lock allocations

### Events
- `CycleStarted(user, cycleStart, cycleEnd, timestamp)`

---

## 7.8 Profit Credit Interface (creditProfit())

MasterVault must expose a controlled interface for SubVaults to credit realized profit.

### Function goal
Accept realized stablecoin profits from SubVaults.

### Inputs
- `subVaultId`
- `profitStableAmount`

### Preconditions
- callable only by allowlisted SubVault contracts
- `profitStableAmount > 0`

### Effects
- `profitBufferStable += profitStableAmount`

### Events
- `ProfitCredited(user, subVaultId, profitStableAmount, timestamp)`

---

## 7.9 Claim / Compound / Withdraw Actions (Post-Settlement)

These actions occur only when:
- `cycleState == SETTLED`

### claimProfit()
- transfers stable profit buffer to user wallet (stablecoin)
- zeroes profit buffer

### compoundProfit()
- moves profit buffer into principal balance
- zeroes profit buffer

### withdrawPrincipal()
- withdraws all or part of principal (if allowed)
- returns vault to IDLE if user exits fully

### Events
- `ClaimProfit(user, amount, timestamp)`
- `CompoundProfit(user, amount, timestamp)`
- `WithdrawPrincipal(user, amount, timestamp)`

---

## 7.10 MasterVault Failure Behaviors (Required)

MasterVault must fail safe.

### If oracle invalid
- do not trade
- do not settle unsafely

### If settlement fails
- remain in `SETTLEMENT_PENDING`
- allow retry
- do not fabricate claimable amounts

### If SubVault misbehaves
- MasterVault can disable SubVault credit permissions
- SubVault can be paused via governance

---

# 8. SubVault Specification (StrategyVaultBucket)

SubVaults are execution compartments representing:
- a single allowlisted asset target
- a strategy mode (GRID / ARB / AUTO)
- a bounded configuration hash
- access limited to allowlisted routers/pools

SubVaults execute trades and report realized outcomes back to MasterVault.

---

## 8.1 SubVault Identity and Registry

Each SubVault MUST have immutable identifiers:

- `assetId`
- `mode`
- `configHash`
- `dexVenueMask` (PCS/BiSwap allowed)
- `masterVaultAddress` (parent contract)

SubVaults MUST be deployed/registered only via governance-approved factory or allowlist entry.

---

## 8.2 SubVault Minimum Allocation

Each SubVault MUST enforce:
- minimum allocation per user bucket ≥ **$100**

If allocation falls below minimum:
- SubVault should not execute any trades for that user’s bucket
- allocation must be topped up or closed at cycle boundary

---

## 8.3 SubVault Accounting (Minimum Required)

SubVault MUST track:

- `allocatedStable`
- `tokenInventory`
- `weightedBasisStable`
- `realizedProfitStable`
- `unrealizedPnLStable` (non-claimable)
- `exposureRatio`
- `cooldownUntil`

---

## 8.4 Universal Execution Rules

SubVault MUST NOT execute trades unless:
- oracle sanity passes
- guardrails pass
- expected net profit threshold passes

SubVault MUST:
- revert or no-op when conditions fail
- emit failure events when attempts are blocked

---

## 8.5 SubVault Close / Exit (Cycle Boundary Only)

At cycle boundary a SubVault allocation can be:
- closed (return stable to idle cash buffer)
- rolled forward unchanged
- increased/decreased and rebalanced

Mid-cycle closing is disallowed.

---

## 8.6 Events (Mandatory)

SubVault MUST emit:

- `SubVaultTradeAttempt(...)`
- `SubVaultTradeExecuted(...)`
- `SubVaultTradeBlocked(reasonCode, ...)`
- `SubVaultInventoryUpdate(...)`
- `SubVaultProfitRealized(...)`

These events are required for proof dashboards and audit trails.

---

# 9. Strategy Router Specification (Engine Selector)

The StrategyRouter is the decision-making module that determines:

- whether the protocol should trade or not
- which engine to use (GRID vs ARB)
- which asset/SubVault should execute
- what trade sizing bounds apply

**Critical design intent:**  
The router is allowed to output **NO_TRADE**. This is not failure. It is correct behavior when:
- spreads are absent
- volatility is insufficient
- oracle sanity fails
- gas makes trades negative EV
- exposure caps are reached

Router outputs are always subordinate to:
- allowlists
- oracle sanity checks
- execution guardrails
- exposure limits
- cooldown logic

---

## 9.1 Router Inputs

Router MUST evaluate at minimum:

### A) MasterVault state
- cycle state (`ACTIVE` only)
- total allocated stable per SubVault
- idle cash (not directly relevant during ACTIVE unless “next cycle buffer” exists)

### B) SubVault state
Per SubVault:
- assetId
- strategy mode supported
- inventory exposure ratio
- weighted basis
- cooldown timer
- last execution attempt
- health status (paused/disabled)

### C) Market inputs (on-chain)
- PCS quotes for asset/stable
- BiSwap quotes for asset/stable
- pool liquidity snapshots
- expected price impact
- gas price estimate (or bounded config)

### D) Oracle sanity flags
- TWAP valid?
- deviation from reference within threshold?
- stale? outlier? manipulated?

### E) Governance constraints
- max trade size caps per asset
- min liquidity thresholds per asset/pool
- max slippage thresholds per asset
- min expected net profit thresholds
- circuit breaker status

---

## 9.2 Router Outputs

The router MUST output exactly one of:

1) `GRID_MODE(assetId, subVaultId, tradeSizeStable, params)`
2) `ARB_MODE(assetId, subVaultId, tradeSizeStable, params)`
3) `NO_TRADE(reasonCode)`

### Recommended reason codes for NO_TRADE
- `ORACLE_INVALID`
- `COOLDOWN_ACTIVE`
- `INSUFFICIENT_LIQUIDITY`
- `SPREAD_TOO_SMALL`
- `VOLATILITY_TOO_LOW`
- `GAS_TOO_HIGH`
- `EXPOSURE_CAP_REACHED`
- `CIRCUIT_BREAKER_ACTIVE`
- `CONFIG_DISABLED`

---

## 9.3 Routing Logic (Baseline)

Router selection SHOULD follow this priority:

### Step 1 — Global safety gate
If ANY of these are true:
- oracle invalid
- circuit breaker active
- asset disabled
- venues disabled
Then:
- output `NO_TRADE`

### Step 2 — Eligible SubVault selection
Build set `eligibleSubVaults` that satisfy:
- mode enabled
- allocation ≥ $100
- cooldown expired
- exposure below cap
- asset enabled

If empty:
- output `NO_TRADE`

### Step 3 — Arb detection pass (opportunistic)
For each eligible asset/subVault:
- compute arb profitability PCS→BiSwap
- compute arb profitability BiSwap→PCS
- pick best positive EV path

If best arb EV >= arb threshold:
- output `ARB_MODE(...)`

### Step 4 — Grid evaluation pass (default)
For each eligible asset/subVault:
- evaluate grid triggers (buy/sell zones)
- confirm trend-break rules (don’t buy into breakdown)
- confirm expected net profit threshold ensures positive EV

If a valid grid action exists:
- output `GRID_MODE(...)`

### Step 5 — Otherwise no trade
Output `NO_TRADE`

---

## 9.4 Trade Sizing Rules (Required)

Router must produce trade sizes that are bounded by:

- `maxTradeSizePerAsset`
- `maxTradeSizePerAttemptGlobal`
- `allocationRemaining`
- `inventoryExposureCap`

### Sizing constraints for Arb
Arb sizing should be limited by:
- pool liquidity depth
- expected price impact
- minimum profit buffer after costs

### Sizing constraints for Grid
Grid sizing should be limited by:
- step size configuration
- inventory cap remaining
- max buys per day
- trend-break state

---

## 9.5 Dynamic Maximum Active SubVault Cap (MasterVault Constraint)

MasterVault should enforce maximum fragmentation.

Router assumes MasterVault already enforces:
- minimum allocation $100
- dynamic maximum number of active SubVaults

Router must not output trades for:
- SubVaults not currently active/allocated
- allocations below minimum

---

# 10. Trading Engines

YieldLoop supports two execution engines under strict guardrails:

- **Grid/Band Engine** (Primary)
- **Cross-DEX Arbitrage Engine** (Secondary)

Each engine must:
- pre-simulate expected outcomes
- verify oracle sanity
- enforce hard execution guardrails
- emit full events

---

## 10.1 Grid/Band Engine (Volatility Harvesting)

### 10.1.1 Purpose
Grid trading attempts to realize profit from oscillations by:

- buying when price falls into defined lower zones
- selling when price rises into defined upper zones

Grid is expected to outperform pure arbitrage in:
- sideways markets
- choppy conditions
- low spread environments

### 10.1.2 Core principle
Grid MUST NOT function as:
- “keep buying forever”

It must be a bounded strategy with:
- range rules
- inventory limits
- breakdown protections

### 10.1.3 Required configuration parameters
Each grid-capable SubVault must be governed by:

- `anchorPrice`
- `lowerBandBps`
- `upperBandBps`
- `gridStepCount`
- `gridStepSizeStable` OR `gridStepSizeBps`
- `minNetProfitPerSellBps`
- `cooldownSeconds`
- `maxInventoryExposureBps`
- `maxBuysPerDay`
- `trendBreakBps` (breakdown trigger)
- `trendRecoveryBps` (resume trigger)

### 10.1.4 Trigger rules (baseline)
Grid has two action types:

#### Action A: BUY
BUY may execute only if:
- price <= nextBuyLevel
- oracle sanity passes
- exposure < maxInventoryExposure
- not in breakdown state
- expected execution cost does not violate minimum viability

#### Action B: SELL
SELL may execute only if:
- price >= nextSellLevel
- oracle sanity passes
- token inventory sufficient
- expected net profit >= threshold after:
  - DEX fees
  - slippage
  - gas cost
  - price impact

### 10.1.5 Trend-break protection (mandatory)
Grid must implement:

- `BREAKDOWN_STATE = TRUE` when:
  - price falls below `anchorPrice * (1 - trendBreakBps)`

When in breakdown state:
- BUY is disabled
- SELL is allowed if profitable
- system may enter settlement-safe posture

Grid resumes BUY only after:
- price recovers above recovery threshold AND
- oracle sanity passes

### 10.1.6 Inventory caps (mandatory)
Each SubVault must enforce:
- `tokenInventoryValue <= allocation * maxInventoryExposureBps`

If cap reached:
- BUY disabled until exposure falls below cap

---

## 10.2 Cross-DEX Arbitrage Engine (PCS ↔ BiSwap)

### 10.2.1 Purpose
Arbitrage captures profit from pricing divergence between:
- PancakeSwap and BiSwap

It is secondary because:
- spreads are intermittent
- MEV competition exists
- profitable opportunities may not exist consistently

### 10.2.2 Arb attempt lifecycle
For each attempt:

1) Determine direction:
   - PCS buy → BiSwap sell
   - BiSwap buy → PCS sell

2) Quote both legs:
   - stable → asset
   - asset → stable

3) Simulate net outcome:
   - expected stable out - stable in - all costs

4) Execute only if:
   - net profit >= threshold

### 10.2.3 Net profit simulation (mandatory)
Arb profit must include:
- DEX fees (both legs)
- slippage bounds (both legs)
- price impact estimate
- gas execution cost estimate
- any router costs

### 10.2.4 Slippage rules (mandatory)
Arb MUST enforce:
- max slippage bps per asset per venue
- `minAmountOut` on swap calls

If any swap would execute below min output:
- revert or abandon the attempt

### 10.2.5 MEV considerations (best effort)
Arb strategies are vulnerable to MEV and sandwich attacks.

Allowed mitigations include:
- private transaction routing when available
- randomization of execution cadence
- strict min profit thresholds
- avoid repeated predictable actions

MEV mitigation is best-effort; safety still relies on:
- strict profitability checks
- bounded trade sizing
- slippage enforcement

---

# 11. Oracle + Price Sanity

Oracle logic exists to prevent trading on manipulated, stale, or broken pricing.

YieldLoop does not require a perfect oracle.
It requires a *sanity oracle*.

---

## 11.1 OracleAdapter goals

OracleAdapter MUST:
- reject stale pool state
- reject flash spikes
- reject extreme outliers
- prevent execution during manipulation

---

## 11.2 Recommended oracle modes

### Mode A: TWAP sanity
- compute TWAP from allowlisted PCS/BiSwap pools
- reject if current spot deviates beyond threshold

### Mode B: Median-of-venues sanity
- compare PCS spot and BiSwap spot
- compute median
- reject if one venue deviates excessively

### Mode C: Hybrid
- TWAP + median-of-venues + outlier rejection

---

## 11.3 Oracle failure behavior (hard rule)

If oracle sanity fails:
- router outputs `NO_TRADE(ORACLE_INVALID)`
- SubVault MUST refuse execution
- settlement may still proceed if safe

Oracle invalid must never cause forced execution.

---

# 12. Execution Guardrails + Safety Controls

ExecutionGuardrails is the universal enforcement layer that prevents the protocol from executing unsafe trades even when the Router produces a trade intent.

**Guardrails win over strategy.**  
If a trade is unsafe, the correct result is **NO_TRADE** or **REVERT**, not execution.

Guardrails MUST be enforced:
- in SubVault execution logic
- and/or as a shared library used by both engines

---

## 12.1 Guardrail Categories (Mandatory)

### A) Allowlist Enforcement (Hard Gate)
Every execution attempt MUST verify:
- token is allowlisted
- pool is allowlisted
- router is allowlisted
- venue is enabled

If any fail:
- revert

---

### B) Liquidity Threshold Enforcement
Each asset/pool MUST have:
- minimum liquidity threshold
- minimum depth threshold (optional)

Example checks:
- stable reserves exceed threshold
- quote output does not exceed % of pool

If below threshold:
- `NO_TRADE(INSUFFICIENT_LIQUIDITY)` or revert

---

### C) Slippage + Price Impact Constraints
Each trade MUST enforce:
- `maxSlippageBps` per asset/venue
- `minAmountOut` on swap calls
- optional price impact estimation caps

If violated:
- revert

---

### D) Gas Discipline
Trades MUST not execute if gas cost makes trade negative EV.

Required gas controls:
- `maxGasSpendPerAttempt`
- `maxGasSpendPerDayPerSubVault`
- `maxFailedAttemptsPerDay`

Gas can be estimated using:
- static configured gas estimate ranges, OR
- chain fee estimate feed, OR
- keeper-provided value bounded by governance limits

---

### E) Cooldown + Rate Limiting
Each SubVault MUST enforce:
- cooldown window between attempts (seconds)
- daily attempt cap (optional but recommended)
- maximum number of trades per day per asset

This prevents:
- spam execution
- predictable MEV farming targets
- gas bleed during bad conditions

---

### F) Exposure Caps (Inventory Risk)
Every SubVault MUST enforce:
- `maxInventoryExposureBps`

Grid BUY actions MUST be blocked when:
- inventory exposure cap is reached

---

### G) Circuit Breakers
Circuit breakers halt execution when unsafe conditions persist.

Required circuit breaker triggers may include:
- repeated oracle failures beyond threshold
- repeated trade failures
- slippage violations
- suspicious deviation between venues
- gas spike beyond allowed bounds
- pool liquidity collapse

Circuit breaker outputs:
- pause SubVault
- disable asset
- disable venue
- force `NO_TRADE`

---

## 12.2 Guardrail Precedence Rules

If Router outputs a trade:
- Router intent is evaluated
- Guardrails evaluate hard gates
- If any hard gate fails → revert
- If any safety condition fails → NO_TRADE

Guardrails must always override Router.

---

## 12.3 Guardrail Events (Required)

Every blocked execution MUST emit structured events:

- `TradeBlocked(user, subVaultId, reasonCode, timestamp)`
- `CircuitBreakerTriggered(assetId, breakerType, timestamp)`
- `AssetDisabled(assetId, reasonCode, timestamp)`
- `VenueDisabled(venueId, reasonCode, timestamp)`

This is mandatory for:
- auditing
- monitoring
- proof dashboards
- community transparency

---

# 13. Profit Accounting (Realized Profit Only) + Profit Buffer

YieldLoop’s accounting model is conservative and must remain conservative even if it reduces marketing appeal.

The protocol does NOT report:
- unrealized profit
- theoretical PnL
- price appreciation

Profit is ONLY recognized when it is realized in stablecoin and isolated in a Profit Buffer.

---

## 13.1 Definitions

### Principal
User-deposited stablecoin that is part of the protocol’s managed balance.

### Allocation
Stablecoin moved from idle buffer into SubVault strategy execution compartments.

### Inventory
The non-stable asset held in a SubVault (BTCB/ETH/XRP/BNB/SOL).

### Realized Profit
Stablecoin surplus resulting from closed trades where stablecoin returned exceeds basis + costs.

---

## 13.2 What “Profit” Means (Hard Rule)

A SubVault may only report realized profit if:

- the SubVault completes a trade cycle
- stablecoin is returned to the SubVault/master accounting domain
- stablecoin balance exceeds basis + costs

Profit is then moved/credited to the MasterVault Profit Buffer.

---

## 13.3 Profit Buffer Rules

Profit Buffer MUST:
- store realized stablecoin profits only
- be segregated from principal
- remain non-claimable until settlement finalization

Profit Buffer is effectively the “truth compartment”:
- if it is not in Profit Buffer, it is not profit

---

## 13.4 Unrealized Gains Are Not Claimable

If a SubVault holds inventory that is “up”:
- it is not claimable profit
- it is not fee eligible
- it is not counted as yield

This prevents:
- fake yield
- rug-like accounting
- insolvency masked by unrealized inventory marks

---

## 13.5 Loss Handling

Losses are allowed. YieldLoop is not insured.

Losses must be:
- accounted transparently
- event logged
- reflected in user settlement outputs

The protocol MUST NOT:
- conceal losses
- smooth losses across users
- subsidize losses using other users’ principal

---

# 14. Fees + Fee Routing

YieldLoop fees are taken only from **realized profit**, never from principal.

Fees MUST be deterministic, auditable, and bounded by governance-configured constraints.

---

## 14.1 Fee Types

### A) Performance Fee (Primary)
A percentage of realized profit.

- applied during settlement finalization
- computed from realized stablecoin profit only

### B) Optional program fees (if enabled)
- discount systems
- referral budgets (not a fee; separate program)
- Genesis program split (separate program, not “protocol fee”)

---

## 14.2 Fee Eligibility (Hard Rule)

Fees may only be collected when:
- profit is realized
- profit is settled
- settlement report is finalized

No other time.

---

## 14.3 FeeRouter Responsibilities

FeeRouter MUST:
- compute fee from realized profit only
- route fee splits to configured destinations
- emit routing events
- never touch principal

FeeRouter SHOULD be:
- separate contract/module
- callable only by SettlementEngine

---

## 14.4 Fee Computation (Example Logic)

If:
- `realizedProfitStable = X`
- `performanceFeeBps = Y`

Then:
- `feeAmount = X * Y / 10000`
- `userProfitNet = X - feeAmount`

If `X <= 0`:
- `feeAmount = 0`

---

## 14.5 Fee Routing Destinations (Configurable)

FeeRouter routes fees to allowlisted destinations such as:
- Dev Treasury
- Ops / Maintenance
- Growth / Marketing Treasury
- Reserve / Backstop Pool (if used)
- Proof-of-Impact program vault (optional)
- Other allowlisted treasury contracts

All destinations MUST be allowlisted.

---

## 14.6 Fee Events (Required)

FeeRouter MUST emit:

- `FeeCharged(user, cycleId, realizedProfit, feeAmount, timestamp)`
- `FeeRouted(destination, amount, timestamp)`

---

# 15. Settlement Engine (End-of-Cycle Accounting)

Settlement is the most important step of the protocol because it defines:
- what profit means
- when fees can be taken
- what users can claim
- how fake yield is prevented

Settlement MUST be deterministic and auditable.

---

## 15.1 Settlement Preconditions

Settlement may only occur when:
- vault cycle end time has been reached
- cycle state is `ACTIVE` or `SETTLEMENT_PENDING`
- oracle sanity is acceptable OR settlement-safe override conditions exist

Settlement MUST NOT execute if pricing is unsafe enough to cause manipulation or forced loss due to oracle failure.

---

## 15.2 Settlement Inputs

Settlement uses:
- SubVault accounting states
- realized profit logs
- profit buffer totals
- fee configuration
- oracle sanity flags (for unwind safety)

---

## 15.3 Settlement Process (Baseline)

At end-of-cycle:

1) Transition MasterVault state:
   - `ACTIVE` → `SETTLEMENT_PENDING`

2) Freeze speculative execution:
   - disable new GRID buys
   - disable new ARB attempts
   - allow only settlement unwind actions if needed

3) Harvest realized profit from SubVaults:
   - SubVaults credit stable profit amounts to MasterVault Profit Buffer

4) Optional unwind:
   - if SubVault holds inventory and unwind is required for deterministic accounting
   - unwind must respect oracle + slippage constraints

5) Compute settlement totals:
   - principal
   - realized profit
   - fee amount
   - net claimable profit

6) Route fees through FeeRouter.

7) Finalize:
   - MasterVault state → `SETTLED`
   - emit settlement report event

---

## 15.4 Settlement Report (Required Output)

Settlement MUST emit a standardized report event including:

- `cycleId`
- `cycleStartTimestamp`
- `cycleEndTimestamp`
- `principalStable`
- `profitRealizedStableGross`
- `feeStable`
- `profitClaimableStableNet`
- `profitCompoundedStable` (if auto-compound exists)
- `inventoryResidual` (if any; non-claimable)
- `oracleStatusFlags`

---

## 15.5 Settlement Failure Handling

Failures will occur (oracle invalid, liquidity collapse, etc).

If settlement cannot safely finalize:
- keep vault in `SETTLEMENT_PENDING`
- allow retry
- do not fabricate results
- emit `SettlementBlocked(reasonCode)`

---

## 15.6 Settlement Completion

Once settlement finalizes:
- user may claim profit
- user may compound profit
- user may withdraw principal
- user may edit allocations for next cycle

---

# 16. User Claims, Compounding, and Withdrawals

Users interact with YieldLoop primarily at cycle boundaries. This is by design.

YieldLoop does NOT allow:
- mid-cycle withdrawals
- mid-cycle profit claims
- mid-cycle rebalancing

Because those features destroy deterministic accounting and invite exploit behavior.

---

## 16.1 Claimable Balance Definition

After settlement (`cycleState == SETTLED`), the user has:

- `principalBalanceStable` (withdrawable / rollable)
- `profitBufferStable` (claimable / compoundable)
- `idleCashBufferStable` (free to allocate next cycle)

**Hard rule:**  
Only Profit Buffer is claimable profit. Anything else is not profit.

---

## 16.2 Claim Profit (claimProfit)

### Purpose
Transfer the user’s settled Profit Buffer amount (stablecoin) to the user’s wallet.

### Preconditions
- `cycleState == SETTLED`
- `profitBufferStable > 0`

### Effects
- `transferStable(user, profitBufferStable)`
- `profitBufferStable = 0`

### Events
- `ClaimProfit(user, cycleId, amount, timestamp)`

---

## 16.3 Compound Profit (compoundProfit / rollProfitIntoPrincipal)

### Purpose
Convert realized profit into additional principal.

### Preconditions
- `cycleState == SETTLED`
- `profitBufferStable > 0`

### Effects
- `principalBalanceStable += profitBufferStable`
- `profitBufferStable = 0`

### Events
- `CompoundProfit(user, cycleId, amount, timestamp)`

---

## 16.4 Partial Compound Option (compoundPercent)

If user selects partial compound:

- `compoundPercentBps` must be between `0` and `10000`
- `compoundAmount = profitBufferStable * compoundPercentBps / 10000`
- `claimAmount = profitBufferStable - compoundAmount`

Effects:
- principal increases by compoundAmount
- claimAmount transferred to wallet
- profitBuffer cleared

Events:
- `CompoundProfit(...)`
- `ClaimProfit(...)`

---

## 16.5 Withdraw Principal (withdrawPrincipal)

### Purpose
Withdraw some or all principal (stablecoin) to the user wallet.

### Preconditions
- `cycleState == IDLE` OR `cycleState == SETTLED`
- principal withdrawal during ACTIVE must revert

### Effects
- reduce `principalBalanceStable`
- transfer stablecoin to user

### Events
- `WithdrawPrincipal(user, amount, timestamp)`

---

## 16.6 Roll Forward Without Action (rollover)

A user may choose:
- no withdrawal
- no claim

And allow:
- principal to remain
- allocations to remain
- new cycle to begin

This requires:
- re-locking allocations
- starting a new cycle

Events:
- `Rollover(user, prevCycleId, nextCycleId, timestamp)`

---

# 17. Governance/Admin Controls (Allowlists, Bounds, Emergency)

Governance/Admin exists to configure the system WITHOUT being able to steal user funds or violate core invariants.

This section defines the governance “power surface” and its safety limits.

---

## 17.1 Governance Roles (Minimum)

Recommended role separation:
- `Admin`: emergency pause + allowlist maintenance
- `Governance`: parameter updates, upgrades, treasury routing
- `Guardian`: limited emergency kill-switch only (optional)

---

## 17.2 Allowlist Registry (Critical Contract)

The allowlist registry is the most important governance system component.

It MUST define allowlisted:

### Token allowlist
- stablecoins (deposit tokens)
- traded assets (BTCB, ETH, XRP, BNB, SOL)
- any intermediary tokens (preferably none)

### Router allowlist
- PCS router(s)
- BiSwap router(s)

### Pool allowlist
- PCS pools per asset
- BiSwap pools per asset

### Per-asset execution bounds
- max slippage bps
- min liquidity threshold
- max trade size per attempt
- max daily trade size
- cooldown seconds
- max inventory exposure

**Hard rule:**  
Any non-allowlisted token/pool/router MUST revert.

---

## 17.3 Parameter Bounds (Prevent Governance Sabotage)

Governance must not be able to vote in suicidal parameters.

Therefore **all parameters MUST have safe bounds enforced on-chain**, such as:

- `0 <= slippageBps <= MAX_SLIPPAGE_CAP`
- `0 <= performanceFeeBps <= MAX_FEE_CAP`
- `minLiquidity >= MIN_LIQUIDITY_FLOOR`
- `maxTradeSize <= MAX_TRADE_FLOOR`
- `cooldownSeconds >= MIN_COOLDOWN`

If governance sets outside bounds:
- revert

---

## 17.4 Emergency Controls

Emergency controls must exist, but be transparent.

Minimum required:
- `pauseAllExecution()`
- `pauseAsset(assetId)`
- `disableVenue(PCS|BISWAP)`
- `disableSubVault(subVaultId)`
- `emergencySettlementMode()` (settlement-only)

Emergency controls MUST:
- emit events
- not transfer user funds to governance
- not allow arbitrary fund seizure

---

## 17.5 Upgrade Path

Upgrades are dangerous. Still, you want them.

Recommended:
- upgrade proxy pattern OR modular router/engine registry
- timelock for upgrades
- hash/version logging
- allow users to opt out at cycle boundary (recommended)

Upgrade events:
- `ProtocolUpgraded(versionHash, timestamp)`
- `ModuleUpgraded(moduleId, old, new, timestamp)`

---

# 18. Genesis Program (Founding Depositor System)

Genesis is a fundraising + user seeding program. It must be implemented as a **separate program module** so it cannot corrupt protocol accounting.

Genesis DOES NOT create yield.
Genesis DOES NOT mint fake profits.
Genesis is just a structured onboarding program.

---

## 18.1 Genesis Goals

- seed development funds
- seed reserve funds (if used)
- seed initial LOOP distribution (if applicable)
- create founding cohort (GenesisBadge)

---

## 18.2 Genesis Eligibility

Genesis eligibility is constrained by:

- max number of wallets (example: first 2,500)
- optional time window
- one Genesis contribution per wallet

Genesis must enforce:
- `genesisCount < genesisCap`
- `user not already genesis`
- `amount == genesisContributionAmount` (if fixed)
- OR amount within allowed bounds if variable

---

## 18.3 Genesis Contribution Handling

Genesis contributions are split (example structure):

- Dev allocation
- Reserve allocation
- LOOP issuance allocation

This split MUST:
- be deterministic
- be event logged
- never touch Profit Buffer logic

Events:
- `GenesisJoined(user, amount, genesisIndex, timestamp)`
- `GenesisSplit(user, dev, reserve, tokenAllocation, timestamp)`

---

## 18.4 GenesisBadge

Genesis program MUST mint or register:
- `GenesisBadge` (NFT or non-transferable record)

The badge can be used to:
- unlock referral program eligibility
- enable lifetime discount binding (if defined)

Badge logic must support:
- enable/disable
- non-transferable option (recommended)

---

## 18.5 Genesis Bonus Issuance (Optional)

If Genesis includes token issuance bonus (example: +2.5% LOOP):

Rules:
- bonus is deterministic
- bonus applies only at Genesis join time
- bonus must be capped
- bonus must be event logged

Event:
- `GenesisBonusIssued(user, amount, bonusAmount, timestamp)`

---

## 18.6 Genesis Program Termination

Genesis must be disableable once complete.

Rules:
- once cap reached, `joinGenesis()` reverts
- governance can close Genesis early (event logged)

Event:
- `GenesisClosed(timestamp)`

---

# 19. Referral Program (GenesisBadge-Gated)

Referral is a controlled acquisition mechanism, not an open emissions system.

Referral MUST be:
- capped
- delayed
- gated
- funded from a dedicated vault

It must NEVER:
- mint money
- promise yield
- drain principal or profits

---

## 19.1 Referral Eligibility

Only GenesisBadge wallets may:
- generate referral codes
- earn referral rewards

Non-Genesis wallets may:
- use a referral code at deposit time (referred party)

---

## 19.2 Referral Attribution Rules

Referral attribution MUST be:
- explicit
- deterministic
- one-time for referred wallet

Rules:
- referred wallet may only set referrer once
- self-referrals are rejected
- circular ref patterns may be rejected (recommended)

Events:
- `ReferralBound(referred, referrer, code, timestamp)`

---

## 19.3 Referral Qualification Rules

Referral reward triggers only if:

- referred user deposits at least **$250**
- referred user remains active for **30 days**
- referred user completes a full cycle settlement successfully

Qualification should be checked at:
- settlement finalization time

---

## 19.4 Referral Reward Rules

Example reward:
- **+1 USDT principal credit** to referrer
- **+1 USDT principal credit** to referred

Reward must be:
- credited to principal (not profit)
- credited only if referral vault is funded

Referral rewards must NOT:
- be taken from other users
- be taken from Profit Buffer
- be taken from principal treasury

---

## 19.5 Referral Caps and Anti-Farm Controls

Minimum required controls:

- per-wallet monthly cap (example: 25)
- one-time reward eligibility for referred wallet
- blacklist suspicious patterns (optional)
- require minimum deposit size (already defined)
- require full cycle completion (anti-dump farming)

Events:
- `ReferralRewardIssued(referrer, referred, amountEach, timestamp)`
- `ReferralRewardBlocked(reasonCode, timestamp)`

---

## 19.6 Referral Pause Behavior

If MarketingRewardsVault is empty:

- referrals pause
- no IOUs
- no debt
- no future promises

Event:
- `ReferralRewardsPaused(reasonCode, timestamp)`

---

# 20. Events, Proof, and Observability (Auditability Hooks)

YieldLoop must be observable by design.

This supports:
- audit review
- community trust
- proof dashboards
- operational debugging

---

## 20.1 Mandatory Event Categories

### MasterVault events
- Deposit
- Allocate
- CycleStarted
- SettlementPending
- SettlementFinalized
- ClaimProfit
- CompoundProfit
- WithdrawPrincipal

### SubVault events
- TradeAttempt
- TradeExecuted
- TradeBlocked
- InventoryUpdate
- ProfitRealized

### Governance events
- AllowlistUpdated
- AssetDisabled / Enabled
- VenueDisabled / Enabled
- ProtocolPaused / Resumed
- ModuleUpgraded

### Program events
- GenesisJoined
- GenesisBadgeMinted
- ReferralBound
- ReferralRewardIssued
- ReferralRewardsPaused

---

## 20.2 Settlement Report Standard

Settlement MUST emit a structured summary including:

- cycle identifiers
- principal start/end
- realized profit gross/net
- fees charged
- claimable profit
- residual inventory summary (if any)
- oracle and guardrail flags

This enables a Proof Dashboard to render:
- what happened
- why it happened
- what was earned (or not earned)

---

## 20.3 Monitoring-Friendly Design

Recommended:
- reason codes enums for blocked actions
- consistent event schemas
- per-asset health status flags
- per-venue health flags

Observability is not optional in DeFi.
It is the difference between:
- “users trust your numbers”
and
- “users assume it’s a scam.”

---

# 21. Security Considerations (Threat Model + Failure Modes)

YieldLoop assumes hostile conditions:
- MEV exists
- sandwich attacks exist
- manipulated pools exist
- governance capture is possible
- keepers can be unreliable
- oracle inputs can fail

The protocol defends by:
- strict allowlists
- strict guardrails
- conservative accounting
- deterministic settlement
- circuit breakers

YieldLoop is not insured.

Users must accept:
- loss is possible
- profit is not guaranteed
- the protocol may choose NO_TRADE

---
