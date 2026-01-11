# YieldLoop  
## MVP1 Developer Whitepaper, Specification & Delivery Document  

**Author:** Todd Koletsky  
**Date:** January 11, 2026  
**Version:** v0.1  

---

## Table of Contents

1. Forward — Purpose of This Document  
2. Core Definitions (YieldLoop, LOOP, Reserve, Cycle, Settlement)  
3. System Boundaries — What YieldLoop Is (and Is Not)  
4. High-Level System Overview (MVP1)  
5. Supported Chain, DEX, and Token Model  
6. User Journey (End-to-End Flow)  

7. Smart Contract Architecture (Modules & Responsibilities)  
8. Upgradeability Model (Proxy Pattern, Versioning, Storage Safety)  

9. Token Whitelist System (Initial List + Admin/Governance Additions)  
10. Vault Model (Per-User Segregation)  
11. Deposits, Eligibility, and Access Rules  
12. Supporter Program (Access Purchase, Flags, Discounts, Limits)  

13. Strategy Engine — Grid Trading (MVP1)  
14. Trade Engine Settings Schema (User Inputs / Minimum Required)  
15. AI Populate Button — Conservative Defaults (Non-Guaranteed)  
16. User Authorization & Acknowledgement (Responsibility + Risk Consent)  

17. Execution Rules, Guardrails, and Failure States  
18. Cycle Model (30-Day Cycle + Start/End Windows + Finality Rules)  
19. Settlement Logic (Profit/Loss, Inventory, Accounting)  

20. Fees (20% Performance Fee) and Allocation Routing  
21. Reserve System (USDT/USDC Core Reserve + Coverage Ratios)  

22. LOOP Token Model (Redemption Token, Non-PCS, Non-Speculative)  
23. LOOP Minting Rules  
24. LOOP Redemption Rules (USDT + USDC)  
25. LOOP Retirement (Extinguishment Upon Redemption)  

26. System Deposit Logic (Protocol-Owned Strategy Vault)  
27. Governance / Change Control Rules (Non-Retroactivity, Cycle Immutability)  

28. Event Logging, Transparency, Proofs, and On-Chain Reporting  
29. Admin Controls, Emergency Stops, and Operational Runbooks  
30. Security Requirements & Audit Targets  

31. Deliverables Checklist (MVP1 Release Scope)

---

# 1. Forward — Purpose of This Document

This document is the authoritative technical whitepaper and delivery specification for **YieldLoop MVP1**.

It is written for:
- protocol engineers
- smart contract developers
- frontend developers
- security reviewers and auditors
- operators responsible for deployment and incident response

It defines:
- what must be built in MVP1
- what YieldLoop explicitly will not do in MVP1
- required contracts, modules, and interfaces
- execution rules and system boundaries
- data structures, guardrails, and failure states
- settlement, reserve, and redemption accounting model
- deliverables and acceptance criteria

This document is not:
- marketing
- an investment pitch
- a generalized DeFi architecture overview
- a “vision doc”

Any behavior not explicitly defined in this specification is out of scope and must not be implemented without an explicit revision of this document.

---

# 2. Core Definitions (YieldLoop, LOOP, Reserve, Cycle, Settlement)

## 2.1 YieldLoop
**YieldLoop** is a rules-based DeFi execution system operating on fixed cycles. Users deposit supported assets into segregated vault structures and authorize a constrained trading strategy engine. Results are settled at cycle end under deterministic rules.

YieldLoop is designed to:
- avoid discretionary trading behavior
- avoid mid-cycle emotional interference
- enforce time-bounded execution
- produce an explicit settlement outcome each cycle

## 2.2 MVP1
**MVP1** is the minimal fully functional version of YieldLoop that includes:
- deposits and segregated vault accounting
- a token whitelist system
- a grid trading engine (single strategy class)
- cycle-based execution boundaries
- end-of-cycle settlement
- performance fee routing
- a USDT/USDC reserve system
- LOOP minting and redemption into USDT/USDC

## 2.3 Supported Chain
YieldLoop MVP1 operates exclusively on:
- **BNB Chain**
- token standard: **BEP-20**

## 2.4 Supported DEX
YieldLoop MVP1 interacts with:
- **PancakeSwap (PCS)** only

No other DEX integrations are in scope for MVP1.

## 2.5 Whitelisted Tokens
A **whitelisted token** is a BEP-20 token explicitly approved by YieldLoop for:
- deposits (optional per token)
- trading pairs
- valuation and settlement accounting

MVP1 initial whitelist:
- **USDT**
- **USDC**
- **BTCB**
- **ETH**
- **XRP**
- **LINK**

## 2.6 User Vault
A **User Vault** is a logical and/or on-chain segregated accounting container representing a single user’s deposited capital and trading state.

Vault segregation must ensure:
- no pooling of user capital for trading
- deterministic attribution of results per user
- no cross-user profit/loss mixing

## 2.7 Cycle
A **Cycle** is a fixed execution window.

MVP1 defines:
- a nominal **30-day cycle**
- a start timestamp
- an end timestamp
- explicit finality rules

During an active cycle:
- strategy settings are locked
- asset routing rules are enforced
- settlement occurs only at the end of the cycle

## 2.8 Execution
**Execution** refers to:
- placing and managing grid orders (or their equivalent on PCS)
- swaps or position adjustments
- internal vault accounting updates required for strategy operation

Execution in YieldLoop is strictly bounded by:
- whitelist constraints
- strategy constraints
- risk and sizing limits
- cycle finality rules

## 2.9 Settlement
**Settlement** is the end-of-cycle final accounting operation which:
- calculates profit/loss (PnL)
- applies the performance fee on profit only
- routes performance fee allocations
- defines user end-cycle balances
- determines LOOP mint amounts (if applicable)
- produces final, verifiable state

Settlement must be deterministic and auditable.

## 2.10 Core Reserve
The **Core Reserve** is the protocol’s reserve backing used to support:
- LOOP redemption obligations
- reserve coverage ratios
- system solvency accounting

MVP1 Core Reserve assets:
- **USDT**
- **USDC**

No other assets may be used as reserve backing in MVP1.

## 2.11 LOOP
**LOOP** is a protocol-native **redemption token**.

LOOP properties in MVP1:
- **not tradable on PCS**
- **not intended as a speculative market token**
- minted only under protocol rules
- redeemable only under protocol rules
- redeemable into USDT and/or USDC
- supply expands/contracts based on settlement and redemption flows

## 2.12 LOOP Redemption Value (“Floor”)
The system-defined authoritative value of LOOP is its redemption value based on:
- reserve backing
- minting constraints
- redemption constraints
- coverage ratios

Market price (if any external market exists in future versions) is not authoritative.

---

# 3. System Boundaries — What YieldLoop Is (and Is Not)

## 3.1 YieldLoop Is
YieldLoop is:
- a cycle-based DeFi execution and settlement system
- a rules engine enforcing strategy boundaries
- an audit-friendly accounting system with explicit outcomes
- a redemption-backed value anchoring system (LOOP + Core Reserve)

## 3.2 YieldLoop Is Not
YieldLoop is not:
- a discretionary trading platform
- a perpetual vault with infinite adjustments
- a pooled hedge fund structure
- a “press button, guaranteed yield” product
- an insurance product
- a promise of profit or principal protection

## 3.3 MVP1 Explicit Non-Features
The following are explicitly out of scope for MVP1:
- cross-chain support
- multi-DEX routing
- lending, borrowing, or leverage
- derivatives, options, or perps
- yield farming across external protocols
- token staking programs
- NFT issuance or NFT gating
- DAO governance token model
- insurance coverage
- strategy marketplace
- copy trading

## 3.4 Design Philosophy
YieldLoop enforces discipline through:
- constrained choices
- fixed windows
- explicit acknowledgement
- deterministic settlement
- transparent accounting

YieldLoop must not be designed to:
- increase complexity for narrative value
- disguise risk
- hide losses
- smooth returns artificially

---

# 4. High-Level System Overview (MVP1)

## 4.1 MVP1 Core Components
YieldLoop MVP1 consists of:
- frontend app (wallet connect, config, authorization, dashboards)
- smart contracts (vaults, whitelist, strategy execution, accounting)
- off-chain services / keepers (cycle timers, execution triggers, monitoring)
- event logging and reporting layer
- Core Reserve and LOOP issuance/redemption system

## 4.2 MVP1 Primary User Flow
1. User connects wallet
2. User purchases Supporter Access (if required)
3. User deposits USDT, USDC, or LOOP into their vault
4. User selects strategy: Grid Trading (MVP1 only)
5. User configures strategy settings OR clicks AI Populate
6. User acknowledges:
   - non-guarantee
   - responsibility
   - risk of loss
7. Cycle begins
8. Execution occurs under bounded rules
9. Cycle ends
10. Settlement occurs
11. User receives final balances and settlement report
12. User chooses next-cycle behavior:
   - withdraw
   - carry over
   - modify settings for next cycle

## 4.3 MVP1 Operational Requirements
MVP1 must include:
- deterministic cycle timing
- deterministic settlement timing
- robust failure handling (PCS execution fails, slippage, price spikes)
- emergency controls
- full audit logging
- complete accounting integrity for vault balances

## 4.4 MVP1 Acceptance Standard
MVP1 is considered deliverable only if:
- it can execute a full cycle on-chain testnet and mainnet
- settlement outputs are deterministic and verifiable
- LOOP minting and redemption are functional
- reserve balances and coverage ratios are reportable
- user vault segregation is provably preserved
- admin controls exist and are permissioned and logged

---

# 5. Supported Chain, DEX, and Token Model

This section defines the hard technical environment and execution boundaries of YieldLoop MVP1. These constraints are not optional. If a capability is not defined here, it is not part of MVP1.

---

## 5.1 Chain Scope (BNB Chain Only)

YieldLoop MVP1 is deployed exclusively on:

- **BNB Chain**
- **EVM-compatible**
- token standard: **BEP-20**

### Requirements
The protocol must assume:

- BNB Chain gas mechanics and transaction finality behavior
- standard EVM limits (gas, reentrancy, call depth)
- BEP-20 compliance differences (some tokens implement ERC-20 poorly)
- BNB Chain RPC instability as an operational reality (build in retry logic off-chain)

### Non-Goals (Out of Scope)
YieldLoop MVP1 does **not** support:

- multi-chain deposits
- bridging
- cross-chain arbitrage
- chain selection UX
- chain-specific strategy selection

All deposits, vault balances, execution, settlement, and redemption occur on BNB Chain only.

---

## 5.2 DEX Scope (PancakeSwap Only)

YieldLoop MVP1 interacts with:

- **PancakeSwap (PCS)** only

PCS is the sole liquidity execution layer for MVP1. All swaps must route through PCS using deterministic, auditable on-chain execution.

### 5.2.1 PCS Compatibility Requirements
The system must be PCS-version explicit.

MVP1 must specify and implement **one** PCS routing standard at launch (example scope options):

- PCS Router v2 (UniswapV2-like constant-product)
- PCS Router v3 (concentrated liquidity)

The protocol must not attempt to support both simultaneously in MVP1.

### 5.2.2 Execution Rules
All execution must obey:

- whitelist-only tokens
- slippage caps (user + protocol hard limit)
- max per-trade and per-window sizing caps
- revert-safe behavior (no partial accounting)
- deterministic event emission for every action

### 5.2.3 Failure Handling
PCS execution can fail for reasons including:

- insufficient liquidity at time of execution
- slippage exceeded due to volatile movement
- MEV / sandwich effects increasing effective slippage
- fee-on-transfer tokens (must be banned by whitelist)
- token blacklists / transfer restrictions (must be banned by whitelist)

If execution fails:
- the transaction must revert OR transition to a safe failure state with no accounting corruption
- failures must emit an event describing the failure reason and code

---

## 5.3 Token Model

YieldLoop MVP1 supports three token categories. These categories exist to enforce strict accounting and prevent the common DeFi failure mode of mixing “money,” “inventory,” and “credits.”

### Category A — Core Reserve Tokens
Core Reserve tokens are stable backing assets held by the protocol to satisfy LOOP redemption obligations.

MVP1 Core Reserve tokens:

- **USDT (BEP-20)**
- **USDC (BEP-20)**

These are the only assets that may sit inside the ReserveVault in MVP1.

Reserve assets must be treated as:
- solvency-critical
- non-speculative
- non-execution inventory

They are not “strategy capital.” They are “redemption backing.”

### Category B — Whitelisted Trading Tokens
Trading tokens are allowed for execution/inventory during the cycle.

MVP1 Trading tokens:
- **BTCB**
- **ETH**
- **XRP**
- **LINK**

Trading tokens may be held temporarily as “inventory” during strategy execution but should be normalized at settlement (defined later).

### Category C — LOOP (Redemption Token)
LOOP is a **protocol-issued redemption token**.

In MVP1, LOOP is:

- **not traded on PCS**
- **not supported as an LP asset**
- **not intended as a speculative market token**
- minted only by protocol rules
- redeemed only through protocol rules into USDT/USDC

LOOP is an accounting credit unit representing a redemption claim defined by protocol rules and reserve coverage.

---

## 5.4 Token Whitelist as a Hard Wall

The whitelist is not a UX filter. It is an enforcement boundary.

If a token is not whitelisted:
- deposits must revert
- execution must revert
- settlement must never touch it
- vault should never custody it

This protects the protocol from:
- honeypot tokens
- tax tokens
- issuer blacklists
- exploit tokens
- low-liquidity traps
- “unexpected token behavior” accounting corruption

---

## 5.5 Initial Token Whitelist (MVP1)

MVP1 whitelist must include at launch:

**Reserve Tokens**
- USDT
- USDC

**Trading Tokens**
- BTCB
- ETH
- XRP
- LINK

This whitelist may be expanded post-launch only through defined admin/governance change control rules.

---

## 5.6 Pair Construction Rules (MVP1)

In MVP1, valid trading pairs must be constrained to:

- (Trading Token) / (Reserve Token)

