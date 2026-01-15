# YieldLoop Whitepaper  
## USDT-Based Automated BTCB Arbitrage Vaults + LOOP Redemption Token

**Date:** January 14, 2026  
**Author:** Todd Koletsky  
**Version:** 0.7.1  

---

## Document Metadata

- **Document Type:** Whitepaper + Protocol Specification
- **Status:** Draft (Engineering-Ready Spec)
- **Chain:** BNB Chain (BSC)
- **DEX Venues:** PancakeSwap (PCS), BiSwap
- **Deposit Asset:** USDT (only)
- **Reward Assets:** USDT or LOOP
- **Strategy Asset Pair:** BTCB/USDT (allowlisted only)

---

## Table of Contents (TOC)

1. **Executive Summary**
2. **What YieldLoop Is (In Plain Terms)**
3. **Core Principles + Non-Negotiable Invariants**
4. Vault Model (Isolated User Vaults + Accounting)
5. Strategy Execution Engine (BTCB Arbitrage PCS ↔ BiSwap)
6. Rule Engine + Guardrails (Safety System)
7. Profit Definition + Profit Events
8. Profit Buffer + Claim Mechanics
9. Fee Model + Fee Routing
10. LOOP Token (Redemption Token, Not Governance)
11. LOOP Minting (Profit-Backed Issuance)
12. LOOP Redemption (Reserve-Limited, Run-Hardened)
13. Admin / Governance Controls (Bounded + Timelocked)
14. Security Model (Oracle Sanity, MEV, Failure Modes)
15. Risks + Disclosures
16. Glossary

---

# 1. Executive Summary

YieldLoop is a USDT-denominated, automated trading protocol on BNB Chain that executes a
narrow, constrained strategy: **real-time arbitrage of BTCB/USDT price discrepancies between
PancakeSwap (PCS) and BiSwap**.

Users deposit **USDT only** into isolated vaults. The protocol executes arbitrage trades when
the projected outcome is profitable **after** all costs, including DEX fees, slippage, and gas.
YieldLoop defines “profit” strictly as **realized USDT increase** after a completed buy/sell cycle.
No unrealized PnL, mark-to-market accounting, or fake yield is permitted.

Profits accumulate into a **Profit Buffer** held in USDT. Users may claim profits at any time
(subject to minimum claim size and protocol safety constraints). Users may receive rewards
either:
- **in USDT**, or
- **in LOOP**, a redemption token that is minted from verified profit events and backed by
protocol reserves.

A platform performance fee applies **only** when real profit is realized:
- **20.0% fee** if profits are claimed in USDT
- **17.5% fee** if profits are claimed in LOOP (discount for choosing LOOP)

Platform performance fee revenue is routed to **four** destinations:
1) **Dev / Ops / Admin** (protocol maintenance, security, execution operations, ECW gas backstop),
2) **Marketing / Partnerships / Onboarding** (growth distribution and integrations),
3) **Redemption Reserve** (USDT routed to the reserve that backs LOOP redemption), and
4) **LoopLabs (Equal Splits)** (distributed equally among allowlisted LoopLabs recipients).

YieldLoop does not promise guaranteed yield, does not use leverage, and does not fabricate
profit through emissions. The protocol can only pay what it truly earns in USDT, and LOOP
redemption is **explicitly limited** by available reserve liquidity.

---

# 2. What YieldLoop Is (In Plain Terms)

YieldLoop is a **profit vault system**, not a farm, not a staking app, and not an emissions token.

It works like this:

1) A user deposits **USDT** into YieldLoop.  
2) The user’s funds live in an isolated accounting vault (no pooled custody accounting tricks).  
3) The system scans for BTCB/USDT price differences between **PCS and BiSwap**.  
4) If a profitable opportunity exists after costs, the system executes:
   - buy BTCB on the cheaper venue using USDT  
   - sell BTCB on the more expensive venue back into USDT  
5) Only after both legs are completed, the system checks if there is real net profit in USDT.  
6) When profit exists:
   - platform fee is taken (20% or 17.5%)
   - remaining profit is credited to the user’s Profit Buffer (USDT)
7) The user can claim profits anytime:
   - receive **USDT**, or
   - choose **LOOP** (discounted fee)

YieldLoop is intentionally narrow in scope to reduce attack surface and complexity. It does not attempt to trade everything. It focuses on one job:

> Capture real arbitrage spreads on BTCB/USDT between two major BSC DEX venues, and return verified profits to depositors.

---

# 3. Core Principles + Non-Negotiable Invariants

YieldLoop is built on strict invariants. These rules are not “preferences.” They are the core of the protocol design. If these are violated, the protocol becomes exploitable, misleading, or fraudulent.

## 3.1 USDT-Only Accounting (Hard Rule)
- Deposits are accepted in **USDT only**
- Vault balances are measured in **USDT only**
- Profit is measured in **USDT only**
- Fees are assessed in **USDT only**
- Reserves are held and measured in **USDT only**

This prevents:
- volatility-based profit illusion
- manipulative accounting
- hidden risk transfer to users

## 3.2 Profit Must Be Realized and Net of Costs
A “Profit Event” is valid only when:
- a trade cycle is fully completed (buy + sell)
- the resulting vault USDT balance is higher than before execution
- profit remains after deducting:
  - venue swap fees
  - slippage/price impact
  - gas costs (converted to USDT equivalent)

No profit event exists if profit is not strictly positive after full costs.

## 3.3 No Yield Smoothing / No Fake APY
YieldLoop does not:
- smooth yields
- promise fixed APY
- distribute emissions as “profit”
- pay users using newly minted tokens not tied to realized profit

If there is no profitable arbitrage available during a period:
- profits may be low
- profits may be zero

That is the honest outcome.

## 3.4 LOOP Is a Redemption Token (Not an LP Token)
LOOP is:
- minted only from verified profit processes
- designed as a redemption-backed claim token

LOOP is not:
- liquidity provider token
- governance token
- inflationary emissions token

## 3.5 Redemption Is Reserve-Limited (Run-Hardened)
LOOP redemption is strictly limited by:
- available, liquid reserves held by the protocol

YieldLoop does not pretend it can redeem infinite tokens instantly. Redemptions are processed only when reserves support them. If reserve liquidity is insufficient:
- redemption may pause, queue, or throttle until reserves refill

This is deliberate and necessary to prevent bank-run collapse mechanics.

## 3.6 Strategy Is Allowlisted and Narrow by Design
YieldLoop strategy scope is intentionally constrained:
- Chain: BNB Chain
- Venues: PCS + BiSwap
- Trading pair: BTCB/USDT only
- Execution: arbitrage only (not directional speculation)

No expansion of scope may occur without formal protocol upgrade and rule validation.

## 3.7 Rule Engine Controls Strategy Behavior (Bounded Configuration)
Certain parameters may be configurable (by governance/admin), but only within safe bounds:
- max trade size
- cooldown period
- oracle sanity thresholds
- min profit thresholds
- max daily drawdown
- circuit breakers / halts
- execution venue enable/disable

A valid configuration must:
- stay within hardcoded safe ranges
- never violate invariants (profit definition, reserve-limited redemption, USDT accounting)

## 3.8 Gas Exposure Is Non-Speculative and Capped
BNB may be temporarily held only to pay transaction execution costs:
- not treated as a strategy asset
- never treated as profit
- maintained at minimal required levels
- replenished by micro-conversion from USDT as needed

This ensures the protocol is not accidentally (or intentionally) taking directional BNB risk.

---

## 4.0 Vault Deployment Model (Hard Clarification — Per-Deposit Vault Contracts)

YieldLoop uses **per-deposit vault deployment**.

**Rule:**
- **Each deposit deploys a new UserVault contract** via `VaultFactory`.
- A single wallet may own multiple vaults.
- Vaults do not share custody with other vaults (no pooled principal).

