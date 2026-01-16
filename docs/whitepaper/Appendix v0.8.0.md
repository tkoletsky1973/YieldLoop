# Appendix A — Full Contract Set + Responsibilities (Developer Blueprint)

This appendix is where a dev stops guessing and starts building.

YieldLoop must be implemented as a **modular contract system**. The goal is:

- isolate risk
- isolate upgrade surface
- isolate accounting
- keep vault funds non-custodial
- keep “admin power” narrow and verifiable

---

## A.1 Contract Inventory (Canonical)

### A.1.1 Core Vault System
1) **VaultFactory** (or VaultManager if using single-contract vault registry)
2) **UserVault** (per-vault contract OR per-vault state record)
3) **ConfigRegistry** (strategy config hashes, bounds, allowlists)
4) **StrategyAcceptanceGate** (accept/decline checkpoint logic)

### A.1.2 Execution + Safety
5) **ExecutionRouter** (validates routes + executes swaps)
6) **OracleAdapter** (TWAP / price sanity layer)
7) **GuardrailEngine** (reason codes + safety flags + standard checks)
8) **KeeperRegistry** (optional; allowlist keepers)

### A.1.3 Profit, Fees, Claims
9) **ProfitBuffer / ClaimLedger** (claim anytime accounting)
10) **FeeRouter** (fee calc + discount stack + routing)

### A.1.4 LOOP + Reserve System
11) **LoopToken** (BEP-20)
12) **LoopMinter** (bounded mint authority)
13) **ReserveVault** (holds USDT reserve)
14) **ReserveController** (redemption/buyback rules + caps)

### A.1.5 Programs
15) **SupporterPresale**
16) **SupporterBadge** (BEP-721)
17) **ReferralRegistry**
18) **ReferralClaimLedger** (optional; can merge into ClaimLedger)

### A.1.6 Governance/Admin
19) **TimelockController**
20) **ProtocolAdminMultisig**
21) **EmergencyPauseModule**

---

## A.2 Contract Responsibilities (Unabridged)

### A.2.1 VaultFactory

**Purpose:** Creates vaults and enforces “strategy checkpoint.”

**Must do:**
- accept deposit (300 USDT min enforced here or in vault)
- create vault record / deploy vault
- store vault owner
- store selected configHash + rewardMode + compoundRate
- set vault state = PENDING_ACCEPTANCE
- emit `VaultCreated` + `StrategyPreviewed`

**Must NOT do:**
- hold funds permanently (funds should move into UserVault)
- allow admin to change accepted settings silently

---

### A.2.2 UserVault

**Purpose:** Holds user funds, enforces accounting and guardrails.

**Must do:**
- store principalUSDT
- store inventory balances (BTCB/SOL/XRP)
- store claimable balance
- store compound balance
- enforce vault state machine
- accept keeper execute attempts
- compute realized net profit and apply fee logic
- emit detailed execution events

**Must NOT do:**
- allow admin withdrawals
- accept arbitrary tokens
- trade without passing guardrails
- claim principal as “profit”

---

### A.2.3 ConfigRegistry

**Purpose:** Maintains strategy parameter sets as hashed immutable configs.

**Must do:**
- store approved config hashes
- store min/max bounds
- store allowlisted routers/tokens/venues
- allow adding/removing configs via timelock
- provide `getConfig(configHash)`

**Must NOT do:**
- override accepted vault config after user acceptance

---

### A.2.4 StrategyAcceptanceGate (could be embedded)

**Purpose:** Enforces Howey-style accept/decline checkpoint.

**Must do:**
- show the user final strategy parameters
- require explicit acceptance tx
- record acceptance timestamp
- prevent any trading before acceptance

**Must NOT do:**
- auto-accept on behalf of user
- allow keepers to trade pre-acceptance

---

### A.2.5 ExecutionRouter

**Purpose:** Executes swaps safely.

**Must do:**
- validate router allowlist
- validate token allowlist
- enforce slippage via minOut
- enforce deadline
- emit route used

**Must NOT do:**
- allow arbitrary calldata injection without allowlisting
- route to unknown routers

---

### A.2.6 OracleAdapter

**Purpose:** Standardizes price sanity checks.

**Must do:**
- produce price reference for BTCB/SOL/XRP vs USDT
- provide TWAP if possible
- enforce freshness window
- enforce deviation checks vs spot

**Must NOT do:**
- allow single low-liquidity spot price to drive execution

---

### A.2.7 GuardrailEngine

**Purpose:** Single source of truth for reject reasons and safety checks.

**Must do:**
- implement checks:
  - oracle sanity
  - venue deviation
  - slippage
  - liquidity
  - peg deviation
  - gas ceiling
  - net profit floor
  - exposure caps
  - rate limiting
- return structured reject reason codes
- store safety flags per vault or global

**Must NOT do:**
- allow bypass flags
- allow “ignore all guardrails” config

---

### A.2.8 KeeperRegistry (Optional)

**Purpose:** Limits who can submit executions (if not permissionless).

**Must do (if used):**
- allowlist keeper addresses
- ability to disable a keeper quickly
- track performance metrics (optional)

**Must NOT do:**
- hold funds
- have upgrade authority beyond allowlisting

---

### A.2.9 ProfitBuffer / ClaimLedger

**Purpose:** Enables claim-anytime payout without touching principal.

**Must do:**
- maintain claimable balances:
  - USDT claimable
  - LOOP claimable
- accept credits from vault profit events
- support claim() functions
- prevent double claims

**Must NOT do:**
- allow admin to divert claim balances

---

### A.2.10 FeeRouter

**Purpose:** Calculates fees and routes them.

**Must do:**
- compute base fee:
  - 20% USDT rewards
  - 17.5% LOOP rewards
- apply discount stack (supporter + future)
- enforce min fee floor
- route fees to configured receivers
- emit fee events

**Must NOT do:**
- ever take fees on principal
- ever take fees without realized net profit

---

### A.2.11 LoopToken (BEP-20)

**Purpose:** Token contract.

**Must do:**
- standard BEP-20 behavior
- no hidden fees
- mint restricted to LoopMinter

**Must NOT do:**
- allow arbitrary mint by admin without LoopMinter caps

---

### A.2.12 LoopMinter

**Purpose:** ONLY place minting is allowed.

**Must do:**
- enforce mint sources:
  - supporter airdrop
  - referral rewards (if mint-based)
  - reward conversion (if mint-based)
- enforce caps per day / per tx / per program
- emit mint events

**Must NOT do:**
- permit “manual mint to admin wallet”
- allow unbounded mint

---

### A.2.13 ReserveVault

**Purpose:** Holds reserve assets.

**Must do:**
- accept USDT inflows from presale and fee routing
- expose reserve balance publicly
- only allow reserve movement through ReserveController rules

**Must NOT do:**
- allow admin free withdrawals

---

### A.2.14 ReserveController

**Purpose:** Redemption + buyback rules (if enabled).

**Must do:**
- enforce reserveMinUSDT
- enforce redemption caps
- enforce buyback caps
- enforce pause controls
- enforce oracle sanity before supporting price

**Must NOT do:**
- support “infinite floor”

---

### A.2.15 SupporterPresale

**Purpose:** Seed funding contract.

**Must do:**
- accept exactly 300 USDT
- enforce 5000 max
- enforce one per wallet
- split funds to:
  - dev
  - ECW
  - reserve
  - airdrop entitlement
- mint SupporterBadge
- create airdrop entitlement record

**Must NOT do:**
- accept arbitrary amounts
- allow second purchase
- allow admin to rewrite entitlements

---

### A.2.16 SupporterBadge (BEP-721)

**Purpose:** Proof-of-support.

**Must do:**
- mint one per supporter
- optionally allow transfer
- enable easy on-chain verification

**Must NOT do:**
- allow public mint
- allow admin arbitrary badge mint outside presale

---

### A.2.17 ReferralRegistry

**Purpose:** Stores referrals, qualification, and payout entitlements.

**Must do:**
- bind referred → referrer once
- track qualification window
- enforce 180-day rule
- enforce caps + blacklist checks
- credit referral rewards into ClaimLedger

**Must NOT do:**
- allow referrer swapping
- pay rewards early

---

### A.2.18 TimelockController

**Purpose:** Prevent instant malicious upgrades/config changes.

**Must do:**
- delay all non-emergency changes
- emit queued/executed operations
- allow cancellation

**Must NOT do:**
- allow bypass by admin EOA

---

### A.2.19 EmergencyPauseModule

**Purpose:** Stop trading fast.

**Must do:**
- disable execution system-wide immediately
- disable minting (optional but recommended)
- disable referral payouts (optional)
- keep claim available if possible

**Must NOT do:**
- seize funds

---

## A.3 Architectural Invariants (Must Never Break)

1) **No admin withdrawal of user principal**
2) **No fees without realized net USDT profit**
3) **No trading before user acceptance**
4) **No bypass of guardrails**
5) **Claim must never pull principal**
6) **Minting must be bounded**
7) **Reserve actions must be bounded**
8) **All critical state transitions must emit events**

---

# Appendix B — Developer Interface Spec (Plain English, No Solidity)

This appendix defines the **developer interfaces** for YieldLoop.

This is NOT Solidity.  
This is the contract/API spec written in plain English so a dev can implement it without ambiguity.

Each module lists:

- Purpose
- Inputs
- Outputs
- Required functions (signature style)
- Required events
- Rules / invariants

---

## B.1 Common Types (Used Everywhere)

### B.1.1 Vault States
Vaults must exist in exactly one state:

- `CREATED`
- `PENDING_ACCEPTANCE`
- `ACTIVE`
- `PAUSED`
- `EXIT_REQUESTED`
- `UNWINDING`
- `CLOSED`

Rules:
- No execution occurs unless `ACTIVE`.
- No execution occurs in `PENDING_ACCEPTANCE`.
- Claims should be available in most states (except catastrophic pause).

---

### B.1.2 Reward Modes

- `USDT_REWARDS`
- `LOOP_REWARDS`

Rules:
- Reward mode affects fee rate and payout asset only.
- Profit is always computed in USDT first.

---

### B.1.3 Reject Reason Codes (Canonical)

Guardrails must return one reason code when rejecting execution:

- `VAULT_NOT_ACTIVE`
- `VAULT_PAUSED`
- `SYSTEM_PAUSED`
- `UNWIND_IN_PROGRESS`
- `CONFIG_MISMATCH`
- `ROUTER_DISABLED`
- `TOKEN_DISABLED`
- `DEX_DISABLED`
- `KEEPER_NOT_ALLOWED`
- `ORACLE_STALE`
- `ORACLE_DEVIATION_TOO_HIGH`
- `VENUE_PRICE_DEVIATION`
- `LOW_LIQUIDITY`
- `SLIPPAGE_TOO_HIGH`
- `MEV_RISK_TOO_HIGH`
- `EXECUTION_COST_TOO_HIGH`
- `RATE_LIMIT`
- `EXPOSURE_LIMIT`
- `PEG_RISK`
- `DRAWDOWN_LIMIT`
- `INVALID_INPUT`

Rules:
- Reject codes must be **logged**.
- Reject codes must be **stable** across versions.

---

### B.1.4 Execution Plan (Keeper Proposal Object)

Every keeper execution attempt must include:

- `router` (address)
- `tokenIn` (address)
- `tokenOut` (address)
- `amountIn` (uint256)
- `minOut` (uint256)
- `deadline` (uint256 timestamp)
- `routeData` (bytes, optional, router-specific)

Rules:
- Vault validates and may ignore keeper’s “expected profit” guesses.
- `minOut` and `deadline` are mandatory for MEV safety.
- `routeData` must be allowlisted (or verified) to prevent injection attacks.