Approved pair categories:
- BTCB/USDT
- BTCB/USDC
- ETH/USDT
- ETH/USDC
- XRP/USDT
- XRP/USDC
- LINK/USDT
- LINK/USDC

### Disallowed Pair Types (MVP1)
The following are not permitted in MVP1:

- trading-token / trading-token (e.g., ETH/BTCB)
- reserve-token / reserve-token execution loops unless explicitly required
- any pair involving non-whitelisted tokens

This restriction is deliberate to preserve:
- solvency clarity
- settlement determinism
- audit simplicity

---

# 6. User Journey (End-to-End Flow)

This section defines the required MVP1 user experience and the protocol state transitions tied to that experience. It exists to ensure engineering and frontend implementation match the actual system behavior.

---

## 6.1 UX Principles

YieldLoop MVP1 UX must enforce:

1. **Clarity**
   - the user can see exactly what the system will do
   - no vague settings or hidden behavior

2. **Consent**
   - the user must explicitly approve the strategy settings
   - the user must acknowledge that AI settings are not guaranteed

3. **Finality**
   - settings lock once the cycle starts
   - results settle at the end of the cycle with explicit outcome

4. **Verification**
   - every action should be traceable to events and settlement math

YieldLoop must not behave like:
- a discretionary trading terminal
- a “set and forget forever” vault
- a hidden strategy allocator

---

## 6.2 Required MVP1 User Flow

The following user flow is mandatory:

### Step 1 — Wallet Connect
User connects wallet.

System checks:
- chain is BNB Chain
- protocol is not globally paused
- user not blacklisted

### Step 2 — Supporter / Eligibility Gate (if enabled)
If SupporterAccess is enabled, user must either:
- purchase supporter access, OR
- already have supporter flag

If not eligible: the user can view but cannot start a cycle.

### Step 3 — Deposit
User deposits one of:
- USDT
- USDC
- LOOP

Deposits must enforce:
- minimum deposit threshold
- only whitelisted deposit tokens
- successful custody inside user vault

User must see:
- deposit credited confirmation
- current vault balances

### Step 4 — Strategy Selection
MVP1 strategy options must show:
- Grid Trading (only)

No other strategies appear in MVP1.

### Step 5 — Configure Settings OR AI Populate
User either:
- manually fills in required parameters, OR
- clicks AI Populate

AI Populate must:
- fill all required fields
- choose conservative default values
- output a configuration summary (human readable)

### Step 6 — Review Summary
Before authorization, the app must show a “strategy summary” including:

- base token
- target token
- total allocated amount
- grid bounds (low/high)
- number of grid levels
- max slippage setting
- max trade size
- inventory cap rules
- settlement conversion preference
- failure state behavior

### Step 7 — Authorization + Acknowledgement
User must sign:
- strategy settings hash
- cycle id
- timestamp
- acknowledgement flags

This signature is required to:
- start a cycle
- allow off-chain keeper execution to proceed

### Step 8 — Cycle Starts
Once started:
- cycle enters ACTIVE state
- parameters lock
- keepers may execute trades

User can view:
- open grid state
- execution logs
- balances
- unrealized PnL (optional display)

### Step 9 — Cycle Ends
At end timestamp:
- execution stops
- cycle enters SETTLEMENT state

### Step 10 — Settlement
Settlement runs deterministically:
- compute PnL
- charge performance fee on profit only
- route fees
- mint LOOP if applicable
- normalize inventory if required
- record final settlement snapshot

### Step 11 — Post-Settlement Options
User can:
- withdraw
- roll principal into next cycle
- modify settings for next cycle

---

## 6.3 Cycle Lock Rules (User UX Enforcement)

During ACTIVE cycle:
- the UI may allow the user to change “next cycle settings”
- but must clearly label them as “next cycle only”
- must not imply current cycle is affected

Users must be warned explicitly:

> “Once authorized, the strategy is locked for the current cycle.”

---

## 6.4 Settlement UX Requirements

Settlement reporting must include:

- start balances by token
- end balances by token
- realized PnL (stable-equivalent)
- performance fee charged (if any)
- fee allocation breakdown (each destination)
- LOOP minted (if any)
- reserve coverage metrics (if shown to user)
- transaction hash references
- event references (cycle id, settlement id)

The system must not hide:
- losses
- slippage costs
- execution failures

---

# 7. Smart Contract Architecture (Modules & Responsibilities)

This section defines the required contract modules and responsibilities for MVP1. Implementations may vary, but responsibilities cannot be removed.

---

## 7.1 Architectural Goals

MVP1 architecture must ensure:

- strict segregation of user funds
- explicit permission boundaries
- upgradeability without corrupting state
- deterministic settlement and auditability
- modular strategy expansion path

MVP1 must avoid:
- monolithic god contracts with mixed responsibilities
- hidden state transitions
- ambiguous accounting behavior

---

## 7.2 Required On-Chain Modules (MVP1)

### 7.2.1 ProtocolController (Core Router)
Responsibilities:
- primary entrypoint for authorized protocol actions
- routes calls to vaults, strategy engines, settlement, reserve
- enforces protocol state gating:
  - not paused
  - correct cycle state
  - whitelist checks

Must not hold user funds.

---

### 7.2.2 WhitelistRegistry
Responsibilities:
- token allowlist / denylist
- token metadata and flags
- deposit eligibility flags
- trading eligibility flags
- emergency disable per token

Must emit events:
- TokenAdded
- TokenUpdated
- TokenDisabled

Whitelist changes must be permissioned.

---

### 7.2.3 UserVaultFactory
Responsibilities:
- create/register user vault instances
- map user wallet to vault
- enforce “one vault per user” policy (unless multi-vault explicitly supported)

Must emit:
- VaultCreated(user, vault)

---

### 7.2.4 UserVault (Per User)
Responsibilities:
- custody user deposits
- track vault balances
- expose controlled interfaces to strategy engine / settlement
- enforce withdrawals according to cycle rules

Must enforce:
- only protocol controller / strategy engine can move funds during execution
- only user can withdraw (outside cycle lock rules)

---

### 7.2.5 StrategyEngine_Grid (MVP1)
Responsibilities:
- validate grid configuration
- enforce grid constraints
- execute PCS swaps under defined rules
- emit execution events for every action

Must not:
- accept arbitrary token addresses
- exceed slippage caps
- exceed size caps
- violate whitelist rules

---

### 7.2.6 CycleManager
Responsibilities:
- store cycle timestamps
- define cycle phases:
  - IDLE
  - FUNDING (optional)
  - ACTIVE
  - SETTLEMENT
  - FINALIZED

- provide gating checks for:
  - deposits
  - withdrawals
  - execution
  - settlement

Must emit:
- CycleStarted
- CycleEnded
- SettlementOpened
- SettlementFinalized

---

### 7.2.7 SettlementEngine
Responsibilities:
- compute cycle results
- define profit/loss
- charge performance fee on profit only
- route fees
- trigger LOOP minting rules
- record settlement hash

Settlement must be deterministic:
- same inputs = same output
- no external oracle reliance unless explicitly defined

---

### 7.2.8 FeeRouter
Responsibilities:
- split collected performance fee into configured buckets
- route assets to:
  - Dev wallet
  - Ops wallet
  - Marketing wallet
  - Partnerships wallet
  - ReserveVault
  - LoopLab vault/wallet
  - SystemDeposit vault

Must emit:
- FeeCharged(vault, amount, profit)
- FeeRouted(destination, amount, category)

---

### 7.2.9 ReserveVault (Core Reserve)
Responsibilities:
- custody USDT/USDC
- expose reserve reporting
- authorize RedemptionEngine payouts
- enforce redemption constraints and rate limits (if applicable)

ReserveVault must not:
- trade
- interact with PCS
- accept non-reserve tokens

---

### 7.2.10 LOOPToken (Redemption Token)
Responsibilities:
- mint/burn (protocol only)
- emit mint/burn events
- enforce transfer restrictions if defined

Key requirement:
- LOOP must not be deployed with PCS liquidity or “market enablement” in MVP1.

---

### 7.2.11 RedemptionEngine
Responsibilities:
- redeem LOOP into USDT/USDC
- burn LOOP upon redemption
- pull reserve from ReserveVault
- emit redemption proof events

Redemption must be:
- deterministic
- reserve-backed
- constrained by coverage rules

---

### 7.2.12 SupporterAccess (Eligibility Module)
Responsibilities:
- supporter purchase OR whitelist gating
- discount entitlement storage
- eligibility checks

Must emit:
- SupporterGranted(user)
- SupporterRevoked(user) (only if explicitly allowed)

---

### 7.2.13 AdminGuard / PauseController
Responsibilities:
- emergency pause controls
- per-module disable flags
- revoke permissions under incident response

Must emit:
- Paused(module, reason)
- Unpaused(module)

---

## 7.3 Roles & Permissions (MVP1)

Minimum required roles:

- DEFAULT_ADMIN_ROLE
- UPGRADE_ADMIN_ROLE
- WHITELIST_ADMIN_ROLE
- ENGINE_OPERATOR_ROLE
- SETTLEMENT_OPERATOR_ROLE
- RESERVE_OPERATOR_ROLE
- EMERGENCY_PAUSER_ROLE

Rules:
- all privileged actions must emit events
- all privileged addresses must be publishable for audit transparency

---

## 7.4 Core Accounting Integrity Requirements

The architecture must guarantee:

- user balances never disappear
- protocol cannot withdraw user funds
- strategy engine cannot call arbitrary tokens
- settlement cannot be re-run to change past results
- reserve cannot be drained except by redemption rule

All these guarantees must be enforceable in code, not “policy.”

---

# 8. Upgradeability Model (Proxy Pattern, Versioning, Storage Safety)

YieldLoop MVP1 must be upgradeable. This is not optional, because MVP1 is explicitly a foundation designed for expansion (new strategies, new tokens, new modules).

However, upgradeability is also a critical security risk. This section defines strict requirements.

---

## 8.1 Upgradeability Requirements

MVP1 must be deployed with:

- audited proxy pattern (OpenZeppelin)
- explicit initializer logic
- explicit version fields
- timelock recommended (optional for MVP1 launch, but strongly preferred)

The protocol must support safe upgrades for:
- strategy engine updates
- settlement engine updates
- whitelist registry updates
- reporting/logging enhancements

---

## 8.2 Approved Proxy Pattern

MVP1 should use ONE:
- Transparent Proxy, or
- UUPS Proxy

The chosen model must be:
- documented
- consistent across modules
- compatible with audit requirements

---

## 8.3 Storage Layout Discipline

Every upgradeable contract must:

- maintain stable storage layout
- reserve storage gaps
- never reorder existing state variables
- never change variable types
- never remove fields (only deprecate)

This is mandatory to prevent state corruption.

---

## 8.4 Upgrade Boundaries (Hard Rules)

Upgrades must never:

- rewrite past settlements
- alter prior cycle results
- change historical fee calculations
- invalidate previously signed user authorizations
- change redemption obligations retroactively

Upgrades may only apply to:
- future cycles
- future settlement calculations
- newly authorized strategies
- new whitelist additions and flags

---

## 8.5 Upgrade Event Logging

Every upgrade must emit an event that includes:

- module upgraded
- previous implementation address
- new implementation address
- executor address
- timestamp
- semantic version bump

Example required event fields:

- UpgradeExecuted(moduleId, oldImpl, newImpl, executor, version, timestamp)

---

## 8.6 Operational Requirement: Upgrade Runbook

The protocol must maintain an operational runbook describing:

- how upgrades are staged
- how upgrades are tested on testnet
- how upgrade execution is approved
- rollback procedure (if possible)
- incident handling during upgrade windows

Even if MVP1 is admin-controlled early, upgrade operations must be structured and logged.

---

# 9. Token Whitelist System (Initial List + Admin/Governance Additions)

This section defines the whitelist system as a hard enforcement layer. The whitelist is not a UI filter. It is a protocol safety boundary that prevents interaction with unsafe, illiquid, or nonstandard tokens that can break accounting, execution, or redemption integrity.

---

## 9.1 Purpose and Non-Negotiables

The whitelist exists to enforce the following:

- **Execution safety:** prevent honeypots, fee-on-transfer tokens, tokens with blacklists, tokens with transfer restrictions, and tokens that revert unpredictably.
- **Accounting safety:** prevent rebasing tokens, reflection tokens, tokens with elastic supply, and tokens with nonstandard decimals behavior.
- **Audit scope control:** auditors can validate a bounded asset universe, rather than an open attack surface.
- **Deterministic settlement:** settlement math remains stable because assets are known and behaviors are known.
- **Reserve protection:** ReserveVault must only custody reserve assets (USDT/USDC) and must never be exposed to arbitrary token risk.

The protocol must treat whitelist enforcement as a compile-time assumption: everything depends on it.

---

## 9.2 Whitelist Data Model

WhitelistRegistry must store, at minimum, the following fields per token:

- `token`: BEP-20 address
- `symbol`: human-readable symbol string (non-authoritative, informational)
- `decimals`: uint8 decimals value used for normalization
- `enabled`: master enable flag (token fully active in the protocol)
- `depositEligible`: whether deposits of this token are allowed
- `tradeEligible`: whether strategy engine may trade or hold this token
- `reserveEligible`: whether ReserveVault may custody this token (MVP1: only USDT and USDC)
- `maxSlippageBpsDefault`: recommended default slippage cap for this token
- `maxTradeSizeDefault`: recommended default per-trade size cap for this token
- `maxDailyTradeVolumeDefault`: recommended default daily cap (optional but recommended)
- `riskClass`: enum (RESERVE, BLUECHIP, MAJOR, OTHER) or similar classification
- `notesHash`: optional hash of off-chain diligence notes / review (optional but recommended for governance transparency)

If the system supports pair-level constraints (recommended), store:

- `pairEnabled[tokenA][tokenB]`: pair allowlist flag
- `pairMaxSlippageBps[tokenA][tokenB]`: pair-specific cap (optional)
- `pairMaxTradeSize[tokenA][tokenB]`: pair-specific cap (optional)

