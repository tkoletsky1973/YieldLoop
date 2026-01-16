# YieldLoop  
## Continuous Arbitrage Vaults + LOOP Redemption Token  
### (Developer Specification + Plain-English Protocol Paper)

**Version:** 0.8.0 (Rewrite Draft)  
**Date:** January 16, 2026  
**Author:** Todd Koletsky  

---

## Document Metadata

- **Document Type:** Whitepaper + Developer Specification  
- **Status:** Draft (Build-Ready Spec Target)  
- **Chain:** BNB Chain (BSC)  
- **Deposit Asset:** USDT (only)  
- **Minimum Deposit:** 300 USDT  
- **Strategy Type:** Band/Grid Rotation (multi-asset spread balancing)  
- **Trading Assets (Allowlisted):**
  - BTCB
  - SOL (Binance-Peg)
  - XRP (Binance-Peg)
  - BNB (optional / policy-defined)
- **DEX Venues:** PancakeSwap + BiSwap (config allowlist only)  
- **Reward Assets:** USDT or LOOP  
- **Fees:**
  - 20.0% performance fee on realized profits (USDT reward path)
  - 17.5% performance fee on realized profits (LOOP reward path)
  - Discounts stack (Supporter + other discounts)

---

## Table of Contents

1. Executive Summary
2. What YieldLoop Is (Plain English)
3. Non-Negotiable Invariants (Truth Rules)
4. User Experience (Deposit → Strategy Preview → Accept/Decline → Execution)
5. Vault Model (Per-Deposit Vaults, Accounting, Balances)
6. Strategy Engine (Band/Grid Rotation Across Allowlisted Assets)
7. Opportunity Validation + Profit Definition (Realized Only, Net of Costs)
8. Guardrails + Safety System (What Can Go Wrong and How It Stops)
9. Execution System (Keepers Propose, Contract Decides)
10. Fees, Discounts, and Fee Routing
11. Profit Buffer + Claim System (Claim Anytime)
12. Compounding Rules (0–100% User Controlled)
13. LOOP Token (Redemption Token, Not Governance)
14. LOOP Minting Rules (Profit-Backed Issuance)
15. LOOP Reserve / Floor System (Reserve-Limited Redemption)
16. Supporter Presale Program (First 5,000 Wallets)
17. SupporterBadge NFT (Discount + Discord Access + On-Chain Verification)
18. Referral Program (180-Day Qualification + $25 LOOP Bonus)
19. Anti-Abuse Controls (Sybil, Farming, Transfer Flip Prevention)
20. Admin Controls + Timelock + Emergency Pause
21. Security Model (MEV, Oracle Sanity, DEX Risks, Keeper Failure)
22. Risks + Disclosures (No Guarantees, No Insurance, No Fake Yield)
23. Glossary
24. Appendices (Interfaces, Events, State Machine, Config Ranges)

---

# 1. Executive Summary

YieldLoop is a non-custodial DeFi protocol on BNB Chain that allows users to deposit USDT into an isolated vault and participate in an automated trading strategy designed to generate **realized profit** through conservative band/grid rotation across a small allowlisted set of liquid assets.

YieldLoop is built around one rule that cannot be violated:

> **No profit is counted unless it is realized in USDT after fees, gas, and execution costs.**

YieldLoop does **not** promise returns, does **not** mint yield out of thin air, and does **not** use hidden leverage. The system can only pay users from actually realized trading profit. If the system cannot safely trade, it does not trade.

The default strategy is conservative and restricted to a limited allowlist of high-liquidity tokens:

- BTCB (Binance-Peg Bitcoin)
- SOL (Binance-Peg Solana)
- XRP (Binance-Peg XRP)

The system operates continuously (not monthly). It may execute many small profit events per day or none at all depending on market conditions and guardrail constraints.

Users maintain control over rewards via a compounding selector (0% to 100%). Realized profits are held in a Profit Buffer contract and can be claimed at any time by the user (subject to protocol rules).

YieldLoop charges a performance fee only on realized profit:

- **20.0%** when rewards are taken in **USDT**
- **17.5%** when rewards are taken in **LOOP** (a 2.5% discount)

Discounts may stack (including Supporter program discounts).


# 2. What YieldLoop Is (Plain English)

YieldLoop is a “profit vault” system.

You deposit USDT into your own isolated on-chain vault.
The protocol trades an automated strategy using that vault, trying to generate small, repeatable gains.
When profit is realized, it is stored and held for you.
You can claim it whenever you want.
Or you can automatically compound some or all of it.

In normal human terms, YieldLoop does this:

1) You deposit at least 300 USDT  
2) You are shown the strategy settings and safety rules  
3) You explicitly approve (“accept”) the strategy (or you decline and exit)  
4) If approved, your vault begins executing trades when safe  
5) Any realized profit is stored in a profit buffer  
6) Your compounding setting controls what portion is reinvested vs claimable  
7) You may claim profits at any time (subject to the vault balance and settlement rules)

YieldLoop is not:
- a meme token
- a ponzi
- a lending protocol
- a guaranteed yield product
- a protocol that pretends “paper profits” are real

It is a **deterministic accounting system + execution engine** that:
- only counts real realized profit,
- only charges fees on real realized profit,
- and only pays users from real realized profit.

If there is no profitable and safe opportunity, YieldLoop does nothing and waits.

The system is designed to be buildable, auditable, and explainable:
- All vault balances are on-chain
- All profits are computed using explicit rules
- All “user owed” amounts are tracked and claimable
- Every action emits events for auditability


# 3. Non-Negotiable Invariants (Truth Rules)

This section defines the protocol “laws.”  
If any of these are violated, the protocol becomes untrustworthy.

## 3.1 Real Profit Only (No Fake Yield)
YieldLoop only treats a profit as “real” when:

- a trade cycle is completed, and
- the vault holds more USDT than before the trade cycle, and
- the increase remains after subtracting:
  - DEX trading fees
  - slippage costs
  - gas costs
  - keeper/execution costs
  - any required swap costs
  - any protocol-defined overhead

If the system cannot prove that profit is real, it is not counted.

## 3.2 Performance Fees Only Apply to Realized Profits
The protocol may only charge its performance fee when realized profit exists.

Fees may not be charged on:
- deposits
- unrealized mark-to-market gains
- price appreciation of held assets
- unrealized inventory changes
- any accounting trick

## 3.3 All Rewards Are Accounted For and Segregated
User rewards are never mixed into ambiguous “shared pool” accounting.

All realized profit must be routed to one of:

- user claimable balance
- user compound balance (if selected)
- protocol fee receiver balances

The user must be able to independently verify:
- what was earned
- what was taken as fees
- what remains claimable
- what was compounded

## 3.4 Isolated Vault Accounting (Per-Deposit Isolation)
Each deposit creates (or joins, depending on design) an isolated vault accounting context.

The vault accounting model must ensure:

- no one user can dilute another user’s balances
- no global pool can cause a “bank run”
- each vault’s PnL is attributable and provable

This is mandatory for auditability and for preventing systemic accounting fraud.

## 3.5 Conservative Execution Preference
When faced with uncertainty, YieldLoop must choose:

- safety over profit
- stopping over continuing
- rejecting execution over guessing

This is a protocol design rule, not a “feature.”

## 3.6 Allowlist Only (No Surprise Tokens)
YieldLoop may only trade assets that are explicitly allowlisted by governance/admin configuration.

At minimum, the allowlist includes:

- BTCB
- SOL (Binance-Peg)
- XRP (Binance-Peg)

The allowlist system must include:
- token address locking
- decimals verification
- router verification
- max slippage bounds
- liquidity minimum thresholds

## 3.7 Strategy Must Be Shown Before Commitment (Accept / Decline Checkpoint)
Before a user’s deposit starts execution, the user must be shown:

- which tokens can be traded
- which DEX venues are used
- the main strategy parameters
- the key guardrails and stop conditions
- fee terms (20% or 17.5% if LOOP rewards)
- any discounts applied
- risk disclosures

The user must then explicitly approve.

This checkpoint exists for:
- informed consent
- risk disclosure
- Howey/lawyer review friendliness
- user control

## 3.8 No Hidden Leverage
The protocol must not:
- borrow funds
- use margin
- use perps
- use lending collateral loops
- rehypothecate user principal
- perform under-collateralized operations

The default system is spot-only, vault-balance-only execution.

## 3.9 Pause and Kill Switch Are Mandatory
The protocol must include emergency controls:

- global pause
- vault-level pause
- per-token disable switch
- per-DEX disable switch

When paused, the system must default to:
- no new executions
- no new risk exposure
- no new positions

## 3.10 User Controls Rewards (Compound Rate 0–100%)
The user chooses how much of realized profit is compounded.

- 0% compound means all realized profit becomes claimable
- 100% compound means all realized profit is reinvested
- any percentage in between is valid

This must be enforced on-chain by deterministic logic.


# 4. User Experience (Deposit → Strategy Preview → Accept/Decline → Execution)

This section defines the end-to-end protocol flow from the user’s perspective, while staying precise enough for developers to implement.

## 4.1 Core UX Goal
YieldLoop should feel simple:

- deposit USDT
- see what will happen
- approve it
- let it run
- claim whenever

But under the hood it must remain:
- deterministic
- auditable
- safe

## 4.2 Step 1 — Connect Wallet
User connects their wallet (BNB Chain).

The UI must display:
- current chain
- USDT token address used by protocol
- minimum deposit amount (300 USDT)
- current strategy allowlist tokens
- current DEX venues enabled

## 4.3 Step 2 — Select Deposit Amount and Vault Settings
User selects:

- deposit amount (>= 300 USDT)
- reward mode:
  - USDT rewards (20.0% perf fee)
  - LOOP rewards (17.5% perf fee)
- compounding rate:
  - 0% to 100%
- optional advanced:
  - execution aggressiveness setting (conservative default)
  - maximum band width bounds (if allowed)
  - additional safety strictness tier (if allowed)

All optional advanced fields must:
- default to safe values
- be bounded by protocol config
- be ignored if unsafe

## 4.4 Step 3 — Strategy Preview Screen (Mandatory)
Before funds begin execution, the UI must display a strategy preview.

This is not marketing. This is a disclosure panel.

It must show:

### A) What the system will trade
- BTCB / SOL / XRP rotations (allowlist)
- venues (PCS/BiSwap as configured)
- execution method (band/grid rotation)

### B) What “profit” means
- realized USDT increase only
- net of gas + DEX fees + slippage + execution costs

### C) What can stop trading
A clear list of guardrails, including at minimum:

- insufficient liquidity
- slippage too high
- oracle sanity fail / TWAP fail
- price deviation threshold exceeded
- gas too high or execution cost too high
- MEV risk threshold exceeded
- DEX router disabled
- token disabled
- system paused / emergency mode
- max drawdown hit (if configured)

### D) Fees and discounts
Show the exact fee rate after discounts:

- base fee: 20.0% profit fee
- LOOP reward fee: 17.5% profit fee
- supporter discount: +1% additional discount
- any other discounts
- final computed rate

This must include:
- the fee receiver addresses (or labels)
- the routing splits (if shown)

### E) User controls
- can change compound % anytime
- can claim profits anytime
- cannot force unsafe execution
- protocol is not responsible for losses

### F) Risk disclosures
- execution risk
- token peg risk (Binance-Peg)
- DEX exploit risk
- oracle risk
- smart contract risk
- no insurance

## 4.5 Step 4 — Accept / Decline Checkpoint
User must take an explicit action:

- **Accept Strategy**
- **Decline (Do Not Execute)**

This action must be stored on-chain in the vault config.

If declined:
- the vault must not execute trades
- the user may withdraw principal (subject to protocol rules)

If accepted:
- vault enters ACTIVE mode
- keepers may begin proposing executions

## 4.6 Step 5 — Execution Begins (Continuous Cycle)
When active, the system runs continuously:

- keepers scan for opportunities
- opportunities are proposed via transactions
- vault validates safety and profit expectations
- vault executes only if pass conditions are met

Execution is event-driven, not time-driven.

There may be:
- multiple micro-profit cycles per day
- long idle periods if unsafe/unprofitable

## 4.7 Step 6 — Profit Handling (Buffer + Compound Split)
When a profit event is realized:

- realized profit is routed to a Profit Buffer
- performance fee is computed and routed
- remaining profit is split based on compound %:
  - compound portion stays for reinvestment
  - claim portion becomes claimable balance

All values must be available in UI:
- realized profit
- fees
- compounded
- claimable

## 4.8 Step 7 — Claim Anytime
User may claim profits at any time.

Claim function must:
- transfer claimable USDT (or LOOP if chosen)
- emit events
- not affect principal accounting
- not require monthly cycle boundaries

If claimable is zero, claim does nothing.

## 4.9 Step 8 — Withdraw / Exit
Exit rules are a protocol policy decision.

However, regardless of exit implementation, the protocol must:
- accurately track what is principal vs what is profit
- never allow a withdrawal that breaks accounting solvency
- maintain invariant that fees only apply to realized profits

---

# 5. Vault Model (Per-Deposit Vaults, Accounting, Balances)

This section defines the core accounting model. If a developer gets this right, the protocol works. If they get this wrong, the protocol becomes a scam by accident.

YieldLoop uses an **isolated vault model**. Each deposit creates a dedicated accounting context and execution container. Even if strategies are shared, accounting is not.

## 5.1 Definitions

**Vault**  
A vault is a smart contract (or a structured set of contract storage) representing one user deposit position.

**Principal**  
The user’s deposited USDT amount that is treated as the “base capital.”

**Inventory**  
Non-USDT assets temporarily held during execution (BTCB, SOL, XRP).

**Profit Buffer**  
A compartment/bucket where realized profits are held and tracked before being claimed or compounded.

**Claimable Balance**  
Realized profit allocated to the user for withdrawal at any time.

**Compound Balance**  
Realized profit allocated for reinvestment by the vault.

**Execution Cost Wallet (ECW)**  
A protocol-controlled funded balance used to pay keeper gas/execution costs and prevent execution halts.

## 5.2 Vault Creation Model

On first deposit, YieldLoop must create an isolated vault position.

Two acceptable implementations:

### Option A — VaultFactory deploys a new vault contract
- VaultFactory deploys a new UserVault contract for each deposit
- Advantages:
  - strongest isolation
  - easiest audit trail