**Implications:**
- Each vault has its own:
  - principal ledger (USDT)
  - Profit Buffer (USDT)
  - config reference
  - state machine
  - execution counters / circuit-breaker status
- Shared infrastructure MAY exist (Keeper set, OracleAdapter, FeeRouter, ReserveSystem), but **fund custody remains per-vault**.

**Rationale:**
- simplest audit narrative
- isolates blast radius
- eliminates pooled accounting doubt
---

## 4.1 Vault Objects

Each user deposit deploys a UserVault contract (isolated custody vault). The vault maintains:

- **Principal Balance (USDT)**  
  The user’s deposited capital that is authorized for strategy execution.

- **Active Trading Balance (USDT)**  
  Subset of principal currently deployed into the arbitrage loop.

- **Profit Buffer (USDT)**  
  Realized profits credited to the user after fees, held for claim or compounding.

- **Execution Cost Ledger (USDT Equivalent)**  
  Tracks gas/execution costs converted into USDT terms for correct net profit accounting.

- **Vault Config Reference (ConfigID / Version Hash)**  
  Points to an allowlisted strategy rule set (see Section 6).

---

## 4.2 Vault Lifecycle States

Vaults progress through explicit states. State changes are logged on-chain.

**State set:**
- **CREATED** — vault position initialized
- **ACTIVE** — eligible for execution
- **PAUSED** — halted due to guardrail trigger, manual pause, or emergency stop
- **SETTLEMENT** — settlement/harvest and ledger reconciliation phase
- **CLOSED** — principal withdrawn and vault terminated (or inactive indefinitely)

**Key invariant:**
A vault may only execute trades in **ACTIVE** state.

---

## 4.3 Deposit Flow (USDT Only)

1) User calls deposit with:
   - amountUSDT
   - selected config reference (ConfigID / Version)

2) Protocol checks:
   - deposit >= minimum ($50)
   - config is allowlisted
   - global protocol not paused

3) Vault ledger updates:
   - principal += amountUSDT
   - vault enters ACTIVE state (or remains ACTIVE)

All deposit events emit:
- vaultId
- depositor
- amount
- configRef
- timestamp

---

## 4.4 Claim Flow (Rewards = USDT or LOOP) — Updated

Each vault maintains a user-selected `rewardPreference`:
- USDT
- LOOP

The rewardPreference can be changed by the user only while:
- vault is ACTIVE, and
- no execution is currently in-flight, and
- change is subject to cooldown to prevent gaming (optional)

RewardPreference determines which fee path applies at Profit Event time (Section 9.2).
Claims follow the vault's configured rewardPreference unless the user changes it pre-execution.

---

## 4.5 Compounding

Compounding is a vault-controlled internal transfer:

- Profit Buffer (USDT) → Principal (USDT)

This increases future trade capacity without requiring additional deposits.

**Important invariant:**
Compounding does not bypass fee assessment. Fees are assessed only on realized profit events, before funds reach the Profit Buffer.

---

## 4.6 Withdrawal of Principal (Option B - Final)

Principal withdrawal is allowed at any time **only for the portion not actively deployed**.

Define:
- `PrincipalUSDT`
- `DeployedUSDT` (currently in-flight / reserved for execution)
- `WithdrawableUSDT = PrincipalUSDT - DeployedUSDT - PendingSettlementUSDT`

Rules:
1) withdrawPrincipal(amount) MUST satisfy `amount <= WithdrawableUSDT`
2) Withdrawals are blocked if vault is in:
   - SETTLEMENT state
   - Incident Mode freeze
   - Per-vault PAUSED state due to manipulation investigation (optional policy)
3) Withdrawals MUST NOT be allowed to break atomic trade integrity.

DeployedUSDT includes any amount reserved for in-flight execution and any non-USDT transient position
created during an atomic transaction until completion/revert.

---

# 5. Strategy Execution Engine (BTCB Arbitrage PCS ↔ BiSwap)

YieldLoop executes **one strategy only**:

> BTCB/USDT arbitrage between PancakeSwap and BiSwap.

The system is not a discretionary trader. It does not predict direction. It captures spread.

---

## 5.1 Strategy Scope (Hard Allowlist)

**Chain:** BNB Chain  
**DEX venues:** PancakeSwap, BiSwap  
**Pair:** BTCB/USDT only  
**Trade type:** two-leg atomic cycle  
- buy BTCB with USDT on Venue A  
- sell BTCB into USDT on Venue B

No other routes are allowed unless explicitly added by protocol upgrade, and validated by governance/admin controls.

---

## 5.2 Arbitrage Execution Cycle

Each arbitrage attempt follows this structure:

### Step 1 — Opportunity Identification (Off-Chain)
A keeper/trader scans both DEX venues and computes:

- Expected USDT spent to acquire BTCB on Venue A
- Expected USDT received by selling BTCB on Venue B
- Estimated slippage + price impact
- DEX fee estimates
- Gas estimate (in BNB) converted to USDT terms
- MEV/failure risk buffer

The keeper creates a trade plan including:
- venueBuy
- venueSell
- amountInUSDT
- minBTCBOut
- minUSDTOut
- deadline

### Step 2 — On-Chain Execution (Atomic)
Execution module runs:

1) swap USDT → BTCB (venueBuy)
2) swap BTCB → USDT (venueSell)
3) compute realized output
4) if netProfit <= 0 → revert

**Atomic requirement:**
If the cycle cannot close profitably, it should not finalize.

---

## 5.2.1 Keeper Proposal Model (Explicit — Keepers Propose, Contract Decides)

Keepers are **proposal submitters**, not discretionary traders.

**Keeper can do:**
- submit a trade plan (`executeArb(vaultId, plan)`)

**Keeper cannot do:**
- change vault config
- bypass Rule Engine constraints
- withdraw, transfer, or seize vault funds
- force a trade that violates bounds
- force a trade if it would finalize with `Profit_USDT <= 0` (must revert where possible)

**On-chain truth:**
- The contract validates *every* plan against:
  - allowlisted venues + pair
  - oracle sanity bands
  - min profit thresholds
  - slippage caps + deadlines
  - max trade size and throttles
  - in-flight locking rules
- If any check fails: **revert**.

---

## 5.3 Execution Frequency

YieldLoop may execute:
- micro trades frequently
- or fewer larger trades

This is controlled by the Rule Engine (Section 6).

However, the system must avoid:
- overtrading (death by gas)
- slippage amplification
- MEV targeting

---

## 5.4 Profit Event Recognition

A profit event is generated only after:
- both trade legs are completed
- resulting USDT balance is strictly greater than starting USDT balance
- after execution costs are accounted for

Profit event triggers:
- performance fee routing
- crediting of user Profit Buffer
- reserve allocation bookkeeping

---

## 5.5 Execution Costs and Gas Handling (Final)

All gas on BSC is paid in BNB. YieldLoop uses a dedicated **Execution Cost Wallet (ECW)**.

### Policy
1) **No deposit skim for gas.**
   Deposits remain USDT principal. YieldLoop does not convert 1–5% of deposits into BNB.

2) ECW is funded from protocol operations revenue:
   - ECW replenishment is sourced from the Dev/Ops portion of performance fees (Section 9.4),
     via automated micro-conversions USDT → BNB when ECW is below target.

3) **BNB exposure cap (non-speculative)**
   ECW maintains:
   - `targetECW_BNB`
   - `minECW_BNB`
   - `maxECW_BNB`
   Any BNB above `maxECW_BNB` MUST be converted back to USDT and routed per policy.

4) **Deterministic cost accounting**
   For every execution, gas is measured from tx receipt as `gasBNBSpent`,
   converted to `gasUSDT` using oracle rules in Section 14.2, and included in `Costs_USDT`
   for Profit_USDT computation (Section 7.2).

If ECW is below `minECW_BNB`, executeArb() MAY be blocked until replenished to prevent
partial / unreliable operation.

---

# 6. Rule Engine + Guardrails (Safety System)

