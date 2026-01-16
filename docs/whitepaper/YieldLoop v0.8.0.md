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