---

## 9.3 Initial Whitelist (MVP1)

MVP1 whitelist at launch must include:

### Reserve Tokens
- USDT (BEP-20)
- USDC (BEP-20)

Flags required:
- `enabled = true`
- `depositEligible = true`
- `tradeEligible = true` (only if you allow trading stable/stable or stable routing; otherwise can be true but not used)
- `reserveEligible = true`

### Trading Tokens
- BTCB
- ETH
- XRP
- LINK

Flags required:
- `enabled = true`
- `depositEligible = true` (optional; allowed if you want direct deposits in these tokens)
- `tradeEligible = true`
- `reserveEligible = false`

LOOP is not part of the PCS whitelist because:
- it is not traded on PCS
- it is not used as DEX inventory
- it is minted/redeemed under protocol rules only

LOOP eligibility is handled by protocol rules, not the PCS token whitelist.

---

## 9.4 Token Inclusion Criteria (MVP1 Hard Requirements)

A token must not be added to the whitelist unless it satisfies:

### Behavior Requirements
- not rebasing
- not reflective / fee-on-transfer
- no blacklist / freeze function that can trap funds
- no transfer hooks that change balances in unexpected ways
- standard BEP-20 transfer/approve semantics

### Liquidity Requirements (PCS)
- deep, stable liquidity in the intended pairs
- reasonable slippage at typical trade sizes
- no abnormal price manipulation risk due to thin liquidity

### Operational Requirements
- price quoting mechanism exists (PCS quote via router or oracle if later introduced)
- decimals and metadata are stable
- contract address is verified and correct (avoid fake “peg” clones)

The whitelist process must assume adversarial conditions. If a token “might be weird,” it is rejected.

---

## 9.5 Whitelist Actions and Permissions

WhitelistRegistry must support these actions:

- `addToken(token, metadata...)`
- `updateToken(token, fields...)`
- `disableToken(token)` (hard disable)
- `setDepositEligible(token, bool)`
- `setTradeEligible(token, bool)`
- `setReserveEligible(token, bool)` (must be restricted to USDT/USDC only in MVP1)
- `setPairEnabled(tokenA, tokenB, bool)` (if pair-level controls exist)

Every action must:
- be permissioned
- emit events
- be traceable and auditable

Minimum required role:
- `WHITELIST_ADMIN_ROLE`

Recommended additional controls:
- timelock for token additions (even if short)
- multi-sig control for whitelist admin keys

---

## 9.6 Emergency Token Disable Rules

WhitelistRegistry must support emergency disable of a token without redeploying contracts.

Emergency disable must be granular:

- disable trading only (tradeEligible = false)
- disable deposits only (depositEligible = false)
- full disable (enabled = false)

When a token is disabled:
- strategy engine must refuse to trade it
- vault must refuse new deposits in it
- UI must visibly warn affected users

Emergency disable must not permanently trap user funds. The protocol must define an exit path in later sections (e.g., settlement conversion rules or controlled withdrawal rules).

---

## 9.7 Required Events (Whitelist)

WhitelistRegistry must emit, at minimum:

- `TokenAdded(token, symbol, decimals, depositEligible, tradeEligible, reserveEligible)`
- `TokenUpdated(token, fieldMaskOrKey, newValue)`
- `TokenDisabled(token, reasonCode)`
- `PairEnabled(tokenA, tokenB, enabled)`

Event payloads must be sufficient for:
- explorers
- indexers
- auditors
to reconstruct the whitelist state over time.

---

# 10. Vault Model (Per-User Segregation)

This section defines the vault model. Vaults are the core safety guarantee: user funds are segregated and outcomes are attributable. MVP1 must not implement pooled trading.

---

## 10.1 Core Guarantee: Segregation

MVP1 must guarantee:

- each user’s capital is tracked independently
- no cross-user PnL mixing
- no pooled position accounting
- strategy engine actions are attributable to a single vault

Segregation may be implemented as:
- per-user vault contracts, or
- per-user accounting records inside a single contract

However, the external guarantee must be the same:
- a user’s balances and results are not impacted by another user’s activity except through protocol-wide parameters (fees, pauses, whitelist changes for future cycles).

---

## 10.2 Vault Identity and Lifecycle

Each user must have a unique vault identity.

Minimum requirements:

- `vaultOf[user] => vaultAddress`
- vault created once and reused, OR recreated with explicit migration rules
- vault version recorded for upgrade compatibility

Vault lifecycle must support:
- creation
- deposit funding
- cycle snapshots
- execution movement (controlled)
- settlement finalization
- withdrawal

If vault versions change, migration must be explicit and logged.

---

## 10.3 Vault State Requirements (Minimum Fields)

The vault must track, at minimum, the following state per cycle:

### Balance State
- balances by token (USDT, USDC, BTCB, ETH, XRP, LINK, LOOP)
- available balances vs. reserved/locked balances (if needed for execution)

### Cycle Snapshot State
- start-of-cycle snapshot (token balances + stable-equivalent valuation)
- end-of-cycle snapshot (token balances + stable-equivalent valuation)
- cycle id and timestamps

### Strategy Configuration State
- strategy id (Grid in MVP1)
- config hash (hash of settings object)
- signature reference (user authorization signature or its hash)
- allocation amount and base/target tokens

### Execution Trace State (Minimal On-Chain)
The vault does not need to store every execution detail on-chain if events are emitted, but it must store:
- the cycle id under which execution is authorized
- a nonce or replay protection value
- a last-execution timestamp or step counter (if required to bound frequency)

### Settlement State
- realized profit/loss (in stable-equivalent)
- performance fee charged amount
- fee routing summary hash (optional)
- LOOP minted amount (if applicable)
- settlement hash (a deterministic summary hash of settlement inputs/outputs)

---

## 10.4 Vault Access Control Rules

Vault must enforce strict access control:

### User Actions
User may:
- deposit eligible tokens during allowed windows
- withdraw eligible tokens during allowed windows
- authorize cycle participation via signature flow
- set “next cycle” settings (stored but not active until next cycle)

### Protocol Actions
Protocol contracts may:
- move funds for execution only when cycle is ACTIVE and authorization is valid
- move funds for settlement only when cycle is in SETTLEMENT state
- route fees at settlement only
- mint/burn LOOP only via designated engines

### Forbidden Actions
The protocol must not allow:
- admin direct withdrawal of user funds
- arbitrary token transfer calls by operators
- strategy engine access outside authorized cycle context

---

## 10.5 Deposit and Withdrawal Windows (Vault Gating)

Vault must enforce cycle gating:

- deposits allowed only when:
  - protocol state permits deposits
  - token is depositEligible
  - user is eligible (if eligibility gating is enabled)
- withdrawals allowed only when:
  - the vault is not locked by an ACTIVE cycle
  - settlement is finalized for the cycle affecting those funds
  - protocol is not paused in a way that blocks withdrawals (withdrawal pauses must be rare and explicitly justified)

The gating logic must be explicit and testable.

---

## 10.6 Vault Event Requirements

Vault must emit events sufficient to reconstruct:

- all deposits
- all withdrawals
- all cycle snapshots
- all settlement results

Minimum events:

- `Deposit(user, vault, token, amount, cycleContext)`
- `Withdrawal(user, vault, token, amount, cycleContext)`
- `CycleSnapshot(vault, cycleId, snapshotType, balancesHash, valueStableEq)`
- `SettlementRecorded(vault, cycleId, pnlStableEq, feeCharged, loopMinted, settlementHash)`

Event payloads must be designed for indexers and UIs to provide proof-backed reporting.

---

# 11. Deposits, Eligibility, and Access Rules

This section defines deposit types, deposit gating, minimums, and eligibility requirements. MVP1 must prevent ambiguous accounting by controlling *when* deposits occur relative to cycle execution and settlement.

---

## 11.1 Accepted Deposit Tokens (MVP1)

A user may deposit any of the following into their vault:

- USDT
- USDC
- LOOP

Optional (only if explicitly enabled via whitelist flags):
- BTCB
- ETH
- XRP
- LINK

Deposits must revert if:
- token is not whitelisted as depositEligible
- protocol is paused for deposits
- deposit window is closed
- amount < minimum deposit threshold for that token

---

## 11.2 Deposit Timing Rules

MVP1 must define explicit timing rules for deposits:

### Recommended Model
- Deposits allowed during:
  - IDLE state (no active cycle), and/or
  - a defined FUNDING window before cycle start

- Deposits blocked during:
  - ACTIVE cycle execution
  - SETTLEMENT computation window

This prevents:
- someone depositing mid-cycle and being counted incorrectly
- settlement math ambiguity
- manipulation of cycle snapshots

If the protocol later supports “mid-cycle top-ups,” that must be a future feature with explicit accounting rules. MVP1 should not include it.

---

## 11.3 Minimum Deposits and Dust Rules

Each deposit token must have:
- a minimum deposit threshold
- a dust threshold (optional but recommended)

Reasons:
- gas griefing defense
- UI/reporting clarity
- avoidance of micro-balance accounting bugs

Minimums must be:
- decimals-aware
- enforced on-chain
- configurable by admin/governance for future cycles only (non-retroactive)

---

## 11.4 Eligibility and Access Gating

MVP1 may implement eligibility gating via SupporterAccess.

Eligibility checks may include:

- supporter access present (if enabled)
- wallet not blacklisted
- protocol not paused
- user vault exists and is in valid state

Eligibility gating must be enforced:
- on cycle start authorization
- optionally on deposit (depending on your business model)
- always on strategy execution authorization

If gating is enabled, the UI must clearly show:
- eligible / not eligible
- the exact reason
- the remediation step (purchase access or contact support)

---

## 11.5 Blacklist Policy (Protocol-Level)

Protocol must include a blacklist mechanism for:
- sanctioned addresses (if required by compliance decisions)
- addresses known to exploit the protocol
- addresses involved in chargeback fraud (if supporter purchases can be reversed)

Blacklist must be:
- admin-controlled
- event-logged
- used sparingly
- documented in terms of what actions it blocks (deposit, start cycle, redemption, withdrawal)

MVP1 recommendation:
- blacklist should block deposits and cycle start
- blacklist should not permanently trap funds without an explicit legal/operational policy (if trapping is required, it must be disclosed and justified)

---

## 11.6 Deposit Events and Auditability

Deposits must emit events that include:
- user address
- vault address
- token address
- amount
- timestamp
- protocol state (cycle id and phase)
- whether the deposit is intended for current or next cycle funding

This is required so that:
- auditors can reconstruct funding history
- indexers can build accurate user dashboards
- disputes can be resolved with on-chain evidence

---

# 12. Supporter Program (Access Purchase, Flags, Discounts, Limits)

This section defines the **Supporter Program** as an MVP1 monetization and access-gating layer. It is not a “community feature.” It is a protocol-controlled eligibility system that can restrict participation and apply entitlement-based fee discounts.

MVP1 MUST support the Supporter Program in a minimal form that is:
- enforceable on-chain
- auditable
- simple enough to not introduce new attack surface

---

## 12.1 Purpose of the Supporter Program

The Supporter Program exists to achieve 4 goals:

1. **Fund development**
   - provide direct revenue to build and audit MVP1

2. **Gate early access**
   - limit load and user count during early, risky stages
   - reduce support and operational exposure

3. **Provide provable entitlements**
   - fee discounts
   - early access eligibility
   - feature toggles (future)

4. **Prevent protocol dependency on speculative token models**
   - MVP1 should not require LOOP trading markets
   - MVP1 should not require yield farming incentives
   - MVP1 should not rely on reflexive “token demand”

---

## 12.2 MVP1 Supporter Models (Choose One)

MVP1 must implement ONE of the following supporter models. Both may exist later, but MVP1 should not introduce unnecessary complexity.

### Model A — Supporter Pass Purchase (Recommended)
User purchases supporter access through an on-chain purchase flow.

Supporter access is stored as:
- a non-transferable entitlement flag in SupporterAccess contract, OR
- a transferable NFT (only if you explicitly want secondary trading), OR
- a non-transferable NFT (Soulbound-style), OR
- a vault entitlement record

Recommended for MVP1:
- **non-transferable entitlement flag** (simplest + cleanest enforcement)

### Model B — Whitelist Flag (Simplest)
Admin flags wallets as supporters without purchase logic.

This is acceptable for:
- private alpha
- early pilot users
- closed cohort testing

However:
- it does not produce protocol revenue
- it creates centralized manual operations
- it weakens auditability compared to purchase events

---

## 12.3 Supporter Pass Purchase Requirements (If Model A)

If Model A is selected, the purchase flow must satisfy:

### 12.3.1 Accepted Payment Tokens
Supporter purchase should accept:
- USDT
- USDC

BNB payments may be added, but MVP1 should prefer stablecoins for:
- accounting clarity
- reduced volatility reporting issues

### 12.3.2 Pricing
Supporter price is a protocol parameter.

MVP1 may implement:
- a single fixed price, OR
- phased pricing (future)

For MVP1:
- implement **single fixed price**
- phase logic is not required

### 12.3.3 Entitlement Grant
Upon successful purchase:
- the user is granted `supporter = true`
- entitlement is recorded permanently unless revoked under explicit revocation policy

Must emit:
- `SupporterPurchased(user, amount, token, timestamp)`
- `SupporterGranted(user, timestamp)`

### 12.3.4 Purchase Safety Requirements
The purchase contract must prevent:
- double-charging (must detect if already supporter)
- purchase reentrancy
- wrong-token acceptance
- purchase during protocol pause (optional, but recommended)

---

## 12.4 Discount Entitlement (Fee Reduction)

Supporter entitlements may include:
- reduced performance fee rate
- reduced or waived platform fees (if any exist later)

MVP1 discount requirement:
- supporter discount must be applied ONLY to the performance fee rate at settlement.

Example behavior:
- standard: 20% performance fee
- supporter: 19% performance fee (or other configured delta)

### 12.4.1 Discount Enforcement Rules
Discounts must be:
- computed in SettlementEngine
- applied deterministically
- included in settlement reporting events