The YieldLoop strategy is simple, but its protection system must be strict. The Rule Engine is the protocol’s control layer that decides:

- whether a trade is allowed
- how large it can be
- when the strategy pauses
- how to prevent exploitation

The Rule Engine exists to prevent:
- false profit execution
- oracle manipulation
- MEV drain
- runaway trading during stress
- governance sabotage

---

## 6.1 Rule Engine: Inputs

The rule engine consumes:

- Vault balance data (principal, deployed, buffer)
- Venue data (reserves, router quotes)
- Oracle price data (BTC/USD, USDT/USD)
- Protocol health signals (fail counts, volatility bands)
- Configuration parameters (bounded)

---

## 6.2 Config System (Final Rules, Bounded)

All strategy behavior must be derived from an allowlisted configuration reference:

- **ConfigID**
- **Version Hash**
- **Activation Timestamp**

Config changes must:
- be bounded
- be timelocked
- be logged
- be revertible by emergency pause

---

## 6.3 Non-Negotiable Safety Guardrails

### Guardrail A — Oracle Sanity Band (Specified)
DEX-implied BTCB/USDT price on each venue MUST be within `oracleDeviationBps`
of the oracle reference price as defined in Section 14.2.

If violated:
- execution is blocked
- manipulation counter increments
- persistent violations may disable the affected venue automatically

---

### Guardrail B — Minimum Profit Threshold
Projected profit must exceed:

- fixedMinProfitUSDT, AND/OR
- minProfitBps of trade size

This avoids:
- trading noise
- gas bleed
- false-positive arb

---

### Guardrail C — Slippage Limits (Hard)
Each swap leg must include:

- amountOutMin
- strict deadline

If trade moves beyond allowed slippage → revert.

---

### Guardrail D — Max Trade Size
Trade size must be capped:

- maxTradeUSDT
- maxTradePctOfVault

Purpose:
- limits damage from bad fill
- reduces MEV incentive
- prevents liquidity abuse

---

### Guardrail E — Cooldown / Throttle
Prevent spam execution:

- minSecondsBetweenTradesPerVault
- minSecondsBetweenTradesGlobal

---

### Guardrail F — Failure Counter Circuit Breaker
If too many failures occur:

- revertCountPeriod
- maxRevertsBeforePause

Then:
- auto-pause vault or global execution
- require manual review/unpause

---

### Guardrail G — Daily Drawdown Circuit Breaker
If realized losses exceed threshold within time window:
- pause strategy
- enter settlement-safe mode

This prevents:
- death spirals
- keeper malfunction amplification

---

## 6.4 Emergency Controls

YieldLoop must include:

- global pause
- per-venue disable (PCS off, BiSwap off)
- per-vault pause
- config freeze

Emergency authority must be:
- multisig controlled
- auditable
- bounded
- optionally timelocked (except urgent pause)

---

## 6.5 Governance / Admin Sabotage Prevention

Because configuration changes can be weaponized, the protocol must hardcode invariants:

**These cannot be overridden by governance/admin:**
- USDT-only accounting
- profit defined only as realized USDT increase
- fee charged only on realized profit
- LOOP redemption limited by reserve
- strategy allowlist boundaries unless formal protocol upgrade

This prevents:
- malicious parameter changes
- “vote to drain users” attacks
- reputation death

---

## 6.6 Loss Handling + Keeper Accountability (Non-Revert Reality)

YieldLoop is designed to revert any execution that would finalize at `Profit_USDT <= 0`.
However, there are real-world edge cases where a transaction can finalize and still
produce adverse outcomes (e.g., partial fills, unexpected router behaviors, fee changes,
or extreme intra-block movement).

### 6.6.1 Loss Policy (Hard Rule)
- **UserVault is never charged a realized net loss from keeper execution.**
- If an execution finalizes and produces `Profit_USDT <= 0` (or any negative net delta after
  Costs_USDT), the system treats this as an **incident loss** and resolves it via keeper bond
  and/or protocol ops funds — not user principal.

### 6.6.2 Keeper Bond (Mandatory)
Each keeper MUST maintain an on-chain bond:
- `keeperBondUSDT` (or stable-equivalent) posted into a `KeeperBondVault`.

### 6.6.3 Bond Slashing Conditions (Deterministic)
Keeper bond is slashable if:
- a finalized execution produces `Profit_USDT <= 0` for the vault, OR
- the keeper violates plan integrity constraints (malformed plan fields, invalid venue routing attempts), OR
- repeated execution negligence triggers failure thresholds.

### 6.6.4 Resolution Order (Deterministic)
If a vault experiences a finalized adverse outcome, compensation occurs in this order:
1) **Slash keeper bond** up to the amount required to restore vault principal neutrality for that incident
2) If keeper bond is insufficient: draw from **Dev/Ops/Admin allocation** (protocol ops backstop)
3) If ops backstop is insufficient: enter **Incident Mode**, halt execution, and require manual remediation

### 6.6.5 Cap + Incident Mode Trigger
- Any single incident above `incidentLossCapUSDT` triggers:
  - global pause
  - keeper auto-disable
  - incident report requirement

This policy makes the strategy honest:
- keepers are economically accountable
- users are not quietly eating “execution losses”

---

# 7. Profit Definition + Profit Events

YieldLoop does not pay “yield.” It pays **verified realized profit**.

This section defines what profit is, when it exists, and what happens when it occurs.

---

## 7.1 Profit Definition (Strict)

A vault is considered profitable only if a completed execution cycle increases the vault’s USDT-denominated balance **after** accounting for all costs.

Let:

- `USDT_before` = vault USDT balance immediately before execution
- `USDT_after`  = vault USDT balance immediately after execution completes (both legs closed)
- `Costs_USDT`  = total costs expressed in USDT terms
- `Profit_USDT` = realized profit in USDT terms

Then:

`Profit_USDT = USDT_after - USDT_before - Costs_USDT`

A Profit Event exists only if:

`Profit_USDT > 0`

If `Profit_USDT <= 0`, the transaction MUST NOT generate any fee or distribution, and the execution SHOULD revert where possible.

---

## 7.2 What Counts as Costs (Mandatory)

All costs must be incorporated into profit calculations to prevent “fake yield.”

`Costs_USDT` includes:

### A) DEX Trading Fees
- Fee charged by PCS for both swaps
- Fee charged by BiSwap for both swaps
- Any router fee if applicable

### B) Slippage / Price Impact
- realized execution price impact (both legs)
- reflected in actual out amounts vs quoted amounts

### C) Execution Gas Cost (BNB → USDT Equivalent)
Gas on BSC is paid in BNB.

YieldLoop must:
- measure BNB spent for execution
- convert into USDT equivalent using a valid oracle reference
- subtract from profit

BNB gas spent is always treated as execution expense, not investment exposure.

### D) MEV / Failure Risk Buffer (Pre-Trade Estimation)
Before attempting execution, the keeper/trader must add safety buffers to projected profit requirements.

This buffer is not “paid out,” but used as a gating filter.

---

## 7.3 Oracle Requirements for Profit Validity

To prevent price manipulation and false settlement, YieldLoop uses an oracle sanity check layer.

Profit is recognized only if:
- both DEX-implied BTCB prices are within a configured deviation band of the oracle BTC reference price
- the oracle data is fresh (within staleness window)

If oracle checks fail, profit recognition is invalid and execution must be blocked.

---

## 7.4 Profit Event Lifecycle (What Happens When Profit Occurs)

When a Profit Event occurs, the vault must execute the following deterministic sequence:

1) **Compute Profit_USDT**
2) **Apply performance fee** on realized profit only (Section 9)
3) **Route fee allocations** to the defined destinations
4) **Credit remainder** into the user’s Profit Buffer (USDT)
5) **Emit ProfitEvent** on-chain

---

## 7.5 Profit Buffer Accounting

The Profit Buffer is a vault compartment that represents:
- realized net gains attributable to the user
- available for:
  - claiming in USDT
  - converting into LOOP
  - compounding back into principal