- Disadvantages:
  - more gas cost
  - more contracts

### Option B — VaultFactory creates a vault ID in a single VaultManager contract
- VaultManager holds all vault state in a mapping keyed by vaultId
- vaultId maps to:
  - owner
  - balances
  - settings
  - state
- Advantages:
  - cheaper
  - scalable
- Disadvantages:
  - isolation must be perfect in storage logic

YieldLoop may use either approach. The invariants are identical.

## 5.3 Vault State Machine (High-Level)

Each vault must have a state.

Minimum states:

- **CREATED**  
  Vault exists, deposit accepted, but no strategy accepted yet.

- **PENDING_ACCEPTANCE**  
  Strategy preview ready, user must accept/decline.

- **ACTIVE**  
  Strategy accepted. Execution allowed (subject to guardrails).

- **PAUSED**  
  Vault paused by admin or safety engine; no execution allowed.

- **EXITING / SETTLEMENT_REQUIRED**  
  Vault is unwinding inventory back to USDT to support withdrawals or safety.

- **CLOSED**  
  Vault position is closed; no further execution.

Transitions must be event-driven and must emit logs.

## 5.4 Vault Storage Variables (Required)

Each vault must track:

### Ownership
- vaultOwner (address)

### Configuration
- rewardMode: USDT or LOOP
- compoundRateBps (0–10000)
- strategyConfigHash (config version)
- acceptedStrategy (bool)
- acceptedAtTimestamp

### Accounting
- principalUSDT
- realizedProfitUSDT (cumulative)
- claimableUSDT
- compoundUSDT

### Inventory
- inventoryBTCB
- inventorySOL
- inventoryXRP

### Risk
- lastExecutionTimestamp
- lastProfitTimestamp
- drawdownTracking (if used)
- safetyFlags (oracle fail, MEV risk, etc.)

### Governance Locks
- configVersionHash
- vaultCodeVersion
- allowedRouters snapshot (optional)
- allowedTokens snapshot (optional)

## 5.5 Separation of Principal vs Profit (Mandatory)

The vault must never mix principal accounting with profit accounting.

Rules:

- Principal is tracked separately from profit.
- Profit is tracked separately from claimable.
- Claimable is tracked separately from compounded.

At minimum:

- principalUSDT is not reduced by claiming profits
- claiming profits does not touch principalUSDT
- performance fees are never deducted from principalUSDT

This avoids the #1 failure mode of DeFi “yield vault” accounting: fake yields that are actually returning principal.

## 5.6 Vault Balance Views (Developer Requirements)

The system must provide view functions for UI + audit:

- getVaultState(vaultId)
- getPrincipal(vaultId)
- getInventory(vaultId) → BTCB/SOL/XRP amounts
- getClaimable(vaultId)
- getCompoundBalance(vaultId)
- getTotalRealizedProfit(vaultId)
- getFeesPaid(vaultId)
- getStrategyConfig(vaultId)

All of these must be deterministic and on-chain.

## 5.7 Master Vault vs Sub-Vaults (Policy)

The protocol can represent user deposits as:

- a single vault per deposit (recommended)
- or a parent “master” vault with internal sub-allocations

However, YieldLoop does NOT require sub-vault complexity, because the strategy itself is already multi-asset.

Recommendation:

- Use 1 vault per deposit.
- Inside that vault:
  - maintain inventory buckets per token
  - maintain accounting buckets per category

This keeps UX simple and avoids unnecessary “vault within vault” attack surface.

## 5.8 Withdrawal Rights vs Execution Rights

User rights:
- claim rewards anytime
- adjust compounding setting anytime
- pause their own vault (optional but recommended)
- request exit (withdraw principal) subject to unwind rules

Protocol rights:
- refuse execution if unsafe
- pause vault globally or locally
- force unwind in emergency

No one (including admin) is allowed to:
- transfer user principal out of vault except through defined exits
- change a vault’s reward mode without user consent
- change the vault’s strategy config after acceptance without forcing re-acceptance

## 5.9 Vault Events (Required Logs)

Every vault must emit events on:

- VaultCreated(vaultId, owner, amount)
- StrategyPreviewed(vaultId, configHash)
- StrategyAccepted(vaultId)
- StrategyDeclined(vaultId)
- ExecutionAttempted(vaultId, keeper)
- ExecutionRejected(vaultId, reasonCode)
- ExecutionCompleted(vaultId, profitUSDT, feesUSDT)
- ProfitBuffered(vaultId, amount)
- Claimed(vaultId, amount, asset)
- CompoundApplied(vaultId, amount)
- VaultPaused(vaultId, reason)
- VaultUnpaused(vaultId)
- ExitRequested(vaultId)
- VaultClosed(vaultId)

Event logs are mandatory for auditability and dispute resolution.


# 6. Strategy Engine (Band/Grid Rotation Across Allowlisted Assets)

This section defines what YieldLoop actually does to generate profit.

The strategy is a **conservative, allowlisted, band/grid rotation system**:

- It holds a basket of assets (BTCB/SOL/XRP)
- It monitors the relative spread between them
- When spreads widen beyond configured bands, it rotates allocation
- When spreads mean-revert, it rotates back
- It captures repeated micro-profits (when available)

This is not leverage.
This is not gambling on a single direction.
This is a controlled rebalancing profit system.

## 6.1 Allowlisted Assets Only

The strategy engine must only trade assets that are allowlisted.

Default allowlist:
- BTCB
- SOL (Binance-Peg)
- XRP (Binance-Peg)

All token addresses must be hardcoded by config and validated at runtime.

## 6.2 DEX Venues

Trades occur only on DEX venues enabled by config.

Default venues:
- PancakeSwap
- BiSwap

The strategy engine must support:
- per-DEX enable/disable
- per-router allowlist
- per-token DEX restrictions (optional but recommended)

## 6.3 Strategy Objective

Objective: capture conservative profits from volatility by rotating between three correlated but not perfectly synchronized assets.

Key principle:
- volatility creates spread
- spread creates rebalancing opportunity
- rebalancing can capture realized gains if executed safely

## 6.4 Spread Model (User-Facing)

For the user, YieldLoop must explain it like this:

- You deposit 300 USDT
- The system splits it across BTCB/SOL/XRP exposure
- The system tries to keep the portfolio balanced
- When one runs ahead, it trims it
- When one lags, it accumulates it
- The rebalancing difference becomes realized profit (when sold back into USDT)

The user is shown the parameter set before they accept.

## 6.5 Band/Grid Parameters (Configurable)

The strategy must have bounded parameters:

- gridStepBps (e.g. 25–250 bps)
- maxRotationPerTrade (limit exposure change per execution)
- maxTradesPerHour (rate limit)
- maxSlippageBps
- minLiquidityUSD per pool
- minProfitUSDT per execution
- minNetProfitUSDT after gas
- inventoryCapPerAsset (avoid overconcentration)
- portfolioRebalanceTargetWeights

All parameters must be bounded by governance.

No unbounded parameters.

## 6.6 Execution Cycle (High Level)

Each execution attempt follows:

1) Gather price references
   - DEX spot
   - oracle/TWAP if used
   - internal last execution pricing

2) Compute spread state
   - determine which asset is overweight/underweight
   - determine if threshold crossed

3) Simulate execution
   - compute expected slippage
   - compute expected DEX fees
   - compute expected gas cost
   - compute expected net profit

4) Guardrail checks
   - oracle sanity
   - liquidity sanity
   - slippage bound
   - MEV risk bound
   - net profit threshold

5) Execute swaps
   - strictly limited trade size
   - route via allowlisted router

6) Verify results
   - did vault USDT increase net of costs?
   - if not, treat as non-profit and record failure reason

7) Allocate profit
   - route to Profit Buffer
   - compute fee
   - apply compounding split

## 6.7 No Forced Trading

The engine must not trade just to trade.

If conditions are not met:
- do nothing
- log rejection reason

This is not optional.

## 6.8 Strategy Acceptance Lock

When the user accepts the strategy config hash:
- the vault stores configHash
- keepers must execute only against that configHash
- any config upgrades require:
  - forcing vault back to PENDING_ACCEPTANCE
  - user re-acceptance

This prevents “bait and switch.”

## 6.9 Conservative Defaults (Recommended)

At launch, defaults should be conservative:

- larger spread thresholds
- strict slippage limits
- strict liquidity requirements
- strict oracle sanity checks
- strict net profit minimums

The goal is:
- survive every day
- never blow up
- build trust
- scale later


# 7. Opportunity Validation + Profit Definition (Realized Only, Net of Costs)

YieldLoop lives or dies on how it defines profit.

A developer must treat this section as protocol law.

## 7.1 Definitions

**Gross Profit**  
Difference in USDT balance before and after a completed trade cycle, ignoring costs.

**Net Profit**  
Gross profit minus:
- DEX fees
- slippage impact (realized through execution)
- gas/execution cost
- any protocol-defined overhead

Only Net Profit is valid profit.

## 7.2 Realized Profit Only (Mark-to-Market Forbidden)

YieldLoop must never count profit using mark-to-market.

Forbidden profit methods:
- “the BTCB we hold is worth more than yesterday”
- “portfolio NAV went up”
- “oracle price says we’re up”
- “unrealized gain”

Only allowed:
- net increase in USDT held by the vault after execution completes

## 7.3 Minimum Profit Threshold

Each execution must satisfy:

- expectedNetProfitUSDT >= minNetProfitUSDT
- and realizedNetProfitUSDT >= 0

If realizedNetProfitUSDT < minNetProfitUSDT:
- treat as non-profit
- record as strategy miss
- optionally update adaptive thresholds

## 7.4 Gas/Execution Cost Accounting

Execution costs must be computed using one of:

- ECW-funded keeper system (recommended)
- reimbursement model
- direct vault deduction (discouraged)

Recommended:
- execution costs are paid from ECW
- ECW is funded by defined program rules (see presale + allocation model)
- the vault is never unexpectedly drained for gas

Regardless of implementation, net profit must include execution cost effects.

## 7.5 Profit Settlement Event

When a profit event occurs:

- realizedNetProfitUSDT is computed
- performance fee is computed
- user remainder is split into:
  - claimable
  - compound (based on compoundRateBps)

All operations must be atomic or revert.

## 7.6 Profit Buffer

All profit events must route through Profit Buffer accounting.

Reason:
- prevents double counting
- makes claiming deterministic
- separates execution from claiming

Profit Buffer is the “truth ledger” of what exists.

## 7.7 Fee Calculation Timing

Performance fee must be computed:

- after net profit validation
- only on net profit
- never on principal
- never before the profit exists

If net profit is zero:
- fee is zero

## 7.8 Reward Asset Choice (USDT vs LOOP)

If user selects USDT reward mode:
- fee = 20.0% of net profit
- remainder in USDT

If user selects LOOP reward mode:
- fee = 17.5% of net profit
- user remainder is swapped/minted into LOOP according to LOOP rules

Reward mode must not be changed silently.
Changing reward mode requires user confirmation and emits an event.

---

# 8. Guardrails + Safety System (What Can Go Wrong and How It Stops)

YieldLoop must assume the market is hostile.

MEV is real. Oracles can fail. DEX pools can be attacked. Pegs can wobble. Gas can spike. Smart contracts can have bugs.

This section defines the minimum guardrails required for launch.

If a guardrail triggers, the system must do one of the following:

- **Reject execution** (do nothing, log why)
- **Pause** (stop trading until conditions clear or admin action)
- **Unwind** (exit inventory back to USDT)

YieldLoop must default to **safety over profit**.

---

## 8.1 Guardrail Categories

All safety controls fall into these categories:

1) **Price sanity**
2) **Liquidity sanity**
3) **Slippage sanity**
4) **Execution cost sanity**
5) **MEV / sandwich protection**
6) **Rate limiting**
7) **Portfolio exposure limits**
8) **Peg risk controls**
9) **DEX/router controls**
10) **Keeper controls**
11) **Emergency controls**

---

## 8.2 Price Sanity Guardrails

Every execution attempt must validate that prices are sane.

YieldLoop must never execute trades if the price environment looks manipulated, broken, or inconsistent.

### 8.2.1 Oracle / TWAP Sanity (Recommended)

If YieldLoop uses any oracle or TWAP source, then for each traded asset:

Required checks:

- **Oracle exists**
- **Oracle is fresh**
- **Oracle price is within configured bounds**
- **DEX spot price is within deviation threshold of oracle**

Example deviation rule:

- `abs(DEXSpotPrice - OraclePrice) / OraclePrice <= maxOracleDeviationBps`

If the deviation exceeds threshold:

- **reject execution**
- emit `ExecutionRejected(vaultId, ORACLE_DEVIATION_TOO_HIGH)`
- set safety flag `ORACLE_SANITY_FAIL = true`

Oracle freshness rule:

- `block.timestamp - oracleTimestamp <= maxOracleStalenessSeconds`

If stale:

- reject execution
- emit `ExecutionRejected(vaultId, ORACLE_STALE)`

### 8.2.2 Cross-Venue Price Sanity (PCS vs BiSwap)

If both venues are enabled, YieldLoop must optionally verify:

- PCS spot price vs BiSwap spot price
- deviation within bounds

Example:

- `abs(PCSPrice - BiSwapPrice) / min(PCSPrice, BiSwapPrice) <= maxVenueDeviationBps`

If exceeded:

- reject execution
- emit `ExecutionRejected(vaultId, VENUE_PRICE_DEVIATION)`

This catches spoofed liquidity / broken pool routing.

### 8.2.3 Sudden Price Jump Guardrail

If prices move too far too fast, trading becomes dangerous.

Rule:

- If `abs(currentPrice - lastExecutionPrice) / lastExecutionPrice > maxJumpBps` within a short window:
  - reject execution
  - optionally pause vault

This prevents “chasing” post-exploit volatility.

---

## 8.3 Liquidity Sanity Guardrails

YieldLoop must never trade into shallow pools.

Liquidity requirements must be enforced for every proposed route.

Minimum checks:

- pool reserves exceed threshold
- minLiquidityUSD per route
- minDepthUSD for the amount being traded

Example:

- `estimatedPriceImpactBps <= maxImpactBps`
- `poolLiquidityUSD >= minLiquidityUSD`