---

### B.1.5 Vault Balances (UI / Accounting View)

Each vault must expose view access to:

- `principalUSDT`
- `claimableUSDT`
- `claimableLOOP`
- `compoundUSDT`
- `inventoryBTCB`
- `inventorySOL`
- `inventoryXRP`

Rules:
- Principal is never fee’d.
- Claimable balances never include principal.

---

# B.2 Module: VaultFactory / VaultManager

## Purpose
Creates and tracks user vaults. Enforces the accept/decline checkpoint.

This is the primary entrypoint for users.

## Required Storage
- `vaultOwner[vaultId] -> address`
- `vaultState[vaultId] -> VaultState`
- `vaultConfigHash[vaultId] -> bytes32`
- `vaultRewardMode[vaultId] -> RewardMode`
- `vaultCompoundRateBps[vaultId] -> uint16`
- `nextVaultId`

## Required Functions

### `createVault(depositUSDT, configHash, rewardMode, compoundRateBps) -> vaultId`
Inputs:
- `depositUSDT` must be >= 300 USDT
- `configHash` must exist in ConfigRegistry allowlist
- `compoundRateBps` must be 0–10000

Actions:
1) transfer USDT from user to vault (or vault manager)
2) create vault record (or deploy vault contract)
3) set state = `PENDING_ACCEPTANCE`
4) emit events

Output:
- returns new `vaultId`

Rules:
- No trading occurs until acceptance.

---

### `acceptStrategy(vaultId)`
Inputs:
- vault must be owned by caller
- state must be `PENDING_ACCEPTANCE`

Actions:
- set state = `ACTIVE`
- record acceptance timestamp
- emit event

Rules:
- acceptance checkpoint must log:
  - configHash
  - rewardMode
  - compoundRate

---

### `declineStrategy(vaultId)`
Inputs:
- vault must be owned by caller
- state must be `PENDING_ACCEPTANCE`

Actions:
- unwind any internal routing (if any)
- return deposit USDT to user
- set state = `CLOSED`
- emit event

Rule:
- If decline is possible, it must be possible **before any trade**.

---

### `setCompoundRate(vaultId, newRateBps)`
Inputs:
- vault must be owned by caller
- newRateBps must be 0–10000

Actions:
- update vault compound rate
- emit event

Rule:
- Applies to future profits only.

---

### `setRewardMode(vaultId, newMode)`
Inputs:
- vault must be owned by caller
- vault must be `ACTIVE` (or policy-defined)

Actions:
- update reward mode
- emit event

Rules:
- Must not retroactively change existing claimable balances.
- Must not allow discount without LOOP payout.

---

## Required Events

- `VaultCreated(vaultId, owner, depositUSDT, configHash, rewardMode, compoundRateBps)`
- `StrategyAccepted(vaultId, owner, configHash)`
- `StrategyDeclined(vaultId, owner, refundedUSDT)`
- `CompoundRateUpdated(vaultId, oldRateBps, newRateBps)`
- `RewardModeUpdated(vaultId, oldMode, newMode)`

---

# B.3 Module: UserVault (Execution + Ledger)

## Purpose
Holds vault funds, executes trades, enforces guardrails, produces realized profit accounting.

## Required Storage
- `principalUSDT`
- `compoundUSDT`
- `claimableUSDT`
- `claimableLOOP`
- inventory balances (BTCB/SOL/XRP)
- `vaultState`
- `configHash`
- `owner`
- `lastExecutionTimestamp`
- reject reason tracking (optional)
- risk flags (optional)

## Required Functions

### `execute(vaultId, plan)`
Caller:
- keeper (permissionless or allowlisted)

Inputs:
- plan object

Actions:
1) validate vault `ACTIVE`
2) validate configHash matches plan compatibility
3) run guardrails
4) if any check fails: reject, emit reject reason
5) if safe: perform swap(s) atomically
6) compute realized net profit in USDT
7) route fee
8) split user profit into claimable vs compound
9) emit execution completion events

Rules:
- If net profit <= 0 → must not charge fee.
- Execution must not trade when pause flags set.
- Execution must revert or reject cleanly; no partial state.

---

### `claim(vaultId, asset) -> amount`
Caller:
- vault owner only

Actions:
- transfer claimable asset to user
- reduce claimable balance
- emit event

Rules:
- nonReentrant
- update ledger before transfer
- claim must never reduce principal

---

### `requestExit(vaultId)`
Caller:
- vault owner only

Actions:
- set state = `EXIT_REQUESTED`
- emit event

Rules:
- protocol must unwind inventory safely before closing
- exit may be delayed by guardrails (safe unwind)

---

### `pauseVault(vaultId, reasonCode)`
Caller:
- admin emergency module OR automated guardrail module

Actions:
- set vault paused
- emit

Rules:
- should not block claims unless chain-level emergency

---

### `unpauseVault(vaultId)`
Caller:
- admin

Actions:
- set state back to ACTIVE
- emit

---

## Required Events

- `ExecutionAttempted(vaultId, keeper, router, tokenIn, tokenOut, amountIn, minOut)`
- `ExecutionRejected(vaultId, keeper, reasonCode)`
- `ExecutionCompleted(vaultId, keeper, realizedNetProfitUSDT, feeUSDT, rewardMode)`
- `ProfitSplitApplied(vaultId, claimPartUSDT, compoundPartUSDT, compoundRateBps)`
- `Claimed(vaultId, owner, asset, amount)`
- `ExitRequested(vaultId, owner)`
- `VaultPaused(vaultId, reasonCode)`
- `VaultUnpaused(vaultId)`

---

# B.4 Module: ConfigRegistry (Strategy Config + Bounds + Allowlist)

## Purpose
Stores the approved strategy configurations and safety bounds.

This is the “rulebook” contract. Vaults use it to decide whether a keeper plan is allowed.

## Required Storage

- `allowedConfigHash[bytes32] -> bool`
- allowlists:
  - `allowedToken[address] -> bool`
  - `allowedRouter[address] -> bool`
  - `allowedDex[address] -> bool`
- bounds per configHash:
  - `minNetProfitUSDT`
  - `maxSlippageBps`
  - `maxImpactBps`
  - `maxOracleDeviationBps`
  - `maxVenueDeviationBps`
  - `maxPegDeviationBps`
  - `maxExposureBpsPerAsset`
  - `maxTradesPerHour`
  - `cooldownSeconds`
  - `maxDrawdownBps`

## Required Functions

### `isConfigAllowed(configHash) -> bool`
### `isTokenAllowed(token) -> bool`
### `isRouterAllowed(router) -> bool`
### `isDexAllowed(dex) -> bool`

---

### `getConfigBounds(configHash) -> Bounds`
Returns:
- all configured bounds for that configHash

---

## Required Events

- `ConfigAdded(configHash)`
- `ConfigRemoved(configHash)`
- `TokenAllowlistUpdated(token, enabled)`
- `RouterAllowlistUpdated(router, enabled)`
- `DexAllowlistUpdated(dex, enabled)`
- `BoundsUpdated(configHash, newBoundsHash)`

---

# B.5 Module: GuardrailEngine (Execution Safety Checks)

## Purpose
A shared safety module so every vault uses consistent checks and reject codes.

## Required Functions

### `precheck(vaultId, plan) -> (ok, reasonCode)`
Must check:
- vault state active
- system not paused
- config allowed
- router allowed
- tokens allowed
- liquidity thresholds
- oracle sanity
- venue deviation sanity
- slippage sanity
- peg sanity
- gas ceiling sanity
- rate limits
- exposure limits
- drawdown limits

Output:
- `ok = true` if trade allowed
- `ok = false, reasonCode` otherwise

---

# B.6 Module: FeeRouter (Fee + Discount Stack)

## Purpose
Computes performance fee on realized net profit and routes it.

## Required Functions

### `computeFeeBps(user, vaultId, rewardMode) -> feeBps`
Rules:
- base fees:
  - USDT rewards: 2000 bps
  - LOOP rewards: 1750 bps
- apply discount stack:
  - supporter badge + others
- enforce minimum fee floor

---

### `computeFeeUSDT(vaultId, realizedNetProfitUSDT) -> feeUSDT`
Rules:
- if profit == 0 → fee == 0

---

### `routeFee(vaultId, feeUSDT)`
Routes fee to configured receivers.

Must emit routing events.

---

# B.7 Module: ClaimLedger / ProfitBuffer

## Purpose
Stores claimable balances. Enables claim-anytime.

## Required Functions

### `creditClaim(vaultId, asset, amount)`
Called by vault only.

### `creditCompound(vaultId, amountUSDT)`
Called by vault only.

### `claim(vaultId, asset) -> amount`
Called by vault owner.

### `getClaimable(vaultId, asset) -> amount`

---

# B.8 Module: LOOP Token + LoopMinter

## Loop Token Requirements
- standard BEP-20
- no fees on transfer
- mint restricted to LoopMinter

## LoopMinter Requirements

### `mintSupporterAirdrop(user, amountLOOP, supporterId)`
### `mintReferralReward(user, amountLOOP, referralId)`
### `mintRewardConversion(user, amountLOOP, vaultId)`

Rules:
- enforce program caps
- enforce global mint caps
- emit events

---

# B.9 Module: ReserveVault + ReserveController

## Purpose
Reserve supports redemption/buybacks (bounded) and solvency signaling.

## ReserveVault Functions
- `reserveBalanceUSDT() -> uint256`

## ReserveController Functions

### `isRedemptionActive() -> bool`
### `getReserveCaps() -> ReserveCaps`
### `redeem(loopAmount) -> usdtOut`
Rules:
- bounded by caps
- bounded by reserve minimum
- may pause automatically

---

# B.10 Module: SupporterPresale

## Purpose
Handles supporter deposits, fund splits, supporter badge issuance, airdrop entitlements.

## Required Functions

### `supporterDeposit()`
Rules:
- exact amount: 300 USDT
- max supporters: 5000
- one per wallet
- split 300 deterministically:
  - 75 dev
  - 25 ECW
  - 100 reserve
  - 100 airdrop entitlement

### `claimSupporterAirdrop()`
Delivers supporter LOOP allocation.

---

# B.11 Module: SupporterBadge NFT

## Purpose
On-chain supporter proof, discount activation, discord gating.

## Required Functions
- `hasBadge(user) -> bool`
- standard NFT ownership views

Rules:
- transferable optional
- transfer safeguard enforced if transferable

---

# B.12 Module: ReferralRegistry

## Purpose
Stores referrer relationships, tracks 180-day qualification, credits rewards.

## Required Functions
- `registerReferralCode(code)`
- `setReferrerByCode(code)` (first deposit only)
- `checkQualification(referred) -> bool`
- `claimReferralRewards() -> amountLOOP`

Rules:
- no referrer changes
- qualification requires 180 days
- caps mandatory
- blacklist integration mandatory

---

# Appendix C — Storage Layout + Data Model (What Must Be Stored, Where, and Why)

This appendix defines the **required storage variables** (data layout) and **data model** for YieldLoop.

A dev needs this to avoid two fatal mistakes:
1) breaking accounting invariants (principal/profit confusion)
2) making the UI impossible to build (missing view data)

This is written so:
- a Solidity dev can implement storage cleanly
- a frontend dev can read it and know what data exists
- an auditor can follow the money

---

## C.1 Core Principle: Separate Money Buckets

Every vault must track money in clean compartments:

### C.1.1 Principal (Never Fee’d)
- what user deposited (USDT)
- not profit
- not claimable unless exiting/withdrawing principal (policy-defined)