The Profit Buffer is always denominated and stored as USDT for accounting clarity.

---

## 7.6 Minimum Claim Threshold and Dust Protection

To prevent gas griefing and spam claim cycles, YieldLoop may enforce:

- `minClaimUSDT`

If the user attempts to claim below minimum, the claim reverts.

This does not change profit entitlement; it prevents operational abuse.

---

## 7.7 Settlement + Ledger Reconciliation (Defined)

YieldLoop includes a Settlement state to ensure vault accounting remains deterministic
across execution, costs, and claims.

### 7.7.1 When Settlement Occurs
Settlement may be triggered:
- on a scheduled cadence (e.g., daily or weekly), and/or
- after `X` successful Profit Events, and/or
- when Incident Mode is entered, and/or
- manually by keepers calling `settle(vaultId)` (permissioned)

### 7.7.2 What Settlement Does (Deterministic)
For a given vault, settlement performs:
1) **In-flight validation**
- confirm no execution is currently in-flight
- confirm no transient non-USDT positions exist (atomic invariant)

2) **Cost reconciliation**
- ensure `Costs_USDT` ledger matches tx receipts / gas conversion rules
- roll up any pending cost entries into the vault’s accounting

3) **Profit Buffer integrity check**
- verify Profit Buffer contains only net-of-fee realized profit outputs
- verify no direct principal contamination

4) **State normalization**
- clear any temporary flags
- update counters and rolling windows
- return vault to ACTIVE if safe, otherwise PAUSED

### 7.7.3 Settlement Failure Behavior
If settlement detects anomalies:
- vault enters PAUSED
- keepers are blocked from executing
- Incident Mode MAY trigger depending on severity thresholds
- an on-chain incident event MUST be emitted with reason code

---

# 8. Profit Buffer + Claim Mechanics

This section defines how users receive profits, how rewards are handled, and how LOOP reward selection integrates with the fee model.

---

## 8.1 Claim Types (Preference-Locked)

Each vault has a `rewardPreference` (Section 4.4) that determines the output type for claims.

- If `rewardPreference = USDT` → user may call `claimUSDT()` only
- If `rewardPreference = LOOP` → user may call `claimLOOP()` only

To switch claim output type, the user must change `rewardPreference` while the vault is ACTIVE
and not in-flight, subject to cooldown (Section 4.4). Preference at Profit Event time determines
fee path (Section 9.2) and applies until changed under valid conditions.

---

## 8.2 Claim Flow (USDT)

User calls:

`claimUSDT(vaultId, amount)`

Protocol checks:
- vault exists and is not globally frozen
- ProfitBufferUSDT >= amount
- amount >= minClaimUSDT

Then:
- reduce Profit Buffer by amount
- transfer USDT to user
- emit ClaimEvent

---

## 8.3 Claim Flow (LOOP)

User calls:

`claimLOOP(vaultId, amountUSDTEquivalent)`

This claim consumes USDT value from the Profit Buffer and converts it into LOOP under mint rules.

Protocol checks:
- ProfitBufferUSDT >= amountUSDTEquivalent
- amount >= minClaimUSDT
- LOOP mint system not paused
- reserve accounting permits minting under current rules

Then:
1) compute LOOP mint quantity:
   - `loopOut = amountUSDTEquivalent * MintMultiplier`
2) reduce Profit Buffer by amountUSDTEquivalent
3) mint LOOP to user
4) emit ClaimEvent (includes mint details)

---

## 8.4 LOOP Mint Multiplier (High-Level Rule)

LOOP is minted based on protocol-defined rules intended to:
- preserve the redemption floor
- ratchet backing upward over time
- prevent over-minting during stress conditions

The Mint Multiplier is derived from:
- reserve ratio
- recent redemption pressure
- protocol health

Mint Multiplier is never allowed to create LOOP liabilities beyond what reserve policy can support.

---

## 8.5 Compounding

Compounding converts profit into additional principal for future arbitrage participation.

User calls:

`compound(vaultId, amount)`

Protocol checks:
- ProfitBufferUSDT >= amount
- vault state eligible

Then:
- Profit Buffer -= amount
- Principal += amount
- emit CompoundEvent

Compounding does not bypass fee logic:
- platform fee is applied at Profit Event time only (realized profit)
- compounded amounts are already net of fees

---

## 8.6 Claim Independence From Trading

Claiming profits does not require trading to be paused.

However, claims may be blocked under:
- global emergency pause
- vault pause due to fraud/manipulation detection
- reserve system lock (for LOOP claims only)

USDT claims should remain operational unless protocol insolvency prevention requires temporary freeze.

---

# 9. Fee Model + Fee Routing

YieldLoop uses a performance fee model that is assessed only when real profit exists.

It is designed to be:
- honest
- deterministic
- auditable
- aligned with protocol sustainability

---

## 9.1 Fee Basis (Profit Only)

Fees are computed exclusively on:

`Profit_USDT (realized)`

Not deposits. Not AUM.

No profit = no fee.

---

## 9.2 Fee Rates — Final

Fee path is determined by the vault’s `rewardPreference` at the time a Profit Event occurs.

- If rewardPreference = USDT → fee = 20.0% of Profit_USDT
- If rewardPreference = LOOP → fee = 17.5% of Profit_USDT

Fees are assessed at Profit Event time (Section 9.3). Claims do not change historical fee basis.

---

## 9.3 Fee Timing

Fees are assessed at Profit Event time, not at claim time.

This prevents:
- claim timing manipulation
- bypass of fee logic through compounding
- ambiguous accounting

Sequence:
1) Profit Event recognized (Section 7)
2) fee calculated
3) fee routed
4) remainder credited to Profit Buffer

---

## 9.4 Fee Split Destinations (Updated — Four Buckets)

The protocol performance fee is split into **four** deterministic allocations:

1) **Dev / Ops / Admin**
- smart contract maintenance
- keeper operations + infra
- security ops
- legal/compliance overhead
- ECW replenishment source (USDT → BNB micro-conversions)

2) **Marketing / Partnerships / Onboarding**
- growth distribution
- partnerships and integrations
- user onboarding and education

3) **Reserve System Allocation**
- USDT routed directly to the ReserveSystem to back LOOP redemption

4) **LoopLabs**
- USDT routed to LoopLabs distribution module
- This is for the creation and support of LoopLabs a future nonprofit center meant to further technological development.


### 9.4.1 Configurable Splits (Bounded)
Fee split percentages MAY be adjustable only within hard bounds, and must obey:
- reserve allocation minimum threshold (never below `minReserveFeeBps`)
- ops minimum threshold (to keep protocol running)
- timelock for changes
- full on-chain event logs

### 9.4.2 Reserve Priority Rule (Retained)
If reserve health is stressed (RHI below threshold), the system MAY automatically:
- increase reserve allocation (within bounds)
- decrease marketing allocation first
- never violate ops minimums

---

## 9.5 Fee Router (Deterministic Routing)

Fee routing is handled by a dedicated FeeRouter module.

The FeeRouter must:
- receive the fee amount in USDT
- split into configured allocations
- transfer to defined addresses
- emit FeeRouted events with:
  - amounts
  - destination addresses
  - config version hash

All addresses must be:
- allowlisted
- changeable only through bounded admin/governance rules
- preferably multisig controlled

---

## 9.6 Fee Rate Invariants

The fee system must obey these invariants:

- fees apply only to realized profit
- fee rate cannot exceed configured maximum
- discounted LOOP path cannot be removed without protocol upgrade notice
- fee routing cannot violate reserve minimum requirements

---

## 9.7 Reserve Priority Rule (Anti-Run Reinforcement)

To preserve LOOP stability, the protocol may enforce a minimum reserve allocation rule:

Example:
- if reserve ratio < threshold:
  - a larger portion of fees route to reserve
  - marketing allocation reduces temporarily

This rule is deterministic and transparent and is triggered by on-chain reserve health metrics.