Discounts must NOT be:
- applied mid-cycle
- changed retroactively for an already-active cycle

---

## 12.5 Supporter Revocation Policy (MVP1)

Revocation is dangerous because it can create “centralized confiscation optics.”
If revocation exists, it must be narrowly scoped and explicit.

Valid revocation triggers (examples):
- chargeback fraud (if off-chain payment was allowed — not recommended)
- proven exploit attempts
- legal compliance requirement

Revocation must:
- emit event `SupporterRevoked(user, reasonCode, timestamp)`
- not retroactively increase fees for prior settled cycles
- not lock user funds indefinitely

MVP1 recommended:
- allow revocation only by DEFAULT_ADMIN_ROLE
- revocation blocks starting new cycles
- revocation does NOT prevent withdrawal of settled balances

---

## 12.6 Supporter Feature Boundaries (MVP1)

Supporter status in MVP1 affects only:
- eligibility to start a cycle (if gating enabled)
- performance fee discount at settlement

Supporter status in MVP1 must NOT affect:
- strategy execution priority
- redemption priority
- reserve solvency obligations
- settlement determinism

---

## 12.7 Supporter Module Events (Minimum)

SupporterAccess must emit:
- `SupporterPurchased(user, payToken, payAmount, timestamp)` (if purchase exists)
- `SupporterGranted(user, timestamp)`
- `SupporterRevoked(user, reasonCode, timestamp)`
- `DiscountApplied(vault, cycleId, feeRateBps, timestamp)` (optional but recommended)

---

# 13. Strategy Engine — Grid Trading (MVP1)

This section defines the only MVP1 execution strategy: **Grid Trading**. All strategy behavior must be deterministic, bounded, and enforceable by rules. No discretionary behavior is permitted.

---

## 13.1 Strategy Objective (MVP1 Definition)

In YieldLoop MVP1, Grid Trading is defined as:

- a bounded trading strategy operating within a configured price range
- that performs repeated buy/sell swaps on PCS
- based on price movement across grid levels
- with hard constraints on:
  - inventory
  - trade size
  - slippage
  - execution frequency
  - max drawdown

It is designed to:
- capture volatility within a range
- produce repeatable execution patterns
- avoid emotional discretionary trades
- maintain auditable behavior

---

## 13.2 Strategy Assets

Grid Trading in MVP1 operates only on:

- (Target Token) / (Base Reserve Token)

Where:
- Base token ∈ {USDT, USDC}
- Target token ∈ {BTCB, ETH, XRP, LINK}

No other pairs are permitted.

---

## 13.3 Grid Model: Core Concepts

### 13.3.1 Grid Range
User config defines:
- `rangeLow`
- `rangeHigh`

These create the only valid operating band.

If market price is:
- below `rangeLow`: strategy may stop executing buys (or treat as max inventory zone)
- above `rangeHigh`: strategy may stop executing sells (or treat as max cash zone)

MVP1 must explicitly define behavior for out-of-range conditions.

### 13.3.2 Grid Levels
User config defines:
- `gridLevels` (N)

The system constructs N discrete levels between low and high.

Grid spacing can be:
- linear (equal spacing)
- logarithmic (optional future enhancement)

MVP1 recommended:
- linear spacing only

### 13.3.3 Allocation
User config defines:
- total capital allocation from vault balance

Allocation must:
- be capped by available balance
- be locked for the cycle (cannot be changed mid-cycle)

---

## 13.4 Execution Triggers

Grid execution must be triggered by:

- keeper / operator calls (off-chain automation)
- or user-authorized automation

MVP1 must NOT require:
- continuous block-by-block execution
- high-frequency micro-execution that invites MEV losses

Execution must:
- be rate-limited
- be bounded by max operations per time window

---

## 13.5 Execution Safety Rules

Grid strategy must enforce:

### 13.5.1 Slippage Constraints
Two layers:
- user slippage tolerance (from config)
- protocol maximum slippage cap (hard limit)

Trade must revert if:
- expected output falls below minOut threshold

### 13.5.2 Trade Size Constraints
Trade sizing must enforce:
- max per-trade size
- max daily trade volume
- max % of allocation per execution step

### 13.5.3 Inventory Constraints
Protocol must enforce:
- max % held in target token
- max % held in base token

These prevent:
- the grid becoming a full directional bet
- runaway inventory accumulation during trends

### 13.5.4 Drawdown Guardrail
Protocol must define a drawdown constraint that can:
- freeze execution for remainder of cycle
- force settlement conversion into reserve
- or enter “safe mode”

MVP1 can implement a simple guard:
- if stable-equivalent value drops below X% of start snapshot, halt execution

---

## 13.6 Strategy State Machine (MVP1)

The grid engine must have an explicit state machine. At minimum:

- `CONFIGURED`
- `ACTIVE`
- `HALTED` (due to rule violation or drawdown)
- `OUT_OF_RANGE` (price outside bounds)
- `SETTLEMENT_PENDING`
- `FINALIZED`

Every state transition must emit events.

---

## 13.7 Strategy Execution Events

Strategy engine must emit events for:

- configuration accepted
- each trade execution attempt
- each successful trade (amountIn, amountOut, pair, slippage)
- each failed trade (reason code)
- each guardrail activation (which rule triggered)
- each state transition

These events are required for:
- user transparency
- settlement proof reconstruction
- operational monitoring

---

# 14. Trade Engine Settings Schema (User Inputs / Minimum Required)

This section defines the minimum configuration required to execute grid trading. MVP1 must enforce that the user cannot start a cycle without either:
- providing required settings manually, OR
- applying a complete AI-generated configuration

---

## 14.1 Strategy Configuration Object

The strategy configuration must be represented as a structured object with a stable encoding and hash.

Recommended:
- encode config via ABI encoding
- hash config into `configHash`
- store `configHash` on-chain
- require EIP-712 signature over `configHash`

---

## 14.2 Required Inputs (Minimum)

To run grid trading, the user must define at minimum:

### Asset Selection
- `baseToken` (USDT or USDC)
- `targetToken` (BTCB/ETH/XRP/LINK)

### Grid Range
- `rangeLow` (price)
- `rangeHigh` (price)

Constraints:
- rangeHigh > rangeLow
- both within plausible bounds (optional validation)

### Grid Density
- `gridLevels` (integer)
Constraints:
- min gridLevels (e.g., 5)
- max gridLevels (e.g., 200)
Exact bounds are protocol parameters.

### Capital Allocation
- `allocationAmount` (amount of base token committed to grid)

Constraints:
- allocationAmount <= available balance
- allocationAmount >= min allocation threshold

### Execution Safety Controls
- `maxSlippageBps`
- `maxTradeSize`
- `maxTradesPerDay` (optional but recommended)
- `maxInventoryTargetPct`
- `maxDrawdownPct`

These inputs may be fully user-defined OR pre-filled via AI Populate, but must always exist.

---

## 14.3 Optional Inputs (MVP1 May Include)

Optional configuration inputs include:

- `cooldownSeconds` between executions
- `executionWindowHours` (execute only in certain hours)
- `rebalancePreference`
- `rangeRecenterRule` (NOT recommended for MVP1; introduces discretion logic)
- `settlementConversionRule`:
  - convert-to-stables at settlement (recommended default)
  - retain inventory (optional; increases complexity)

MVP1 recommended:
- settlementConversionRule default to convert-to-stables

---

## 14.4 Validation Rules (Must Be On-Chain)

Before a cycle can start, config must pass validation:

- baseToken whitelisted and enabled
- targetToken whitelisted and enabled
- pair allowed
- allocation within vault balances
- slippage within protocol cap
- trade sizing within protocol caps
- drawdown rules within protocol allowed ranges
- gridLevels within allowed bounds
- range is valid and non-zero

If any validation fails:
- configuration is rejected
- cycle cannot be started

---

## 14.5 Config Hashing and Determinism

The config must be hashed and stored for proof:

- `configHash = keccak256(abi.encode(config))`

The UI must display:
- the config hash
- the exact parameter values
- a summary explanation

Settlement reporting must reference:
- config hash
- cycle id
so that any observer can verify the cycle behavior was authorized as configured.


---

# 15. AI Populate Button — Conservative Defaults (Non-Guaranteed)

This section defines the AI Populate feature as a **configuration assistant**, not a trading system and not an advisor. Its purpose is to reduce onboarding friction while preserving YieldLoop’s core principles: explicit consent, bounded execution, and personal responsibility.

AI Populate is optional. Users can configure manually. But if AI Populate is offered, it must be implemented with strict safeguards to prevent false trust and to preserve auditability.

---

## 15.1 Purpose

AI Populate exists to:

- reduce the cognitive load of configuring a grid strategy
- provide conservative defaults for users who do not know what settings to choose
- produce a complete configuration object that still requires user approval

AI Populate does NOT exist to:
- guarantee profit
- optimize returns beyond safety constraints
- adapt the strategy mid-cycle
- “think” during execution

YieldLoop MVP1 is a rules system, not a live AI trading bot.

---

## 15.2 MVP1 Requirements (Hard Rules)

AI Populate must satisfy these hard requirements:

1. **Produces a complete config**
   - AI Populate must fill all required fields defined in Section 14.

2. **Conservative posture**
   - the output must always bias toward:
     - lower frequency
     - lower allocation
     - tighter slippage caps
     - lower inventory risk
     - tighter drawdown stop rules

3. **Deterministic recording**
   - the final configuration must still be hashed and signed (configHash)
   - the system must not store “AI intent” — only the resulting parameter set

4. **No mid-cycle modification**
   - AI output is used only pre-cycle
   - strategy settings remain locked during active cycle

5. **User must approve**
   - AI output must always be editable
   - user must explicitly acknowledge responsibility

---

## 15.3 AI Populate Inputs (Allowed)

AI Populate may use only:

- token selected (base + target)
- user allocation amount (or user max allocation limit)
- current PCS pool liquidity and price data
- historical volatility approximations (if available)
- protocol hard limits

AI Populate must not use:
- off-chain custodial signals
- user identity, KYC, or profiling
- any “performance promise” mechanism

---

## 15.4 AI Populate Output Schema

AI Populate must output a complete StrategyConfig object including:

### Core
- `baseToken`
- `targetToken`
- `allocationAmount`

### Grid
- `rangeLow`
- `rangeHigh`
- `gridLevels`

### Safety Rules
- `maxSlippageBps`
- `maxTradeSize`
- `cooldownSeconds` (if used)
- `maxTradesPerDay` (if used)
- `maxInventoryTargetPct`
- `maxDrawdownPct`

### Settlement Preference
- `settlementConversionRule` (recommended: convert-to-stables)

### Human-Readable Explanation (UX Output Only)
AI Populate must also generate a UX summary:

- “Why these settings were chosen”
- “What failure scenarios look like”
- “What these settings do NOT protect against”

This explanation is informational only and is not relied upon by the protocol.

---

## 15.5 Conservative Defaults (MVP1 Guidance)

The following are recommended conservative defaults.

These are examples and should be parameters stored in the protocol config so they can be modified for future cycles without redeploy.

### Grid Levels
- default N = 20–40
- clamp between min=5 and max=200

### Allocation
- default: 25–50% of available base token balance
- clamp by protocol max allocation per vault

### Slippage
- default: 30–75 bps depending on token
- clamp by protocol hard max (example: 150 bps)

### Trade Size
- default: 2–5% of allocation per execution step
- clamp by token liquidity

### Inventory Cap
- default max target inventory: 40–60%
- ensures grid does not become a directional hold

### Drawdown Stop
- default: 10–20% drawdown halt threshold
- behavior on trigger must be defined in Section 17

---

## 15.6 Legal / Consent Boundary

AI Populate must include explicit disclaimer language:

- “This configuration is not financial advice.”
- “This configuration is not guaranteed to be profitable.”
- “You are responsible for reviewing and approving all settings.”
- “You can lose money.”

The system must ensure:
- these disclaimers are visible
- consent is recorded by signature flags

---

## 15.7 Auditability Requirements

AI Populate must not reduce auditability.

The protocol must be able to show:

- final config parameters
- configHash
- user signature over configHash
- cycle id linkage

Nothing about “AI” should be required to validate the settlement.

The system must remain:
- deterministic
- provable
- reviewable by third parties

---

# 16. User Authorization & Acknowledgement (Responsibility + Risk Consent)

This section defines the consent and authorization model. YieldLoop MVP1 must not begin execution for a user unless the user has explicitly authorized the strategy configuration and acknowledged responsibility.

Authorization is not “terms and conditions.”
Authorization is the binding consent layer that makes the system legitimate, defensible, and verifiable.

---

## 16.1 Authorization Requirements (Hard Rules)

Before a cycle starts for a user vault:

- the user must approve the final StrategyConfig parameters
- the user must sign an authorization message that references:
  - configHash
  - vault identity
  - cycle id
  - timestamp
  - acknowledgement flags

No signature = no cycle participation.

---

## 16.2 What the User Must Acknowledge

The consent layer must include explicit acknowledgements.

Minimum required acknowledgements:

1. **Non-guarantee**
   - “This system may lose money.”
   - “Profit is not guaranteed.”

2. **Strategy lock**
   - “Settings are locked for the duration of the cycle.”

3. **Responsibility**
   - “I am responsible for reviewing and approving the settings.”

4. **AI disclaimer**
   - if AI Populate was used:
   - “AI-generated settings are not guaranteed and may be wrong.”

5. **Protocol constraints**
   - “Execution may fail due to DEX conditions (slippage, liquidity, volatility).”
   - “Emergency pauses may occur.”

6. **Accounting finality**
   - “Settlement is final at cycle end.”
   - “No retroactive modification.”

---

## 16.3 Authorization Message Structure

MVP1 should use:

- **EIP-712 typed structured data signing**

Required signed fields:

- `user`: wallet address
- `vault`: vault address
- `cycleId`: uint256
- `configHash`: bytes32
- `strategyId`: uint256 (Grid = 1, for example)
- `timestamp`: uint256
- `ackFlags`: bitmask (or struct of booleans)
- `nonce`: anti-replay