### C.1.2 Claimable (User-Owned Profit)
- realized profit owed to user
- claim-anytime

### C.1.3 Compound (Profit Reinvest Portion)
- realized profit allocated to reinvestment
- tracked separately to prevent “fake profit compounding”

### C.1.4 Inventory (Active Risk Exposure)
- BTCB/SOL/XRP holdings inside strategy
- value fluctuates, NOT counted as profit until realized into USDT

---

## C.2 Canonical Storage: VaultFactory / VaultManager

This module maintains a registry and is the authoritative source of:

- vault ownership
- vault config selection
- vault acceptance

### C.2.1 Required Storage Variables

- `nextVaultId: uint256`
- `vaultOwner[vaultId] -> address`
- `vaultAddress[vaultId] -> address` (if per-vault contract deployment)
- `vaultState[vaultId] -> VaultState`
- `vaultConfigHash[vaultId] -> bytes32`
- `vaultRewardMode[vaultId] -> RewardMode`
- `vaultCompoundRateBps[vaultId] -> uint16`
- `vaultCreatedAt[vaultId] -> uint256`
- `vaultAcceptedAt[vaultId] -> uint256` (0 until accepted)
- `vaultClosedAt[vaultId] -> uint256` (0 until closed)

Optional but recommended:
- `vaultLastExecutionAt[vaultId] -> uint256`
- `vaultLastRejectReason[vaultId] -> RejectReason`
- `vaultLastRejectAt[vaultId] -> uint256`

### C.2.2 Required Views for UI/API

- `getVaultSummary(vaultId)` returns:
  - owner
  - state
  - configHash
  - rewardMode
  - compoundRate
  - createdAt
  - acceptedAt
  - closedAt

- `getVaultIdsByOwner(owner)` returns list/array  
  (can be expensive on-chain; if so, emit events and index off-chain)

---

## C.3 Canonical Storage: UserVault

UserVault is where truth lives. This is the money box.

Even if you implement vault as “one contract with mappings,” you must preserve the same logical storage.

### C.3.1 Required Storage Variables (Per Vault)

Ownership + identity:
- `owner: address`
- `vaultId: uint256`
- `configHash: bytes32`

State:
- `state: VaultState`
- `paused: bool` (optional; can be encoded into state)
- `pauseReason: RejectReason`

Accounting:
- `principalUSDT: uint256`
- `compoundUSDT: uint256`

Claim ledger (two-asset model):
- `claimableUSDT: uint256`
- `claimableLOOP: uint256`

Inventory:
- `balBTCB: uint256`
- `balSOL: uint256`
- `balXRP: uint256`

Execution tracking:
- `lastExecutionAt: uint256`
- `executionCount: uint256`
- `lastRejectReason: RejectReason`
- `lastRejectAt: uint256`
- `rejectCountByReason[RejectReason] -> uint256` (optional but powerful)

Risk tracking (recommended):
- `lossStreak: uint16`
- `maxDrawdownBpsObserved: uint16`
- `lastHighWaterUSDT: uint256` (for drawdown computation)
- `exitRequestedAt: uint256` (0 if not requested)

### C.3.2 Critical Invariants (Must Never Break)

1) `principalUSDT` never decreases except on exit/withdraw principal path  
2) fees never touch principal  
3) claim never touches principal  
4) profit never exists until realized into USDT  
5) inventory valuations never counted as realized profit  
6) state machine blocks execution unless ACTIVE  

---

## C.4 Canonical Storage: ClaimLedger / ProfitBuffer

You can implement claim balances inside UserVault directly OR in a separate ClaimLedger contract.

If separate, it should track:

### C.4.1 Required Storage Variables

- `claimable[vaultId][asset] -> uint256`
- `totalClaimed[vaultId][asset] -> uint256` (optional)
- `totalCredited[vaultId][asset] -> uint256` (optional)
- `lastClaimAt[vaultId] -> uint256`

### C.4.2 Claim Safety Variables

- `claimNonce[vaultId]` (optional)
- `claimPaused[vaultId]` (rare, emergency only)

### C.4.3 Required Views

- `getClaimable(vaultId, asset) -> uint256`
- `getLifetimeClaimed(vaultId, asset) -> uint256` (optional)

---

## C.5 Canonical Storage: ConfigRegistry

This is the “protocol rulebook.”

### C.5.1 Required Storage Variables

Config allowlist:
- `allowedConfigHash[bytes32] -> bool`

Token allowlist:
- `allowedToken[address] -> bool`

Router allowlist:
- `allowedRouter[address] -> bool`

DEX allowlist (optional but recommended):
- `allowedDex[address] -> bool`

Per-config bounds:
- `configBounds[configHash] -> BoundsStruct`

Where BoundsStruct contains:
- `minNetProfitUSDT: uint256`
- `maxSlippageBps: uint16`
- `maxImpactBps: uint16`
- `maxOracleDeviationBps: uint16`
- `maxVenueDeviationBps: uint16`
- `maxPegDeviationBps: uint16`
- `maxExposureBpsPerAsset: uint16`
- `maxTradesPerHour: uint16`
- `cooldownSeconds: uint32`
- `maxDrawdownBps: uint16`
- `maxLossStreak: uint16` (recommended)
- `maxExecutionCostUSDT: uint256` (recommended)
- `profitToCostMultiplierBps: uint16` (recommended)

---

## C.6 Canonical Storage: GuardrailEngine

Guardrail engine can be stateless (pure checks) or stateful (tracking last rejects, flags).

Recommended stateful storage:

### C.6.1 Required Storage Variables

Global flags:
- `globalPaused: bool`
- `tokenPaused[token] -> bool`
- `routerPaused[router] -> bool`
- `dexPaused[dex] -> bool`

Per-vault flags (optional):
- `vaultPaused[vaultId] -> bool`
- `vaultPauseReason[vaultId] -> RejectReason`

Execution cost sanity:
- `maxGasPriceWei: uint256`
- `maxExecCostUSDT: uint256`

---

## C.7 Canonical Storage: FeeRouter

FeeRouter needs to compute a fee rate and route amounts.

### C.7.1 Required Storage Variables

Fee base config:
- `baseFeeBps_USDT: uint16` (default 2000)
- `baseFeeBps_LOOP: uint16` (default 1750)
- `minFeeBps: uint16` (to prevent 0 fee)
- `maxDiscountBps: uint16` (cap)

Discount sources:
- `supporterBadgeAddress: address`
- `supporterDiscountBps: uint16` (default 100)

Fee routing receivers:
- `receiverDev: address`
- `receiverMarketing: address`
- `receiverReserve: address`
- `receiverECW: address`

Fee routing splits (must sum to 10000 bps):
- `splitDevBps: uint16`
- `splitMarketingBps: uint16`
- `splitReserveBps: uint16`
- `splitECWBps: uint16`

Rules:
- all split updates timelocked

---

## C.8 Canonical Storage: LOOP Token + LoopMinter

### C.8.1 LOOP Token Storage (Standard)
- total supply
- balances
- allowances
- minter role (LoopMinter only)

### C.8.2 LoopMinter Storage

Program caps:
- `maxMintPerTx: uint256`
- `maxMintPerDay: uint256`
- `maxMintPerMonth: uint256`

Per-source caps:
- `maxMintSupporterTotal: uint256`
- `maxMintReferralPerMonth: uint256`
- `maxMintRewardConversionPerDay: uint256`

Telemetry:
- `mintedToday: uint256`
- `mintedThisMonth: uint256`
- `mintedBySource[sourceCode] -> uint256`

Pause:
- `mintPaused: bool`

---

## C.9 Canonical Storage: ReserveVault + ReserveController

### C.9.1 ReserveVault Storage
- reserve token balances (USDT)
- deposit-only allowed from allowlisted sources

### C.9.2 ReserveController Storage

Reserve config:
- `reserveMinUSDT: uint256`
- `maxRedeemPerTxUSDT: uint256`
- `maxRedeemPerDayUSDT: uint256`
- `cooldownSeconds: uint256`

Redemption state:
- `redemptionActive: bool`
- `lastRedeemAt[user] -> uint256` (if cooldown enforced)
- `redeemedTodayUSDT: uint256`

Buyback state (if enabled):
- `buybackActive: bool`
- `maxBuybackPerDayUSDT: uint256`
- `maxBuybackPerTxUSDT: uint256`
- `boughtBackTodayUSDT: uint256`

---

## C.10 Canonical Storage: SupporterPresale

### C.10.1 Required Storage Variables

Sale constraints:
- `MAX_SUPPORTERS: uint256 = 5000`
- `supporterCount: uint256`
- `saleClosed: bool`
- `salePaused: bool`

Per-wallet:
- `supporterIdByWallet[wallet] -> uint256`
- `walletBySupporterId[supporterId] -> address`
- `hasPurchased[wallet] -> bool`

Airdrop entitlement:
- `entitlementValueUSDT[wallet] -> uint256` (102.50 USDT equivalent)
- `airdropClaimed[wallet] -> bool`

Receiver addresses:
- dev receiver
- ECW receiver
- reserve receiver
- airdrop program budget receiver (or mint path)

---

## C.11 Canonical Storage: SupporterBadge NFT

Badge policy impacts storage needs.

Required:
- standard NFT ownership mapping

Recommended additions:
- `supporterIdOfWallet[wallet] -> supporterId`
- transfer timestamps:
  - `lastTransferAt[tokenId] -> uint256`
  - `lastTransferAtWallet[wallet] -> uint256` (optional)

This enables:
- discount warmup after transfer

---

## C.12 Canonical Storage: ReferralRegistry

### C.12.1 Required Storage Variables

Referral mapping:
- `referrerOf[referred] -> referrer`
- immutable after set

Code mapping:
- `referrerOfCode[code] -> referrer`

Qualification tracking:
- `registeredAt[referred] -> uint256`
- `qualifiedAt[referred] -> uint256`
- `paidAt[referred] -> uint256`

Status:
- `status[referred] -> {NONE, QUALIFYING, QUALIFIED, PAID, REJECTED}`

Reward caps:
- `rewardsPaidThisMonth[referrer] -> uint256`
- `rewardsPaidLifetime[referrer] -> uint256`
- `globalRewardsPaidThisMonthUSDT -> uint256`

Blacklist integration:
- `blacklisted[wallet] -> bool`

---

## C.13 Required Event Data Model (Indexing for UI)

A frontend cannot query mappings efficiently at scale.

So YieldLoop must emit events sufficient to build:
- per-user dashboard
- per-vault history
- profit history
- claim history
- rejection reasons history

### C.13.1 Minimum Events to Index

- Vault creation / acceptance / decline
- Each execution attempt + completion
- Each reject reason
- Each profit credited
- Each fee charged + routed
- Each claim withdrawal
- Badge mint + transfer
- Referral register + qualification + reward credit

---

## C.14 UI Data Requirements (What the App Must Show)

At minimum per vault, UI must display:

1) Status:
   - state
   - last execution time
   - last reject reason (if any)

2) Accounting:
   - principal USDT
   - claimable USDT
   - claimable LOOP
   - compound USDT

3) Exposure:
   - BTCB inventory
   - SOL inventory
   - XRP inventory
   - % weights (derived)

4) Strategy settings:
   - reward mode
   - compound rate

5) Fees:
   - base fee
   - discounts applied
   - effective fee

6) Guardrails:
   - current safety flags
   - last block reason (if paused/rejected)

---

## C.15 Final Rule (Developer Warning)

If your storage layout does not preserve these compartmental separations:

- principal
- claimable
- compound
- inventory