---

# 10. LOOP Token (Redemption Token, Not Governance)

LOOP is a protocol-issued redemption token designed to represent a claim against YieldLoop’s redemption reserve.

LOOP is not an LP token, not a speculative meme coin, and not a governance token.

Its sole purpose is:

> Provide an internal reward/redeem instrument that can be minted from verified protocol profit, held by users, and later redeemed for USDT subject to reserve availability.

---

## 10.1 LOOP Design Goals

LOOP exists to accomplish three things:

1) **Provide a reward option that reduces immediate USDT outflows**
   - users can choose LOOP instead of USDT
   - discounted fee path incentivizes LOOP selection

2) **Allow protocol to build a stable reserve-backed floor**
   - LOOP liability is explicitly tied to reserve support rules
   - redemption is capped by reserves, preventing bank-run death spirals

3) **Create a ratcheting backing model**
   - over time, backing per LOOP can increase if protocol earns and retains surplus

---

## 10.2 LOOP Is Not Governance

LOOP provides:
- no voting rights
- no admin privileges
- no parameter control
- no treasury control

All governance/admin control (if any exists) lives outside LOOP and must be explicitly defined in Section 13.

This prevents:
- governance capture by whales
- “vote to drain” scenarios
- confusion under securities scrutiny

---

## 10.3 LOOP Supply Policy

LOOP supply is:
- **variable**
- minted only under defined mint rules (Section 11)
- burned only under defined redemption rules (Section 12)

There is no presale requirement for LOOP under this model.
There is no emissions schedule.
There is no “APY token printing.”

---

## 10.4 LOOP Denomination and Accounting Unit

Even though LOOP is a token, all protocol accounting is anchored to USDT.

LOOP is minted and redeemed relative to USDT-equivalent amounts using:
- mint multiplier rules
- reserve availability rules
- oracle sanity checks

This prevents:
- LOOP price games
- “market cap illusion”
- redemption ambiguity

---

## 10.5 LOOP Utility Summary

A LOOP holder can:
- hold LOOP as a reserve-backed claim token
- redeem LOOP for USDT (subject to reserve limits)
- potentially benefit from rising backing per LOOP over time (if surplus accrues)

A LOOP holder cannot:
- demand immediate redemption beyond reserve liquidity
- vote to change rules
- extract value without profit generation

---

# 11. LOOP Minting (Profit-Backed Issuance)

LOOP may only be minted as a consequence of verified profit generation.

This section defines the rules for minting, the mint rate logic, and the hard constraints that prevent over-minting.

---

## 11.1 Minting Preconditions (Hard Requirements)

LOOP minting is permitted only if all conditions are true:

1) Vault has sufficient Profit Buffer in USDT
2) Profit buffer source was created only from verified Profit Events (Section 7)
3) Oracle layer is healthy and not stale
4) LOOP mint system is not paused
5) Reserve system is solvent per rule engine thresholds

If any condition fails, LOOP minting is blocked.

---

## 11.2 Mint Inputs

Mint function consumes:

- `amountUSDT` (USDT-equivalent taken from Profit Buffer)
- `mintMultiplier` (derived from reserve health and protocol rules)
- `configVersionHash`

Outputs:
- `loopMinted = amountUSDT * mintMultiplier`

---

## 11.3 Mint Multiplier Rule (Deterministic, Not Vibes)

LOOP does not mint 1:1 blindly. It mints within a bounded range, based on reserve health.

Example target range:
- 1.00x (minimum)
- 1.15x (maximum)

This means:
- Under strong reserve conditions, user may receive up to 1.15 LOOP per 1 USDT equivalent
- Under stressed reserve conditions, user receives closer to 1.00 LOOP per 1 USDT equivalent

**The mint multiplier must be fully deterministic and derived from on-chain variables.**

---

## 11.4 Reserve Health Index (RHI)

To avoid subjective governance abuse, the mint multiplier must be tied to a Reserve Health Index.

Define:

- `ReserveUSDT` = USDT held in the redemption reserve
- `LoopLiabilityUSDT` = total LOOP outstanding valued at redemption floor basis (protocol-defined)
- `RHI = ReserveUSDT / LoopLiabilityUSDT`

RHI bands control minting aggressiveness.

Example bands:

- **RHI >= 1.10** → mintMultiplier up to 1.15
- **RHI 1.02 – 1.10** → mintMultiplier 1.05–1.12 (linear scaling)
- **RHI 1.00 – 1.02** → mintMultiplier 1.00–1.05
- **RHI < 1.00** → minting restricted or paused

This stops LOOP from becoming unbacked debt.

---

## 11.4.1 LOOP Liability Valuation (Explicit Equation)

To remove ambiguity, LOOP liabilities are valued strictly at the redemption floor.

Define:
- `LoopSupply` = total outstanding LOOP
- `FloorUSDTPerLOOP` = current monotonic redemption floor
- `LoopLiabilityUSDT = LoopSupply * FloorUSDTPerLOOP`

Reserve Health Index becomes:
`RHI = ReserveTotalUSDT / LoopLiabilityUSDT`

(Optionally: use `ReserveAvailableUSDT` instead of `ReserveTotalUSDT` for stricter health accounting,
but the protocol MUST pick one and keep it consistent everywhere.)

---

## 11.5 Mint Caps and Anti-Debt Rules

Even with RHI, YieldLoop must enforce caps:

- Max LOOP minted per vault per day
- Max LOOP minted globally per day
- Max LOOP minted per block (optional)

Purpose:
- reduces attack surface
- prevents sudden supply shock
- avoids “print and dump” incidents

---

## 11.6 Mint Event Logging

Every mint must emit:

- vaultId
- user
- amountUSDT consumed
- loopMinted
- mintMultiplier
- reserveHealthIndex
- configVersion

This makes LOOP issuance fully auditable.

---

# 12. LOOP Redemption (Reserve-Limited, Run-Hardened)

LOOP redemption is the defining stability mechanism of the protocol.

It must be explicit, limited, and honest.

> Redemption is never “guaranteed instantly at any size.”
> Redemption is limited by available reserve liquidity.

---

## 12.1 Redemption Preconditions

A redemption transaction is allowed only if:

1) LOOP redemption system is enabled
2) Reserve is solvent and non-frozen
3) Requested redemption amount <= available reserve liquidity (or within redemption rate limit)
4) Oracle sanity checks are valid

If not satisfied:
- redemption reverts OR
- redemption enters queue mode (if implemented)

---

## 12.2 Reserve-Limited Redemption Rule (Hard Invariant)

Redemption is limited to:

`RedeemableUSDT <= ReserveAvailableUSDT`

Where ReserveAvailableUSDT is a protocol-defined reserve partition:
- excludes operational funds
- excludes protected reserve portions (if any)
- excludes pending settlement allocations (if any)

This prevents:
- bank run collapse
- reserve drain beyond solvency
- false guarantee narratives

---

## 12.2.1 Reserve Partitions (Operational Definition)

The Redemption Reserve is **partitioned**. Only the liquid, permitted partition counts as
`ReserveAvailableUSDT`.

Define:
- `ReserveTotalUSDT` = total USDT held inside the ReserveSystem contract(s)
- `ReserveAvailableUSDT` = the portion allowed for immediate redemption

### Partitions (Canonical)
1) `ReserveAvailableUSDT`
- liquid USDT available for immediate LOOP redemption, subject to rate limits

2) `ReserveProtectedUSDT`
- protected solvency buffer that cannot be redeemed
- exists to harden against runs and operational shocks

3) `ReservePendingUSDT`
- amounts reserved for:
  - queued redemptions (if queue mode)
  - in-flight settlement allocations
  - any time-locked reserve movements

4) `ReserveOpsHoldbackUSDT` (optional)
- explicit operational holdback if governance enables it (bounded)
- MUST be excluded from `ReserveAvailableUSDT`