If liquidity is insufficient:

- reject execution
- emit `ExecutionRejected(vaultId, LOW_LIQUIDITY)`

---

## 8.4 Slippage Sanity Guardrails

Slippage limits are mandatory.

Every swap must enforce:

- `minOut` protection on router call
- `maxSlippageBps` bound in validation step
- cap on swap size per execution

If expected slippage exceeds bound:

- reject execution
- emit `ExecutionRejected(vaultId, SLIPPAGE_TOO_HIGH)`

No exceptions.

---

## 8.5 Execution Cost Sanity (Gas + Keeper Costs)

YieldLoop must protect users from “profitable” trades that become net negative after costs.

Rules:

- if gasPrice > ceiling → reject
- if estimatedGasCostUSDT > maxGasCostUSDT → reject
- if expectedNetProfitUSDT < minNetProfitUSDT → reject
- if expectedNetProfitUSDT < (profitToCostMultiplier * estimatedGasCostUSDT) → reject

If any fail:

- reject execution
- emit `ExecutionRejected(vaultId, EXECUTION_COST_TOO_HIGH)`

---

## 8.6 MEV / Sandwich Protection

MEV is not theoretical. Treat it as guaranteed.

Mandatory controls:

- enforce strict `minOut`
- use conservative swap sizing
- avoid large single swaps
- route optimization (avoid fragile pools)
- optional private RPC / bundle relay (recommended)

MEV detection heuristics (optional but recommended):

- quote volatility within short window
- pool manipulation signals
- repeated failed executions

If MEV risk too high:

- reject execution
- emit `ExecutionRejected(vaultId, MEV_RISK_TOO_HIGH)`

---

## 8.7 Rate Limiting Guardrails (Anti-Churn)

YieldLoop must avoid overtrading and churn.

Controls:

- maxTradesPerHour
- maxTradesPerDay
- cooldownSeconds between executions
- maxFailedAttemptsPerWindow

If limits exceeded:

- reject execution
- emit `ExecutionRejected(vaultId, RATE_LIMIT)`

---

## 8.8 Portfolio Exposure Limits

YieldLoop must prevent concentration risk.

Rules:

- maxExposureBpsPerAsset
- maxInventoryUSDPerAsset
- maxDeviationFromTargetWeights
- maxRotationPerTradeBps

If proposed execution would exceed caps:

- shrink swap size or reject
- emit `ExecutionRejected(vaultId, EXPOSURE_LIMIT)`

---

## 8.9 Drawdown / Loss Controls

Even conservative strategies can lose.

Vault must track drawdown.

Rules:

- maxDrawdownBps
- maxLossStreak
- maxInventoryHoldTimeSeconds (optional)

If drawdown exceeds threshold:

- pause vault
- emit `VaultPaused(vaultId, MAX_DRAWDOWN)`
- optionally begin unwind to USDT

---

## 8.10 Peg Risk Controls (Binance-Peg Tokens)

BTCB/SOL/XRP are pegged representations.

Peg risk is real.

Required checks:

- measure peg deviation vs reference
- if deviation exceeds threshold:
  - disable token for buying
  - optionally force unwind selling exposure

Example:

- if `pegDeviationBps > maxPegDeviationBps`:
  - reject executions that increase exposure
  - emit `ExecutionRejected(vaultId, PEG_RISK)`

---

## 8.11 DEX / Router Controls

YieldLoop must be able to instantly disable:

- a DEX venue
- a router contract
- a pool route
- a token route

If disabled:

- execution rejected
- emit `ExecutionRejected(vaultId, ROUTER_DISABLED)` or similar

This is how you survive a DEX exploit.

---

## 8.12 Keeper Controls

Keepers are not trusted.

Rules:

- keeper proposes execution
- vault validates execution
- keeper cannot withdraw funds
- keeper cannot change config

If a keeper repeatedly submits invalid attempts:

- optionally blocklist keeper
- emit alert event

---

## 8.13 Emergency Controls (Kill Switch)

Mandatory emergency controls:

- GlobalPause
- TokenPause
- DexPause
- VaultPause
- ForceUnwind (bounded)
- Timelock on upgrades

When paused:

- no new trades
- claims still allowed (preferred)
- exits allowed only when safe

YieldLoop must be designed so it can safely stop without collapsing.

---

# 9. Execution System (Keepers Propose, Contract Decides)

YieldLoop uses an execution model where automation actors (keepers) submit execution attempts, but the vault contract itself decides whether the execution is valid.

Keepers are not trusted.

The protocol works because:

- keepers can propose
- contracts validate
- execution only happens if all guardrails pass

This makes the system safe and deterministic.

---

## 9.1 Roles

### 9.1.1 User
The user:

- deposits USDT
- accepts strategy parameters
- selects compounding rate (0–100%)
- selects reward mode (USDT or LOOP)
- can claim profit at any time
- can request exit (subject to unwind rules)
- cannot force trades

### 9.1.2 Keeper (Automation Executor)
The keeper:

- monitors market conditions
- detects potential opportunities
- builds an execution plan
- calls `execute(vaultId, executionPlan)` or similar

The keeper:

- cannot withdraw user funds
- cannot change configs
- cannot bypass guardrails
- cannot force execution

### 9.1.3 Vault Contract
The vault contract:

- holds vault balances and accounting
- enforces state machine
- validates every execution attempt
- executes swaps only when safe
- computes realized net profit
- routes fees + profit
- emits audit logs

### 9.1.4 Governance / Admin
Governance/admin can:

- set allowlists and bounded parameter ranges
- pause the system
- disable tokens/DEXs/routers
- upgrade contracts via timelock

Admin cannot:

- seize user funds
- bypass invariant rules
- rewrite accepted vault configs without re-acceptance

---

## 9.2 Keeper Execution Model

Keepers must be treated as "market sensors" and execution submitters, not as decision makers.

Keepers propose:

- tokenIn, tokenOut
- amounts
- route
- minOut values
- deadline

The vault decides.

---

## 9.3 Execution Call Interface (Recommended)

Main function:

- `execute(uint256 vaultId, ExecutionPlan plan)`

Where `ExecutionPlan` includes at minimum:

- `router` (address)
- `tokenIn` (address)
- `tokenOut` (address)
- `amountIn` (uint256)
- `minOut` (uint256)
- `deadline` (uint256)
- `routeData` (bytes) (optional, router dependent)

Optional advanced:

- multi-hop route list
- multiple swaps for cycle completion
- "expected profit" hints (not trusted)

---

## 9.4 Execution Preconditions (Must Pass Before Any Swap)

Before executing any swaps, the vault must validate:

1) **Vault state**
   - vault is ACTIVE
   - not PAUSED
   - not in SETTLEMENT_REQUIRED

2) **Config lock**
   - plan is compatible with the accepted config hash
   - router is allowlisted
   - tokens are allowlisted

3) **Safety conditions**
   - price sanity
   - liquidity sanity
   - slippage sanity
   - peg sanity
   - MEV sanity
   - execution cost sanity
   - rate limit sanity
   - exposure caps

4) **Profit expectation sanity**
   - expected net profit >= threshold

If any check fails:
- reject execution
- emit rejection event with reason code
- do nothing else

---

## 9.5 Pre-Execution Simulation (Required)

The vault must simulate or approximate:

- expected out amount
- slippage impact
- DEX fee impact
- expected gas cost (or keeper reimbursement)
- expected net profit

Execution should proceed only if:

- expectedNetProfitUSDT >= minNetProfitUSDT
- expectedNetProfitUSDT >= estimatedCostUSDT * profitToCostMultiplier

---

## 9.6 Execution Atomicity Requirements

Execution must be atomic.

Rule:

- If the execution includes multiple swaps, the full sequence must complete or revert.

No partial accounting.
No partial state.

If any swap fails:
- revert tx
- state unchanged

---

## 9.7 Execution Success Rules (Post-Trade Validation)

After swaps execute, vault must verify:

- net USDT value increased (realized)
- net profit is positive after costs

If realized net profit is <= 0:
- treat as a non-profit execution
- optionally record failure
- optionally reduce aggressiveness / widen band thresholds

YieldLoop should not attempt to “force profitability” by accounting tricks.

---

## 9.8 Execution Failure Handling

Execution failures are expected.

Failures include:

- slippage changed too fast
- gas spiked mid-block
- liquidity moved
- oracle sanity deviated
- MEV interference

Failure rule:

- if failure is guardrail-detected → reject without swap
- if failure occurs mid swap → revert

Additionally:

- repeated failures must trigger cooldown
- after too many failures in window:
  - pause vault
  - emit alert event

---

## 9.9 Keeper Incentives (Implementation Policy)

Keeper economics can be implemented in one of these ways:

### Option A — ECW reimbursement (recommended)
- keeper pays gas
- protocol reimburses keeper from ECW
- reimbursement capped per execution

### Option B — keeper reward paid from protocol fee share
- keeper receives a small fraction of fee or fixed reward

### Option C — hybrid
- reimbursement + reward

Regardless:
- keeper payments are bounded
- keeper payments cannot exceed configured caps
- keeper cannot drain profit by claiming too much cost

---

## 9.10 Events (Mandatory Execution Telemetry)

Every execution attempt must emit:

- `ExecutionAttempted(vaultId, keeper)`
- `ExecutionRejected(vaultId, reasonCode)`
- `ExecutionCompleted(vaultId, profitUSDT, feeUSDT, rewardMode)`
- `ExecutionMetrics(vaultId, gasUsed, slippageBps, venueUsed)`

---

# 10. Fees, Discounts, and Fee Routing

YieldLoop is funded by performance fees on realized profit.

Fees are never applied to deposits.
Fees are never applied to principal.
Fees are never applied to unrealized gains.

---

## 10.1 Performance Fee Rates

Base fee:

- **20.0%** of realized net profit

Discounted fee:

- **17.5%** of realized net profit if reward mode is LOOP

This is a 2.5% discount for users who choose LOOP.

---

## 10.2 Discount Stack Model

Discounts may stack.

Discount sources include:

- SupporterBadge NFT: +1% additional discount
- other NFT tiers (future)
- deposit-size discounts (optional)
- campaign discounts (optional)

Discount rules:

- discounts are expressed in bps
- final fee cannot be reduced below a defined minimum
- all discounts are verifiable on-chain

Example:

- `finalFeeBps = max(baseFeeBps - totalDiscountBps, minFeeBps)`

---

## 10.3 Supporter Discount Enforcement

Supporter discount requires:

- wallet holds SupporterBadge NFT
- badge is verified on-chain
- discount applies automatically

If badge is transferable:
- discount follows holder
- no off-chain lists required

---

## 10.4 Fee Charging Conditions

Fee can only be charged when:

- realizedNetProfitUSDT > 0

Fee is computed:

- `feeUSDT = realizedNetProfitUSDT * finalFeeBps / 10000`

If profit is zero:
- fee is zero

---

## 10.5 Fee Routing Requirements

Fees must be routed deterministically to protocol receivers.

Receivers (policy-defined but recommended):

- Dev/Treasury Receiver
- ECW Receiver
- Reserve/Floor Receiver
- Marketing/Partnership Receiver

Routing must be:

- on-chain
- auditable
- configurable only through timelocked governance/admin

---

## 10.6 Fee Receiver Security

Fee receiver addresses must be:

- controlled via multisig
- changeable only through timelock
- validated against zero address
- optionally require "receiver allowlist"

---

## 10.7 Fee Events

Mandatory events:

- `FeeCharged(vaultId, feeAmount, feeBps)`
- `FeeRouted(receiver, amount, category)`

---

# 11. Profit Buffer + Claim System (Claim Anytime)

YieldLoop stores realized profits in deterministic accounting buckets so the user can claim at any time.

---

## 11.1 Profit Buffer Purpose

Profit Buffer exists to:

- separate realized profit from principal
- prevent accounting mixing
- prevent double claims
- support compounding logic
- support claim anytime UX

---

## 11.2 Profit Routing Logic

When realized net profit is detected:

1) compute fee
2) route fee to protocol receivers
3) compute user remainder
4) split by compounding rate:
   - compound portion
   - claim portion

Accounting:

- `claimable += claimPortion`
- `compoundBalance += compoundPortion`

---

## 11.3 Claim Anytime Function

User calls:

- `claim(vaultId)`

Rules:

- transfers claimable balance to user
- sets claimable to zero (or decrements)
- emits event

Claim does not require:
- monthly cycles
- settlement windows
- admin approval
- keeper action

---

## 11.4 Claim Asset (USDT vs LOOP)

If reward mode is USDT:
- claim transfers USDT

If reward mode is LOOP:
- claim transfers LOOP

Reward mode affects:
- fee rate
- payout asset

Reward mode must be stored per vault and emitted when changed.

---

## 11.5 Claim Security

Claim must:

- be non-reentrant
- validate available balance
- never allow principal withdrawal through claim
- revert on accounting mismatch

---

## 11.6 Claim Events

Emit:

- `Claimed(vaultId, user, asset, amount)`


# 12. Compounding Rules (0–100% User Controlled)

Compounding is a user-selected rule controlling the split between reinvestment and withdrawable profit.

It is not the strategy.

---

## 12.1 Compound Rate

`compoundRateBps` is in basis points:

- 0 = 0%
- 10000 = 100%

---

## 12.2 Compound Application

For each realized profit event:

- `compoundAmount = userRemainder * compoundRateBps / 10000`
- `claimAmount    = userRemainder - compoundAmount`

Accounting:

- `compoundBalance += compoundAmount`
- `claimable += claimAmount`

---

## 12.3 Compound Usage

Compound balance is treated as:

- earned profit
- available capital for future execution sizing
- still tracked separately from principal

---

## 12.4 User Updates

User may update compound rate:

- `setCompoundRate(vaultId, newRateBps)`

Rules:

- bounded range 0–10000
- emits event
- applies next profit event forward

---

## 12.5 Compound Events

Emit:

- `CompoundRateUpdated(vaultId, oldRateBps, newRateBps)`
- `CompoundApplied(vaultId, amount)`

---

# 13. LOOP Token (Redemption Token, Not Governance) — UNABRIDGED

LOOP is the YieldLoop protocol token deployed on BNB Chain (BEP-20).

LOOP is not a “yield token” and it is not governance. LOOP is a protocol utility and alignment token with the following purposes:

1) allow users to receive rewards in LOOP instead of USDT  
2) provide fee discounts when users accept LOOP rewards  
3) support a reserve-linked redemption/floor mechanism (bounded, reserve-limited)  
4) provide an “aligned participation token” that grows only if the protocol produces real profit

YieldLoop must never represent LOOP as equity, ownership, dividends, guaranteed income, or guaranteed price appreciation.

This entire protocol only works if LOOP is treated honestly:

- LOOP value is a function of real protocol usage and reserve behavior
- LOOP does not print money
- LOOP does not create profit
- LOOP does not replace risk

---

## 13.1 LOOP Design Constraints (Non-Negotiable)

The LOOP token design must satisfy the following constraints:

### 13.1.1 No Infinite Emissions
There must not be any design that “emits LOOP per block” or “emits LOOP per day” as a reward stream unrelated to realized profit.

### 13.1.2 No Fake APY
The protocol must not use LOOP emissions to manufacture APY numbers.

If the system shows performance, it must be based on:
- realized net profit
- after fees and costs

### 13.1.3 LOOP Can Be Optional
Users must be able to participate in YieldLoop without ever touching LOOP:

- deposit USDT
- receive USDT rewards
- claim anytime

If LOOP becomes mandatory, you create forced token exposure and regulatory and trust problems.

### 13.1.4 LOOP Must Be Auditable
All LOOP issuance must be:

- deterministic
- event logged
- explainable
- bounded by rule

### 13.1.5 LOOP Must Not Break Accounting Integrity
LOOP must never cause principal/profit accounting to blur.

Principal is USDT.

Profit is USDT.

LOOP is only:
- a reward payout option
- a discount alignment option
- a reserve-linked token with optional redemption

---

## 13.2 LOOP Token Contract (BEP-20) Requirements

LOOP must be a standard BEP-20 token.

Minimum BEP-20 compliance:

- `name()`
- `symbol()`
- `decimals()`
- `totalSupply()`
- `balanceOf(address)`
- `transfer(address,uint256)`
- `allowance(address,address)`
- `approve(address,uint256)`
- `transferFrom(address,address,uint256)`
- events:
  - `Transfer(address,address,uint256)`
  - `Approval(address,address,uint256)`

### 13.2.1 Minting Permission Model
Minting must not be externally available.

Minting must be restricted to a single mint authority:

- `LoopMinter` contract (preferred)
- or `ProtocolCore` contract

Mint authority must be:

- updateable only via timelock + multisig governance
- pausable
- bounded by supply and/or policy rules

### 13.2.2 Burning Model (Optional)
Burning is optional. If present:

- burn may be used for supply control
- burn may be used for redemption mechanics
- burn must emit `Transfer(from, 0x0, amount)`

### 13.2.3 Token Upgrade Policy
Do not use upgradeable token contracts unless absolutely necessary.

If upgradeable:
- token upgrade requires timelock
- token upgrade requires governance vote
- token upgrade requires public disclosure in protocol UI

---

## 13.3 LOOP Reward Mode (User Experience + Contract Rules)

Users can choose **Reward Mode** per vault:

- Reward Mode A: **USDT rewards**
- Reward Mode B: **LOOP rewards**

This choice has two direct effects:

1) **Payout asset**
   - USDT mode pays the user in USDT
   - LOOP mode pays the user in LOOP

2) **Fee rate**
   - USDT mode: 20.0% performance fee on realized net profit
   - LOOP mode: 17.5% performance fee on realized net profit (2.5% discount)

### 13.3.1 Reward Mode Must Be Vault-Scoped
Reward mode must be stored per vault:

- `rewardMode[vaultId] = USDT | LOOP`

Reward mode is not global per wallet, because a wallet may have multiple deposits/vaults with different intents.

### 13.3.2 Reward Mode Must Be Locked Behind Accept/Decline Checkpoint
Reward mode affects fees and payout, therefore it must be explicitly accepted.

When user accepts strategy:

- reward mode is included in the accepted config and stored
- acceptance emits:
  - `StrategyAccepted(vaultId, rewardMode, compoundRateBps, configHash)`

### 13.3.3 Reward Mode Updates
If YieldLoop allows changing reward mode after activation, then:

- changing reward mode must require explicit user tx
- changing reward mode must emit an event
- changing reward mode must not retroactively change past profit treatment

Recommended rule:

- reward mode changes apply only to **future profit events**, not to already buffered profits

Example:

- user had USDT claimable already
- user flips to LOOP mode
- those prior USDT claimables remain USDT claimables
- only future profits use LOOP conversion rules

### 13.3.4 Discount Integrity
The LOOP discount is earned only if the user accepts LOOP payout.

You must not allow:

- “I get the 17.5% fee but still want USDT rewards”

That would break token demand and collapse the discount logic.

---

## 13.4 LOOP Conversion Mechanics (How USDT Profit Becomes LOOP)

Even when rewards are in LOOP, all profit must still be defined in USDT terms.

Invariant:

> **Profit is calculated in USDT. LOOP is only a representation of the user’s profit entitlement converted into token form.**

There are two acceptable conversion paths:

### 13.4.1 Path A — Market Buy LOOP (Recommended)
Process:

1) strategy realizes net profit in USDT
2) fee is charged in USDT
3) user remainder is USDT
4) protocol swaps that USDT remainder into LOOP on a DEX
5) LOOP is delivered to Profit Buffer as claimable LOOP

This is preferred because:

- LOOP is purchased from the market
- LOOP receives natural demand as protocol grows
- no inflationary printing is required
- LOOP price becomes meaningful

Constraints:

- LOOP must have sufficient liquidity
- swap routes must be allowlisted
- slippage limits must be enforced

If LOOP liquidity is not healthy:

- protocol must revert to fallback behavior (see 13.5)

### 13.4.2 Path B — Mint LOOP (Only if Strictly Bounded)
Process:

1) strategy realizes net profit in USDT
2) fee is charged in USDT
3) user remainder is computed in USDT
4) LOOP is minted to equal that value according to conversion price rule

This path is riskier because:

- LOOP supply increases
- LOOP can become inflationary
- LOOP price can collapse if minting outpaces demand

If minting is used, it must be bounded by policy:

- maximum mint per day
- maximum mint per vault per day
- maximum mint per month
- hard cap or soft cap
- emergency pause

### 13.4.3 Conversion Price Source
If minting (Path B) is used, mint requires a conversion price.

Conversion price sources must be conservative:

- TWAP of LOOP/USDT on allowlisted DEX pool
- multi-venue check (PCS + BiSwap)
- deviation bounds
- fallback freeze if price manipulation suspected

Never use:

- last trade spot price with low liquidity
- off-chain admin-defined “price”
- a value that can be arbitraged cheaply by attackers

---

## 13.5 LOOP Reward Mode Fallback Logic (Mandatory)

Because LOOP conversion introduces additional failure modes, LOOP reward mode must include fallbacks.

If LOOP conversion cannot execute safely, do not guess.

### 13.5.1 Fallback Trigger Conditions
Fallback triggers include:

- LOOP liquidity below minimum threshold
- LOOP slippage would exceed maximum
- oracle price deviation too high
- LOOP pool disabled
- DEX disabled
- MEV risk too high

### 13.5.2 Fallback Actions
Any of these actions are valid, depending on policy:

**Fallback A (recommended):**
- store profit remainder as USDT claimable
- label it as “USDT fallback from LOOP reward mode”
- user can claim USDT

**Fallback B:**
- store profit remainder as USDT but mark “pending conversion”
- conversion attempted later when safe
- user can override and claim USDT instead

**Fallback C (not recommended unless needed):**
- pause LOOP reward mode for the vault
- require user to re-accept strategy

---

## 13.6 LOOP as a Protocol Alignment Token (What It Is For)

LOOP’s intended purpose is alignment. That means:

- users who choose LOOP accept token exposure
- in exchange they receive a fee discount
- this creates organic demand for LOOP
- protocol growth should lead to increased LOOP usage

Alignment effect:

- if YieldLoop is producing real profit, LOOP demand increases
- if YieldLoop is not producing profit, LOOP demand does not grow

This is the correct economic behavior.

---

## 13.7 LOOP Disclosures (Non-Negotiable UI Requirements)

Whenever LOOP reward mode is displayed, the UI must include:

- LOOP is volatile
- LOOP is not guaranteed
- LOOP rewards may be converted via DEX purchase or mint (as defined)
- LOOP reward mode can fail over to USDT claimable
- LOOP has no governance rights
- LOOP has no equity rights
- LOOP is not guaranteed to have redemption availability

---

## 13.8 LOOP Events (Mandatory)

The system must emit events for:

- `RewardModeSelected(vaultId, mode)`
- `RewardModeUpdated(vaultId, oldMode, newMode)`
- `LoopRewardConversionAttempted(vaultId, usdtIn, expectedLoopOut)`
- `LoopRewardConversionCompleted(vaultId, usdtIn, loopOut)`
- `LoopRewardConversionFailed(vaultId, reasonCode)`
- `LoopMinted(to, amount, reasonCode, vaultId)` (if minting exists)
- `LoopPurchased(usdtIn, loopOut, venue)` (if market-buy exists)

---

# 14. LOOP Minting Rules (Profit-Backed Issuance) — UNABRIDGED

This section defines the only acceptable ways LOOP can enter circulation under protocol control.

This matters because most DeFi “yield tokens” fail for one reason:

> they print rewards endlessly until the token collapses.

YieldLoop cannot do that. LOOP must be minted or acquired under strict rules, or the entire protocol becomes a disguised inflation machine.

The design goal is simple:

- If YieldLoop produces real profit → LOOP distribution can grow
- If YieldLoop does not produce real profit → LOOP distribution must not grow
- LOOP issuance must always be explainable to an auditor and to a user

---

## 14.1 Minting Philosophy (Protocol Law)

LOOP minting must comply with these laws:

### 14.1.1 No “Emission Schedules”
There must be no:
- LOOP per block emissions
- LOOP per day emissions
- APY printing mechanics
- “liquidity mining” emissions

If the protocol wants to incentivize liquidity later, that is a separate, explicitly disclosed program and cannot be embedded into the core vault reward engine by default.

### 14.1.2 Minting Is Not the Source of Profit
Minting LOOP does not create profit.

Profit is created only when the vault realizes net USDT gain.

LOOP is only one way to represent rewards.

### 14.1.3 Minting Must Be Narrow and Contained
Any minting mechanism must be:
- bounded by caps
- bounded by role permissions
- bounded by timelock policy
- pausable instantly

### 14.1.4 Minting Must Be Transparent
Every mint must emit a structured event:

- who received LOOP
- how much LOOP
- why it was minted
- which vault/program caused it

If an auditor can’t explain LOOP supply changes, it’s broken.

---

## 14.2 Minting Sources (What Can Mint LOOP)

LOOP may only be minted from these sources:

1) **SupporterPresale airdrop minting**
2) **Referral reward minting** (only if policy chooses mint vs market-buy)
3) **Reward conversion minting** (if Path B is chosen instead of market-buy)
4) **Governance-defined bounded programs** (explicit, timelocked, disclosed)

If a mint is not inside one of these sources, it must revert.

---

## 14.3 LoopMinter Contract (Required)

All mint actions must go through a single contract:

- `LoopMinter`

The token itself must not allow arbitrary minting.

LOOP token contract must enforce:

- only `LoopMinter` has `MINTER_ROLE`
- token is pausable (optional)
- minter role is revocable

### 14.3.1 LoopMinter Functions (Required)

`LoopMinter` should expose at minimum:

- `mintSupporterAirdrop(address to, uint256 amount, uint256 supporterId)`
- `mintReferralReward(address to, uint256 amount, bytes32 referralId)`
- `mintRewardConversion(address to, uint256 amount, uint256 vaultId)`
- `pauseMinting()`
- `unpauseMinting()`
- `setMintCaps(...)` (timelocked only)

### 14.3.2 LoopMinter Permissions
Minting authority must be controlled by:

- governance/admin timelock
- multisig

No EOAs.

---

## 14.4 Mint Caps (Mandatory)

Mint caps prevent economic sabotage and protocol destruction.

Even if you “trust yourself,” code must assume you can be hacked or governance can be attacked.

Mandatory caps:

### 14.4.1 Per-Transaction Cap
- `maxMintPerTx`

If mint > cap:
- revert

### 14.4.2 Per-Vault Cap (Reward Minting)
- `maxMintPerVaultPerDay`
- `maxMintPerVaultPerMonth`

If exceeded:
- revert or fallback to USDT payout

### 14.4.3 Global Mint Cap
- `maxMintPerDay`
- `maxMintPerMonth`

If exceeded:
- revert or pause minting automatically

### 14.4.4 Program-Specific Caps
Each mint source should have its own caps:

- presale mint cap
- referral mint cap
- reward conversion mint cap
- special program mint cap

These allow you to kill one broken program without killing all minting.

---

## 14.5 Mint Pricing Rules (Only for Reward Conversion Minting)

If LOOP is minted as a reward conversion (Path B), the system must define a conversion price.

This price source must be:

- conservative
- manipulation-resistant
- consistent
- bounded by sanity checks

### 14.5.1 Allowed Price Source
Allowed sources:

- TWAP of LOOP/USDT from allowlisted pool
- multi-DEX TWAP median (PCS + BiSwap)
- Chainlink-style oracle (if available and trusted)

TWAP must have:

- minimum liquidity requirement
- minimum time window requirement
- staleness limits

### 14.5.2 Price Deviation Guardrail
Mint conversion must enforce:

- if price deviates > maxDeviationBps → reject mint
- fallback to USDT claimable

This prevents attackers from manipulating LOOP price upward to steal supply.

---

## 14.6 Minting vs Market-Buy Preference (Recommended Policy)

YieldLoop should prefer:

> **Market-buy LOOP whenever liquidity is sufficient.**

Minting should be used only when:

- LOOP liquidity is too small for stable buys
- OR there is a defined bounded mint program
- OR in presale/referral programs where exact distribution must be deterministic

### 14.6.1 Market-Buy Benefits
Market-buy:
- creates demand
- does not inflate supply
- ties LOOP success to real protocol usage
- prevents slow death by emissions