Then your protocol will inevitably:
- miscalculate profit
- mischarge fees
- break trust
- fail audit

This appendix is not optional.

---

# Appendix D — Execution Pseudocode (Step-by-Step, No Ambiguity)

This appendix defines **exactly how execution works**.

A keeper can suggest a trade.
The vault decides.
The vault executes only if safe.
Profit is only profit if realized in USDT net of costs.

This is the “engine room” spec.

---

## D.1 Core Execution Loop (Plain English)

YieldLoop runs a continuous cycle.

It does not “wait for a month.”
It idles until conditions are safe and profitable.

At any moment:
- vault holds some mixture of BTCB/SOL/XRP/USDT
- system evaluates whether a rotation improves balance
- system executes a rebalancing trade only if it passes guardrails
- if net profit is realized, it is split into:
  - claimable
  - compound

---

## D.2 Inputs to Execution

Execution must have these inputs:

### D.2.1 Required Vault Inputs
- vaultId
- vault configHash
- vault state
- vault reward mode
- vault compound rate
- vault current inventory balances:
  - BTCB amount
  - SOL amount
  - XRP amount
  - USDT amount

### D.2.2 Required Market Inputs
- current DEX spot prices (PCS + BiSwap)
- oracle/TWAP price for sanity check
- liquidity depth
- estimated slippage for planned size
- estimated gas cost

### D.2.3 Required Policy Inputs (Config)
- min net profit threshold (USDT)
- max slippage (bps)
- max venue deviation (bps)
- max oracle deviation (bps)
- max peg deviation (bps)
- max exposure per asset (bps)
- max trades per hour
- cooldown time
- drawdown threshold (bps)
- gas ceiling

---

## D.3 Execution Plan Generation (Keeper Side)

Keepers are allowed to propose an execution plan.

The keeper does NOT have authority.
They are a delivery mechanism.

### D.3.1 Keeper Algorithm (Suggested)

Keeper computes:

1) Compute target weights for vault (config):
   - Example weights:
     - BTCB 33.33%
     - SOL 33.33%
     - XRP 33.33%

2) Compute current weights based on USDT valuation:
   - valueBTCB = BTCB_amt * priceBTCB_USDT
   - valueSOL  = SOL_amt  * priceSOL_USDT
   - valueXRP  = XRP_amt  * priceXRP_USDT
   - totalValue = valueBTCB + valueSOL + valueXRP + USDT_amt

3) Determine overweight and underweight assets
4) Propose a rotation:
   - sell overweight → buy underweight
5) Build an ExecutionPlan:
   - choose router and venue (PCS/BiSwap) for best output
   - set amountIn conservatively
   - set minOut with slippage cap
   - set deadline (short)

Keeper submits:
- `execute(vaultId, plan)`

---

## D.4 Canonical Vault Execution Pseudocode (Authoritative)

This pseudocode is the protocol truth.

### D.4.1 Execute() — High Level

function execute(vaultId, plan):

emit ExecutionAttempted(…)

// 0) State checks
if vault.state != ACTIVE:
emit ExecutionRejected(VAULT_NOT_ACTIVE)
return

if system.globalPaused == true:
emit ExecutionRejected(SYSTEM_PAUSED)
return

if vault.exitRequested == true or vault.state in {EXIT_REQUESTED, UNWINDING}:
emit ExecutionRejected(UNWIND_IN_PROGRESS)
return

// 1) Config checks
if ConfigRegistry.isConfigAllowed(vault.configHash) == false:
emit ExecutionRejected(CONFIG_MISMATCH)
return

// 2) Allowlist checks
if ConfigRegistry.isRouterAllowed(plan.router) == false:
emit ExecutionRejected(ROUTER_DISABLED)
return

if ConfigRegistry.isTokenAllowed(plan.tokenIn) == false:
emit ExecutionRejected(TOKEN_DISABLED)
return

if ConfigRegistry.isTokenAllowed(plan.tokenOut) == false:
emit ExecutionRejected(TOKEN_DISABLED)
return

// 3) Guardrail precheck (pricing, slippage, MEV, peg)
(ok, reason) = GuardrailEngine.precheck(vaultId, plan)
if ok == false:
emit ExecutionRejected(reason)
return

// 4) Snapshot vault value BEFORE
valueBefore = computeVaultValueUSDT(vaultId)   // based on oracle/TWAP rules
usdtBefore  = vault.USDT_balance

// 5) Perform swap
swapResult = Router.swap(plan)
if swapResult.failed:
emit ExecutionRejected(INVALID_INPUT) // or ROUTER error mapping
return

// 6) Snapshot vault value AFTER
valueAfter = computeVaultValueUSDT(vaultId)
usdtAfter  = vault.USDT_balance

// 7) Compute realized net profit
// IMPORTANT: profit is realized only when we actually increased USDT position
realizedProfitUSDT = max(usdtAfter - usdtBefore, 0)

// 8) Deduct execution costs (if ECW model credits cost)
execCostUSDT = estimateOrRecordExecutionCostUSDT()
netProfitUSDT = 0
if realizedProfitUSDT > execCostUSDT:
netProfitUSDT = realizedProfitUSDT - execCostUSDT
else:
netProfitUSDT = 0

// 9) Profit threshold gate
if netProfitUSDT < config.minNetProfitUSDT:
// treat as “no profit event”
// do NOT fee
// optionally revert if you want execution to be atomic-profit-only
emit ExecutionCompleted(vaultId, keeper, 0, 0, vault.rewardMode)
return

// 10) Compute fee
feeBps = FeeRouter.computeFeeBps(vault.owner, vaultId, vault.rewardMode)
feeUSDT = (netProfitUSDT * feeBps) / 10000

// 11) Route fee
FeeRouter.routeFee(vaultId, feeUSDT)

userProfitUSDT = netProfitUSDT - feeUSDT

// 12) Split user profit into claim vs compound
compoundRate = vault.compoundRateBps  // 0..10000
compoundUSDT = (userProfitUSDT * compoundRate) / 10000
claimUSDT    = userProfitUSDT - compoundUSDT

// 13) Credit claim/compound based on reward mode
if vault.rewardMode == USDT_REWARDS:
ClaimLedger.creditClaim(vaultId, USDT, claimUSDT)
Vault.creditCompound(vaultId, compoundUSDT)

if vault.rewardMode == LOOP_REWARDS:
// convert claimUSDT into LOOP
// preferred: market-buy LOOP
(loopOut, ok2) = convertUSDTtoLOOP(claimUSDT)
if ok2 == true:
ClaimLedger.creditClaim(vaultId, LOOP, loopOut)
else:
// fallback: store as USDT claimable
ClaimLedger.creditClaim(vaultId, USDT, claimUSDT)

Vault.creditCompound(vaultId, compoundUSDT)

emit ProfitSplitApplied(vaultId, claimUSDT, compoundUSDT, compoundRate)
emit ExecutionCompleted(vaultId, keeper, netProfitUSDT, feeUSDT, vault.rewardMode)

vault.lastExecutionAt = now

---

## D.5 Important Clarification: What “Profit Event” Means

A profit event is NOT:
- token inventory increasing
- oracle value going up
- mark-to-market gain

A profit event IS:
- realized net increase in USDT inside vault after costs

This is why the system is credible.

---

## D.6 computeVaultValueUSDT() Rules

Vault value is computed for reporting and sanity checks.

But profit MUST still be realized in USDT.

### D.6.1 computeVaultValueUSDT(vaultId)

valueUSDT =
USDT_balance
	•	BTCB_amt * oraclePriceBTCB_USDT
	•	SOL_amt  * oraclePriceSOL_USDT
	•	XRP_amt  * oraclePriceXRP_USDT

Rules:
- use oracle/TWAP for valuation
- enforce staleness
- if oracle stale, execution must reject

---

## D.7 convertUSDTtoLOOP() Rules

Conversion must be safe.

### D.7.1 Preferred Conversion Method (Market Buy)

function convertUSDTtoLOOP(amountUSDT):

if LOOP_liquidity < minLiquidity:
return (0, false)

expectedOut = quoteSwap(USDT->LOOP)

if slippage(expectedOut) > maxSlippage:
return (0, false)

out = executeSwap(USDT->LOOP, amountUSDT, minOut)

if out == 0:
return (0, false)

return (out, true)

Fallback:
- if conversion fails, credit claimUSDT as USDT claimable

---

## D.8 Guardrail Engine Pseudocode (Precheck)

Guardrails enforce safety.

### D.8.1 Precheck() Steps

function precheck(vaultId, plan):

// 1) cooldown / rate limits
if now < vault.lastExecutionAt + config.cooldownSeconds:
return (false, RATE_LIMIT)

if tradesInLastHour(vaultId) >= config.maxTradesPerHour:
return (false, RATE_LIMIT)

// 2) liquidity check
if liquidity(plan.tokenIn, plan.tokenOut, plan.router) < minLiquidityThreshold:
return (false, LOW_LIQUIDITY)

// 3) oracle sanity
oraclePriceIn  = Oracle.getPriceUSDT(plan.tokenIn)
oraclePriceOut = Oracle.getPriceUSDT(plan.tokenOut)
if oracle stale:
return (false, ORACLE_STALE)

// 4) venue deviation sanity
spotPrice = DEX.getSpotPrice(plan.tokenIn, plan.tokenOut)
if deviation(spotPrice, oraclePriceIn/oraclePriceOut) > config.maxVenueDeviationBps:
return (false, VENUE_PRICE_DEVIATION)

// 5) peg deviation sanity (BTCB/SOL/XRP)
if plan.tokenIn is pegged and pegDeviation(tokenIn) > config.maxPegDeviationBps:
return (false, PEG_RISK)

if plan.tokenOut is pegged and pegDeviation(tokenOut) > config.maxPegDeviationBps:
return (false, PEG_RISK)

// 6) slippage check
expectedOut = quoteSwap(plan)
if expectedOut < plan.minOut:
return (false, SLIPPAGE_TOO_HIGH)

// 7) exposure check (post trade)
newExposure = simulateExposureAfterTrade(vaultId, plan)
if anyExposure > config.maxExposureBpsPerAsset:
return (false, EXPOSURE_LIMIT)

// 8) drawdown check
drawdown = computeDrawdown(vaultId)
if drawdown > config.maxDrawdownBps:
return (false, DRAWDOWN_LIMIT)

// 9) estimated execution cost sanity
execCostUSDT = estimateGasCostUSDT()
if execCostUSDT > config.maxExecutionCostUSDT:
return (false, EXECUTION_COST_TOO_HIGH)

// 10) profit-to-cost check (optional but strong)
estimatedProfitUSDT = estimateProfitUSDT(vaultId, plan)
if estimatedProfitUSDT < (execCostUSDT * profitToCostMultiplier):
return (false, EXECUTION_COST_TOO_HIGH)

return (true, NONE)

---

## D.9 Execution Must Be Atomic (No Partial Updates)

Execution must be:
- atomic (succeed fully or fail fully)
- non-reentrant
- no partial updates leaving accounting corrupt

---

## D.10 Profit Split Pseudocode (Claim vs Compound)

This is deterministic and must never vary:

compoundUSDT = userProfitUSDT * compoundRateBps / 10000
claimUSDT    = userProfitUSDT - compoundUSDT

Rules:
- compoundRateBps is always 0–10000
- compoundRate affects future profit only

---

## D.11 “Claim Anytime” Pseudocode

Claim is simple and must remain safe.

function claim(vaultId, asset):

require(msg.sender == owner)

amount = ClaimLedger.claimable[vaultId][asset]
require(amount > 0)