The signature must be stored or referenced on-chain via:

- event emission (signature hash)
- and/or storage record in vault state

---

## 16.4 Authorization Storage Requirements

The protocol must store:

- configHash
- signature hash (or signature itself if needed)
- authorization timestamp
- authorization nonce
- ackFlags
- cycleId linkage

This ensures:
- disputes can be resolved
- auditors can prove consent occurred
- settlement logic can prove it operated under authorized parameters

---

## 16.5 Cycle Lock Enforcement

Once authorization is accepted and the cycle starts:

- the config becomes immutable for that cycle
- the strategy engine must reject any config changes
- the UI may allow “next cycle” edits but must not imply they affect the active cycle

Immutability must be enforced on-chain, not by frontend only.

---

## 16.6 Authorization Failure Modes

Authorization must fail if:

- cycle is not in a valid pre-start state
- vault has insufficient balance for allocation
- config fails validation checks
- whitelist disallows token pair
- signature is invalid or replayed
- protocol is paused

Failures must emit events such as:

- `AuthorizationRejected(vault, cycleId, reasonCode)`
- `AuthorizationAccepted(vault, cycleId, configHash)`

---

## 16.7 UX Requirements for Consent

Frontend must display:

- the full config parameters in human-readable form
- a “diff” if user modified AI settings
- acknowledgement checkboxes
- a summary of worst-case scenarios

User must not be allowed to sign if:

- acknowledgements not checked
- required fields missing
- config not validated

---

# 17. Execution Rules, Guardrails, and Failure States

This section defines execution boundaries. YieldLoop MVP1 must enforce guardrails in code. Guardrails are not suggestions. They are the mechanism that prevents grid execution from becoming unbounded risk.

---

## 17.1 Execution Guardrails (MVP1 Must Enforce)

StrategyEngine_Grid must enforce:

### 17.1.1 Whitelist Enforcement
- only trade between whitelisted token pairs
- reject any call with non-whitelisted token addresses

### 17.1.2 Slippage Caps
Two-layer model:
- user-configured slippage cap
- protocol maximum slippage cap

Effective slippage cap:
- `min(userMaxSlippageBps, protocolMaxSlippageBps)`

All swaps must use:
- minOut constraints

### 17.1.3 Max Trade Size
Trade sizing must be bounded by:
- user maxTradeSize
- protocol maxTradeSize

Max trade size can be expressed as:
- absolute amount OR
- percentage of allocation OR
- percentage of vault balance

MVP1 recommendation:
- percentage of allocation + absolute cap

### 17.1.4 Max Execution Frequency
Grid must enforce:
- cooldown between executions
- max trades per day (or per cycle)

This protects against:
- MEV bleed
- operator mistakes
- runaway loops

### 17.1.5 Inventory Caps
Grid must enforce inventory caps such as:
- target token holdings cannot exceed X% of total value
- base token holdings cannot drop below Y%

Inventory caps prevent:
- the grid becoming a full directional bet
- accumulating too much risk asset during downtrends

### 17.1.6 Drawdown Guard
Drawdown must be measured relative to start-of-cycle stable-equivalent valuation.

If drawdown exceeds threshold:
- execution must halt OR enter safe mode
- system must emit guardrail activation event

---

## 17.2 Out-of-Range Behavior

When price is outside configured grid range:

### Above rangeHigh
- strategy should not buy
- may sell if inventory exists and sells are within constraints
- may pause executions

### Below rangeLow
- strategy should not sell
- may buy only if inventory caps allow and rules permit
- may pause executions

MVP1 recommended approach:
- out-of-range => **no new exposure added**
- prefer halting new buys below rangeLow and new sells above rangeHigh

---

## 17.3 Failure States (Execution)

Execution failures include:

- slippage exceeds limit
- PCS liquidity too thin
- swap reverts
- token transfer fails
- cooldown prevents execution
- daily limits exceeded
- token pair disabled mid-cycle (rare but must be handled)

On failure:
- no accounting corruption
- revert transaction OR record failure event
- engine state remains coherent

Minimum failure event:
- `ExecutionFailed(vault, cycleId, reasonCode, detailsHash)`

---

## 17.4 Emergency Pause Effects

If PauseController triggers:

- execution must stop immediately
- deposits may be paused
- withdrawals should remain enabled if safe
- settlement may proceed only if safe and consistent

Emergency pause must:
- emit events with reason codes
- be visible in UX

---

## 17.5 Keeper / Operator Constraints (If Used)

If execution requires keeper bots:
- keeper can only call engine functions that are:
  - permissioned
  - bounded
  - vault-specific
  - cycle-state gated

Keeper must never be able to:
- drain funds
- bypass whitelist
- bypass slippage and sizing rules
- execute when authorization is absent

The keeper is a trigger, not a controller.

---

## 17.6 Execution Proof Requirements

Every successful execution action must emit:

- vault id
- cycle id
- tokenIn
- tokenOut
- amountIn
- amountOut
- slippage bps (actual)
- PCS tx references
- timestamp

This ensures that settlement proof can be reconstructed without trust.

---

# 18. Cycle Model (30-Day Cycle + Start/End Windows + Finality Rules)

This section defines YieldLoop’s core execution primitive: the **fixed cycle**. YieldLoop is not a continuously adjustable vault. It is a time-boxed execution system that forces:
- pre-commitment
- bounded behavior
- deterministic settlement
- audit-friendly finality

MVP1 must implement this model explicitly and enforce it on-chain.

---

## 18.1 Cycle Concept (MVP1 Definition)

A **Cycle** is a bounded time interval during which:

- user capital is committed to an authorized strategy configuration
- execution occurs only under that configuration and only within defined guardrails
- the user cannot change strategy parameters mid-cycle
- final balances are produced at settlement and recorded as final

YieldLoop is designed to eliminate the most common destructive behavior in DeFi:
- panic selling
- mid-trade meddling
- constantly changing settings
- chasing volatility without discipline

The cycle is the contract between:
- user and protocol
- strategy and accounting
- execution and settlement truth

---

## 18.2 Cycle Duration

MVP1 cycle duration is:

- **30 days** (nominal)

Implementation note:
- cycle timing must be defined using timestamps
- cycle boundaries must be deterministic
- off-chain keepers may trigger actions, but the authoritative truth is on-chain

The protocol must define:
- cycle start timestamp
- cycle end timestamp
- settlement open timestamp
- settlement finalization timestamp (or window)

---

## 18.3 Cycle Phases (State Machine)

MVP1 must implement cycle phases as an explicit state machine.

Minimum required phases:

1. **IDLE**
   - no active cycle
   - deposits allowed
   - configuration allowed
   - withdrawals allowed

2. **FUNDING** (optional but recommended)
   - pre-cycle funding window
   - deposits allowed
   - configuration allowed
   - cycle not yet active

3. **ACTIVE**
   - execution allowed
   - deposits typically blocked
   - withdrawals blocked (unless emergency rules exist)
   - config locked for the cycle

4. **SETTLEMENT**
   - execution stopped
   - settlement computation begins
   - withdrawals still blocked until settlement finalizes

5. **FINALIZED**
   - settlement completed
   - withdrawals allowed
   - next-cycle configuration allowed

The protocol must not allow ambiguous overlaps such as:
- deposits while settlement is running
- config changes while active
- execution after settlement begins

---

## 18.4 Deposit + Withdrawal Gating by Cycle Phase

The protocol must strictly enforce which user actions are allowed per phase.

### Deposits
Allowed in:
- IDLE
- FUNDING

Blocked in:
- ACTIVE
- SETTLEMENT

### Withdrawals
Allowed in:
- IDLE
- FINALIZED

Blocked in:
- FUNDING (optional; can allow but complicates readiness)
- ACTIVE
- SETTLEMENT

MVP1 recommended:
- allow deposits only before cycle begins
- allow withdrawals only after settlement finalizes

---

## 18.5 Parameter Lock Rules

Once a vault is committed to a cycle (authorization accepted):

- config becomes immutable for the cycle
- strategy engine must reference the stored configHash
- any attempted updates must revert

This must be enforced on-chain.

Users may create/update “next cycle config” but:
- it must be stored separately
- must not affect the active configHash

---

## 18.6 Cycle Participation Model (Per-Vault Participation)

MVP1 can implement cycles as:

### Model A — Global Cycle
All vaults share the same cycle start/end timestamps.

Pros:
- simple
- clear settlement schedule
- easier monitoring and reporting

Cons:
- creates “rush windows” for deposits
- users must align schedule

### Model B — Per-Vault Cycle
Each vault has its own cycle start/end.

Pros:
- user-friendly flexibility
- no rush windows

Cons:
- higher operational complexity
- more settlement events
- harder monitoring

MVP1 recommendation:
- **Global Cycle** model

If Global Cycle is used:
- cycleId increments every 30 days
- user vaults join that cycle by authorizing before the start timestamp

---

## 18.7 Settlement Window

Settlement must be structured and predictable.

MVP1 must define:
- settlement open time (cycle end)
- settlement allowed window
- settlement finality trigger rules

Settlement should be:
- triggered by keeper/operator
- verifiable
- idempotent (cannot be run twice to change outcome)

---

## 18.8 Finality Rules (Non-Retroactivity)

Once settlement is finalized:

- results are final
- fee routing is final
- LOOP minting is final
- reserve changes are final

The protocol must not permit:
- re-running settlement
- altering settlement math
- retroactively applying parameter changes

Any later upgrades apply to future cycles only.

---

## 18.9 Cycle Event Requirements

CycleManager must emit events at every critical boundary.

Minimum required events:

- `CycleCreated(cycleId, startTs, endTs, settlementOpenTs)`
- `CyclePhaseChanged(cycleId, oldPhase, newPhase, timestamp)`
- `CycleStarted(cycleId, timestamp)`
- `CycleEnded(cycleId, timestamp)`
- `SettlementOpened(cycleId, timestamp)`
- `SettlementFinalized(cycleId, timestamp)`

These events are required for:
- UI schedule display
- indexing
- audit verification
- operator runbooks

---

# 19. Settlement Logic (Profit/Loss, Inventory, Accounting)

This section defines the most important enforcement point in YieldLoop: **settlement**.

Everything the system claims — honesty, rules, accountability — becomes real only at settlement.

Settlement must be:
- deterministic
- conservative
- auditable
- resistant to manipulation
- incapable of retroactive modification

---

## 19.1 Settlement Overview

Settlement occurs once per cycle and produces:

- final vault balances per token
- stable-equivalent valuation outcome
- realized profit or loss (PnL)
- performance fee charged (profit-only)
- fee allocations routed
- LOOP minted (if applicable)
- settlement proof record

Settlement is not a UI report.
Settlement is the canonical truth for that cycle.

---

## 19.2 Settlement Inputs (Authoritative Data)

Settlement engine must use:

### Vault Snapshot Inputs
- start-of-cycle balances (snapshot)
- end-of-cycle balances (snapshot)
- inventory balances per token

### Execution Proof Inputs
- events emitted by StrategyEngine_Grid
- internal vault accounting movements
- PCS transaction outputs (amountIn/amountOut)

### Pricing Inputs
MVP1 must define stable-equivalent valuation method.

Options:
- PCS spot price from router at settlement timestamp
- time-weighted average price (TWAP) from PCS (preferred if available)
- oracle (future; not recommended MVP1 unless necessary)

MVP1 recommendation:
- use PCS TWAP if PCS version supports it cleanly
- otherwise use router quote with strict constraints

---

## 19.3 Stable-Equivalent Valuation

Settlement must compute value in a stable-equivalent unit (SEV):

- SEV is denominated in USDT or USDC (normalized)
- BTCB/ETH/XRP/LINK inventory must be priced into SEV

Valuation must be conservative:
- do not assume perfect liquidity
- do not use optimistic mid-price if it cannot be executed

MVP1 conservative approach:
- value inventory using PCS quote with slippage haircut, OR
- force conversion at settlement (recommended), which converts uncertainty into realized amounts

---

## 19.4 Profit/Loss Definition

Define:

- `StartValueSEV` = stable-equivalent value at cycle start snapshot
- `EndValueSEV` = stable-equivalent value at cycle end snapshot (after forced normalization if used)

Then:

- `PnL = EndValueSEV - StartValueSEV`

### Profit
Profit exists only if:
- `PnL > 0`

### Loss
Loss exists if:
- `PnL < 0`

### Break-even
If `PnL == 0`:
- no fee charged
- settlement still finalizes with reporting

---

## 19.5 Profit-Only Performance Fee

Performance fee is charged only when:
- `PnL > 0`

Fee base:
- `Profit = PnL`

Fee charged:
- `Fee = Profit * FeeRate`

FeeRate:
- standard: 20%
- supporter-adjusted: discounted fee rate

No fee is charged on:
- principal
- losses
- withdrawals

Fee must be computed deterministically with explicit rounding rules.

---

## 19.6 Settlement Inventory Normalization (MVP1 Strong Recommendation)

MVP1 should normalize all inventory to reserve tokens at settlement:

- convert BTCB/ETH/XRP/LINK into USDT/USDC at settlement
- ensure end-of-cycle balance is primarily stable

Reasons:
- simplifies valuation
- makes PnL real, not theoretical
- reduces dispute risk
- aligns accounting with Core Reserve model
- reduces exposure to holding volatile inventory into next cycle by accident

If normalization is not used:
- the protocol must define valuation haircuts and explicit conversion assumptions
- MVP1 will be harder to audit and easier to dispute

---

## 19.7 Settlement Ordering Rules

Settlement must execute in the following deterministic order:

1. Freeze execution (no trades allowed)
2. Snapshot vault balances
3. Normalize inventory if enabled
4. Compute EndValueSEV
5. Compute PnL
6. If Profit:
   - compute fee
   - deduct fee from vault
   - route fee allocations
7. Record settlement outputs + hash
8. Mint LOOP if applicable (rules defined in LOOP sections)
9. Finalize cycle state for vault
10. Emit events