### 14.6.2 Minting Risks
Minting:
- increases supply
- can collapse price if uncontrolled
- can become an APY gimmick
- can destroy credibility fast

---

## 14.7 Supporter Presale Minting (Inaugural Airdrop)

Supporters deposit 300 USDT and receive an airdrop allocation.

Minting rules must guarantee:

- a supporter gets exactly one airdrop allocation
- allocation is deterministic
- allocation cannot be duplicated
- allocation cannot be exploited via reentrancy
- allocation cannot exceed the presale cap

### 14.7.1 Airdrop Amount Formula
Supporter LOOP airdrop is defined as:

- `airdropValueUSDT = 100 USDT`
- `bonusMultiplier = 1.025`
- `airdropValueUSDTAdjusted = 100 * 1.025 = 102.50 USDT equivalent`

LOOP amount depends on price rule:

If market-buy:
- swap 102.50 USDT to LOOP and deliver amount

If mint:
- `loopAmount = 102.50 / loopPriceUSDT`

### 14.7.2 Supporter Mint Timing
Two valid implementations:

**Option A — Immediate mint at deposit**
- supporter deposits
- contract mints and transfers LOOP instantly

**Option B — Claim-based mint**
- supporter deposits
- contract records entitlement
- supporter calls `claimSupporterAirdrop()`

Recommendation:
- Option B is safer for gas and avoids forced mint routing during congestion.

### 14.7.3 Presale Mint Cap
Presale minting must be capped:

- max 5,000 supporters
- each supporter receives only one entitlement

The contract must enforce:

- `supporterCount <= 5000`
- `supporterEntitlement[to]` can only be set once

---

## 14.8 Referral Reward Minting (If Used)

Referral rewards are:

- $25 worth of LOOP to referrer
- $25 worth of LOOP to referred

The referral reward should be funded from marketing/partnership budget.

Implementation options:

### 14.8.1 Preferred: Market-Buy LOOP
- program budget holds USDT
- when referral qualifies:
  - swap 25 USDT into LOOP for referrer
  - swap 25 USDT into LOOP for referred

This keeps supply controlled and creates demand.

### 14.8.2 Optional: Mint LOOP
If referral rewards mint LOOP instead:
- must be capped
- must use conservative TWAP price
- must respect global mint caps

---

## 14.9 Fallback Behavior When Minting/Buying Fails

If LOOP minting or LOOP market-buy cannot happen safely:

- do not guess
- do not mint anyway
- do not “estimate price”

Required fallback:

- credit the reward as USDT claimable
- label it as “LOOP payout fallback”
- allow user to claim USDT

This protects users and prevents protocol embarrassment.

---

## 14.10 Mint Auditing and Supply Telemetry

Protocol must expose on-chain telemetry:

- total minted by program
- minted last 24h
- minted last 30d
- minted by vault strategy engine
- minted by presale
- minted by referrals

View functions:

- `getMintTotalsBySource()`
- `getMintTotalsByDay(dayIndex)`
- `getMintTotalsByVault(vaultId)`

Events must include:

- mint source code
- vaultId (if applicable)
- programId (if applicable)
- amount minted

---

## 14.11 Mint Events (Mandatory)

Emit:

- `LoopMinted(to, amount, sourceCode, vaultId, programId)`
- `MintRejected(to, amount, sourceCode, reasonCode)`
- `MintCapsUpdated(oldCaps, newCaps)` (timelocked)
- `MintPaused()`
- `MintUnpaused()`

---

# 15. LOOP Reserve / Floor System (Reserve-Limited Redemption) — UNABRIDGED

This section defines the reserve and floor mechanics that support LOOP.

This is not marketing. This is engineering.

If you do this wrong, LOOP becomes either:
- a hollow token with no credibility, or
- a forced “bank run” redemption token that collapses the protocol.

So the rules here must be brutally strict:

- the reserve is real USDT (or approved stable assets)
- the reserve is auditable on-chain
- redemption (if enabled) is strictly limited by reserve availability
- reserve cannot be drained below safety thresholds
- users must never be led to believe redemption is unlimited

---

## 15.1 What the Reserve Is (Plain English)

The LOOP Reserve is a protocol-owned pool of USDT used to:

- support redemption mechanics (optional feature)
- support floor mechanics (policy-defined)
- provide solvency signaling to the market
- act as a stabilizing sink/source for LOOP liquidity events

The LOOP Reserve is **not**:
- a promise
- an insurance system
- an infinite buyback wallet
- a guarantee of token price

It is a bounded support mechanism.

---

## 15.2 Reserve Contract Architecture (Build Requirement)

Reserve must be implemented as its own contract module.

Recommended contracts:

- `ReserveVault` (holds assets)
- `ReserveController` (enforces redemption rules / parameters)
- `ReserveRouter` (executes buyback/redemption swaps, if used)
- `ReserveTimelock` (governance-controlled changes)

If you merge reserve logic into the core vault, you increase blast radius.
Keep it separate.

### 15.2.1 Reserve Assets

Reserve holds only allowlisted low-risk assets:

- USDT (primary)
- optionally USDC
- optionally BUSD-like stable if available/trusted

Do **not** put volatile assets in reserve.

---

## 15.3 Reserve Funding Sources (Where It Comes From)

Reserve is funded by deterministic sources:

### 15.3.1 Supporter Presale Allocation
From supporter program:

- 100 USDT per supporter → reserve

With 5,000 supporters, maximum reserve seed:

- 500,000 USDT

This is meaningful initial support.

### 15.3.2 Protocol Fee Routing
A portion of performance fees may route into reserve.

This portion must be:

- fixed by config version, OR
- timelock adjustable

Example categories:

- dev
- ECW
- reserve
- marketing

### 15.3.3 Treasury Seeding (Optional)
Protocol treasury may seed reserve.

### 15.3.4 External Partnerships (Optional)
Partners may contribute to reserve under disclosed agreements.

---

## 15.4 What “Floor System” Means (Avoiding Bullshit Language)

The phrase “floor price” is extremely dangerous.

It implies:
- guaranteed price
- infinite support
- risk-free token

That cannot be true.

So YieldLoop must use strict definitions:

### 15.4.1 Floor Support (Acceptable Meaning)
The reserve may provide **bounded market support**:

- buy LOOP only under defined conditions
- only up to defined budgets
- only while reserve exceeds minimum
- only if price feeds sane

### 15.4.2 Floor Support (Forbidden Meaning)
The reserve must not imply:

- LOOP cannot fall
- LOOP is guaranteed redeemable
- LOOP will always be bought back

The UI must explicitly disclose:
- support is bounded and may pause
- redemption availability is not guaranteed

---

## 15.5 Reserve-Limited Redemption (The Only Safe Model)

If LOOP redemption exists at all, it must follow this rule:

> Redemption is limited by the reserve’s available USDT and controlled by protocol safety thresholds.

That means:

- redemptions can be denied
- redemptions can be paused
- redemptions can be rate limited
- reserve cannot be drained to zero

This is non-negotiable.

---

## 15.6 Reserve State Variables (Required)

ReserveController must track:

- `reserveUSDTBalance`
- `reserveMinUSDT` (minimum safety reserve)
- `reserveMaxRedemptionPerDayUSDT`
- `reserveMaxRedemptionPerTxUSDT`
- `reserveCooldownSeconds`
- `reserveActive` (bool)
- `redemptionActive` (bool)

Optional (recommended):

- `priceSupportActive` (bool)
- `maxBuybackPerDayUSDT`
- `maxBuybackPerTxUSDT`

---

## 15.7 Redemption Mechanics (If Enabled)

Redemption means:

- a user gives LOOP
- protocol gives USDT back
- LOOP is burned or held

Redemption must be:

- voluntary
- user-initiated
- bounded

### 15.7.1 Redemption Flow

User calls:

- `redeemLoop(amountLoop)`

Contract performs:

1) verify redemptionActive
2) verify amountLoop > 0
3) verify user has amountLoop
4) compute redemption output:
   - `usdtOut = amountLoop * redemptionPrice`
5) enforce caps:
   - per tx cap
   - per day cap
   - reserve must remain >= reserveMinUSDT
6) transfer LOOP from user
7) burn LOOP (preferred) or hold in treasury bucket
8) transfer USDT to user
9) emit event

### 15.7.2 Redemption Price Definition

Redemption price must be conservative and manipulation resistant.

Allowed:
- TWAP-based LOOP/USDT price
- capped maximum to avoid exploitation

Also required:
- deviation guardrails
- staleness guardrails
- minimum liquidity requirement

### 15.7.3 Redemption Fee (Optional)
A redemption fee may exist to prevent abuse.

Example:
- 0.25% to 2%

This fee:
- reduces reserve drain risk
- discourages rapid arbitrage loops

If redemption fee exists, disclose it in UI.

---

## 15.8 Redemption Caps (Anti-Bank-Run)

Mandatory caps:

### 15.8.1 Per Transaction Cap
- max USDT out per redemption tx

### 15.8.2 Per Wallet Cap (Recommended)
- max USDT out per wallet per day/week

### 15.8.3 Per Day Cap
- global daily redemption ceiling

### 15.8.4 Reserve Minimum
Reserve must not drop below `reserveMinUSDT`.

If redemption would cause reserve < min:
- reject redemption
- emit rejection event

---

## 15.9 Automatic Redemption Pauses

Redemption must auto-pause if:

- reserve balance too low
- oracle price feed stale
- LOOP pool liquidity below threshold
- price deviation too large
- exploit suspected (manual kill switch)

When paused:
- emit `RedemptionPaused(reasonCode)`

---

## 15.10 Price Support / Buyback Mechanic (Optional)

A “floor” in practice usually means buybacks.

If YieldLoop implements buybacks:

- Reserve may buy LOOP on open market
- Under strict budget and safety rules

### 15.10.1 Buyback Trigger Conditions
Triggers must be explicit and limited:

Examples:
- LOOP price below moving average by X%
- LOOP price below configured threshold
- volatility within safe range
- reserve balance above minimum by safety margin

### 15.10.2 Buyback Execution Rules
Buybacks must:

- use allowlisted DEX routes
- enforce slippage caps
- enforce daily budget
- enforce tx budget
- reject execution when unsafe

### 15.10.3 Buyback Output Handling
Bought LOOP can be:

- burned
- held in treasury
- used for incentives later (not recommended unless disclosed)

Burning is clearest.

---

## 15.11 Reserve Transparency (UI + On-Chain Proof)

Reserve must be publicly verifiable.

Required view functions:

- `getReserveBalanceUSDT()`
- `getReserveMinUSDT()`
- `getRedemptionCaps()`
- `getBuybackCaps()` (if buybacks enabled)
- `isRedemptionActive()`

UI must show:

- reserve balance
- redemption status (active/paused)
- redemption caps
- disclosure that reserve is bounded

---

## 15.12 Reserve Security Requirements

### 15.12.1 Multisig Control
Reserve control addresses must be multisig.

### 15.12.2 Timelock Governance
Any change to:

- reserve min
- redemption caps
- buyback caps
- reserve routing %
- redemption enable/disable

Must go through timelock.

### 15.12.3 Emergency Pause
Reserve must support instant pause.

Only allowed actions during pause:

- disable redemption
- disable buybacks

No movement of reserve funds unless explicitly defined and disclosed.

---

## 15.13 Reserve Events (Mandatory)

Emit events on:

- `ReserveFunded(source, amountUSDT)`
- `ReserveWithdrawn(destination, amountUSDT, reasonCode)` (only if allowed)
- `RedemptionRequested(user, loopIn)`
- `RedemptionCompleted(user, loopIn, usdtOut)`
- `RedemptionRejected(user, loopIn, reasonCode)`
- `RedemptionPaused(reasonCode)`
- `RedemptionUnpaused()`
- `BuybackAttempted(usdtIn, expectedLoopOut)`
- `BuybackCompleted(usdtIn, loopOut)`
- `BuybackRejected(reasonCode)`
- `ReserveConfigUpdated(oldConfigHash, newConfigHash)`

---

# 16. Supporter Presale Program (First 5,000 Wallets) — UNABRIDGED

This section defines the early supporter presale program.

This presale is not a “token presale” in the usual scammy sense. It is a **community supporter funding program** that:

- seeds development capital
- seeds execution costs and launch needs (ECW)
- seeds the LOOP reserve/floor support system
- grants early supporters a deterministic inaugural LOOP allocation bonus
- assigns an on-chain supporter marker (SupporterBadge NFT)
- activates additional benefits (discount + Discord channel access + referral eligibility)

The program is limited. When full, it closes.

---

## 16.1 Supporter Program Summary

Supporter program constraints:

- Chain: BNB Chain
- Deposit asset: USDT
- Supporter buy-in: **300 USDT**
- Maximum supporters: **5,000 wallets**
- One supporter position per wallet (enforced on-chain)
- SupporterBadge NFT issued per supporter
- Supporters get:
  - +1% discount stacked on top of any other discounts they qualify for
  - access to private Discord channel(s)
  - a referral code with rewards after 180-day qualification

Key principle:

> This is seed funding + alignment. Not guaranteed return. Not a security promise.

---

## 16.2 SupporterPresale Contract Requirements

A dedicated contract must exist:

- `SupporterPresale`

This contract must:

- accept supporter deposits
- enforce max supporters
- enforce one deposit per wallet
- split incoming funds deterministically
- mint/issue supporter entitlements
- emit events for auditing
- remain readable long-term (no “mystery admin logic”)

### 16.2.1 Deposit Function

Recommended interface:

- `supporterDeposit(uint256 amountUSDT)`

Rules:

- amount must equal exactly 300 USDT
- deposit must revert if:
  - supporter cap reached
  - wallet already purchased
  - contract paused

### 16.2.2 Acceptable Deposit Assets

Only accept the exact USDT token address used by protocol.

Do not accept “any stablecoin” in presale.

Reason:
- simplifies auditing
- prevents dust exploits and fee-on-transfer chaos
- avoids decimals mismatch

---

## 16.3 300 USDT Split (Hardcoded Policy)

Each supporter deposit is split into four allocations:

- **75 USDT** → Development funding
- **25 USDT** → ECW + launch seed needs
- **100 USDT** → LOOP reserve/floor system
- **100 USDT** → LOOP inaugural supporter airdrop value

Total = 300 USDT

These splits must be:

- deterministic
- enforced on-chain
- event logged

### 16.3.1 Development Allocation (75 USDT)

Dev allocation is routed to:

- Dev/Treasury receiver multisig

Rules:

- receiver must be multisig
- receiver changeable only via timelock (or not changeable during presale)

### 16.3.2 ECW / Seed Needs Allocation (25 USDT)

ECW allocation is routed to:

- `ExecutionCostWallet` contract (ECW)
- or an ECW seed receiver that funds ECW

ECW is required for:

- keeper reimbursement
- launch execution costs
- monitoring bots
- emergency execution (unwind)

This allocation exists to prevent execution paralysis at launch.

### 16.3.3 Reserve Allocation (100 USDT)

Reserve allocation is routed to:

- `ReserveVault`

This must be:

- on-chain
- auditable
- not withdrawable by admin except via strict disclosed rules

### 16.3.4 Supporter Airdrop Allocation (100 USDT)

This allocation sets the supporter LOOP entitlement.

Supporters receive:

- 1 : 1.025 bonus

Meaning:

- supporter is entitled to 102.50 USDT-equivalent of LOOP

The mechanics of delivering this LOOP are defined in Section 14 and Section 13.

---

## 16.4 Supporter LOOP Airdrop Rules (Precise)

Supporter airdrop must be implemented as an entitlement system.

A supporter must be able to prove:

- deposit happened
- entitlement exists
- entitlement has not yet been claimed or delivered
- the resulting LOOP amount was computed according to policy

### 16.4.1 Entitlement Accounting Variables

Presale contract must track:

- `supporterIdByWallet[address]`
- `walletBySupporterId[uint256]`
- `supporterCount`
- `supporterPurchased[address]`
- `airdropEntitlementValueUSDT[address]` (should equal 102.50 USDT-equivalent)
- `airdropClaimed[address]`

### 16.4.2 Airdrop Delivery Models

Two acceptable models:

#### Model A — Immediate delivery
- supporter deposits
- contract directly buys or mints LOOP
- LOOP transferred to supporter immediately

Risks:
- gas spikes may break deposit tx
- liquidity may be insufficient at launch
- hostile MEV conditions may degrade swaps

#### Model B — Claim-based delivery (recommended)
- supporter deposits
- entitlement recorded
- supporter later calls:
  - `claimSupporterAirdrop()`
- claim executes when conditions safe

This is cleaner and more reliable.

### 16.4.3 Airdrop Delivery Fallbacks

If LOOP buy/mint fails safely:

- entitlement remains unclaimed
- supporter can retry later

Optionally:
- supporter can choose USDT payout instead (if policy allows)

But do not silently change entitlement.

---

## 16.5 Supporter Limit Enforcement (Strict)

The presale must enforce exactly:

- max 5,000 successful supporter positions

Rules:

- once supporterCount == 5000:
  - contract must reject all new purchases
  - emit `SupporterSaleClosed()`

If a deposit is attempted after cap:
- revert
- do not accept funds

---

## 16.6 One Supporter Position per Wallet

Supporter program is limited to first 5,000 wallets.

This is enforced as:

- `require(!supporterPurchased[msg.sender])`

No “add another 300 later.”  
No stacking supporter entitlements per wallet.

This protects fairness and reduces abuse.

---

## 16.7 Program Pausing

SupporterPresale must support pause/unpause.

Reasons to pause:

- exploit discovered
- USDT token issue
- Reserve routing issue
- LoopMinter issue
- badge mint issue

When paused:

- new deposits blocked
- claims optionally blocked (policy-defined)

---

## 16.8 Supporter Events (Mandatory)

Presale must emit the following:

- `SupporterDeposit(address supporter, uint256 supporterId, uint256 amountUSDT)`
- `SupporterAllocationRouted(uint256 supporterId, address receiver, uint256 amountUSDT, uint8 categoryCode)`
- `SupporterAirdropEntitlementCreated(address supporter, uint256 supporterId, uint256 entitlementValueUSDT)`
- `SupporterAirdropClaimed(address supporter, uint256 supporterId, uint256 amountLOOP)`
- `SupporterSaleClosed(uint256 totalSupporters)`
- `SupporterPresalePaused()`
- `SupporterPresaleUnpaused()`

---

## 16.9 Supporter Program Disclosure Requirements

UI must disclose clearly:

- supporter deposit is not refundable by protocol policy (unless you choose otherwise)
- supporter deposit is not a guaranteed return
- LOOP is volatile
- discounts are benefits, not yield
- supporter program is limited and may close quickly
- referral rewards are conditional and not guaranteed

Users must explicitly accept these disclosures.

This prevents future disputes and improves legal defensibility.

---

# 17. SupporterBadge NFT (Discount + Discord Access + On-Chain Verification) — UNABRIDGED

SupporterBadge is a transferable on-chain badge issued to supporters.

This badge is the core mechanism that allows YieldLoop to:

- verify early supporters without off-chain lists
- apply supporter discounts automatically
- gate Discord access
- enable referral privileges

---

## 17.1 Badge Standard (BNB Chain)

The badge must be issued as an NFT on BNB Chain.

Recommended standard:

- **BEP-721** (equivalent to ERC-721)

Optional standard:

- BEP-1155 if multiple tiers are needed later

YieldLoop’s current requirements match BEP-721 best:

- one badge per supporter wallet
- easy “does wallet hold badge” check
- simple gating

---

## 17.2 SupporterBadge Contract Requirements

Contract name:

- `SupporterBadge`

It must implement:

- ERC-721/BEP-721 interface
- metadata URI support
- owner query functions
- transfer functions (if transferable)

Recommended features:

- `supportsInterface()`
- `tokenURI()`
- `balanceOf()`
- `ownerOf()`

### 17.2.1 Mint Permission Model

Only the presale contract (or a BadgeMinter module) may mint badges.

Rules:

- minting role must be restricted
- role updates must be timelocked

No public mint.

---

## 17.3 Badge Issuance Rules

When supporter deposit succeeds:

- exactly 1 badge NFT is minted
- badge is minted to supporter wallet
- badge tokenId must be unique
- badge tokenId should map to supporterId for auditability

Example:

- tokenId == supporterId

This makes it easy to tie badge ownership to supporter entitlements.

---

## 17.4 Transferability Policy

You asked for transferable — this is allowed, but must be handled carefully.

Two policy options:

### Policy A — Transferable Badge (Your Preferred Model)
Badge can be sold or gifted.

Effects:
- fee discount follows badge holder
- Discord access follows badge holder
- referral eligibility follows badge holder

Risk:
- badge markets can become “discount exploitation markets”

So anti-abuse controls are required (see 17.7).

### Policy B — Soulbound (Non-Transferable)
Badge cannot transfer.

Effects:
- discount locked to supporter wallet only
- prevents discount exploitation
- reduces resale value / “tradability hype”

Either policy is valid.
If you’re trying to create something that can be traded and has value, use transferable.
If you’re trying to reduce exploitation and simplify logic, use soulbound.

---

## 17.5 Discount Activation Rules

SupporterBadge grants an additional discount:

- **+1% additional discount**
- stacks with other discounts

Implementation:

- Discount is computed at fee time by FeeRouter:
  - if `SupporterBadge.balanceOf(user) > 0`
  - add supporterDiscountBps to discount stack

Badge must be verifiable on-chain.

No off-chain signature gating is allowed for discount.

---

## 17.6 Discord Access Verification

Discord access is off-chain, but must be tied to on-chain proof.

Mechanism:

- user connects wallet to Discord bot
- bot checks:
  - `SupporterBadge.balanceOf(wallet) > 0`
- bot assigns role:
  - `Supporter`

If badge transferred:
- bot must re-check ownership periodically
- if badge no longer held:
  - role removed (recommended)

---

## 17.7 Transfer Safeguards (Anti-Flip / Anti-Exploit)

If badge is transferable, you must prevent instant resale exploitation.

Required safeguards (choose one or combine):

### Safeguard Option 1 — Discount Warmup Time
If badge was transferred, discount does not activate until:

- held for X days

Rule:

- `discountActiveAt = lastTransferTimestamp + warmupSeconds`

### Safeguard Option 2 — Vault Age Requirement
Discount only activates if:

- wallet has an ACTIVE vault older than X days

This prevents badge-only wallets from abusing discounts.

### Safeguard Option 3 — Referral Eligibility Delay
Referral program only activates if:

- badge held for X days
- vault active for X days

This prevents referral farming via badge trading.

Recommendation:
- enforce at least one safeguard, or you will be attacked immediately.

---

## 17.8 Badge Revocation / Blacklist Interaction

The badge should not be revokable casually.

But the protocol must defend itself.

Recommended approach:

- badge stays owned by user
- discount can be disabled by:
  - blacklist flags in FeeRouter
  - referral program blacklist

Meaning:
- “you keep your badge, but you don’t get to exploit the protocol”

---

## 17.9 Badge Metadata

Metadata should include:

- supporter number (supporterId)
- issuance date
- level/tier (Supporter)
- optional art traits

Do not include personally identifying data.

---

## 17.10 Badge Events (Mandatory)

Emit:

- `SupporterBadgeMinted(address to, uint256 tokenId, uint256 supporterId)`
- standard `Transfer(from, to, tokenId)`
- optional `BadgeConfigUpdated(oldHash, newHash)` (timelocked only)

---

## 17.11 Badge View Functions (Required)

Add helper views for protocol integration:

- `function hasBadge(address user) external view returns (bool)`
- `function supporterIdOf(address user) external view returns (uint256)` (optional)
- `function walletOfSupporterId(uint256 supporterId) external view returns (address)` (optional)

---

# 18. Referral Program (180-Day Qualification + $25 LOOP Bonus) — UNABRIDGED

This section defines the referral program.

The referral program must be engineered as if it will be attacked immediately, because it will be.

This is not a “marketing feature.” It is an economic subsystem that can destroy the protocol if it is weak.

YieldLoop’s referral program is intentionally conservative:

- rewards are paid only after 180 days
- rewards are fixed-size
- rewards are capped
- rewards are funded from marketing/partnership budget
- rewards do not touch principal
- rewards do not depend on fake yield

---

## 18.1 Program Purpose

Referral program goals:

1) reward early supporters for bringing real users
2) create growth that is profit-positive
3) avoid farmable emissions and sybil drains
4) keep referral rewards as **bonuses**, not a core ROI driver

This means:

- no instant payouts
- no “invite 10 people and get rich”
- no unsustainable loops

---

## 18.2 Core Referral Concept

A supporter receives a referral code.

When a new user joins through that code:

- they become “referred”
- their vault is tracked under that referrer
- they must remain a real participant for 180 days

After 180 days:

- referrer receives **$25 worth of LOOP**
- referred receives **$25 worth of LOOP**

Rewards are not paid if:

- user leaves early
- user is flagged for abuse
- program budget is exhausted
- protocol is paused (policy-defined)

---

## 18.3 Eligibility Requirements (Referrer)

Referrer must meet all:

1) holds SupporterBadge NFT (on-chain verified)
2) not blacklisted
3) referral program enabled globally
4) (recommended) has at least one ACTIVE vault

A referrer is not eligible if:

- badge was transferred within warmup window (if enforced)
- wallet has no legitimate participation (optional but recommended guardrail)
- the wallet is flagged for abuse

---

## 18.4 Eligibility Requirements (Referred User)

Referred user must meet all:

1) uses a valid referral code at onboarding OR sets referrer on first deposit
2) deposits at least the minimum system deposit:
   - **>= 300 USDT**
3) remains in system for **180 days**
4) not blacklisted
5) does not trigger abuse flags

### 18.4.1 What “Remain in System for 180 Days” Means

This must be precisely defined.

Recommended definition:

- referred user has at least one vault that remains open and active for 180 days, AND
- referred user does not fully exit the protocol during that period

Alternative definition (stricter but safer):

- referred user maintains a minimum balance threshold continuously for 180 days

Example:

- vault principal must remain >= 300 USDT-equivalent
- no full withdrawal before 180 days

Policy must be consistent and coded.

---

## 18.5 Referral Code System

Referral codes can be implemented as:

### Option A — Deterministic on-chain code
Code derived from wallet address:

- `refCode = hash(walletAddress)`

Advantages:
- no storage required

### Option B — Explicit code registry (recommended)
Supporter registers code:

- `registerReferralCode(bytes32 code)`

Mapping:

- code → referrerAddress

Advantages:
- easy for UI
- supports custom codes
- supports future tier systems

---

## 18.6 Referral Registration (When It Is Set)

Referral must be locked early.

Critical rule:

> A referred user must not be able to “change referrer” after joining.

Recommended rule:

- referrer is set on first deposit only
- immutable thereafter

Implementation:

- `referrerOf[user]` set once
- subsequent set attempts revert

---

## 18.7 Referral Tracking State Variables

ReferralRegistry must track:

- `referrerOf[address referred]`
- `referredList[address referrer]` (optional, but expensive)
- `referralStatus[referred]`:
  - NONE
  - REGISTERED
  - QUALIFYING
  - QUALIFIED
  - PAID
  - REJECTED

Also track:

- `registeredAtTimestamp`
- `qualifiedAtTimestamp`
- `paidAtTimestamp`

---

## 18.8 Qualification Logic (The 180-Day Rule)

Qualification must be deterministic.

When referred user registers:

- status = QUALIFYING
- qualifyingStart = block.timestamp

Qualification check:

- if `block.timestamp >= qualifyingStart + 180 days`
- and user meets active criteria
- then status becomes QUALIFIED

Qualification can be triggered by:

- referred user action
- referrer action
- keeper automation
- general public call (permissionless)

Recommended:

- permissionless qualification call:
  - `checkQualification(referred)`

---

## 18.9 Referral Reward Amount and Asset

Referral reward is fixed:

- **$25 worth of LOOP** each

Reward payout asset is LOOP.

However, LOOP payout must follow the same integrity principles:

- avoid printing unlimited LOOP
- prefer market-buy
- use mint only if bounded

Therefore:

- referral reward should be funded from a USDT budget
- swap USDT to LOOP and credit to ClaimLedger

---

## 18.10 Funding Source: Marketing + Partnership Budget

Referral rewards must be funded explicitly from:

- marketing/partnership budget

This budget may be funded by:

- a portion of performance fees routed to marketing bucket
- treasury seeding

Do not fund referral from:

- vault principal
- reserve minimums
- hidden inflation

---

## 18.11 Reward Delivery Method (Claim Ledger)

Referral rewards must not be paid by pushing tokens into wallets unexpectedly.

Recommendation:

- referral rewards are credited into:
  - `ReferralClaimLedger`

User claims by calling:

- `claimReferralRewards()`

This:
- prevents failed transfers
- prevents MEV sniping of payouts
- allows batching multiple rewards

---

## 18.12 Referral Caps (Mandatory)

Without caps, you get drained.

### 18.12.1 Cap per Referrer per Month
Example:

- max 5 qualified referrals per referrer per month

Or:

- max $125 worth per month

### 18.12.2 Cap per Referrer Lifetime (Recommended)
Example:

- max 100 rewards lifetime
- or max $2,500 worth lifetime

### 18.12.3 Global Program Cap
Example:

- max $10,000 referral rewards per month globally

If cap exceeded:

- new qualifications still tracked
- reward payouts deferred until budget resets
- or rewards disabled until governance action

This must be disclosed.

---

## 18.13 Abuse Prevention Rules (Required)

A referral program must assume these attacks:

- self-referral (same person)
- wallet farms
- circular referrals
- badge borrowing / renting
- deposit then withdraw at day 179
- deposit dust to “qualify”

Mandatory restrictions:

### 18.13.1 No Self-Referral
If:

- referred wallet == referrer wallet → revert

### 18.13.2 No Circular Referral
If:

- A refers B and B refers A → reject one side

### 18.13.3 Minimum Active Participation
Referred user must have:

- maintained vault at minimum deposit for the full window (recommended)

### 18.13.4 Blacklist Integration
If either wallet is blacklisted:

- status becomes REJECTED
- no rewards paid

---

## 18.14 Referral Failure / Rejection Conditions

Referral is rejected if:

- referred exits before 180 days
- referred flagged for sybil abuse
- referred deposit reversed/invalid
- referrer loses badge (if required)
- program paused permanently

Rejected referrals must:

- emit events
- store rejection reason code

---

## 18.15 Referral Events (Mandatory)

Emit:

- `ReferralCodeRegistered(referrer, code)`
- `ReferralRegistered(referrer, referred)`
- `ReferralQualificationStarted(referred, startTimestamp)`
- `ReferralQualified(referrer, referred, qualifiedTimestamp)`
- `ReferralRewardBudgetUsed(amountUSDT, amountLOOP)`
- `ReferralRewardCredited(user, amountLOOP, referralId)`
- `ReferralRewardClaimed(user, amountLOOP)`
- `ReferralRejected(referrer, referred, reasonCode)`


# 19. Anti-Abuse Controls (Sybil, Farming, Transfer Flip Prevention) — UNABRIDGED

This section consolidates all anti-abuse controls.

If you do not build this, you will be attacked and drained.

This protocol includes:

- supporter rewards
- discounts
- referrals
- LOOP incentives
- reserve support

That is enough surface area to attract exploitation.

Therefore anti-abuse must exist at the protocol level and at each program level.

---

## 19.1 Threat Model

YieldLoop anti-abuse assumes attackers will try to:

- create many wallets
- buy presale positions across wallets
- farm referral rewards
- farm discounts via badge trading
- wash trade LOOP to manipulate mint pricing
- exploit claim systems
- exploit rounding errors
- exploit time windows

---

## 19.2 Required Controls Overview

At minimum:

1) support blacklist
2) one supporter position per wallet
3) referral qualification window
4) referral reward caps
5) badge transfer safeguard
6) minimum vault participation requirement for discount/rewards
7) contract pausing and kill switches
8) event telemetry for monitoring

---

## 19.3 Sybil Resistance (Presale)

Presale-specific controls:

### 19.3.1 One Position per Wallet
Contract enforces:

- `supporterPurchased[msg.sender] == false`

### 19.3.2 Per-Wallet Limits Are Not Enough
Sybil attackers can create many wallets.

Therefore:

- implement optional off-chain heuristics
- implement on-chain minimum activity thresholds (optional)

Examples:

- require wallet age (first txn older than X days)
- require minimum BNB spent historically (optional)
- require allowlisted participation (only if needed)

Be cautious:
- avoid KYC
- avoid heavy friction
- but be prepared to block obvious farms

---

## 19.4 Referral Abuse Controls

### 19.4.1 Long Qualification Period (Already Built In)
180-day period is an anti-abuse filter.

It ensures:
- only real users qualify
- farms have high capital cost

### 19.4.2 Referral Reward Caps
Capping prevents a single referrer from draining budget.

### 19.4.3 Qualification Requires Continuous Participation
Recommended strict rule:

- referred wallet must maintain >= 300 USDT vault balance for entire window

If they exit early:
- status rejected

---

## 19.5 Discount Abuse Controls

Discount abuse happens via badge trading.

If badge is transferable, impose safeguard.

### 19.5.1 Discount Warmup on Transfer (Recommended)
If badge transferred:

- record `lastTransferTimestamp`
- discount inactive until `lastTransferTimestamp + warmupSeconds`

### 19.5.2 Discount Requires ACTIVE Vault
Discount only applies if:

- wallet has ACTIVE vault older than X days

---

## 19.6 LOOP Price Manipulation Controls

If LOOP reward conversion uses price feeds:

- enforce TWAP
- require minimum liquidity
- require multi-venue price agreement
- enforce deviation checks
- fall back to USDT claimable if price is suspicious

Attackers will try to inflate LOOP price to steal more minted LOOP if mint-based conversion exists.

This is why market-buy is preferred.

---

## 19.7 Claim System Abuse Controls

Claims can be attacked via:

- reentrancy
- repeated calls for rounding
- partial state updates

Mandatory controls:

- nonReentrant on claim functions
- update state before transferring out
- safeTransfer wrappers
- use precise accounting types
- handle decimals carefully

---

## 19.8 Blacklist System

Blacklist is required for defense.

Blacklist must:

- block discounts
- block referral rewards
- block supporter reward entitlements (if necessary)
- optionally block new vault creation

Blacklist must NOT:

- allow admin to seize funds

Blacklist update authority must be:

- multisig
- event logged
- optionally timelocked (except emergency additions)

---

## 19.9 Monitoring + Telemetry Requirements

You must track metrics to detect attacks.

Emit events for:

- repeated execution rejects
- repeated claim failures
- abnormal referral registrations
- abnormal supporter purchases
- badge transfer spikes
- LOOP price deviation spikes

This provides early warning and supports incident response.

---

## 19.10 Incident Response Controls

Protocol must support:

- pausing presale
- pausing referral program
- disabling discounts temporarily
- disabling LOOP reward conversion
- disabling minting
- disabling a token route
- disabling a DEX venue

These should be independent switches, not “one big kill switch.”

---

## 19.11 Anti-Abuse Disclosures

UI must disclose:

- abuse may result in reward loss
- referral rewards may be denied for abuse
- discounts may be disabled for suspicious wallets
- programs may pause at any time
- decisions are rule-based and recorded on-chain

---

# 20. Admin Controls + Timelock + Emergency Pause — UNABRIDGED

This section defines how YieldLoop can be operated safely without becoming custodial.

The entire point is:

- the protocol must be able to survive emergencies
- without allowing an admin to steal funds
- without allowing governance to become a “rug lever”

So admin powers must be narrow, explicit, timelocked, and auditable.

---

## 20.1 Governance/Admin Model (Plain English)

YieldLoop will have protocol operators.

They are allowed to:

- turn off risky features quickly (pause execution)
- adjust bounded safety parameters (within ranges)
- update allowlists (add/remove routes)
- upgrade contracts through a timelock

They are not allowed to:

- withdraw user principal
- reassign user balances
- steal profits
- bypass accepted user configs

YieldLoop must remain non-custodial.

---

## 20.2 Governance Structure (Recommended)

Use a multi-layer governance structure:

1) **Multisig Admin** (fast emergency control)
2) **Timelock Governor** (all non-emergency changes)
3) **Emergency Council** (optional, limited to pause)

This keeps you alive while preserving user trust.

---

## 20.3 Admin Powers (Allowed)

Admin/governance MAY:

### 20.3.1 Set Safety Config Bounds
Admin sets parameter bounds for:

- max slippage
- max impact
- max oracle deviation
- max gas
- min net profit threshold
- exposure caps
- drawdown caps
- rate limits
- peg deviation caps

These should be enforceable by config module.

### 20.3.2 Update Allowlists
Admin may update allowlists for:

- tokens
- DEX venues
- routers
- pools/routes
- keepers (if allowlisted)

All allowlist updates should emit events.

### 20.3.3 Pause Execution
Admin must be able to pause:

- globally
- per token
- per DEX
- per router
- per vault (optional)

Pausing stops execution, not claims.

### 20.3.4 Force Unwind (Bounded)
Admin may be allowed to force unwind inventory back to USDT if:

- severe exploit risk exists
- peg risk exists
- DEX exploit exists

Force unwind must:

- be bounded
- be constrained by slippage caps
- never route funds out of user vault
- only rotate inventory back into USDT inside vault

### 20.3.5 Upgrade Contracts (Timelock Only)
Upgrades may happen only via timelock.

No instant upgrades.

---

## 20.4 Admin Powers (Forbidden)

Admin/governance must NOT be able to:

- withdraw user principal
- withdraw user claimable balances
- mint LOOP arbitrarily
- change user vault configs silently
- move funds between users
- disable claim functions except in catastrophic chain conditions

If the system allows any of these, it is custodial and trust collapses.

---

## 20.5 Timelock Requirements (Build Requirement)

All non-emergency changes must pass through a timelock.

Timelock ensures:

- public notice period
- time for community review
- time for bots to detect malicious changes
- time for users to exit if needed

### 20.5.1 What Must Be Timelocked
Timelock must protect:

- contract upgrades
- config bound updates
- allowlist changes (except emergency disables)
- fee receiver changes
- reserve parameter changes
- mint cap changes
- referral budget changes
- discount rules changes

### 20.5.2 Timelock Delay Window
A reasonable delay:

- 24–72 hours

Emergency actions (pause/disable) do not require delay.

---

## 20.6 Emergency Powers

Emergency powers exist to stop catastrophe quickly.

Emergency actions MUST include:

- Global pause
- Disable token
- Disable DEX
- Disable router
- Disable minting
- Disable referral program
- Disable supporter presale (if active)

Emergency powers MUST NOT include:

- withdraw user funds
- drain reserve to admin
- change fee routing to admin instantly

---

## 20.7 Upgrade Safety and Versioning

Every upgrade must:

- increment protocol version
- record upgrade hash
- emit event

Vaults must track:

- codeVersion
- acceptedConfigHash

If upgrades change strategy behavior:

- vault must be forced back to PENDING_ACCEPTANCE
- user must re-accept

This prevents bait-and-switch changes.

---

## 20.8 Admin Event Telemetry (Mandatory)

Emit events for:

- `ConfigBoundsUpdated(oldHash, newHash)`
- `AllowlistUpdated(category, item, enabled)`
- `GlobalPaused(reasonCode)`
- `GlobalUnpaused()`
- `TokenPaused(token, reasonCode)`
- `TokenUnpaused(token)`
- `DexPaused(dex, reasonCode)`
- `DexUnpaused(dex)`
- `RouterPaused(router, reasonCode)`
- `RouterUnpaused(router)`
- `ForceUnwindRequested(vaultId, reasonCode)`
- `ForceUnwindCompleted(vaultId, usdtOut)`
- `UpgradeQueued(newImplementation, eta)`
- `UpgradeExecuted(newImplementation)`

---

# 21. Security Model (MEV, Oracle Sanity, DEX Risks, Keeper Failure) — UNABRIDGED

This section describes the real-world security model.

YieldLoop is exposed to:

- DEX risks
- oracle risks
- MEV
- peg risks
- governance risks
- smart contract risks

Security is not one thing.
Security is layered defense.

---

## 21.1 Security Principles

YieldLoop security principles:

1) keepers propose, contracts decide
2) no trading without guardrails passing
3) no profit unless realized in USDT net of costs
4) fees only on realized profits
5) bounded exposure limits
6) pause fast, upgrade slow (timelock)

---

## 21.2 Threat: MEV / Sandwich Attacks

### How it happens
A keeper submits a trade.
MEV bots see it and sandwich it:

- front-run pushes price against you
- you execute worse
- they back-run restore price
- they steal the slippage

### Mitigations
YieldLoop must use:

- strict minOut
- small swap sizing
- exposure caps
- optional private relays/bundle submission
- cooldown after abnormal slippage

---

## 21.3 Threat: Oracle Manipulation

Oracles can be manipulated or can fail.

### Mitigations
- TWAP price use
- deviation bounds vs DEX spot
- staleness enforcement
- fail closed (reject execution)

If oracle fails:
- no trading

---

## 21.4 Threat: DEX Pool Manipulation

Attackers can manipulate pool liquidity briefly.

### Mitigations
- min liquidity threshold
- max price impact threshold
- cross-venue checks
- do not trade on small pools

---

## 21.5 Threat: DEX Exploit / Router Exploit

DEX routers can be exploited.

### Mitigations
- allowlist routers only
- ability to disable DEX instantly
- emergency pause
- force unwind to USDT if safe

---

## 21.6 Threat: Peg Depeg Risk

Binance-Peg assets can deviate.

### Mitigations
- peg deviation guardrail
- disable token on deviation
- unwind inventory exposure
- require conservative exposure caps

---

## 21.7 Threat: Keeper Failure

If keepers fail:

- protocol stops executing
- vault remains safe
- claims remain available

This is acceptable.

YieldLoop must never require keepers for solvency.

---

## 21.8 Threat: Smart Contract Bugs

This is always a risk.

Mitigations:

- strong modular design
- unit tests and fuzzing
- invariant testing
- audit by SourceHat or other auditor
- emergency pause
- gradual rollout

---

## 21.9 Threat: Governance/Admin Abuse

If governance can steal funds, protocol is dead.

Mitigations:

- no admin withdrawal routes
- timelock for upgrades
- multisig
- separate emergency pause from upgrade authority
- event telemetry

---

## 21.10 Security Disclosure Requirements

UI must disclose:

- smart contract risk
- DEX risk
- oracle risk
- MEV risk
- peg risk
- no insurance

Users accept these at strategy checkpoint.

---

## 21.11 Incident Handling Process (Recommended)

Protocol should define:

- detection triggers (events)
- pause procedure
- comms procedure
- bug bounty policy
- upgrade patch process
- post-mortem

This is not optional if you want to be taken seriously.

---

# 22. Risks + Disclosures (No Guarantees, No Insurance, No Fake Yield) — UNABRIDGED

YieldLoop is a risk product.

Users must be told this clearly.

This section must be included in UI and in documentation.

---

## 22.1 No Guarantee of Profit

YieldLoop does not guarantee:

- profit
- APY
- income
- stability

The strategy may produce profits, losses, or idle time.

---

## 22.2 Principal Can Be Lost

Users can lose principal due to:

- market volatility
- token depeg
- DEX exploit
- smart contract bug
- oracle errors
- MEV degradation

---

## 22.3 No Insurance

YieldLoop does not provide insurance.

If users want insurance they must use external products.

---

## 22.4 Execution Risk

Even safe-looking opportunities can fail because:

- slippage changes instantly
- liquidity changes
- MEV attacks
- gas spikes

YieldLoop rejects most trades.
It will idle often.
That is by design.

---

## 22.5 Protocol Pause Risk

If the protocol pauses:

- execution stops
- user funds remain in vault
- claim may remain available
- exit may require unwind if inventory exists

---

## 22.6 LOOP Token Risk

If user chooses LOOP rewards:

- LOOP is volatile
- LOOP price can fall
- LOOP liquidity can collapse
- LOOP redemption support can pause
- LOOP rewards may fallback to USDT claimable

---

## 22.7 Regulatory Risk

Users must understand:

- regulations may change
- jurisdictions differ
- protocol may restrict access in future

YieldLoop does not provide legal advice.

---

## 22.8 User Responsibility Disclaimer

Users are responsible for:

- understanding DeFi risks
- wallet security
- private key security
- tax reporting

---

## 22.9 UI Acceptance Requirement

Before activation, user must accept:

- fee terms
- risk disclosures
- guardrails summary

This is the strategy accept/decline checkpoint.

---

# 23. Glossary — UNABRIDGED

This glossary defines every critical term used in YieldLoop documentation and contracts.

A developer must treat these definitions as canonical.

A lay person must be able to read these and understand what the system is doing.

---

## 23.1 Accounting Terms

### Principal
The original USDT amount deposited by the user that constitutes their base capital.

Principal is not profit.
Principal is not yield.

Principal is never charged performance fees.

### Profit
A positive net increase in vault USDT holdings that occurs only after a completed execution cycle and only after deducting all costs.

Profit must be:
- realized
- net of costs
- auditable

### Realized Profit
Profit that exists as actual USDT owned by the vault.

It is not:
- a mark-to-market gain
- an oracle valuation increase
- a paper profit estimate

### Gross Profit
Profit before deducting costs such as:

- gas/execution costs
- slippage
- DEX fees
- protocol-defined overhead

Gross profit is not eligible for fee charging.

Only net profit is.

### Net Profit
Gross profit minus:

- DEX fees
- slippage impacts (realized execution degradation)
- gas/execution costs (ECW or direct)

Net profit is the only profit that matters.

### Profit Buffer
A dedicated accounting bucket/contract where realized profit is routed after execution.

Profit Buffer exists so:

- principal stays clean
- profit cannot be double counted
- claiming becomes deterministic
- compounding logic becomes deterministic

### Claimable Balance
The portion of realized profit that is owed to the user and withdrawable now.

Claimable balance is tracked per vault.

Claimable balance can be:

- USDT (if reward mode USDT)
- LOOP (if reward mode LOOP)

### Compound Balance
The portion of realized profit that is allocated to reinvestment based on the user’s compound rate.

Compound balance remains in the vault’s execution capital pool but remains separately tracked from principal.

### Performance Fee
A fee charged only on realized net profit.

It is not a deposit fee.
It is not a withdrawal fee.
It is not a principal tax.

### Fee Router
A contract module that:

- computes fees
- applies discounts
- routes fees to configured receivers

### Fee Receiver
A protocol address/contract that receives routed fees.

Examples:
- dev/treasury
- marketing budget
- reserve
- ECW replenishment

---

## 23.2 Strategy Terms

### Band/Grid Trading
A conservative execution approach where the system trades within pre-defined price/spread bands.

Rather than betting on direction, it:

- trims winners
- accumulates laggards
- rotates exposure

### Rotation
The act of swapping from an overweight asset into an underweight asset.

Example:
- BTCB runs up relative to SOL and XRP
- system sells some BTCB into USDT
- system buys SOL/XRP

### Spread
The relative difference between assets that creates rebalancing opportunity.

YieldLoop does not rely on:
- price prediction
- directional bets

It relies on:
- relative movement differences
- volatility-induced divergence and mean reversion

### Allowlist
A restricted set of tokens/routers/DEXs that YieldLoop is allowed to use.

If not allowlisted:
- execution must reject

### Execution Plan
A proposed trade route submitted by a keeper, including:

- tokenIn/tokenOut
- amountIn
- minOut
- router
- deadline

The vault validates and executes only if safe.

---

## 23.3 Token / Reward Terms

### LOOP
The YieldLoop BEP-20 protocol token used for:

- discount incentives
- reward payout option
- reserve-linked mechanics

LOOP has:
- no governance rights
- no equity rights

### Reward Mode
A per-vault configuration choice:

- USDT rewards (20% fee)
- LOOP rewards (17.5% fee)

### Discount Stack
The total reductions applied to the performance fee rate based on:

- SupporterBadge
- optional future tiers
- policy-defined campaigns

Discounts are bounded by:
- a minimum final fee rate

### Supporter Airdrop
The one-time LOOP allocation delivered to presale supporters based on:

- 100 USDT allocation
- 1.025 bonus

---

## 23.4 Risk / Security Terms

### MEV (Miner/Maximal Extractable Value)
An ecosystem threat where bots:

- front-run trades
- sandwich trades
- extract slippage

MEV risk increases as swap size increases.

### Slippage
The loss in expected swap output due to:

- price impact
- pool movement
- MEV

### Oracle
A price feed used to sanity-check execution.

Oracles can be:
- external
- TWAP-based
- multi-venue

### TWAP
Time Weighted Average Price.

TWAP is used to reduce manipulation.

### Peg Risk
Risk that pegged tokens (BTCB/SOL/XRP) deviate from their intended reference price due to:

- bridge failure
- issuer risk
- market disruption
- liquidity collapse

### Drawdown
A measure of loss from a prior peak.

Used for safety pausing/unwinding.

### Emergency Pause
A protocol control that disables trading/execution in response to risk.

Claims should remain enabled if possible.

---

## 23.5 Program Terms

### Supporter
A wallet that joined the supporter presale and holds a SupporterBadge NFT.

### SupporterBadge
A BEP-721 NFT used for:

- on-chain supporter verification
- fee discount verification
- Discord role verification
- referral eligibility

### Referral
A program where a supporter invites a new user.

Rewards are paid only after 180 days of qualification.

### Qualification Window
The 180-day continuous participation period required for referral rewards.

---

# 24. Appendices (Interfaces, Events, State Machine, Config Ranges) — UNABRIDGED

The appendices are not optional. They are the implementation blueprint.

This section defines:

- the contract set
- contract responsibilities
- function interfaces
- event catalog
- state machine requirements
- strategy config ranges
- reason codes

---

## 24.1 Canonical Contract Set (Required)

YieldLoop must contain these contracts/modules.

### 24.1.1 Core Vault System
- `VaultFactory` OR `VaultManager`
  - creates vaults
  - enforces config acceptance checkpoint
  - tracks vault ownership

- `UserVault` OR vault storage module
  - holds user funds (USDT + inventory)
  - contains vault state machine
  - enforces execution validation

### 24.1.2 Strategy System
- `StrategyEngine`
  - computes band/grid rebalancing logic
  - provides execution recommendations (optional)
  - defines allowed token set and weighting targets

### 24.1.3 Execution System
- `ExecutionRouter` OR integrated into vault
  - executes swaps through allowlisted routers
  - applies slippage protections

- `KeeperRegistry` (optional)
  - allowlists keepers
  - tracks keeper performance

### 24.1.4 Guardrail System
- `OracleAdapter` (recommended)
  - reads TWAP feeds
  - reads oracle feeds if available
  - validates staleness and deviation

- `GuardrailEngine` (optional)
  - shared checks
  - reason codes
  - safety flag management

### 24.1.5 Profit and Fees
- `ProfitBuffer` OR `ClaimLedger`
  - holds claimable balances
  - tracks compound balances

- `FeeRouter`
  - computes fees
  - applies discounts
  - routes fees

### 24.1.6 Token System
- `LoopToken` (BEP-20)
- `LoopMinter`
- `ReserveVault`
- `ReserveController`

### 24.1.7 Programs
- `SupporterPresale`
- `SupporterBadge` (BEP-721)
- `ReferralRegistry`
- `ReferralClaimLedger` (optional but recommended)

### 24.1.8 Governance + Admin
- `TimelockController`
- `MultisigAdmin`
- `EmergencyPauseModule`

---

## 24.2 Minimal Function Interface (Developer Blueprint)

This list is a build checklist.

### VaultFactory / VaultManager
- `createVault(amountUSDT, rewardMode, compoundRateBps, configHash) -> vaultId`
- `getVaultOwner(vaultId)`
- `getVaultConfig(vaultId)`
- `setCompoundRate(vaultId, newRateBps)`
- `setRewardMode(vaultId, newMode)` (optional)
- `acceptStrategy(vaultId)`
- `declineStrategy(vaultId)`

### UserVault
- `execute(vaultId, ExecutionPlan plan)`
- `claim(vaultId)`
- `pauseVault(vaultId)` (optional for user)
- `requestExit(vaultId)` (policy dependent)
- `getBalances(vaultId)` (principal/claimable/compound/inventory)

### FeeRouter
- `computeFee(vaultId, profitUSDT) -> feeUSDT`
- `computeDiscountBps(user) -> discountBps`
- `routeFee(feeUSDT)`

### ProfitBuffer / ClaimLedger
- `creditClaimable(vaultId, asset, amount)`
- `creditCompound(vaultId, amountUSDT)`
- `getClaimable(vaultId, asset)`
- `claim(vaultId, asset)`

### StrategyEngine
- `getTargets(configHash) -> weights`
- `computeRotation(vaultId) -> suggestedPlan`
- `validatePlan(plan) -> bool`

### SupporterPresale
- `supporterDeposit()`
- `claimSupporterAirdrop()`
- `getSupporterStatus(address)`

### SupporterBadge
- `balanceOf(address)`
- `ownerOf(tokenId)`
- `tokenURI(tokenId)`

### ReferralRegistry
- `registerReferralCode(code)`
- `setReferrer(referred, code)` (first deposit only)
- `checkQualification(referred)`
- `creditReferralRewards(referred)` (if qualified)
- `claimReferralRewards()`

---

## 24.3 ExecutionPlan Struct (Canonical)

```solidity
struct ExecutionPlan {
  address router;
  address tokenIn;
  address tokenOut;
  uint256 amountIn;
  uint256 minOut;
  uint256 deadline;
  bytes routeData; // optional
}

24.4 Vault State Machine (Canonical)

States:
	•	CREATED
	•	PENDING_ACCEPTANCE
	•	ACTIVE
	•	PAUSED
	•	EXIT_REQUESTED / UNWINDING
	•	CLOSED

Required transitions:
	•	CREATED -> PENDING_ACCEPTANCE (after deposit accepted)
	•	PENDING_ACCEPTANCE -> ACTIVE (acceptStrategy)
	•	PENDING_ACCEPTANCE -> CLOSED (declineStrategy + withdraw)
	•	ACTIVE -> PAUSED (guardrail / admin / user)
	•	ACTIVE -> EXIT_REQUESTED (requestExit)
	•	EXIT_REQUESTED -> CLOSED (inventory unwound and principal withdrawn)

⸻

24.5 Reason Code Catalog (ExecutionRejected)

YieldLoop must standardize reason codes.

Examples:
	•	VAULT_NOT_ACTIVE
	•	CONFIG_MISMATCH
	•	SYSTEM_PAUSED
	•	TOKEN_DISABLED
	•	DEX_DISABLED
	•	ROUTER_DISABLED
	•	ORACLE_STALE
	•	ORACLE_DEVIATION_TOO_HIGH
	•	VENUE_PRICE_DEVIATION
	•	LOW_LIQUIDITY
	•	SLIPPAGE_TOO_HIGH
	•	MEV_RISK_TOO_HIGH
	•	EXECUTION_COST_TOO_HIGH
	•	RATE_LIMIT
	•	EXPOSURE_LIMIT
	•	PEG_RISK
	•	DRAWDOWN_LIMIT
	•	UNWIND_IN_PROGRESS

⸻

24.6 Config Parameter Ranges (Bounded)

All parameters must be bounded.

Example strategy config fields:
	•	minNetProfitUSDT
	•	maxSlippageBps
	•	maxImpactBps
	•	maxOracleDeviationBps
	•	maxVenueDeviationBps
	•	maxPegDeviationBps
	•	maxGasPrice
	•	maxExecutionCostUSDT
	•	profitToCostMultiplier
	•	maxExposureBpsPerAsset
	•	maxTradesPerHour
	•	cooldownSeconds
	•	maxDrawdownBps
	•	maxLossStreak

⸻

24.7 Appendix Events (Canonical)

Canonical events include:
	•	VaultCreated
	•	StrategyAccepted
	•	StrategyDeclined
	•	ExecutionAttempted
	•	ExecutionRejected
	•	ExecutionCompleted
	•	ProfitBuffered
	•	FeeCharged
	•	FeeRouted
	•	Claimed
	•	CompoundRateUpdated
	•	RewardModeUpdated
	•	SupporterDeposit
	•	SupporterBadgeMinted
	•	ReferralRegistered
	•	ReferralQualified
	•	ReferralRewardCredited
	•	ReferralRewardClaimed
	•	GlobalPaused
	•	UpgradeQueued
	•	UpgradeExecuted