### Computation (Hard Rule)
`ReserveAvailableUSDT = ReserveTotalUSDT
                         - ReserveProtectedUSDT
                         - ReservePendingUSDT
                         - ReserveOpsHoldbackUSDT`

### Invariant
Redemption MUST enforce:
`usdtOut <= ReserveAvailableUSDT`

---

## 12.3 Redemption Output (Floor-Ratchet Model)

YieldLoop defines an on-chain redemption floor:
- `FloorUSDTPerLOOP` starts at **1.00** at genesis.
- The floor is **monotonic non-decreasing** (it can rise, never fall).

At redemption time:
- user submits `loopIn`
- protocol computes `usdtOut = loopIn * FloorUSDTPerLOOP * (1 - redemptionSpread)`,
  subject to reserve availability and rate limits.

### Floor Ratchet Rule (Deterministic)
Let:
- `Backing = ReserveAvailableUSDT / LoopSupply`
- `ProposedFloor = Backing * (1 - floorSafetyMarginBps)`

If `ProposedFloor > FloorUSDTPerLOOP`, then:
- `FloorUSDTPerLOOP` may be updated upward (automatic or timelocked policy).

If `Backing < FloorUSDTPerLOOP`, then:
- redemption MUST throttle or pause until reserve health returns
- the floor is NOT reduced (run-hardened behavior)

---

## 12.4 Redemption Spread (Dynamic Exit Liquidity Cost)

To protect the reserve and deter rapid cycling, YieldLoop may apply a redemption spread.

Example allowed range:
- 0.5% minimum
- 2.0% maximum

This spread:
- is not “profit”
- routes directly into reserve reinforcement (or reserve recovery)

Spread must be deterministic based on:
- recent redemption volume
- reserve health index
- volatility regime
- time-weighted redemption pressure

---

## 12.5 Redemption Rate Limits (Anti-Run Throttles)

YieldLoop may enforce:
- max redemption per wallet per period
- max redemption globally per period

Example:
- maxGlobalRedeemPerDay = 2% of reserve
- maxWalletRedeemPerDay = fixed USDT cap or % of wallet LOOP

Rate limits must be:
- published
- deterministic
- configurable only within bounded ranges

---

## 12.6 Redemption Pausing and Queue Logic (Optional but Recommended)

If reserves are temporarily insufficient, the protocol may:
- pause redemptions
- enter queued redemption mode

Queued redemption must be:
- FIFO (first-in first-out)
- cancellable by user
- transparent

If queue mode is not implemented, redemption must revert cleanly when reserve is insufficient.

---

## 12.7 LOOP Burn on Redemption

When LOOP is redeemed:
- LOOP must be burned
- total outstanding supply decreases

This prevents LOOP liabilities from persisting after reserve payout.

Burn events must emit:
- redeemer
- loopBurned
- usdtPaidOut
- spreadApplied
- reserveSnapshot

---

## 12.8 Redemption Safety Halt Conditions

Redemption must automatically halt if:
- oracle stale
- reserve health index below minimum threshold
- abnormal price manipulation detected
- emergency admin pause active

This prevents attackers from redeeming into manipulated market conditions.

---

# 13. Admin / Governance Controls (Bounded + Timelocked)

YieldLoop is not a “trustless magic box.” It is a protocol that must be operated safely in real conditions.

This section defines:
- what can be changed
- who can change it
- what cannot be changed (hard invariants)
- how upgrades occur without creating rug risk

---

## 13.1 Control Model Overview

YieldLoop uses a **bounded admin + timelocked configuration model**.

This means:
- parameters can be adjusted within strict ranges
- changes are delayed (timelock)
- emergency pause is immediate (safety)
- critical invariants are immutable

This model exists to prevent two equally fatal outcomes:
1) **“No admin” chaos** (cannot halt exploits)
2) **Unbounded admin** (rug-risk perception, real rug potential)

---

## 13.2 Roles

### A) Admin Multisig (Security Council)
Emergency authority to:
- pause execution
- pause LOOP minting
- pause LOOP redemption
- disable PCS venue
- disable BiSwap venue
- freeze config updates
- trigger incident mode

Admin multisig must:
- be public
- be threshold-based (e.g., 3/5 or 4/7)
- emit all actions on-chain

### B) Timelock Controller
All non-emergency changes must flow through a timelock:
- config updates
- parameter changes
- strategy scope changes (if ever allowed)
- fee routing changes
- reserve policy adjustments (within bounds)

### C) Keeper Set (Execution Operators)
Permissioned addresses allowed to:
- call executeArb()
- call settle()
- perform upkeep actions

Keepers can be:
- allowlisted and rotated
- paused instantly if compromised

### D) Keeper Security Model (Final)

Keepers are **permissioned execution operators** allowed to call:
- executeArb()
- settle()
- upkeep hooks (pause triggers, health pings)

#### Keeper Requirements
- Keepers MUST be allowlisted.
- Keepers MUST post a refundable on-chain bond (`keeperBondUSDT` or equivalent),
  used as economic deterrence for abuse or negligence.

#### On-Chain Limits (Keepers cannot override)
All keeper-submitted trade plans MUST satisfy hardcoded Rule Engine constraints:
- maxTradeUSDT / maxTradePctOfVault
- oracleDeviationBps sanity pass
- slippage caps and strict deadlines
- minProfit thresholds
- cooldowns and global throttles

If constraints fail, the transaction reverts.

#### Failure / Abuse Handling
- Each keeper has a failure counter tracked over rolling windows.
- If failure rate exceeds `maxKeeperRevertsPerWindow`, keeper is auto-disabled.
- Admin multisig can disable any keeper instantly.
- Timelock required to add new keepers (except emergency replacement).

#### Goal
Keepers can trigger execution, but **cannot change strategy rules, steal funds, or bypass invariants**.

---

## 13.3 Hard Invariants (Cannot Be Changed)

These are protocol constitutional laws. Governance/admin cannot override them.

### Immutable Invariants
1) **USDT-only accounting**
   - profit unit = USDT
   - reserve unit = USDT

2) **Profit is realized only**
   - no mark-to-market “profit”
   - no emissions treated as profit

3) **Fees only apply on realized profits**
   - never on principal deposits

4) **LOOP redemption is reserve-limited**
   - cannot redeem more than available reserves

5) **Only allowlisted venues**
   - PCS and BiSwap only (unless full protocol upgrade)

6) **Only allowlisted pair**
   - BTCB/USDT only (unless full protocol upgrade)

7) **BNB use is non-speculative**
   - gas only
   - capped

---

## 13.4 Configurable Parameters (Bounded)

These values may be adjusted ONLY within safe ranges:

### Execution Controls
- `maxTradePctOfVault` (e.g., 0.5% – 10%)
- `maxTradeUSDT` (absolute cap)
- `cooldownSeconds` (min time between attempts)
- `maxTradesPerDay` (optional)
- `maxFailedTxPerHour`

### Safety Controls
- `oracleDeviationBps`
- `minProfitUSDT`
- `minProfitBps`
- `maxSlippageBps`

### Circuit Breakers
- `dailyDrawdownMaxBps`
- `incidentModeTriggerThresholds`

### LOOP Controls
- `mintMultiplierMin/Max` (e.g., 1.00–1.15)
- `redemptionSpreadMin/Max` (e.g., 0.5%–2.0%)
- `walletRedeemCap`
- `globalRedeemCap`

### Fees
- fee split routing percentages MAY be adjustable, but only within bounds
- reserve allocation must never fall below a reserve minimum threshold

---

## 13.5 Timelock Requirements

All parameter updates (non-emergency) require:

- queued proposal
- full disclosure of:
  - old value
  - new value
  - activation time
  - config version
- timelock delay (example: 24–72 hours)

This provides:
- community visibility
- withdrawal window
- rug prevention

---

## 13.6 Emergency Powers (Immediate)

Admin multisig may immediately:

- pause execution
- pause minting
- pause redemption
- disable DEX venue
- freeze keepers
- lock config updates