ClaimLedger.claimable[vaultId][asset] = 0
transfer(asset, msg.sender, amount)

emit Claimed(vaultId, owner, asset, amount)

return amount

Rules:
- update state before transferring
- nonReentrant

---

## D.12 Exit / Unwind Pseudocode (High-Level)

Exit is a controlled unwind.

function requestExit(vaultId):

require(msg.sender == owner)
require(state == ACTIVE or state == PAUSED)

state = EXIT_REQUESTED
emit ExitRequested(vaultId)

keeperOrUser triggers unwind steps:
	•	convert BTCB->USDT safely
	•	convert SOL->USDT safely
	•	convert XRP->USDT safely
	•	enforce slippage caps
	•	enforce peg risk caps
	•	once inventory cleared:
	•	close vault
	•	allow principal withdrawal path (policy-defined)

  ---

## D.13 Final Rule: If Guardrails Reject, That Is “Correct Behavior”

YieldLoop will reject many trades.

It will idle.

That is a feature — not a failure.

Any implementation that:
- forces execution
- relaxes slippage
- ignores oracle deviation

…will get exploited or bleed to death through MEV.

This appendix is designed to prevent that.

---

# Appendix E — Guardrail Rule Table (Inputs → Checks → Reject Codes → User-Facing Display)

This appendix defines **all guardrails** as a rules table.

A dev uses this to implement deterministic checks.
A UI uses this to display exactly what the user is accepting at the accept/decline checkpoint.
An auditor uses this to verify the protocol is not “lying with math.”

Guardrails are grouped by category:
- State & permissions
- Pricing & oracle sanity
- Liquidity & slippage
- Peg risk
- Execution cost
- Exposure & risk
- Rate limiting
- Drawdown & emergency behavior

---

## E.1 Guardrail Output Contract

Every execution attempt must produce one of:

- **ALLOW**
- **REJECT(reasonCode)**

If REJECT:
- reason code must be emitted on-chain
- UI must map reason code to user-readable explanation

---

## E.2 User-Facing Guardrail Summary (Shown at Accept/Decline)

At the acceptance checkpoint, UI must show (minimum):

1) **Tokens traded:** BTCB / SOL (Binance-Peg) / XRP (Binance-Peg)  
2) **Venues allowed:** PancakeSwap + BiSwap (or allowlisted routers)  
3) **Safety rules:**  
   - no trade unless oracle sane  
   - no trade if peg deviates beyond threshold  
   - no trade if liquidity too low  
   - no trade if slippage too high  
   - no trade if estimated cost too high  
   - no trade if vault exposure violates caps  
   - no trade if drawdown limit hit  
4) **Profit definition:** realized net USDT only  
5) **Fee rule:** fee only on realized net profit  
6) **Claim rule:** claim anytime, claimable tracked separately  
7) **Discount rule:** LOOP rewards reduce fee from 20% to 17.5% before other discounts

This summary must match the rule table below.

---

## E.3 Canonical Guardrail Rule Table

Each rule includes:
- Inputs required
- Condition checked
- Action
- Reject code
- UI message template

---

### E.3.1 State: Vault Must Be Active

**Inputs**
- vaultState

**Check**
- vaultState == ACTIVE

**Reject**
- `VAULT_NOT_ACTIVE`

**UI Message**
- “Vault is not active. Trading only runs after you accept the strategy.”

---

### E.3.2 State: System Not Globally Paused

**Inputs**
- globalPaused flag

**Check**
- globalPaused == false

**Reject**
- `SYSTEM_PAUSED`

**UI Message**
- “Trading is paused protocol-wide due to safety conditions.”

---

### E.3.3 State: Vault Not In Unwind

**Inputs**
- vaultState

**Check**
- vaultState NOT IN {EXIT_REQUESTED, UNWINDING}

**Reject**
- `UNWIND_IN_PROGRESS`

**UI Message**
- “Vault is exiting/unwinding. Trading is disabled during unwind.”

---

### E.3.4 Config: Vault Config Must Match Allowed Config

**Inputs**
- vaultConfigHash
- ConfigRegistry.allowedConfigHash

**Check**
- allowedConfigHash[vaultConfigHash] == true

**Reject**
- `CONFIG_MISMATCH`

**UI Message**
- “Vault strategy configuration is not approved or no longer allowed.”

---

### E.3.5 Allowlist: Router Must Be Allowed

**Inputs**
- plan.router
- ConfigRegistry.allowedRouter

**Check**
- allowedRouter[plan.router] == true

**Reject**
- `ROUTER_DISABLED`

**UI Message**
- “This router is not allowed for safety reasons.”

---

### E.3.6 Allowlist: Tokens Must Be Allowed

**Inputs**
- plan.tokenIn
- plan.tokenOut
- ConfigRegistry.allowedToken

**Check**
- allowedToken[tokenIn] && allowedToken[tokenOut] == true

**Reject**
- `TOKEN_DISABLED`

**UI Message**
- “One of the tokens is disabled by protocol safety rules.”

---

### E.3.7 Venue: DEX Must Be Allowed (If Separately Tracked)

**Inputs**
- dexId / router maps to dex
- ConfigRegistry.allowedDex

**Check**
- allowedDex[dex] == true

**Reject**
- `DEX_DISABLED`

**UI Message**
- “This trading venue is currently disabled.”

---

### E.3.8 Oracle Freshness (Staleness)

**Inputs**
- oracleUpdatedAt(tokenIn), oracleUpdatedAt(tokenOut)
- maxStalenessSeconds

**Check**
- now - oracleUpdatedAt <= maxStalenessSeconds for all involved tokens

**Reject**
- `ORACLE_STALE`

**UI Message**
- “Price feed is stale. Trading is blocked until pricing is fresh.”

---

### E.3.9 Oracle Deviation (Spot vs Oracle)

**Inputs**
- oraclePrice(tokenIn), oraclePrice(tokenOut)
- dexSpotPrice(tokenIn/tokenOut)
- maxOracleDeviationBps or maxVenueDeviationBps

**Check**
- deviation(spotPrice, oracleImpliedPrice) <= thresholdBps

**Reject**
- `ORACLE_DEVIATION_TOO_HIGH` OR `VENUE_PRICE_DEVIATION`

**UI Message**
- “Market price deviated too far from reference price. Trading blocked to prevent manipulation.”

---

### E.3.10 Liquidity Threshold

**Inputs**
- pool liquidity for route
- minimum liquidity threshold (USDT equivalent)

**Check**
- liquidityUSDT >= minLiquidityUSDT

**Reject**
- `LOW_LIQUIDITY`

**UI Message**
- “Liquidity is too low. Trading blocked to avoid extreme slippage.”

---

### E.3.11 Slippage Ceiling (Pre-Trade Quote Check)

**Inputs**
- quotedOut for plan.amountIn
- plan.minOut
- config.maxSlippageBps

**Check**
- quotedOut >= plan.minOut
- and impliedSlippageBps <= maxSlippageBps

**Reject**
- `SLIPPAGE_TOO_HIGH`

**UI Message**
- “Slippage is too high. Trade rejected.”

---

### E.3.12 Deadline Check

**Inputs**
- plan.deadline
- current time

**Check**
- now <= plan.deadline

**Reject**
- `INVALID_INPUT`

**UI Message**
- “Trade expired. Keeper must submit a fresh plan.”

---

### E.3.13 Peg Deviation (Binance-Peg Token Risk)

Applies to BTCB, Binance-Peg SOL, Binance-Peg XRP.

**Inputs**
- pegReferencePrice (oracle or cross-market)
- token market price
- config.maxPegDeviationBps

**Check**
- pegDeviationBps <= maxPegDeviationBps

**Reject**
- `PEG_RISK`

**UI Message**
- “Peg deviation exceeded safety threshold. Token disabled for trading.”

---

### E.3.14 Execution Cost Ceiling (Gas and Keeper Costs)

**Inputs**
- estimated gas units * current gas price
- gasCostUSDT estimate
- config.maxExecutionCostUSDT

**Check**
- gasCostUSDT <= maxExecutionCostUSDT

**Reject**
- `EXECUTION_COST_TOO_HIGH`

**UI Message**
- “Execution cost too high relative to expected profit. Trade rejected.”

---

### E.3.15 Profit-to-Cost Ratio Minimum (Strong Recommended)

**Inputs**
- estimatedProfitUSDT
- estimatedCostUSDT
- config.profitToCostMultiplier (e.g., 2.0x)

**Check**
- estimatedProfitUSDT >= estimatedCostUSDT * multiplier

**Reject**
- `EXECUTION_COST_TOO_HIGH`

**UI Message**
- “Trade not profitable enough after costs. Trade rejected.”

---

### E.3.16 Exposure Caps (Per Asset)

**Inputs**
- post-trade simulated portfolio weights
- config.maxExposureBpsPerAsset

**Check**
- each asset weight <= maxExposureBpsPerAsset

**Reject**
- `EXPOSURE_LIMIT`

**UI Message**
- “Exposure limit exceeded. Trade rejected to prevent overconcentration.”

---

### E.3.17 Rate Limit: Cooldown Time

**Inputs**
- vault.lastExecutionAt
- config.cooldownSeconds

**Check**
- now >= lastExecutionAt + cooldownSeconds

**Reject**
- `RATE_LIMIT`

**UI Message**
- “Cooldown active. Trade rejected to prevent overtrading.”

---

### E.3.18 Rate Limit: Trades Per Hour

**Inputs**
- trades executed in last hour
- config.maxTradesPerHour

**Check**
- tradesLastHour < maxTradesPerHour

**Reject**
- `RATE_LIMIT`

**UI Message**
- “Trade rate limit reached. Trade rejected.”

---

### E.3.19 Drawdown Limit (Stop Trading on Bad Conditions)

**Inputs**
- vault high water mark (USDT value)
- current vault value (USDT)
- config.maxDrawdownBps

**Check**
- drawdownBps <= maxDrawdownBps

**Reject**
- `DRAWDOWN_LIMIT`

**UI Message**
- “Drawdown limit reached. Trading paused to prevent further loss.”

Action:
- recommended: pause vault automatically and require admin/user unpause.

---

### E.3.20 Loss Streak Limit (Optional but Smart)

**Inputs**
- consecutiveLossCount
- config.maxLossStreak

**Check**
- lossStreak <= maxLossStreak

**Reject**
- `DRAWDOWN_LIMIT` (or a dedicated LOSS_STREAK code if you add it)

**UI Message**
- “Loss streak threshold reached. Trading paused.”

---

### E.3.21 MEV Risk Gate (Optional but Valuable)

**Inputs**
- swap size vs pool depth
- historical sandwich frequency
- impact estimate

**Check**
- mevRiskScore <= threshold

**Reject**
- `MEV_RISK_TOO_HIGH`

**UI Message**
- “MEV/sandwich risk too high for this trade size. Trade rejected.”

---

### E.3.22 Keeper Permission (If Using Allowlisted Keepers)

**Inputs**
- msg.sender
- KeeperRegistry.allowlisted

**Check**
- allowlisted[msg.sender] == true

**Reject**
- `KEEPER_NOT_ALLOWED`

**UI Message**
- “Keeper not authorized.”

---

## E.4 Guardrail UI Mapping (Required)

UI must map each reasonCode to:

- Title (short)
- Explanation (1–2 sentences)
- “What happens next” (user action or wait)
- Whether funds are safe (always “yes” unless chain-level failure)

Example mapping:

- `ORACLE_STALE`
  - Title: “Price feed stale”
  - Explanation: “YieldLoop blocks trading until price references update.”
  - Next: “Wait for oracle refresh or try again later.”
  - Funds safe: “Yes”