This ordering must be identical for all vaults.

---

## 19.8 Settlement Failure Handling

Settlement can fail due to:
- PCS conversion failure
- token disabled mid-cycle
- reserve token liquidity issues
- unexpected revert

Settlement failure must:
- not corrupt balances
- not partially route fees
- be retryable safely
- emit failure event with reason code

Required failure event:
- `SettlementFailed(vault, cycleId, reasonCode, detailsHash)`

---

## 19.9 Settlement Event Requirements

SettlementEngine must emit events including:

- `SettlementComputed(vault, cycleId, startValueSEV, endValueSEV, pnlSEV)`
- `PerformanceFeeCharged(vault, cycleId, profitSEV, feeRateBps, feeAmount)`
- `SettlementFinalized(vault, cycleId, finalBalancesHash, settlementHash)`

These events must allow any observer to verify:
- that profit fee was only applied on profit
- that settlement math is reproducible
- that the final state matches chain balances

---

# 20. Fees (20% Performance Fee) and Allocation Routing

This section defines fee mechanics. YieldLoop MVP1 charges a performance fee only on profit. Fee routing must be deterministic, transparent, and resistant to manipulation.

---

## 20.1 Fee Type (MVP1)

MVP1 implements:
- **Performance fee on profit only**

No other protocol fees are required in MVP1 unless explicitly added later.

There is no:
- deposit fee (unless later added explicitly)
- withdrawal fee (unless later added explicitly)
- staking fee
- management fee

---

## 20.2 Fee Rate

Default fee rate:
- **20%** of profit

Supporter discounted fee rate:
- reduced fee rate (example: 19%)
- exact value is protocol parameter

Fee rate must be:
- stored in protocol config
- applied at settlement
- immutable for the active cycle once the user authorizes participation

---

## 20.3 Fee Base (Profit Only)

Fee is charged only if:
- `Profit > 0`

Fee base:
- profit measured in stable-equivalent unit

Fee must never be charged on:
- principal
- losses
- unrealized gains

This rule is non-negotiable.

---

## 20.4 Fee Allocation Split (of the 20%)

In MVP1, the total performance fee is split as:

- Dev: 10%
- Ops: 10%
- Marketing: 10%
- Partnerships: 10%
- System Reserve: 30%
- LoopLab (Proof of Impact): 25%
- System Deposit: 5%

Total = 100% of the collected performance fee.

These allocations must be:
- stored as configurable parameters
- applied deterministically
- changeable only for future cycles (non-retroactive)

---

## 20.5 Fee Routing Assets

FeeRouter must define what assets fees are routed in.

MVP1 recommended:
- route fees primarily in USDT/USDC
- if fees originate in volatile inventory, normalize before routing

This prevents:
- protocol holding volatile inventory unintentionally
- fee recipients receiving volatile exposure
- ambiguous accounting

---

## 20.6 Fee Routing Order

Fee routing must occur after settlement profit is computed:

1. settlement computes profit
2. fee is deducted from profit portion
3. fee is routed according to split
4. settlement finalizes

Fees must never be routed:
- before settlement valuation is final
- during active execution
- in a way that can cause partial settlement state

---

## 20.7 Fee Routing Failure Handling

Fee routing can fail due to:
- transfer failure
- token disabled
- downstream contract revert

Fee routing failures must:
- revert whole settlement OR
- enter a clearly defined retry-safe state

MVP1 recommendation:
- revert the routing step to prevent partial routing

If partial routing occurs, it is an accounting hazard and must be prevented.

Required event:
- `FeeRoutingFailed(vault, cycleId, reasonCode, detailsHash)`

---

## 20.8 Fee Routing Events

FeeRouter must emit:

- `FeeCharged(vault, cycleId, profitSEV, feeRateBps, feeAmount)`
- `FeeRouted(vault, cycleId, destinationCategory, destinationAddress, token, amount)`
- `FeeSplitConfigUpdated(newConfigHash, effectiveCycleId)` (for future cycles only)

This ensures:
- full transparency of fee routing
- verifiable proof for audits
- ability to track protocol economics by cycle

---

# 21. Reserve System (USDT/USDC Core Reserve + Coverage Ratios)

This section defines the **Core Reserve**, which is the solvency anchor behind LOOP redemption. The Reserve is not a strategy pool. It is not yield capital. It is not available for discretionary deployment.

The Core Reserve exists for one purpose:

> To satisfy LOOP redemption obligations under protocol rules.

If Reserve discipline fails, the entire YieldLoop accounting model collapses into narrative finance. MVP1 must treat the Reserve as sacred.

---

## 21.1 Reserve Definition

The Core Reserve is a protocol-owned vault holding only:

- **USDT**
- **USDC**

These assets are held to:
- back LOOP redemption
- maintain system solvency under stress
- enforce conservative coverage ratios

Reserve holdings must be:
- reportable
- auditable
- verifiable on-chain

---

## 21.2 ReserveVault Contract Responsibilities

ReserveVault must:

- custody USDT and USDC
- expose view methods for:
  - reserve balances
  - outstanding LOOP obligations
  - coverage ratios
- only allow outflows via RedemptionEngine
- block all trading or strategy execution use
- be pauseable under emergency conditions

ReserveVault must NOT:

- interact with PCS router
- hold volatile tokens
- be used for yield farming
- be used for strategy execution
- allow admin arbitrary withdrawal (except explicitly defined emergency recovery rules)

---

## 21.3 Reserve Funding Sources

Reserve increases through:

- performance fee allocations (System Reserve bucket)
- any additional protocol revenue explicitly routed to reserve
- system deposit profits routed into reserve (if configured)

Reserve must not rely on:
- LOOP minting
- token burns
- market price appreciation
- external LP incentives

Reserve is funded from **real, realized protocol revenue**.

---

## 21.4 Reserve Segregation Rules

Reserve is segregated from:

- user vault assets
- execution inventory
- strategy engine balances
- protocol ops wallets

No module may “temporarily borrow” reserve funds.
No module may “rebalance” reserve funds.

Reserve is not a “tool.” It is a liability backstop.

---

## 21.5 Reserve Coverage Ratio (Core Solvency Metric)

MVP1 must define an explicit solvency metric:

### 21.5.1 Redeemable LOOP Supply
Define:

- `LOOP_redeemable_supply`

This is the amount of LOOP that represents redeemable claims against reserve.

This value must be computable on-chain.

### 21.5.2 Reserve Balance
Define:

- `Reserve_USDT`
- `Reserve_USDC`
- `Reserve_Total_SEV` (stable-equivalent value)

### 21.5.3 Coverage Ratio
Define:

- `CoverageRatio = Reserve_Total_SEV / LOOP_redeemable_supply`

CoverageRatio is the protocol’s solvency heartbeat.

---

## 21.6 Coverage Ratio Rules (MVP1 Enforcement)

MVP1 must enforce explicit rules tied to coverage ratio.

Recommended minimum rules:

### 21.6.1 Minting Constraint
If CoverageRatio falls below a threshold:
- LOOP minting must be reduced or paused

Example:
- if CoverageRatio < 1.00:
  - minting stops OR minting enters reduced mode

### 21.6.2 Redemption Constraint
If reserve liquidity is insufficient:
- redemptions may rate-limit
- redemptions may be delayed (only with explicit UX disclosure)

However:
- redemption constraints must be deterministic
- redemption cannot become discretionary or arbitrary

MVP1 recommendation:
- implement rate limits rather than “admin approval redemption”

---

## 21.7 Reserve Reporting Requirements

Reserve must expose on-chain reporting functions:

- `getReserveBalances()`
- `getOutstandingRedeemableLOOP()`
- `getCoverageRatio()`

Additionally, ReserveVault must emit events on:

- reserve inflows
- reserve outflows (redemptions)

Minimum events:

- `ReserveInflow(token, amount, sourceCategory, cycleId)`
- `ReserveOutflow(token, amount, redeemer, redemptionId)`

These events must be sufficient for third-party verification.

---

## 21.8 Reserve UX Requirements (User-Facing)

The user UI must not treat reserve as a “promise,” but as:
- an auditable value anchor

UI should show:

- total reserve size
- coverage ratio
- redemption policies and limits
- protocol-defined redemption value of LOOP

UI must NOT show:
- market speculation
- “guaranteed floor” language
- any claim of insurance

---

# 22. LOOP Token Model (Redemption Token, Non-PCS, Non-Speculative)

This section defines LOOP as an accounting-grade redemption token.

LOOP is not a meme token.
LOOP is not a “go trade it” token.
LOOP is not on PCS in MVP1.

LOOP exists only as:

> a protocol-defined redeemable credit unit tied to reserve accounting.

---

## 22.1 LOOP Core Properties

In MVP1, LOOP must satisfy:

- **protocol-minted only**
- **protocol-burned only**
- **not tradable on PCS**
- **not LP-able**
- **not used in execution pairs**
- **not used for speculative market signaling**
- **redeemable only via RedemptionEngine**
- redeemable into **USDT and/or USDC** only

If LOOP becomes tradable in the future, it must be treated as a separate version upgrade with explicit design changes. MVP1 does not allow it.

---

## 22.2 LOOP Role in YieldLoop Accounting

LOOP is the accounting expression of:
- settlement-linked value credits
- protocol-defined redeemable unit

LOOP does NOT represent:
- governance rights
- equity
- yield entitlement
- profit share by default
- dividends
- staking rewards

LOOP value is authoritative only through:
- redemption math + reserve backing + coverage constraints

---

## 22.3 LOOP Supply Definitions

MVP1 must define LOOP supply categories clearly.

### 22.3.1 Redeemable LOOP
Redeemable LOOP represents:
- actual redemption obligations

This supply is used in:
- coverage ratio calculations
- solvency metrics
- minting constraint rules

### 22.3.2 Non-Redeemable LOOP (Optional)
If the protocol requires a non-redeemable category (ex: internal incentive units):
- it must be explicitly flagged and excluded from coverage ratio obligations

MVP1 recommendation:
- avoid non-redeemable LOOP in MVP1 unless absolutely necessary
- keep LOOP definition clean

---

## 22.4 LOOP Transfer Rules (MVP1)

MVP1 must decide whether LOOP is:

### Option A — Transferable BEP-20 (Not Traded)
LOOP may technically be transferable wallet-to-wallet, but:
- not supported on PCS
- no LP
- no DEX routing

Risk:
- users may still create informal markets
- optics can drift

### Option B — Restricted Transfer Token (Recommended)
LOOP transfers are restricted so LOOP can only move:

- protocol => user (mint)
- user => protocol (redeem)
- user => user transfers disabled OR limited to whitelisted contexts

Recommendation:
- **restricted transfers** in MVP1 to preserve accounting purity and avoid informal markets.

---

## 22.5 LOOP Authoritative Redemption Value (“Floor”)

In MVP1, LOOP’s authoritative value is:

- what the protocol will redeem it for in USDT/USDC under the current rule set

This value must be computed using:
- reserve backing
- redemption constraints
- coverage ratios
- minting caps

Market price is irrelevant in MVP1 because LOOP is not traded.

---

## 22.6 LOOP Events

LOOPToken must emit:

- `LoopMinted(to, amount, cycleId, reasonCode)`
- `LoopBurned(from, amount, redemptionId, reasonCode)`

These events are required for:
- reserve solvency proof
- settlement reporting
- third-party verification

---

# 23. LOOP Minting Rules

This section defines exactly how LOOP enters existence. LOOP cannot be minted by discretion. LOOP minting is a direct accounting event tied to settlement logic and reserve solvency constraints.

---

## 23.1 Mint Authority

Only protocol contracts may mint LOOP:

- SettlementEngine (primary)
- SystemDeposit module (only if explicitly defined)

No admin wallet may mint LOOP directly.

No user wallet may mint LOOP.

LOOP minting must be enforced in code with:
- role restrictions
- immutable minter definitions (or upgrade-gated minter changes)

---

## 23.2 Mint Timing

In MVP1, LOOP may be minted only:

- at settlement
- after profit/loss is computed
- after fees are applied and routed
- after reserve-related allocations are finalized (or at least deterministically recorded)

Minting may not occur:
- mid-cycle
- during execution
- during funding
- outside protocol-defined settlement actions

---

## 23.3 Mint Preconditions (Solvency Constraints)

Before minting LOOP:

- coverage ratio must be computed
- mint caps must be checked
- mint must not push system below minimum reserve coverage ratio

Recommended enforcement model:

- Define `MRCR` (Minimum Reserve Coverage Ratio)
- Require:
  - `CoverageRatio_afterMint >= MRCR`

If not satisfied:
- mint is reduced to allowed amount OR
- mint is rejected entirely

MVP1 recommendation:
- reject mint if constraints fail (simpler + safer)

---

## 23.4 Mint Caps and Limits

MVP1 must define a mint cap system to prevent runaway issuance.

Possible caps:

- per-cycle mint cap (absolute)
- per-vault mint cap (absolute)
- per-vault mint cap (percentage of profit or allocation)
- global mint cap based on reserve growth

Recommended MVP1 model:
- cap minting per vault per cycle as a function of realized profit

Example:
- `LoopMinted <= ProfitSEV * MintFactor`

MintFactor must be a protocol parameter.

---

## 23.5 Mint Calculation Method

MVP1 must define how much LOOP is minted.

The simplest model:
- LOOP minted is denominated in stable-equivalent units
- 1 LOOP corresponds to 1 unit of redemption base value (scaled by decimals)

Example style rule:
- `1 LOOP = 1 SEV unit` (USDT/USDC equivalent under redemption rules)

Minting must use deterministic rounding rules.
No floating ambiguity.

---

## 23.6 Mint Recording (Required Fields)

Every mint must record:

- recipient address
- vault address (if applicable)
- cycleId
- minted amount
- mint reason code:
  - user settlement
  - protocol/system deposit
  - other explicit category
- pre-mint and post-mint coverage ratio values (recommended)

Mint event must be sufficient for proof reconstruction without off-chain assumptions.

---

## 23.7 Mint Failure Behavior