Emergency actions must be:
- reversible
- logged
- explained via incident report

---

## 13.7 Upgrade Path (Protocol Versioning)

YieldLoop upgrades are performed by:

- deploying a new implementation module
- migrating vault config references
- preserving user vault balances and ledgers

Upgrades must not:
- allow admin to seize user funds
- alter profit accounting rules
- bypass reserve limitations

---

# 14. Security Model (Oracle Sanity, MEV, Failure Modes)

YieldLoop’s core strategy is simple.
The security model is not.

This section documents attack vectors and the defense system.

---

## 14.1 Threat Model Summary

Primary threats:

1) **Oracle manipulation**
2) **DEX liquidity manipulation**
3) **MEV / sandwich / backrun drain**
4) **Keeper compromise**
5) **Router/pair migration attacks**
6) **Config sabotage (governance attack)**
7) **Redemption bank-run dynamics**
8) **Operational failure (overtrading, gas bleed)**

---

## 14.2 Oracle Sanity Layer (Mandatory, Specified)

YieldLoop uses oracles for **sanity validation and cost accounting only**.
Oracles do **not** set execution price. They prevent manipulated execution and false profit recognition.

### 14.2.1 Primary Oracle Feeds (BNB Chain)
YieldLoop MUST use a trusted decentralized oracle for:

- **BTC/USD** (reference price for sanity checks)
- **BNB/USD** (gas cost conversion into USD terms)
- **USDT/USD** (optional; if not used, USDT is treated as $1.00 with depeg protections below)

Recommended primary source: **Chainlink Data Feeds**, where available.

If USDT/USD feed is not used, `oracleUSDT_USD` MUST be treated as exactly 1.0 for all conversions.

### 14.2.2 Staleness Windows (Hard Rule)
Oracle answers MUST be considered invalid if older than:

- `maxOracleStalenessSeconds_BTC = 90`
- `maxOracleStalenessSeconds_BNB = 90`
- `maxOracleStalenessSeconds_USDT = 300` (if used)

If any required feed is stale:
- **block executeArb()**
- **block ProfitEvent recognition**
- **enter Incident Mode** if staleness persists beyond `incidentStaleThresholdSeconds`

### 14.2.3 Deviation Bands (Hard Rule)
YieldLoop computes DEX-implied BTC price from each venue quote:

- `dexPriceA = USDT_per_BTCB on PCS`
- `dexPriceB = USDT_per_BTCB on BiSwap`

Both MUST satisfy:

- `abs(dexPriceX - oracleBTC_USDT) / oracleBTC_USDT <= oracleDeviationBps`

Where:
- `oracleBTC_USDT = oracleBTC_USD / oracleUSDT_USD` (or oracleUSDT_USD = 1.0 if USDT feed not used)

If either venue violates the band:
- block execution (Guardrail A)
- increment manipulation counter
- trigger venue-disable review if persistent

### 14.2.4 USDT Depeg Protection
Even though accounting is USDT-based, USDT is not assumed perfect.
If an oracle USDT/USD feed is used, then:
- if `USDT/USD` deviates beyond `usdtDepegBps` (example 50–150 bps),
  the protocol MUST enter Incident Mode, pause minting, and may throttle redemption.

If no USDT oracle feed is used, protocol MUST implement a conservative depeg fail-safe:
- require BTC/USD oracle sanity + DEX price sanity band tightening during abnormal volatility regimes.

### 14.2.5 Gas Cost Conversion (Deterministic)
Gas costs MUST be recorded as:

- `gasBNBSpent` from tx receipt
- `gasUSDT = gasBNBSpent * oracleBNB_USD / oracleUSDT_USD` (or / 1.0)

This `gasUSDT` MUST be included in `Costs_USDT` used for Profit_USDT computation.

### 14.2.6 Failure Behavior (Non-Negotiable)
If oracle integrity is not provable (stale, reverted, extreme spike, invalid answer):
- **no execution**
- **no profit recognition**
- **minting paused**
- **redemption may throttle/pause based on RHI policy**

---

## 14.3 MEV Protection (Final)

YieldLoop is MEV-targetable because profitable arb is deterministic. Defenses are mandatory.

### 14.3.1 Private Routing (Preferred)
Keepers SHOULD submit transactions via private routing / private relays on BSC when available,
so execution does not sit in the public mempool.

If private routing is available for the keeper, it MUST be used for executeArb() submissions unless
the protocol is in emergency/manual mode.

Example class of solutions:
- private transaction relays / protect RPCs
- BSC private-tx endpoints offered by relay providers

### 14.3.2 In-Contract MEV Hardening
Every execution MUST enforce:
- strict `amountOutMin` on both legs
- short deadlines (e.g., 20–45 seconds)
- bounded trade sizing (caps reduce MEV incentive)
- cooldown/throttle (reduces predictability spam)

### 14.3.3 MEV-Aware Profit Thresholding
Rule Engine MUST require projected profit to exceed:
- gasUSDT + dexFees + slippageBuffer + mevBuffer

If not exceeded, execution is blocked.

### 14.3.4 Failure Response
If sandwich/backrun patterns are detected (high revert rate, abnormal slippage spikes):
- trigger auto-pause (Incident Mode)
- reduce maxTrade size
- tighten slippage bands until stable

---

## 14.4 Atomicity Requirement

Arbitrage is executed as a two-leg atomic cycle:

- USDT → BTCB
- BTCB → USDT

If either leg fails or results in non-profit:
- transaction reverts (preferred)
- no fee charged
- no profit logged

Atomic execution prevents stranded BTCB exposure.

---

## 14.5 Liquidity & Pair Health Checks

Trading must be blocked if:
- liquidity drops below threshold
- pair reserves become abnormal
- router call returns anomalous values
- venue is paused or unstable

Venue and pair health are first-class safety signals.

---

## 14.6 Failure Modes & Auto-Pause

YieldLoop must detect and respond to:
- repeated reverts
- abnormal slippage
- abnormal profit volatility
- too many near-zero profit attempts

Triggers:
- revert counter thresholds
- gas burn thresholds
- drawdown thresholds

Responses:
- pause vault
- pause venue
- global incident mode

---

## 14.7 Incident Mode (Defined Behavior)

If triggered, incident mode enforces:

- strategy execution disabled
- only safe operations allowed:
  - USDT profit claims (if possible)
  - principal withdrawals (if policy allows)
- LOOP minting paused
- LOOP redemption may be throttled or paused depending on reserve health

Incident mode exists to protect user funds first.

---

## 14.8 Auditability & Proof

Every meaningful action emits events:

- deposits
- executions (attempt + result)
- profit events
- fee routes
- claims
- mint/burn
- redemptions
- config changes
- pauses/unpauses

This enables:
- third-party audit
- user verification
- compliance defense

---

# 15. Risks + Disclosures

YieldLoop is an automated trading protocol.
It is not insured, not guaranteed, and not risk-free.

This section is included because pretending otherwise is dishonest and legally suicidal.

---

## 15.1 Market Risks (Spread Availability)

Arbitrage depends on persistent pricing differences between venues.

Risks:
- spreads collapse to near zero
- competition increases
- profitability becomes intermittent

Result:
- yields may decrease
- yields may become zero

---

## 15.2 Execution Risks (Slippage, Failed Trades)

Risks:
- price movement between quote and execution
- slippage exceeding tolerance
- transaction reverts
- gas price spikes

Impact:
- fewer profitable executions
- higher costs
- potential temporary halts

---

## 15.3 MEV Risks

Even with protections, MEV can:
- reduce captured profit
- cause failed execution cycles
- increase operational inefficiency

YieldLoop mitigates but cannot eliminate MEV on public blockchains.

---

## 15.4 Oracle Risks

Oracles may:
- become stale
- fail
- deviate
- be attacked upstream

YieldLoop response:
- block profit recognition
- pause execution and/or redemption until safe

---

## 15.5 Smart Contract Risk