---

## E.5 Guardrail Display At Accept/Decline (Minimum Fields)

At acceptance checkpoint, show actual parameter values:

- maxSlippageBps
- maxOracleDeviationBps
- maxVenueDeviationBps
- maxPegDeviationBps
- minLiquidityUSDT
- maxExecutionCostUSDT
- minNetProfitUSDT
- cooldownSeconds
- maxTradesPerHour
- maxExposureBpsPerAsset
- maxDrawdownBps

This is the user consent line.

---

## E.6 Implementation Rule: Fail Closed

If any required input is missing or invalid:
- reject execution
- return `INVALID_INPUT` or a specific reason

Never “assume ok.”

---

## E.7 Implementation Rule: Guardrails Must Be Shared and Consistent

Do not implement guardrails differently across modules.

GuardrailEngine should be a single consistent set of checks so:
- behavior is predictable
- audits are possible
- UI can show accurate rules

This appendix is the guardrail truth table.

---

# Appendix F — UI / API Data Spec (What the Dashboard Must Show, and How to Compute It)

This appendix defines the **developer-facing UI/API contract** for YieldLoop.

It answers:

- What does the app display?
- What view functions must exist?
- What data must be indexable from events?
- What values must be computed off-chain vs on-chain?
- What is the minimum dashboard that makes the system trustworthy?

This is not fluff.
If this part is weak, normies will not trust it and devs will ship nonsense dashboards.

---

## F.1 UI Philosophy

YieldLoop UI must do two things:

1) Make it **impossible to misunderstand** what is happening  
2) Make it **impossible for YieldLoop to lie about profit**  

Everything else is secondary.

---

## F.2 Core Screens

Minimum screens required:

1) Landing / What YieldLoop Is
2) Deposit / Create Vault
3) Strategy Preview + Accept / Decline (Howey checkpoint)
4) Vault Dashboard (per vault)
5) Claim Screen
6) Supporter Presale Screen
7) Referral Screen
8) System Status Screen (global guardrail flags)
9) Settings / Advanced
10) Admin-only (not public UI unless needed)

---

## F.3 “Accept / Decline” Strategy Preview Screen (Mandatory)

This is the critical legal + behavioral checkpoint.

### F.3.1 Must Display
- selected vault tokens: BTCB / SOL pegged / XRP pegged
- DEX venues used
- conservative trade behavior statement:
  - “YieldLoop may idle for long periods.”
- user-selected compound rate
- user-selected reward mode (USDT / LOOP)
- fee rate (effective, after discounts)
- risks disclosure summary (top risks)
- guardrail parameters (actual values)
- a hard “Accept” button and hard “Decline” button

### F.3.2 Must Display Guardrail Values (Not Just Names)
Example display fields:

- max slippage: `X%`
- max peg deviation: `X%`
- max oracle deviation: `X%`
- min liquidity: `$X`
- min net profit: `$X`
- max exec cost: `$X`
- cooldown: `X seconds`
- max trades/hour: `X`

### F.3.3 Must Display Profit Definition
- Profit is only realized in USDT.
- LOOP rewards are converted from USDT profit.

### F.3.4 Must Display Claim Rule
- “You can claim profit anytime.”
- “Principal is separate.”

---

## F.4 Vault Dashboard — Required Sections

Each vault dashboard must show:

### 1) Vault Status
- state: ACTIVE / PAUSED / EXIT_REQUESTED / CLOSED
- last execution timestamp
- last reject reason (if any)
- current guardrail status (green/yellow/red)

### 2) Vault Capital Overview
- principalUSDT
- compoundUSDT
- claimableUSDT
- claimableLOOP

### 3) Inventory Exposure
- BTCB balance
- SOL balance
- XRP balance
- USDT idle balance
- estimated portfolio value (USDT)
- target weight vs current weight

### 4) Performance History
- realized net profit history
- fees history
- claim history
- execution count
- reject count

### 5) Settings
- reward mode
- compound rate
- supporter discount eligibility
- referral link status

### 6) Safety + Guardrails
- max slippage
- max peg deviation
- max oracle deviation
- liquidity threshold
- drawdown threshold
- exposure caps

---

## F.5 Required API / View Functions (On-Chain)

The protocol must expose view functions that return the exact data UI needs.

### F.5.1 VaultFactory / VaultManager Views

#### `getVaultSummary(vaultId) -> VaultSummary`
VaultSummary includes:
- owner
- vaultAddress (if applicable)
- vaultState
- configHash
- rewardMode
- compoundRateBps
- createdAt
- acceptedAt
- closedAt

#### `getVaultState(vaultId) -> VaultState`

#### `getVaultOwner(vaultId) -> address`

#### `getVaultConfigHash(vaultId) -> bytes32`

#### `getRewardMode(vaultId) -> RewardMode`

#### `getCompoundRateBps(vaultId) -> uint16`

---

### F.5.2 UserVault Views

#### `getBalances(vaultId) -> VaultBalances`
VaultBalances includes:
- principalUSDT
- compoundUSDT
- claimableUSDT
- claimableLOOP
- inventoryBTCB
- inventorySOL
- inventoryXRP

#### `getInventory(vaultId) -> InventoryBreakdown`
If you choose to return inventory separately:
- btcBalance
- solBalance
- xrpBalance
- usdtBalance

#### `getLastExecution(vaultId) -> ExecutionStatus`
- lastExecutionAt
- lastRejectReason
- lastRejectAt

---

### F.5.3 ClaimLedger Views

#### `getClaimable(vaultId, asset) -> uint256`

#### `getLifetimeClaimed(vaultId, asset) -> uint256` (recommended)

---

### F.5.4 ConfigRegistry Views

#### `isConfigAllowed(configHash) -> bool`

#### `getGuardrailParams(configHash) -> GuardrailParams`

GuardrailParams includes:
- minNetProfitUSDT
- maxSlippageBps
- maxOracleDeviationBps
- maxVenueDeviationBps
- maxPegDeviationBps
- minLiquidityUSDT
- maxExposureBpsPerAsset
- maxTradesPerHour
- cooldownSeconds
- maxDrawdownBps
- maxExecutionCostUSDT

---

### F.5.5 FeeRouter Views

#### `getFeeConfig() -> FeeConfig`
- base fee USDT
- base fee LOOP
- min fee

#### `getEffectiveFeeBps(user, vaultId) -> uint16`
This must include all discounts.

#### `getDiscountBreakdown(user, vaultId) -> DiscountBreakdown`
DiscountBreakdown includes:
- supporterDiscountApplied (bool)
- supporterDiscountBps
- otherDiscountBps
- totalDiscountBps

---

### F.5.6 Guardrail Status Views

#### `isPausedGlobal() -> bool`
#### `isTokenPaused(token) -> bool`
#### `isRouterPaused(router) -> bool`
#### `isDexPaused(dex) -> bool`

Optional:
- `getVaultPauseStatus(vaultId) -> (paused, reasonCode)`

---

## F.6 Off-Chain Indexing Requirements (Subgraph/Indexer)

On-chain views are not enough for performance charts and history.

You must index events into a DB.

### F.6.1 Minimum Events to Index

Per vault:
- VaultCreated
- StrategyAccepted / Declined
- ExecutionAttempted
- ExecutionRejected
- ExecutionCompleted
- ProfitSplitApplied
- FeeCharged / FeeRouted
- Claimed
- ExitRequested
- VaultPaused / Unpaused

Per program:
- SupporterDeposit
- SupporterBadgeMinted
- ReferralRegistered
- ReferralQualified
- ReferralRewardCredited
- ReferralRewardClaimed

### F.6.2 Computed Views from Events

The indexer must compute:

- realizedProfitTotalUSDT (sum of ExecutionCompleted.netProfit)
- feesPaidTotalUSDT
- profitAfterFeesUSDT
- claimedTotalUSDT
- claimedTotalLOOP
- claimableRunningBalanceUSDT/LOOP
- executions per day
- rejects per day
- reason breakdown

---

## F.7 Dashboard Calculations (Definition of Each Metric)

These must be consistent everywhere.

### F.7.1 Vault Value (Estimated)

vaultValueUSDT =
USDT_balance
	•	BTCB_amt * oraclePriceBTCB
	•	SOL_amt  * oraclePriceSOL
	•	XRP_amt  * oraclePriceXRP

  ### F.7.2 Total Profit (Realized Only)

  totalRealizedProfitUSDT = sum(netProfitUSDT from ExecutionCompleted)

  ### F.7.3 Total Fees

  totalFeesUSDT = sum(feeUSDT from ExecutionCompleted)

  ### F.7.4 User Profit After Fees

  userProfitUSDT = totalRealizedProfitUSDT - totalFeesUSDT

  ### F.7.5 Claimable Balances
Claimable balances must come directly from:
- ClaimLedger mappings
- or vault storage

Not computed from price changes.

---

## F.8 Must-Have User Messages (Trust UX)

UI must show these messages prominently:

- “YieldLoop may pause trading to protect funds.”
- “YieldLoop may reject most trades. That is normal.”
- “Profit is only counted when realized in USDT.”
- “Fees are charged only on realized net profit.”
- “Claims do not affect principal.”

---

## F.9 Debug Screen (Developer Mode)

A hidden “dev mode” screen should show:

- current configHash
- guardrail params
- last 20 execution attempts
- last reject reason counts
- oracle freshness status
- venue deviation status
- peg deviation status
- minProfit / maxCost thresholds
- exposure weights

This massively improves debugging and audit readiness.

---

## F.10 Summary

If you implement this appendix properly:

- the vault cannot fake yield
- the UI cannot hide risk
- the user understands what they’re accepting
- developers can build confidently

If you skip it:

- the dashboard will be a lie
- users will assume it’s a scam
- you will fail investor review
- you will fail audit

---

# Appendix G — Testing Plan + Invariants (What Must Never Break)

This appendix defines the **test requirements** for YieldLoop.

This is not optional.

If these invariants are not tested and proven:
- you will ship bugs
- you will mis-account profit
- you will mischarge fees
- you will get exploited

YieldLoop must be tested like a financial system, not like a meme token.

---

## G.1 Test Philosophy

YieldLoop is a rule-based execution protocol.

Therefore tests must prove:

1) accounting correctness
2) safety guardrails correctness
3) fee correctness
4) non-custodial guarantees
5) that keepers cannot steal funds or force unsafe trades
6) that admin cannot rug
7) that profit cannot be faked

---

## G.2 Test Layers Required

Minimum test layers:

1) **Unit tests**
2) **Integration tests**
3) **Invariant tests**
4) **Fuzz tests**
5) **Fork tests** (BSC fork with real PCS/BiSwap behavior)
6) **Chaos tests** (oracle stale, peg deviation, liquidity collapse)
7) **Upgrade tests** (timelock enforcement + storage compatibility)

---

## G.3 Canonical Invariants (Must Always Hold)

These invariants must hold at all times, in all states, after any call sequence.

### G.3.1 Accounting Invariants

**INV-1: Principal is never fee’d**
- performance fees must never reduce `principalUSDT`

**INV-2: Claim never reduces principal**
- claim only reduces claimable balances

**INV-3: Profit is only realized in USDT**
- inventory gains must not create claimable profit

**INV-4: Claimable cannot become negative**
- claimable balances must always be >= 0

**INV-5: Fees only on realized net profit**
- if netProfitUSDT == 0, feeUSDT == 0

**INV-6: User profit split correctness**

userProfitUSDT = netProfitUSDT - feeUSDT
claimPartUSDT + compoundPartUSDT == userProfitUSDT

**INV-7: Compound rate bounded**
- compoundRateBps must always be within [0, 10000]