Mint can fail if:
- coverage ratio constraints prevent it
- reserve is below threshold
- mint caps exceeded
- protocol paused

Mint failure must:
- not corrupt settlement state
- still allow settlement finalization
- emit event `LoopMintFailed(vault, cycleId, reasonCode)`

MVP1 recommendation:
- treat LOOP minting as optional output of settlement
- settlement must not be blocked solely because minting is prevented by solvency constraints

---

# 24. LOOP Redemption Rules (USDT + USDC)

This section defines the redemption system. Redemption is the anchor of LOOP. It is the mechanism that turns LOOP from “protocol points” into an enforceable accounting unit.

Redemption must be:
- deterministic
- rule-based
- reserve-backed
- auditable
- non-discretionary

Redemption is not “support.” Redemption is a protocol obligation governed by explicit constraints.

---

## 24.1 Redemption Authority (Only Through Protocol)

In MVP1, LOOP redemption must occur only through:

- `RedemptionEngine`

Users must not be able to:
- redeem LOOP by swapping on PCS
- redeem LOOP through third-party routing
- redeem LOOP by interacting directly with ReserveVault

The only valid redemption path is:

1. user calls RedemptionEngine
2. RedemptionEngine validates eligibility + constraints
3. RedemptionEngine pulls USDT/USDC from ReserveVault
4. RedemptionEngine burns (extinguishes) LOOP
5. RedemptionEngine transfers USDT/USDC to user
6. events emitted for proof

This ensures redemption is:
- controlled
- auditable
- impossible to spoof

---

## 24.2 Redemption Inputs

User supplies:

- `amountLOOP` to redeem
- `redemptionPreference` (one of):
  - USDT only
  - USDC only
  - split (USDT + USDC)

RedemptionEngine must validate:

- amountLOOP > 0
- user has sufficient LOOP balance
- protocol is not paused for redemption
- user not blocked by blacklist policy (if implemented)
- reserve constraints permit redemption

---

## 24.3 Redemption Output Assets (Hard Rule)

LOOP redemption pays out only in:

- USDT and/or USDC

No redemption into:
- BTCB
- ETH
- XRP
- LINK
- BNB
- any other assets

This is a hard boundary because:
- reserve must remain stable and solvency-proof
- redemption must not become market-execution dependent
- redemption must not introduce volatility exposure into the “anchor mechanism”

---

## 24.4 Redemption Rate and Value (Authoritative Math)

Redemption value must be deterministic and computed using protocol-defined rules.

MVP1 must define a redemption pricing model. Two acceptable models exist:

### Model A — Fixed Unit Model (Simplest)
- 1 LOOP redeems for 1 unit of stable-equivalent value (subject to constraints)

This assumes LOOP is minted in stable-equivalent units and redemption is near-constant.

### Model B — Coverage-Scaled Model (More Conservative)
- redemption value is scaled by coverage ratio

Example:
- `RedemptionValuePerLOOP = min(1.0, CoverageRatio)`

This model prevents the protocol from paying out above its reserve backing when stressed.

MVP1 recommendation:
- implement **coverage-scaled model** for strict solvency discipline
- expose the math explicitly in UX and docs

---

## 24.5 Redemption Constraints (Solvency Protection)

Redemption must be constrained by explicit rules.

MVP1 must implement at least one of:

### 24.5.1 Liquidity Constraint
If ReserveVault has insufficient USDT/USDC liquidity:
- redemption may partially fill OR revert

MVP1 recommendation:
- partial fill is complex
- prefer **revert with explicit failure reason**

### 24.5.2 Rate Limits (Recommended)
Implement:
- per-user redemption cap per day/week
- global redemption cap per day/week

Reason:
- prevents a run draining reserve instantly
- creates predictable redemption behavior under stress

Rate limits must be:
- deterministic
- visible
- non-discretionary

### 24.5.3 Coverage Constraint
Redemption must not reduce the system below minimum solvency thresholds.

Define:
- MRCR = Minimum Reserve Coverage Ratio

Rule:
- redemption allowed only if post-redemption coverage remains ≥ MRCR
OR
- redemption value per LOOP decreases if below MRCR (coverage-scaled model)

---

## 24.6 Redemption Timing and Windows

MVP1 should allow redemption:
- any time protocol is not paused
- independent of cycle timing

However, redemption must not be allowed if:
- protocol is in incident mode that risks solvency accounting corruption
- ReserveVault is compromised
- LOOP supply/accounting is uncertain during a live exploit response

Redemption gating must be explicit and logged.

---

## 24.7 Redemption Failure Handling

Redemption can fail due to:

- insufficient reserve liquidity
- redemption rate limit exceeded
- coverage constraint violation
- protocol paused
- user blacklisted

If redemption fails:
- no LOOP is burned
- no reserve is transferred
- emit failure event:
  - `RedemptionFailed(user, amountLOOP, reasonCode, timestamp)`

---

## 24.8 Redemption Events (Proof Requirements)

Redemption must emit events sufficient for full third-party reconstruction:

- `RedemptionRequested(user, amountLOOP, preference, timestamp)`
- `RedemptionExecuted(user, amountLOOP, usdtOut, usdcOut, redemptionValuePerLoop, redemptionId, timestamp)`
- `RedemptionFailed(user, amountLOOP, reasonCode, timestamp)`

These events are mandatory because redemption is the core trust anchor.

---

# 25. LOOP Retirement (Extinguishment Upon Redemption)

This section defines LOOP retirement. In MVP1, LOOP is not “burned for tokenomics.” It is extinguished as a claim when redeemed.

This distinction matters. It must be written and implemented as accounting truth.

---

## 25.1 Retirement Definition

When LOOP is redeemed:

- it is **retired** (burned/extinguished)
- redemption obligations decrease
- `LOOP_redeemable_supply` decreases accordingly
- reserve outflow is recorded as fulfillment of claim

This is claim finality.

LOOP retirement must always occur as part of redemption execution.

---

## 25.2 Retirement Authority

Only protocol contracts may burn LOOP:

- RedemptionEngine

No admin wallet may burn user LOOP arbitrarily.

No user wallet may burn LOOP directly.

---

## 25.3 Burn Ordering Rule (Critical)

In RedemptionEngine, ordering must be deterministic.

Recommended safe order:

1. validate redemption constraints
2. calculate redemption outputs (USDT/USDC)
3. lock/commit redemption intent (optional but recommended using redemptionId)
4. burn LOOP
5. transfer reserve USDT/USDC
6. emit final event

Alternative ordering (transfer then burn) creates risk of:
- partial completion
- accounting mismatch if transfer fails
- reentrancy or failure edge cases

MVP1 must choose an ordering and implement it consistently.

---

## 25.4 Retirement Accounting Effects

Retiring LOOP must reduce:

- user LOOP balance
- total redeemable LOOP supply

This affects:
- coverage ratio
- future minting constraints
- future redemption value

Therefore retirement must emit events and update state atomically.

---

## 25.5 Retirement Events

At burn, LOOPToken must emit:

- `LoopBurned(from, amount, redemptionId, reasonCode)`

Additionally, RedemptionEngine must emit:

- `LoopRetired(user, amount, redemptionId, timestamp)`

Reason codes must clearly identify:
- redemption retirement
- any other permitted burn type (if later added)

---

## 25.6 Prohibited Retirement Behavior (MVP1)

MVP1 must not include:
- discretionary burns
- scheduled “supply reduction” burns
- burns intended to manipulate perceived value

LOOP value is enforced via redemption and reserve solvency, not burn marketing.

---

# 26. System Deposit Logic (Protocol-Owned Strategy Vault)

This section defines the System Deposit module. System Deposit is a protocol-owned vault/position designed to create recursive sustainability and long-term reserve reinforcement.

It must be simple, conservative, and transparent.

MVP1 must implement System Deposit in a way that:
- cannot be confused with user vaults
- cannot be withdrawn by users
- cannot introduce solvency risk to the Core Reserve
- can be audited like any other protocol component

---

## 26.1 Purpose

System Deposit exists to:

- fund protocol longevity without speculative token reliance
- create recursive reinforcement for reserve growth
- provide a “protocol-owned position” that compounds under conservative rules
- act as a stabilizing economic base over time

System Deposit is not:
- a user product
- a hidden pool
- discretionary trading capital for admins

---

## 26.2 Funding Source

System Deposit is funded only via:

- performance fee allocation bucket: **System Deposit (5%)**

This allocation occurs at settlement.

System Deposit must not receive:
- user deposits
- reserve funds
- admin injections (unless explicitly disclosed and logged)

---

## 26.3 System Deposit Strategy Constraints

System Deposit must use a conservative strategy profile.

MVP1 required behavior:

- Grid trading engine only (same StrategyEngine_Grid class)
- restricted token universe:
  - base: USDT and/or USDC
  - target: BTCB and/or ETH (recommended)
- tighter constraints than users:
  - lower slippage caps
  - lower trade size caps
  - lower inventory exposure
  - aggressive drawdown halts

System Deposit must not:
- take higher risk than user vaults
- use leverage
- use non-whitelisted tokens
- operate in discretionary mode

---

## 26.4 Compounding Rule (50/50)

System Deposit must run under a clear compounding rule:

- 50% of profits are compounded into the System Deposit
- 50% of profits are routed according to defined protocol sustainability rules

MVP1 default sustainability routing recommendation:

- 50% to Core Reserve (USDT/USDC)

This creates recursive reinforcement of redemption solvency.

If additional routing is desired (future):
- it must be explicitly defined and visible

---

## 26.5 Relationship to LOOP

System Deposit outcomes may impact LOOP indirectly by:

- increasing reserve balances
- improving coverage ratio
- enabling safer LOOP minting/redemption dynamics

System Deposit must not:
- mint LOOP
- burn LOOP
- manipulate LOOP supply

LOOP minting and redemption remain governed by Sections 23–25 only.

---

## 26.6 Transparency Requirements

System Deposit must expose:

- its balance
- its trade activity (events)
- its realized PnL per cycle
- its contributions to reserve

Events must be clearly labeled as:
- protocol-owned
- not user-owned

Minimum events:

- `SystemDepositFunded(cycleId, token, amount)`
- `SystemDepositSettled(cycleId, pnlSEV, compoundedAmount, reserveContribution)`
- `SystemDepositExecution(vaultIdOrModuleId, tokenIn, tokenOut, amountIn, amountOut)`

---

## 26.7 Failure Handling

If System Deposit execution fails:
- it must fail independently of user vaults
- user cycles must not be blocked
- settlement must proceed

System Deposit is additive to protocol health.
It must not become a single-point-of-failure.

---

# 27. Governance / Change Control Rules (Non-Retroactivity, Cycle Immutability)

This section defines protocol change rules. YieldLoop’s credibility depends on this being enforced in code, not by promises.

MVP1 is upgradeable, but upgradeability must not mean:
- retroactive changes
- moving goalposts
- rewriting outcomes
- changing settlement math after the fact

YieldLoop must behave like an execution ledger:
- rules apply forward
- settlements are final
- history is immutable

---

## 27.1 Core Principles

MVP1 change control must be grounded in four principles:

1. **Non-retroactivity**
   - changes apply to future cycles only

2. **Cycle immutability**
   - once a cycle starts for a vault, rules are locked

3. **Deterministic settlement finality**
   - settlement outputs cannot be re-run to change results

4. **Audit trail**
   - every change emits events and can be reconstructed

---

## 27.2 What Can Change (MVP1)

The protocol may change:

- token whitelist
- strategy parameter boundaries (min/max)
- fee splits (allocation percentages)
- default protocol slippage caps
- keeper execution settings
- supporter discount rate
- system deposit configuration

However all changes must include:
- effective cycle id (future)
- event emission
- explicit versioning

---

## 27.3 What Must Never Change Retroactively

The protocol must never permit retroactive alteration of:

- completed cycle settlements
- past profit/loss calculations
- past fee rates applied
- past fee split distributions
- past LOOP minting outputs
- past redemption outcomes
- signed authorizations and strategy hashes
- historical vault snapshots

Past outputs must remain provable forever.

---

## 27.4 Cycle Immutability Enforcement

Once a vault is committed into a cycle:

- strategy config is locked
- fee rate is locked
- whitelist set for that cycle is locked (recommended)
- parameter constraints are locked

In MVP1:
- a token should not be disabled mid-cycle unless emergency requires it
- if token is disabled mid-cycle, settlement behavior must be deterministic (defined in failure rules)

Immutability must be enforced by:
- storing cycle-specific config hashes and parameters
- checking cycleId at every execution call
- preventing updates when cycleState == ACTIVE

---

## 27.5 Parameter Versioning (Required)

MVP1 must implement a parameter versioning system.

Recommended structure:
- a global `ProtocolConfig` stored with:
  - version number
  - config hash
  - activation cycleId

When updated:
- new config is stored
- event emitted with activation cycleId
- old configs remain queryable for historical proof

Minimum functions:
- `getConfigForCycle(cycleId)`
- `getCurrentConfig()`

---

## 27.6 Governance Scope vs Admin Scope (MVP1 Reality)

MVP1 can launch with admin control, but governance boundaries must be written now so upgrades remain consistent.

Two acceptable MVP1 governance models:

### Model A — Admin-Controlled MVP1 (Recommended)
- multi-sig admin controls config changes
- all actions emit events
- governance introduced later

### Model B — Minimal Governance MVP1
- whitelist + fee split changes require:
  - delay + on-chain vote
  - time lock

MVP1 recommendation:
- Model A with strict event trail and timelock

Regardless of model, rules must follow:
- forward-only change control

---

## 27.7 Required Change Events

Any change to protocol configuration must emit:

- what changed
- old value
- new value
- executor identity
- activation cycleId
- timestamp

Minimum events:
- `ProtocolConfigUpdated(oldHash, newHash, activationCycleId, executor)`
- `WhitelistUpdated(token, actionType, activationCycleId, executor)`
- `FeeSplitUpdated(oldConfigHash, newConfigHash, activationCycleId, executor)`

---