Risks include:
- bugs
- economic exploits
- integration failures with DEX routers

YieldLoop mitigation:
- audits
- constrained scope (single pair, two venues)
- bounded parameters
- emergency pause systems

But:
> Contract risk cannot be eliminated.

---

## 15.6 Venue Risks (PCS/BiSwap)

DEX venues are external systems.

Risks:
- router upgrades
- liquidity migration
- pool changes
- governance changes
- unexpected fee model changes
- blacklists/pauses at venue level

YieldLoop must be able to:
- disable a venue instantly
- continue safe settlement

---

## 15.7 Stablecoin Risks (USDT)

USDT carries issuer and systemic risks including:
- depegging
- freezing/blacklisting risk
- regulatory intervention risk

YieldLoop uses USDT for deterministic accounting, but USDT is not risk-free.

---

## 15.8 Redemption & Liquidity Risks (LOOP)

LOOP redemption is:
- reserve-backed
- reserve-limited
- rate-limited

This means:
- LOOP redemption may be delayed
- LOOP redemption may be throttled
- LOOP redemption may be paused if reserves are insufficient or protocol safety requires

Users must understand:
> LOOP is not a guaranteed instant cash-out instrument at any size.

---

## 15.9 No Insurance / No Guarantee

YieldLoop provides:
- automated execution
- deterministic accounting
- transparent rules

It does not provide:
- insured principal
- guaranteed APY
- protection from all market conditions

Users are responsible for their own risk decisions.

---

# 16. Glossary

This glossary defines key terms as used in YieldLoop. These definitions are protocol-specific and should be treated as canonical for interpretation of this document.

---

## Accounting / Vault Terms

### **AUM (Assets Under Management)**
The total USDT principal across all active vaults under YieldLoop accounting. AUM is not profit and must not be used to imply protocol earnings.

### **Principal**
The user’s deposited capital (USDT) authorized for strategy execution.

### **Profit Buffer**
A vault compartment holding **realized, net profits** in USDT that are available for:
- claim in USDT
- conversion into LOOP (mint)
- compounding back into principal

### **Claim**
A user action that withdraws USDT profits from the Profit Buffer or converts profits into LOOP.

### **Compound**
A user action that transfers USDT from the Profit Buffer back into Principal to increase future trade capacity.

### **Vault**
A **per-deposit deployed UserVault smart contract** created via `VaultFactory`.

Each deposit deploys a new Vault (one deposit → one vault contract). A single wallet may own
multiple vaults. Vaults do not share custody or principal.

A Vault maintains isolated state and accounting including:
- Principal (USDT)
- Deployed/Active Trading Balance (USDT)
- Profit Buffer (USDT)
- Execution Cost Ledger (USDT equivalent)
- Vault Config Reference (ConfigID / Version Hash)
- Vault lifecycle state (CREATED, ACTIVE, PAUSED, SETTLEMENT, CLOSED)

A Vault is therefore **not** a pooled accounting position and **not** a shared custody bucket.

### **Vault State**
The current operational status of a vault (CREATED, ACTIVE, PAUSED, SETTLEMENT, CLOSED).

---

## Strategy / Trading Terms

### **Arbitrage**
A trading action that captures price discrepancy for the same asset pair across two venues, typically executed as an atomic buy/sell cycle.

### **Atomic Execution**
A requirement that both legs of a trade cycle complete successfully in the same transaction. If either leg fails or results in non-profit outcomes, the transaction reverts.

### **BTCB**
Binance-Peg BTC token on BNB Chain, used as the strategy asset.

### **DEX Venue**
A decentralized exchange venue used for routing swaps. YieldLoop allowlists only:
- PancakeSwap (PCS)
- BiSwap

### **Execution Cycle**
A complete arbitrage cycle:
1) buy BTCB with USDT on DEX A
2) sell BTCB into USDT on DEX B
3) verify net USDT profit after costs

### **Keeper**
An operational address allowed to trigger trade execution calls. Keepers do not control user funds, but can initiate strategy actions subject to protocol rules.

### **MEV (Miner/Maximal Extractable Value)**
The ability for third parties to front-run, back-run, or sandwich transactions to extract value from predictable or profitable on-chain actions.

### **Slippage**
Price movement and execution deviation between expected swap output and realized output due to order size, volatility, and liquidity depth.

---

## Profit / Fees Terms

### **Profit**
In YieldLoop, profit is defined only as:
> realized net USDT increase after a completed execution cycle, net of all costs.

No unrealized profit exists in protocol accounting.

### **Profit Event**
A protocol-recognized event where Profit_USDT is strictly greater than zero after:
- both legs closed
- fees
- slippage impact
- gas accounted

### **Performance Fee**
A fee charged only on realized profit events:
- 20.0% if reward is claimed in USDT
- 17.5% if reward is claimed as LOOP

### **Fee Router**
The module that deterministically routes performance fees to their assigned destinations.

---

## LOOP / Reserve Terms

### **LOOP**
A redemption token minted from verified profits and designed to be redeemable for USDT subject to reserve availability.

LOOP is:
- not governance
- not LP
- not emissions yield

### **Mint Multiplier**
A deterministic multiplier controlling how much LOOP is minted per USDT-equivalent profit consumed from the Profit Buffer. Bounded example range:
- 1.00x to 1.15x

### **Redemption**
The process of converting LOOP back into USDT, subject to:
- reserve availability
- oracle validity
- rate limits
- emergency pauses

### **Redemption Reserve**
USDT held specifically to support LOOP redemption. The reserve is partitioned and cannot be treated as general operating capital unless explicitly defined by rules.

### **Reserve-Limited Redemption**
An invariant:
> LOOP can only be redeemed up to available reserve liquidity.

There is no promise of unlimited instant redemption.

### **Redemption Spread**
A deterministic exit liquidity cost applied to LOOP redemption (example range 0.5%–2.0%) that routes to reserve reinforcement.

### **RHI (Reserve Health Index)**
A solvency ratio used to govern minting and redemption behavior:
> RHI = ReserveUSDT / LoopLiabilityUSDT

---

## Oracle / Security Terms

### **Oracle Sanity Layer**
A validation mechanism that ensures DEX-implied BTCB prices remain within bounded deviation from a trusted oracle reference price.

### **Deviation Band**
The allowed difference between DEX price and oracle price (e.g., 75 bps = 0.75%). Beyond this band, execution and/or redemption is blocked.

### **Circuit Breaker**
A protocol-defined trigger that halts execution or operations when abnormal failure, manipulation, or drawdown conditions occur.

### **Incident Mode**
A safety state where:
- strategy execution halts
- minting may pause
- redemption may throttle/pause
- only safe operations are allowed

---

## Governance / Admin Terms

### **Admin Multisig**
A multi-signature control group permitted to execute emergency actions such as pausing execution or disabling venues.

### **Timelock**
A delay mechanism for non-emergency protocol changes, requiring queued updates and delayed activation to prevent sudden malicious parameter changes.

### **Hard Invariant**
A protocol constitutional rule that cannot be overridden by admin/governance actions (e.g., USDT-only accounting, reserve-limited redemption).

---

# Appendix A — Canon Protocol Invariants (Summary)

This appendix restates the most important rules of YieldLoop in one place.

1) Deposits are USDT-only (minimum $50).
2) Vault accounting unit = USDT.
3) Strategy scope allowlist:
   - Chain: BNB Chain
   - Venues: PCS + BiSwap
   - Pair: BTCB/USDT only
4) Profit = realized net USDT increase after closed cycle + costs.
5) Fees only apply to realized profit (never principal).
6) Rewards: USDT or LOOP only.
7) LOOP minting only from verified profits under bounded multiplier rules.
8) LOOP redemption is reserve-limited and may throttle/pause under stress.
9) BNB is used only for gas, capped and non-speculative.
10) Config changes are bounded and timelocked; emergency pause is immediate.
11) All meaningful actions must emit auditable on-chain events.

---