---

### G.3.2 Safety / Guardrail Invariants

**INV-8: Execution cannot happen unless ACTIVE**
- all execute() calls must reject if vaultState != ACTIVE

**INV-9: Execution cannot happen before acceptStrategy()**
- after createVault(), state is PENDING_ACCEPTANCE and trade must be blocked

**INV-10: Global pause blocks all executions**
- if globalPaused = true, all execute attempts reject

**INV-11: Disabled router/token/DEX blocks execution**
- if token/router disabled, execute rejects

**INV-12: Oracle staleness blocks execution**
- stale oracle => reject

**INV-13: Peg deviation blocks execution**
- peg deviation above threshold => reject

**INV-14: Slippage cap enforced**
- trade must never execute with output < minOut

---

### G.3.3 Non-Custodial / Admin Invariants

**INV-15: Admin cannot withdraw user funds**
- no admin function can transfer principal to admin addresses

**INV-16: Admin upgrades must be timelocked**
- upgrade cannot execute without timelock delay

**INV-17: Pause must not seize funds**
- pause only blocks execution, does not reassign balances

---

### G.3.4 Keeper Abuse Invariants

**INV-18: Keeper cannot drain vault**
- keeper cannot route tokens to themselves
- keeper cannot bypass allowlists

**INV-19: Keeper cannot execute arbitrary calldata**
- routeData must be verified/allowlisted

**INV-20: Keeper cannot force negative EV trades**
- guardrails must reject if:
  - cost too high
  - slippage too high
  - profit-to-cost threshold not met

---

### G.3.5 LOOP Reward Invariants

**INV-21: LOOP conversion cannot exceed claimUSDT value by policy**
- conversion rate must be market-anchored or capped

**INV-22: LOOP conversion fallback works**
- if LOOP conversion fails, claimable USDT must still be credited

**INV-23: Minting bounded**
- LOOP mint cannot exceed configured caps

---

## G.4 Unit Tests (Required)

### G.4.1 Vault Creation + Acceptance
Tests:
- createVault requires >= 300 USDT
- vault starts in PENDING_ACCEPTANCE
- execute() rejected before accept
- acceptStrategy sets ACTIVE
- declineStrategy refunds and closes vault

### G.4.2 Compound Rate
Tests:
- setCompoundRate bounds enforced
- compound applies only to new profit events
- compound math always sums correctly

### G.4.3 Reward Mode
Tests:
- USDT rewards apply 20% fee (base)
- LOOP rewards apply 17.5% fee (base)
- switching reward mode does not affect existing claimable amounts

### G.4.4 Claim
Tests:
- claim reduces claimable balance
- claim cannot exceed claimable
- claim never touches principal
- claim reentrancy protection works

### G.4.5 Fee Router
Tests:
- fee computed only when profit > 0
- discounts stack but bounded by minFee floor
- fee routing bps sum to 10000
- routed amounts match fee

---

## G.5 Integration Tests (Required)

### G.5.1 Full Trade Cycle (Profit Event)
Scenario:
- vault ACTIVE
- keeper proposes valid plan
- plan passes guardrails
- trade executes
- net profit realized
- fee taken
- claim/compound credited
- claim withdraw works

Assertions:
- all events fired
- balances consistent
- invariants hold

### G.5.2 No-Profit Trade
Scenario:
- keeper executes trade with 0 profit
Expected:
- no fee
- no credit to claimable/compound

### G.5.3 Execution Rejection Paths
Run execute() with:
- stale oracle
- high slippage
- low liquidity
- peg deviation
- paused router
Expected:
- reject reason correct
- no accounting changes
- execution does not partially mutate balances

---

## G.6 Invariant Testing (Property-Based)

You must run invariant tests with:
- random sequences of:
  - deposits
  - accept/decline
  - setting compound rate
  - switching reward mode
  - execution attempts
  - claims
  - pausing/unpausing

### G.6.1 Recommended Invariant Framework
- Foundry invariant tests
- Echidna
- Medusa

### G.6.2 Example Invariant Suite

**Suite A — Accounting Never Breaks**
Randomize:
- 1–200 executions
- 1–200 claims
Assertions:
- claimable >= 0 always
- principal constant unless exit
- fee never taken with 0 profit

**Suite B — State Machine Never Breaks**
Randomize:
- accept/decline ordering
- pausing/unpausing
Assertions:
- execute never succeeds in wrong states

**Suite C — Keeper Cannot Drain**
Randomize:
- malicious plans
- weird token routes
- invalid routers
Assertions:
- funds cannot be routed out
- reject occurs

---

## G.7 Fuzz Tests (Must Include)

Fuzz these values:

- depositUSDT near thresholds: 299.99, 300, 300.01
- compoundRateBps: -1, 0, 1, 9999, 10000, 10001
- slippage boundaries
- deadline boundaries (expired vs valid)
- tiny amounts that trigger rounding
- maximum amounts that trigger overflow risk

Assertions:
- no rounding exploit yields extra claim
- no overflow/underflow possible
- state remains consistent

---

## G.8 Fork Testing (BSC Fork)

Fork tests are mandatory because:
- PCS and BiSwap behave like real DEXs
- slippage is real
- MEV conditions matter

Fork tests should:

- create vault
- accept strategy
- execute against actual pools (fork)
- validate quote/minOut protection
- simulate pool liquidity shock

---

## G.9 Chaos Testing Scenarios (Safety Must Hold)

Run scenarios:

### G.9.1 Oracle Failure
- oracle stale
Expected:
- execution rejects
- claims still work

### G.9.2 Peg Break Scenario
- BTCB deviates 3–10%
Expected:
- token paused
- inventory unwind path requires explicit safety rules

### G.9.3 Liquidity Collapse
- remove liquidity
Expected:
- LOW_LIQUIDITY rejects

### G.9.4 Gas Spike
- gas price spikes
Expected:
- EXECUTION_COST_TOO_HIGH rejects

---

## G.10 Upgrade Testing (Critical)

If contracts are upgradeable, you must prove:

1) storage layout compatibility
2) timelock enforced
3) no upgrade can steal funds

Tests:
- queue upgrade
- attempt early execute → fails
- execute after delay → succeeds
- verify storage preserved:
  - principal
  - claimable
  - compound
  - inventory

---

## G.11 Required Coverage Targets

Minimum targets before launch:

- Unit test coverage: **>= 90%** of critical modules
- Invariant suites: **>= 10,000 randomized sequences**
- Fork tests: at least **20 successful executions** + **50 rejection cases**
- Fuzz testing: **>= 50k runs** minimum

If you skip this, you are not launch-ready.

---

## G.12 Final Build Gate (Ship/No-Ship Checklist)

Protocol may not deploy publicly until:

- all invariants hold
- guardrail rejects are correct
- profit is not faked
- fees not misapplied
- claim works in all safe states
- admin cannot rug
- keeper cannot drain

That’s the bar.

No exceptions.

---

# Appendix H — Upgrade + Incident Response Playbook (Operational Reality)

This appendix defines the operational playbook.

It answers:
- What happens when something breaks?
- Who can press which buttons?
- What is the exact procedure to pause/unpause?
- How do upgrades happen without turning into a rug?

If you don’t write this down, you will improvise under stress — and that’s how protocols die.

---

## H.1 Roles and Authority Model

YieldLoop must use a strict separation of power.

### H.1.1 Required Roles

1) **Protocol Multisig (Admin)**
   - emergency pause/unpause
   - emergency disable router/token/DEX
   - cannot withdraw user principal
   - cannot mint arbitrary LOOP
   - cannot upgrade instantly

2) **Timelock Governor**
   - upgrades
   - parameter updates
   - allowlist additions
   - fee routing changes
   - discount changes

3) **Keeper Operators**
   - submit execution plans
   - no privileged permissions (unless allowlisted keepers used)

4) **Observer / Monitoring**
   - off-chain alerting
   - dashboards
   - incident channel posts

---

## H.2 Emergency Controls Inventory

### H.2.1 Global Switches (Immediate)

- `pauseAll(reasonCode)`
- `unpauseAll()`

Effect:
- blocks all execute() calls
- does NOT block claim()

---

### H.2.2 Asset-Level Switches (Immediate)

- `pauseToken(token, reasonCode)`
- `unpauseToken(token)`

Effect:
- blocks all execution plans involving that token

Use for:
- peg breaks
- token exploit
- liquidity collapse

---

### H.2.3 Router/DEX Switches (Immediate)

- `pauseRouter(router, reasonCode)`
- `unpauseRouter(router)`
- `pauseDex(dex, reasonCode)`
- `unpauseDex(dex)`

Use for:
- router exploit
- DEX exploit
- suspicious slippage / MEV attacks

---

### H.2.4 Minting Switches (Immediate)

- `pauseMinting(reasonCode)`
- `unpauseMinting()`

Use for:
- LOOP price manipulation
- mint exploit suspicion
- referral abuse

---

### H.2.5 Program Switches (Immediate)

- `pauseSupporterSale(reasonCode)`
- `pauseReferralProgram(reasonCode)`
- `disableDiscounts(reasonCode)` (optional but recommended)

Use for:
- referral farming attack
- badge discount exploitation
- presale bot attack

---

## H.3 Incident Severity Levels

Every alert must map into a severity level.

### SEV0 — Catastrophic
Examples:
- active exploit draining funds
- router hacked
- mint exploit
- admin keys compromised

Action:
- pauseAll immediately
- pauseMinting immediately
- disable affected router/token immediately

---

### SEV1 — High Risk
Examples:
- peg deviation spike BTCB/SOL/XRP
- oracle malfunction
- slippage spike due to MEV
- repeated guardrail bypass attempts

Action:
- pause token(s) or router
- keep claims enabled
- investigate
- consider force unwind

---

### SEV2 — Degraded
Examples:
- oracle staleness
- keepers failing
- execution costs high

Action:
- allow system to idle
- no emergency action unless persistent

---

### SEV3 — Cosmetic / UI
Examples:
- UI outage
- indexer lag

Action:
- no on-chain action

---

## H.4 Emergency Pause Procedure (Step-by-Step)

This is the exact playbook.

### H.4.1 Detection Triggers

Any of these triggers a SEV0/SEV1 response:

- netProfit calculations abnormal
- swaps executing with unexpected output
- minOut protection failing
- LOOP mint amount exceeds expected caps
- token depeg beyond threshold
- unexplained reserve drain
- router calls to non-allowlisted addresses
- repeated revert patterns suggesting exploit attempt

---

### H.4.2 Immediate Actions (0–2 minutes)

1) **pauseAll("SEV0_EXPLOIT")**
2) **pauseMinting("SEV0_EXPLOIT")**
3) **pauseRouter(suspectRouter)**
4) **pauseToken(suspectToken)**

Mandatory:
- emit all pause events
- post incident message to public channels immediately

---

### H.4.3 Containment Actions (2–30 minutes)

- confirm exploit scope
- confirm whether funds moved
- snapshot state:
  - reserve balances
  - vault balances sample set
  - total claimable outstanding
  - last executed plans

- disable any additional vectors:
  - secondary routers
  - secondary tokens

---

### H.4.4 Recovery Actions (Hours–Days)

- patch fix
- test on fork
- announce patch plan + timelock schedule
- deploy upgrade via timelock
- re-enable:
  - unpause minting (only after verified)
  - unpause routers/tokens

---

## H.5 Communication Procedure (Non-Negotiable)

### H.5.1 What You Say Publicly
- what happened (even if incomplete)
- what’s paused
- whether claims are enabled
- what users should do (usually: nothing)
- timeline for updates