# 28. Event Logging, Transparency, Proofs, and On-Chain Reporting

This section defines the protocol’s transparency standard. YieldLoop cannot claim to be rules-based and auditable unless on-chain logs and proofs support independent verification.

Logging is not a nice-to-have. It is the trust mechanism.

---

## 28.1 Transparency Goals

MVP1 must allow:

- users to verify execution occurred as configured
- users to verify settlement math
- auditors to reconstruct outcomes
- independent observers to verify reserve and redemption integrity
- proof of fee routing and allocations

The protocol must not rely on:
- backend-only reporting
- unverifiable UI claims
- proprietary logs

Everything important must be on-chain.

---

## 28.2 Required Event Categories

MVP1 must emit events for:

### User Funding
- deposits
- withdrawals
- vault creation

### Cycle State
- cycle created
- cycle started
- cycle ended
- settlement opened
- settlement finalized

### Strategy Actions
- configuration accepted
- configuration rejected
- trade executed
- trade failed
- guardrail triggered
- strategy state transitions

### Accounting
- start snapshot
- end snapshot
- valuation method used (code)
- PnL computed
- fee charged

### Fee Routing
- each routed transfer by destination category

### Reserve + LOOP
- reserve inflows
- reserve outflows
- LOOP minted
- LOOP burned
- redemption requested/executed/failed
- coverage ratio values (recommended)

### Admin Actions
- pauses
- unpauses
- upgrades
- whitelist changes
- parameter changes

---

## 28.3 Proof Objects and Hashing Requirements

To allow external reconstruction, MVP1 must:

- hash strategy configuration into `configHash`
- hash settlement outputs into `settlementHash`
- optionally hash balance snapshots into `balancesHash`

Recommended:

### Strategy Proof
- `configHash = keccak256(abi.encode(strategyConfig))`

### Settlement Proof
- `settlementHash = keccak256(abi.encode(
    cycleId,
    startValueSEV,
    endValueSEV,
    pnlSEV,
    feeCharged,
    feeRateBps,
    loopMinted,
    finalBalancesHash
  ))`

Hashes ensure:
- data is tamper-evident
- UI reports match protocol truth

---

## 28.4 On-Chain Reporting Functions

In addition to events, MVP1 must provide view functions:

- `getVaultSummary(vault, cycleId)`
- `getVaultBalances(vault)`
- `getVaultSettlement(vault, cycleId)`
- `getReserveSummary()`
- `getCoverageRatio()`
- `getRedeemableLoopSupply()`
- `getProtocolConfig()` (and config versions)

These functions allow UIs to render truth without relying on backend indexers (though indexers may improve UX).

---

## 28.5 UX Transparency Requirements

The UI must display:

- cycle status
- strategy config summary + configHash
- execution logs
- settlement outputs + settlementHash
- fee routing breakdown
- LOOP mint/redeem activity
- reserve coverage ratio

The UI must never hide:
- losses
- guardrail triggers
- execution failures

---

## 28.6 Indexing Requirements (Operational)

MVP1 must ship with an indexing plan.

Either:
- a simple event-based indexer
or
- subgraph-like indexing

The goal:
- make proof visible without requiring users to manually parse events

Indexing is an operational deliverable.

---

# 29. Admin Controls, Emergency Stops, and Operational Runbooks

This section defines protocol control and incident response. Admin powers are a security risk. They must be bounded, visible, and logged.

Admin controls exist to prevent:
- exploits
- cascading losses
- redemption draining during incident
- execution bugs from harming users

---

## 29.1 Admin Control Philosophy

Admin controls must follow:

- **minimum necessary power**
- **maximum transparency**
- **event logging for every action**
- **separation of duties**
- **emergency powers are for emergencies only**

If admin can do something, it must be written explicitly.

No hidden powers.

---

## 29.2 Required Pause Controls (MVP1)

PauseController must support at minimum:

### Global Pause
- pause all protocol operations except read-only views

### Module Pauses
- pause deposits
- pause withdrawals (only if absolutely necessary)
- pause execution engine
- pause settlement engine
- pause redemption engine

Each pause must emit:
- module identifier
- reason code
- executor
- timestamp

---

## 29.3 Emergency Stop Triggers

Emergency stops may be invoked for:

- detected exploit
- PCS router malfunction
- whitelist token compromise
- oracle manipulation (if oracle exists)
- accounting bug detection
- redemption draining event

Emergency stop must halt:
- execution immediately

Depending on severity:
- deposits may be paused
- redemptions may be paused
- withdrawals should remain enabled unless they increase harm

---

## 29.4 Emergency Settlement Rules

The protocol must define what happens if:

- cycle is ACTIVE and emergency pause occurs

Possible allowed outcomes:

### Option A — Freeze Until Resolved
- execution stops
- cycle remains ACTIVE but paused
- settlement occurs later once incident resolved

### Option B — Force Early Settlement
- execution stops
- settlement opens immediately
- normalize inventory into reserve tokens if possible
- finalize with best available state

MVP1 recommendation:
- implement Option A first (simpler, less chaotic)
- Option B can be added later as a protocol upgrade

In either case, rules must be deterministic, not discretionary.

---

## 29.5 Admin Wallet Structures

Admin keys must be controlled via:
- multi-sig

Admin roles should be separated:

- whitelist admin
- pause admin
- upgrade admin
- reserve operator
- settlement operator

Single hot wallets must not control full protocol.

---

## 29.6 Operational Runbooks (Required Deliverable)

MVP1 delivery must include operational runbooks covering:

### PCS Execution Failure
- what triggers pause
- how to verify
- how to resume

### Token Compromise
- disable token
- notify users
- settlement implications

### Exploit Response
- immediate pause
- block keeper actions
- preserve evidence
- coordinate patch + upgrade

### Reserve Stress / Redemption Run
- redemption rate limit enforcement
- pause criteria
- user communication guidelines

Runbooks must specify:
- who can do what
- what events are emitted
- what states the protocol will enter

Runbooks are part of MVP1 delivery, not “later.”

---

# 30. Security Requirements & Audit Targets

This section defines the security standard for MVP1. YieldLoop MVP1 must be treated as production financial infrastructure. “DeFi MVP” is not an excuse. The goal is to ship a minimal system — not a fragile one.

Security requirements are part of the spec. If a feature cannot be implemented securely in MVP1, it must be removed or deferred.

---

## 30.1 Threat Model Assumptions

YieldLoop MVP1 must assume adversarial conditions:

- MEV bots attempt sandwiching / slippage exploitation
- users attempt parameter abuse to bypass guardrails
- attackers attempt to drain ReserveVault
- attackers attempt to manipulate settlement valuation
- attackers attempt reentrancy attacks during swap/transfer flows
- attackers attempt upgrade hijack (proxy exploit)
- attackers attempt whitelist bypass to inject malicious tokens
- attackers attempt keeper abuse to execute outside authorized bounds
- malicious or broken BEP-20 tokens behave unpredictably

MVP1 must not depend on “users will behave nicely.”

---

## 30.2 Required Security Controls (Must-Haves)

MVP1 contracts must include the following controls:

### 30.2.1 Access Control
- role-based access control using OpenZeppelin AccessControl
- explicit role separation (no single role with all powers)
- all privileged actions emit events

### 30.2.2 Reentrancy Protection
All functions involving:
- transfers
- swaps
- redemption
must include:
- nonReentrant guards
- checks-effects-interactions pattern

### 30.2.3 Pause Controls
- global pause
- module-level pause
- emergency stop must halt execution immediately

### 30.2.4 Input Validation
Every strategy configuration must validate:
- token eligibility
- pair eligibility
- ranges
- caps
- cycle state gating

Never rely on frontend validation.

### 30.2.5 Whitelist Enforcement
WhitelistRegistry must be consulted at every:
- deposit
- trade
- settlement conversion
- redemption action (reserveEligible constraint)

Any whitelist bypass is a critical exploit.

### 30.2.6 Slippage and Size Constraints
Every PCS swap must enforce:
- minOut with slippage bps
- size caps
- frequency caps

### 30.2.7 Upgrade Controls
Upgrade admin keys must:
- be multi-sig
- be timelocked if possible
- emit full upgrade events
- enforce storage-safe upgrade pattern

---

## 30.3 Audit Scope (What Must Be Audited)

A complete audit must cover:

### Upgradeability
- proxy correctness
- initializer correctness
- storage layout safety
- upgrade permission enforcement

### Vault Safety
- user funds cannot be drained by admin/operator
- withdrawals only by user
- cycle gating cannot be bypassed
- authorization signature validation

### Strategy Engine Safety
- cannot trade non-whitelisted tokens
- cannot exceed caps
- cannot execute outside ACTIVE cycle state
- cannot execute without valid signature configHash

### Settlement Integrity
- profit/loss math correct
- fee charged only on profit
- fee routing correct
- settlement cannot be replayed to change outcomes

### Fee Router Safety
- split math correct
- rounding safe
- transfers cannot be redirected
- destinations are fixed/approved

### Reserve and Redemption Safety
- ReserveVault cannot be drained
- redemption only via RedemptionEngine
- redemption constraints enforced
- LOOP burn/mint authority restricted

### MEV / Price Manipulation Risks
- settlement valuation vulnerability
- oracle vulnerabilities (if used)
- PCS quote manipulation risks
- mitigation strategy correctness

---

## 30.4 Oracle and Pricing Risk Controls (MVP1)

MVP1 must explicitly define how price is determined for:

- grid logic triggers (if price-based)
- settlement valuation (if not force converting)

If settlement uses pricing instead of forced conversion:

- you MUST use TWAP or protected oracle
- spot router quote alone is vulnerable to manipulation

MVP1 recommended:
- forced conversion at settlement into USDT/USDC
- eliminates theoretical valuation disputes and oracle attack surface

If you still use TWAP:
- define window length
- define fallback behavior
- define update frequency
- define manipulation detection thresholds

---

## 30.5 Formal Verification / Property Testing (Recommended)

MVP1 should implement property tests for invariants such as:

- user cannot lose funds without explicit execution loss
- reserve cannot decrease except through redemption
- settlement cannot be executed twice
- fees cannot exceed profit * feeRate
- LOOP supply cannot be increased without settlement mint
- LOOP burn cannot occur without redemption

This should be done with:
- Foundry invariant tests
- fuzz tests for config boundaries

---

## 30.6 Security Logging and Alerting Requirements

Operational monitoring must track:

- failed execution attempts
- guardrail triggers
- unusual slippage events
- redemption spikes
- coverage ratio drops
- reserve outflows
- any admin action

MVP1 must provide:
- event-based alert rules
- incident notification routing (ops requirement)

---

## 30.7 Security Acceptance Criteria

MVP1 cannot ship unless:

- audit performed and critical issues resolved
- main security invariants tested
- upgrade keys stored in multi-sig
- pause controls proven functional
- redemption proven safe against reserve drain
- whitelist bypass impossible under expected call surfaces

---

# 31. Deliverables Checklist (MVP1 Release Scope)

This section defines MVP1 delivery requirements. MVP1 is not complete when code compiles. MVP1 is complete only when it can safely run a cycle end-to-end on-chain under real conditions.

---

## 31.1 Smart Contract Deliverables

The following contracts must be delivered:

1. ProtocolController  
2. WhitelistRegistry  
3. UserVaultFactory  
4. UserVault  
5. StrategyEngine_Grid  
6. CycleManager  
7. SettlementEngine  
8. FeeRouter  
9. ReserveVault  
10. LOOPToken  
11. RedemptionEngine  
12. SupporterAccess  
13. PauseController / AdminGuard  

Each must include:
- full NatSpec comments
- role definitions and access control mapping
- events for every critical action
- test coverage

---

## 31.2 Frontend Deliverables

Frontend must include:

### Wallet & Eligibility
- wallet connect
- BNB chain enforcement
- supporter access status
- eligibility state and reason

### Funding
- deposit flow
- vault balance display
- deposit window messaging

### Strategy
- grid strategy selection (only option)
- manual configuration form
- AI Populate button
- config summary review
- risk acknowledgements
- authorization signature flow

### Cycle View
- cycle status
- execution logs
- inventory balances
- guardrail status
- time remaining

### Settlement View
- cycle settlement report
- PnL breakdown
- fee charged and routing breakdown
- LOOP minted
- settlement proof hashes

### Withdrawal
- post-settlement withdrawals
- next cycle options

---

## 31.3 Keeper / Automation Deliverables

MVP1 must include off-chain automation:

- cycle start triggers
- execution triggers
- settlement triggers

Keepers must:
- be permissioned
- respect cycle state
- respect vault authorization
- log all actions

Keeper errors must:
- not corrupt protocol state
- be observable in monitoring dashboards

---

## 31.4 Monitoring / Ops Deliverables

Ops deliverables include:

- RPC reliability strategy
- monitoring dashboards
- alerting rules
- incident runbooks (Section 29)
- reserve coverage tracking dashboard
- redemption activity tracking

---

## 31.5 Testnet + Mainnet Requirements

MVP1 must be deployed to:

- BNB testnet (full cycle simulation)
- BNB mainnet (production)

Deployment process must include:
- scripted deploys
- versioned release tags
- upgrade procedure testing
- rollback plan (where applicable)

---

## 31.6 Acceptance Criteria (Definition of Done)

MVP1 is “done” when all of the following are proven:

1. Vault creation, deposits, and withdrawals work correctly.  
2. Whitelist enforcement cannot be bypassed.  
3. Grid strategy executes within guardrails.  
4. Cycle locking works (no mid-cycle config edits).  
5. Settlement produces deterministic outcomes.  
6. Performance fee applies only on profit.  
7. Fee routing matches split configuration.  
8. Reserve reporting matches on-chain truth.  
9. LOOP minting works under defined constraints.  
10. LOOP redemption works into USDT/USDC and burns LOOP.  
11. Emergency pause works instantly and predictably.  
12. Audit completed and critical issues resolved.  
13. Monitoring + runbooks exist for operations.  

If any of these are missing, MVP1 is incomplete.