### H.5.2 What You Never Say
- “funds are 100% safe” (unless proven)
- “it’s fine” with no data
- speculative blame

---

## H.6 Unpause Procedure (Controlled Restart)

Unpausing must be more conservative than pausing.

### H.6.1 Preconditions to Unpause

All must be true:

- exploit vector eliminated
- patched code deployed (if needed)
- fork tests passed
- on-chain config verified
- mint caps verified

---

### H.6.2 Controlled Unpause Order

1) unpause global execution BUT keep risky assets disabled
2) unpause 1 router only (primary)
3) run limited execution with strict caps:
   - max trades/hr temporarily reduced
   - higher minProfit threshold
   - lower maxSlippage
4) monitor for 1–6 hours
5) gradually restore normal bounds
6) enable remaining routers/tokens

---

## H.7 Upgrade Procedure (Timelock Discipline)

Upgrades are where rugs happen.

YieldLoop upgrades must be predictable and slow.

### H.7.1 Upgrade Must Always Be Timelocked

Every upgrade includes:

- queued upgrade transaction hash
- queued timestamp
- ETA execution timestamp

Must be public.

---

### H.7.2 Upgrade Checklist (Before Queue)

- patch merged
- unit tests pass
- invariants pass
- fork tests pass
- simulated upgrade on fork confirms storage preserved
- migration steps written

---

### H.7.3 Upgrade Execution Checklist

Before executing the upgrade:

1) pauseAll("UPGRADE_EXECUTION")
2) confirm storage slot plan (if proxy)
3) execute upgrade
4) run post-upgrade checks:
   - vault creation works
   - accept/decline works
   - claim works
   - guardrails reject unsafe trades
   - fee computed correctly
5) unpause gradually (controlled restart)

---

## H.8 Storage Compatibility Rules

If upgradeable contracts are used:

- never reorder storage variables
- only append
- never change type sizes in-place

Post-upgrade must prove:

- principal preserved
- claimable preserved
- compound preserved
- inventory preserved
- configHash preserved
- acceptance timestamp preserved

---

## H.9 Emergency Force Unwind Playbook

Force unwind is dangerous.
But necessary for peg/DEX catastrophe.

### H.9.1 When Force Unwind Is Allowed
- peg deviation sustained above threshold
- DEX exploit threatens vault inventory
- oracle malfunction makes valuation unsafe

### H.9.2 How Force Unwind Works (Safe Version)
- unwind only in bounded chunks
- strict slippage caps
- only unwind into USDT
- never route to external addresses

### H.9.3 After Unwind
- vault goes PAUSED
- user notified through UI events
- user can:
  - claim rewards
  - exit principal (if supported)
  - wait

---

## H.10 Referral / Discount Attack Response

If referral farming is detected:

1) pauseReferralProgram("REFERRAL_ABUSE")
2) disable new referrals
3) do NOT revoke earned rewards without explicit policy
4) tighten qualification conditions:
   - continuous participation requirement
   - stricter caps
   - badge warmups
5) restore program slowly

---

## H.11 “Do Not Rug” Commitments (Operational)

Operational commitments that must be provable:

- pause blocks execution, not claims
- timelock required for upgrades
- no admin withdrawal of principal
- all config changes are public
- all allowlist changes are public

If these fail, YieldLoop is not credible.

---

## H.12 Post-Mortem Requirements (After Any SEV0/SEV1)

Publish:

- incident summary
- timeline
- what failed (root cause)
- what was paused
- what funds affected (if any)
- fixes applied
- prevention changes

This is how you become real.

---

## H.13 Hard Rule

If you try to operate YieldLoop without this playbook:

- you will freeze under pressure
- you will make bad decisions
- your community will assume rug
- you will lose credibility forever

This appendix prevents that.

---

# Appendix I — Supporter + Referral Abuse Scenarios (And How to Prevent Them)

This appendix defines the **real-world attack surface** of:

- Supporter Presale
- SupporterBadge discount marker
- Referral program qualification + rewards

If these are not hardened, you will be farmed.

This is not theoretical.
Referral systems are one of the easiest places to lose control of token economics and marketing budgets.

---

## I.1 Core Principles (Non-Negotiable)

1) **No instant referral rewards**
2) **No reward without time-in-system qualification**
3) **No unlimited referral payouts**
4) **No referral reward without funding source limits**
5) **No discount privilege that can be instantly traded or sold**
6) **No program that can be drained by sybil wallets**

---

## I.2 Supporter Presale Abuse Scenarios

### I.2.1 Bot Wallet Swarm Buys All 5000 Slots

**Attack**
- attacker scripts 5000 wallets
- buys all supporter slots immediately
- captures all future discounts, Discord access, and referral privilege
- uses it to farm referral bonuses

**Impact**
- kills community trust
- kills organic adoption
- creates “protocol captured by sybil farms”

**Mitigations**
- allowlist early phase (optional)
- rate limit purchases per block
- randomized sale start or cooldown
- require wallet to have:
  - age threshold (e.g., wallet created before X date) OR
  - minimum on-chain activity OR
  - minimum BNB balance history
- enforce 1 per wallet (already)
- optional “anti-bot signature gate” (not KYC)

---

### I.2.2 SupporterBadge Transfer Farming

**Attack**
- supporter buys badge
- sells/transfers badge
- buyer gets lifetime discount + referral privilege
- attacker repeats

**Impact**
- discount becomes tradable commodity
- protocol loses fee revenue
- referral system turns into a black market

**Mitigations (pick one)**
Option A (recommended): **Discount bound to badge ownership + warmup**
- badge must be held for `X days` before discount activates
- on transfer: discount resets and requires warmup again

Option B: **Non-transferable badge (soulbound)**
- simplest security
- but less “marketable”

Option C: **Transferable but discount bound to original supporter wallet**
- badge transferable as collectible
- discount/discord/referral privilege stays on minter wallet only

**Best recommendation**
- SupporterBadge transferable as a collectible
- BUT the discount is bound to the original wallet OR requires a hold warmup after transfer

---

### I.2.3 Presale Contract Drained by Wrong Split Logic

**Attack**
- bad split math
- integer rounding errors
- dev receiver called incorrectly
- attacker exploits reentrancy or callback

**Impact**
- funds lost at the seed stage

**Mitigations**
- no external calls before state update
- test splits with fuzz tests
- require exact payment amount
- hardcode split bps
- emit “split receipt” events proving amounts routed

---

## I.3 Referral Abuse Scenarios

### I.3.1 Self-Referral (Same Human)

**Attack**
- user creates 2 wallets
- wallet A is supporter/referrer
- wallet B deposits min 300 USDT and “stays”
- both paid 25 LOOP each

**Impact**
- referral rewards become “pay yourself for using the protocol”

**Mitigations**
- allow it (some protocols accept this)
- OR restrict:
  - referred wallet must not share funding wallet patterns
  - referred wallet must have 2+ unique inflow sources
  - referred wallet must pass “anti-sybil scoring” (light)
- enforce strict caps so it’s not profitable to mass sybil it

**My blunt recommendation**
Don’t pretend you can stop it fully.
Instead: cap it so it can’t scale.

---

### I.3.2 Sybil Farm (1000 Wallets)

**Attack**
- attacker creates 1000 referred wallets
- rotates funds
- keeps each wallet at minimum deposit
- waits 180 days
- drains referral budget

**Impact**
- destroys marketing budget
- mints/dumps LOOP or drains treasury

**Mitigations**
1) **Hard caps**
   - max referral rewards per referrer per month
   - max referral rewards per referred wallet lifetime
   - max total referral budget per month global

2) **Qualification stricter than “deposit exists”**
   Qualification should require:
   - minimum “time-in-vault” (180 days)
   - minimum number of profit events (not just holding)
   - minimum cumulative fees paid (means actually used protocol)
   - no early exit
   - no long idle withdrawal cycles designed to qualify without risk

3) **Proof-of-activity**
   - vault must have N successful executions
   - or must have at least X realized profit activity
   - or must have at least Y USDT in cumulative volume rotated

This is a big deal.
If it’s “just deposit and wait,” sybil farms will win.

---

### I.3.3 Referral Link Hijack

**Attack**
- malicious UI or attacker convinces user to enter their referral code
- user intended to use someone else’s code

**Impact**
- social dispute, lost trust

**Mitigations**
- referrer binding is irreversible
- must show referrer wallet in UI before confirming
- user must click: “Confirm Referrer”

---

### I.3.4 Code Guessing / Collision

**Attack**
- referral codes are short/guessable
- attacker brute forces codes and steals referrals

**Mitigations**
- referral codes must be hashed and random
- codes should be:
  - at least 10–16 bytes of entropy
  - not sequential
  - not human guessable

---

### I.3.5 “Deposit, Qualify, Withdraw Instantly” Exploit

**Attack**
- referred wallet deposits min 300 USDT
- stays 180 days but avoids risk
- claims referral reward then withdraws immediately

**Impact**
- referrals become “free airdrop for idle capital”
- not aligned with actual protocol usage

**Mitigations**
Require that qualification includes:
- continuous ACTIVE participation (vault must remain ACTIVE)
- no exit requested during window
- minimum amount of realized profit events OR fee generation
- optional: minimum average vault value

---

### I.3.6 Referral Reward Dump (Price Crash)

**Attack**
- referral rewards mint LOOP
- recipients dump LOOP instantly
- LOOP price collapses
- discount model implodes

**Mitigations**
Option A: pay referral bonus as USDT claimable  
Option B: pay LOOP but:
- vest it linearly over 30–90 days
- or lock it inside vault as compound-only
- or pay half USDT / half LOOP
- or enforce min market-buy (not mint) so it’s demand-driven

**My recommendation**
Referral bonus should be:
- paid from marketing budget
- delivered in LOOP only if market-bought (not minted)
- and if not possible, fallback to USDT claimable

---

## I.4 Best Referral Program Definition (Safe Version)

### Eligibility Rules

**Referrer**
- must hold SupporterBadge
- must have supporter wallet in good standing
- must not be blacklisted

**Referred**
- must deposit min system deposit (300 USDT)
- must accept strategy (ACTIVE)
- must remain active for 180 consecutive days
- must not exit/unwind during window
- must generate at least:
  - N successful executions OR
  - minimum fees paid threshold

### Payout Rules

After qualification:
- referrer gets **25 LOOP**
- referred gets **25 LOOP**
- credited into ClaimLedger

Caps:
- per referrer:
  - max 25 LOOP * 5 referrals per month (example)
- global:
  - max marketing budget outflow per month

(Exact numbers are governance configurable. Must be bounded.)

---

## I.5 Abuse Detection Signals (Off-Chain Monitoring)

These should trigger investigation/pause:

- many wallets created same week qualifying together
- many referred wallets funded from same source
- referred wallets that do not trade at all
- massive clusters with identical behavior
- repeated claim followed by immediate exit

---

## I.6 Blacklist Policy (Must Exist)

YieldLoop must have a blacklisting system for program abuse.

Blacklist must be:
- only for program eligibility (discount/referral)
- NOT used to seize funds
- publicly event logged

Blacklist should trigger:
- referral eligibility disabled
- discount eligibility disabled
- no change to claim/principal rights

---

## I.7 Program Pause Policy

If referral abuse spikes:

- pauseReferralProgram immediately
- keep vault trading active
- keep claims active
- announce clearly

This prevents budget drain without hurting normal users.

---

## I.8 Final Reality Check

If you don’t include this appendix in your build process:

- your referral system will be farmed
- your discount model will be abused
- your marketing budget will be drained
- and your community will turn hostile

This appendix prevents that.

