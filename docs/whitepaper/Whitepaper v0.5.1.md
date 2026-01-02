# YieldLoop  
## A Monthly Cycle–Based Execution, Settlement, and Redemption System for Decentralized Finance

**Author:** Todd Koletsky  
**Date:** January 1, 2026  
**Version:** v0.5.1  

---

## Table of Contents

1. Forward — What YieldLoop Is (and Is Not)  
2. Core Principles and Invariants  
3. System Overview  
4. User Vaults and Deposits  
5. Strategy Engines  
6. AI-Assisted Configuration  
7. Authorization and Commitment  
8. Profit Handling Modes  
9. Gas and Execution Cost Funding  
10. Monthly Cycle Rules  
11. Execution and Safety Guardrails  
12. Settlement and Inventory Handling  
13. Fees and Platform Sustainability  
14. LOOP Token and Redemption  
15. System Deposit and Reinvestment  
16. Governance and Configuration Limits  
17. Risk Disclosure and User Responsibility  
18. Long-Term System Behavior  
19. Conclusion — What Success Looks Like

---

## 1. Forward — What YieldLoop Is (and Is Not)

YieldLoop exists to solve a narrow but critical problem in decentralized finance:

**How can capital be deployed into trading and yield strategies without lying about outcomes, hiding risk, or manufacturing returns that do not exist?**

Most DeFi systems fail this test. They smooth results, project yields, emit tokens to mask losses, or quietly shift risk onto users. YieldLoop explicitly refuses to do that.

This system is built around **execution truth, settlement finality, and explicit consent**.

---

### 1.1 What YieldLoop *Is*

YieldLoop is a **monthly, cycle-based execution and settlement system** that allows users to:

- Deposit capital into an isolated vault  
- Select explicit trading or yield strategies (or allow AI to suggest them)  
- Approve all parameters in advance  
- Commit funds to a fixed, calendar-based execution window  
- Set how verified profits are handled before execution begins  
- Receive outcomes that resolve cleanly to either:
  - verified profit, or  
  - zero  

YieldLoop does not promise profit.  
It promises **honest accounting**.

Every cycle has:
- a defined start
- a defined end
- deterministic settlement
- no mid-cycle interference
- no retroactive adjustments

If profit exists, it is proven.  
If it does not, nothing is fabricated.

---

### 1.2 What YieldLoop *Is Not*

YieldLoop is **not**:

- a savings account  
- a yield guarantee  
- an APY product  
- a passive income scheme  
- a continuously adjustable vault  
- a token emission protocol  

It does not:
- project returns  
- smooth losses  
- redistribute value between users  
- borrow against user funds  
- subsidize execution costs  
- rescue failing strategies  

YieldLoop is intentionally allowed to do **nothing** if conditions are unfavorable.

Inactivity is not a failure state.  
Dishonesty is.

---

### 1.3 Cycles as the Unit of Truth

YieldLoop treats **time-bounded cycles** as the only valid unit of measurement.

Each cycle:
- begins at a fixed calendar boundary  
- executes under locked parameters  
- ends with a single settlement event  

There is no rolling profit, no live PnL, and no mark-to-market accounting.

Profit is only recognized if it survives:
- execution
- costs
- settlement

Anything unrealized remains inventory and is excluded from profit.

Cycle Enrollment Timing
Capital deposited into YieldLoop does not enter execution immediately.
Deposits are enrolled into the next available calendar cycle only.

YieldLoop does not permit late entry, partial-cycle participation, or mid-cycle capital adjustments.
All capital committed to a cycle is known, fixed, and locked before execution begins.

---

### 1.4 Explicit Consent Over Convenience

Every meaningful action in YieldLoop requires **explicit user approval**:

- strategy selection  
- parameter bounds  
- profit split choice  
- gas and execution cost funding  
- cycle authorization  

Once a cycle begins:
- funds are locked
- strategies cannot be modified
- withdrawals are disabled
- no party can intervene  

This constraint is not a limitation — it is the foundation of fairness.

No user receives special treatment.  
No administrator can override outcomes.

---

### 1.5 Why This Design Exists

YieldLoop was designed under a simple premise:

> **A system that cannot say “no” will eventually lie.**

By enforcing:
- hard time boundaries  
- deterministic settlement  
- zero-result outcomes  
- pre-funded execution costs  
- and explicit redemption rules  

YieldLoop prioritizes survival, auditability, and long-term trust over short-term appeal.

This document defines the rules of that system.  
Nothing implied, nothing hidden, nothing softened.

The sections that follow describe **exactly how those rules are enforced**.

---

## 2. Core Principles and Invariants

YieldLoop is governed by a small set of **non-negotiable principles**.  
These principles are enforced by system design, not discretion.  
They apply uniformly to all users, strategies, and cycles.

If any future modification violates these invariants, it is not YieldLoop.

---

### 2.1 Cycles Are the Only Unit of Truth

YieldLoop recognizes **only completed cycles** as valid accounting periods.

- There is no continuous profit tracking  
- There is no live PnL  
- There is no mark-to-market valuation  

A cycle:
- starts at a defined calendar boundary  
- executes under locked parameters  
- ends once, and only once, with settlement  

Anything not settled is not profit.

---

### 2.2 Binary Profit Recognition

YieldLoop enforces **binary profit recognition**, not binary performance.

Each cycle settles exactly once and produces one of the following accounting outcomes:

1. **Verified Net Profit Exists**
2. **No Verified Net Profit Exists**

A cycle that produces no verified profit may result in:
- a zero outcome, or
- a loss outcome

YieldLoop does not fabricate gains to offset losses, does not smooth adverse results, and does not assume recovery.

Profit is recognized only if it survives:
- execution,
- gas and trade costs,
- protocol fees, and
- settlement rules.

If verified profit does not exist at settlement, it does not exist at all.

---

### 2.3 No Assumed Yield

YieldLoop does not:
- promise yield  
- target APY  
- smooth returns  
- offset losses with emissions  

Profit must be earned through execution.  
If conditions do not allow profit, the system remains idle or resolves to zero.

This is intentional.

---

### 2.4 Explicit Consent Is Required for All Risk

No capital is ever placed at risk without **prior, explicit approval**.

Users must approve:
- strategy selection  
- execution parameters  
- profit split handling  
- gas and execution cost funding  
- cycle authorization  

Approval is granular and binding.

Silence is not consent.  
Defaults do not imply permission.

---

### 2.5 Locked Execution, No Mid-Cycle Intervention

Once a cycle begins:

- funds are locked  
- parameters are immutable  
- strategies cannot be changed  
- withdrawals are disabled  
- administrators cannot intervene  
- governance cannot intervene  

This applies equally to:
- profitable cycles  
- losing cycles  
- stalled cycles  

The system does not react emotionally to outcomes.

---

### 2.6 No Hidden Subsidies, No Debt

YieldLoop never:
- borrows against user principal  
- borrows against expected profit  
- borrows against system reserves  
- creates negative balances  
- subsidizes execution costs  

All execution costs must be **pre-funded** by the user.

If execution costs are exhausted:
- execution halts  
- settlement proceeds  
- no debt is created  

---

### 2.7 Separation of Concerns

YieldLoop enforces strict separation between:

- user capital  
- execution logic  
- accounting records  
- platform fees  
- system deposits  
- LOOP token mechanics  

No component may silently depend on another.

This prevents:
- cross-subsidization  
- hidden liabilities  
- circular accounting  
- incentive distortion  

---

### 2.8 Determinism Over Optimization

YieldLoop prefers:
- predictability over aggressiveness  
- determinism over optimization  
- correctness over speed  

If a strategy cannot operate within defined bounds, it is not permitted.

The system is allowed to:
- halt  
- wait  
- do nothing  

Survival is a valid strategy.

---

### 2.9 Prospective Change Only

All changes to YieldLoop:
- apply only to future cycles  
- never retroactively alter outcomes  
- never rewrite settlement history  

Completed cycles are final.

There are no re-runs, reversals, or discretionary corrections.

---

### 2.10 These Invariants Are Not Configurable

The principles in this section:
- cannot be toggled  
- cannot be overridden  
- cannot be waived  
- cannot be voted away  

They define the boundary between:
- an execution system  
- and a discretionary fund  

YieldLoop exists on one side of that boundary — deliberately.

---

## 3. System Overview

YieldLoop is composed of a small number of clearly separated components that interact in a fixed, deterministic sequence.  
Each component has a single responsibility.  
No component may override or compensate for another.

At a high level, YieldLoop operates as a **monthly execution pipeline**:

> Deposit → Configure → Authorize → Execute → Settle → Redeem or Reinvest

---

### 3.1 Primary System Components

YieldLoop consists of the following core components:

- **User Vaults**  
- **Strategy Engines**  
- **AI Configuration Layer**  
- **Execution Cost Wallet (ECW)**  
- **Cycle Scheduler**  
- **Settlement Engine**  
- **Fee and System Deposit Router**  
- **LOOP Accounting and Redemption Module**

Each is described briefly below and in detail in later sections.

---

### 3.1.1 Execution Model (Keepers and Automation)

YieldLoop execution is performed by **automated transaction submitters** (“keepers”).

Smart contracts do not initiate transactions autonomously.  
All execution actions require a valid transaction to be submitted to the blockchain.

Keepers are responsible only for:
- submitting execution transactions when permitted by contract rules
- calling strategy functions within approved bounds
- respecting execution timing and safety constraints

Keepers:
- do not control strategy logic
- do not select parameters
- do not assume profitability
- cannot move funds outside approved paths
- cannot override settlement or guardrails

Execution functions are deterministic and permissioned by contract state.  
Any keeper submitting a valid transaction receives the same result.

If execution conditions are not satisfied:
- transactions revert, or
- execution halts conservatively

YieldLoop does not rely on discretionary human intervention for execution.

---

### 3.2 User Vaults

Each user interacts with YieldLoop through an **isolated vault**.

A vault:
- holds user principal
- holds realized profits
- holds inventory (unsettled positions)
- cannot access other vaults
- cannot be pooled with other users

Vaults move through defined states:
- **Idle**
- **Configured**
- **Authorized**
- **Executing**
- **Settled**

State transitions are one-directional per cycle and cannot be skipped.

---

### 3.3 Strategy Engines

Strategy engines are modular execution units that operate **only within approved bounds**.

Key characteristics:
- No leverage
- No borrowing
- No derivatives
- No open-ended execution
- No strategy may roll positions across cycles without reauthorization

Strategy engines **do not**:
- assume profitability
- share state across vaults
- compensate for losses
- override settlement rules

If a strategy cannot execute within constraints, it halts.

---

### 3.4 AI Configuration Layer

The AI layer exists **only before execution**.

Its role is limited to:
- suggesting strategy selections
- proposing parameter ranges
- estimating execution cost requirements

The AI layer:
- cannot authorize execution
- cannot modify approved parameters
- cannot intervene mid-cycle
- cannot override safety rules

All AI output is advisory.

---

### 3.5 Execution Cost Wallet (ECW)

Execution costs are funded through a **separate wallet** attached to each vault.

The ECW:
- is pre-funded by the user
- pays gas and trade fees
- cannot borrow from principal
- cannot borrow from profit
- cannot borrow from system reserves

If the ECW balance reaches zero:
- execution halts
- settlement proceeds
- no debt is created

---

### 3.6 Cycle Scheduler

YieldLoop operates on fixed **calendar-based cycles**.

- Cycles begin on the **first day of the month**
- Cycles end on the **last day of the month**
- No mid-cycle entry
- No mid-cycle exit
- No rolling execution

This enforces:
- consistent accounting periods
- deterministic settlement
- comparability across cycles

---

### 3.7 Settlement Engine

Settlement occurs **once per cycle**.

The settlement engine:
- halts all execution
- computes realized balances
- deducts verified costs
- determines whether profit exists

Settlement does not:
- mark inventory to market
- assume future value
- smooth outcomes

Profit either exists or it does not.

---

### 3.8 Fees and System Deposits

If verified profit exists:
- a performance fee is applied
- fees are routed to defined categories
- system deposits are handled immutably

If no profit exists:
- no fees are taken

Fees are never charged against principal.

---

### 3.9 LOOP Accounting and Redemption

LOOP is minted **only after settlement** and only for **verified retained profit**.

LOOP:
- represents settled surplus
- is not pre-minted
- is not emitted
- may be redeemable (subject to liquidity rules)

Redemption:
- converts LOOP into USDT
- is bounded by available liquidity
- may be paused
- is never guaranteed in timing

---

### 3.10 System Flow Summary

At no point does YieldLoop:
- fabricate profit
- subsidize losses
- assume favorable conditions
- hide risk
- rewrite history

Each cycle stands alone.

The sections that follow define **exactly how users interact with this system** and how each component enforces these rules.

---

## 4. User Vaults and Deposits

User vaults are the fundamental control boundary in YieldLoop.  
All execution, accounting, settlement, fee handling, and redemption logic operates **within the scope of an individual vault**.

There is no pooled execution and no shared risk between users.

---

### 4.1 Vault Creation

A vault is created when a user makes an initial deposit.

Each vault:
- is uniquely associated with a single user
- is isolated from all other vaults
- maintains its own balances, state, and execution history
- cannot be merged or split mid-cycle

Vault creation does not initiate execution and does not imply consent to risk.

---

### 4.2 Supported Deposit Assets

YieldLoop supports the following deposit assets:

- **USDT**
- **LOOP** (if redemption is enabled, accepted at current redemption value)

All deposits are validated on-chain before being credited to the vault.

---

### 4.3 External Deposit Minimums

YieldLoop enforces a **minimum external deposit amount**.

Any deposit made into a vault — whether in USDT or LOOP — must meet a minimum value threshold.

At launch, the minimum external deposit is expected to be **approximately $100 USDT (or equivalent in LOOP)**, subject to adjustment by the YieldLoop team or future governance.

This minimum exists to:
- ensure execution and settlement are economically viable
- prevent excessive gas consumption on trivial balances
- reduce failed or halted executions
- preserve honest, deterministic outcomes

Deposits below the minimum are **not accepted** and will not be credited to a vault.

This requirement applies uniformly to:
- initial deposits
- subsequent top-up deposits
- deposits made for future cycles

---

### 4.4 Vault States

Each vault progresses through a defined set of states during a cycle:

1. **Idle**  
   - Funds deposited  
   - No strategy selected  
   - Full withdrawal available  

2. **Configured**  
   - Strategies selected  
   - Parameters defined  
   - No execution yet  
   - Full withdrawal available  

3. **Authorized**  
   - Strategy approved  
   - Profit split selected  
   - Execution Cost Wallet funded  
   - Withdrawals disabled  
   - Awaiting cycle start  

4. **Executing**  
   - Cycle is active  
   - Strategies execute within approved bounds  
   - Funds locked  
   - No user, administrative, or governance intervention  

5. **Settled**  
   - Cycle execution complete  
   - Settlement finalized  
   - Vault unlocked  
   - Withdrawals enabled  

State transitions are linear per cycle and cannot be skipped.

---

### 4.5 Deposit Timing Rules

- Deposits may be made **only when a vault is Idle or Configured**
- Deposits made after authorization apply to the **next cycle**
- Deposits made during execution do not alter the active cycle

YieldLoop does not partially enroll capital into an active cycle.

---

### 4.6 Withdrawals

Withdrawals are governed strictly by vault state:

- **Idle / Configured:**  
  - Full withdrawal allowed  
  - No penalties  

- **Authorized / Executing:**  
  - Withdrawals disabled  
  - Funds are locked until settlement  

- **Settled:**  
  - Full withdrawal allowed  
  - Subject to profit handling and redemption rules  

There is no emergency exit mechanism during execution.

This lock is:
- time-bounded
- disclosed in advance
- applied uniformly to all users

---

### 4.7 Execution Cost Wallet (ECW)

Each user vault includes a dedicated **Execution Cost Wallet (ECW)** used exclusively to fund execution-related costs.

The ECW:
- is pre-funded by the user
- pays blockchain gas costs and execution-related fees
- is strictly separate from principal and profits
- cannot borrow from any other balance
- cannot create debt under any circumstance

#### Minimum Funding Requirement

At launch, each vault must maintain a **minimum ECW balance of approximately $10 USDT (or equivalent)**.

A vault cannot be authorized for a cycle unless this minimum is met.

#### Low-Balance and Exhaustion Behavior

If the ECW balance falls below a defined low threshold (expected to be approximately **$2.50 USDT equivalent**):

- execution for that vault may pause
- no new trades are initiated
- existing positions are not forcibly closed

If the ECW balance is fully exhausted:

- all execution halts immediately
- no borrowing occurs
- no debt is created
- settlement proceeds using realized results only

Execution halting due to ECW exhaustion is a valid system outcome.

#### User Notification

Low ECW balance conditions may trigger off-chain notifications (e.g., email or in-app alerts).  
Notification mechanisms do not affect on-chain behavior.

#### ECW Balances After Settlement

After settlement completes:
- any unused ECW balance remains under user control
- ECW funds may be withdrawn or reused for future cycles

If a vault is permanently closed:
- unused ECW balances are refunded to the user

---

### 4.8 Inventory Handling Within Vaults

Unsettled positions at cycle end are classified as **inventory**.

Inventory:
- is held within the vault
- is not marked to market
- does not count as profit
- requires explicit reauthorization to participate in a new cycle

---

### 4.9 Vault Isolation Guarantees

YieldLoop guarantees that:

- no vault subsidizes another vault
- no losses are socialized
- no profits are redistributed
- no execution state is shared

Each vault stands alone.

This isolation is fundamental to system integrity, auditability, and user trust.

---

## 5. Strategy Engines

Strategy engines are the **only components authorized to deploy user capital** during an active cycle.  
They operate exclusively within user-approved bounds and are subject to strict safety constraints.

No strategy is allowed to:
- assume profit
- borrow capital
- use leverage
- roll positions across cycles without reauthorization
- override settlement rules

If a strategy cannot operate within its constraints, it must halt.

---

### 5.0.1 Position Closure and Carryover Rules

Strategy engines are designed to **attempt orderly position closure** prior to cycle end.

However, YieldLoop **does not permit forced liquidation at a loss** solely to satisfy a time boundary.

If a position cannot be closed profitably or safely within approved execution bounds before the cycle end:

- the position remains open
- the exposure is classified as **inventory**
- the inventory is carried forward conservatively
- no profit is recognized from the position
- no mark-to-market valuation is applied

Carried inventory:
- remains isolated within the user vault
- does not execute further without future authorization
- does not generate profit until realized
- does not affect settlement of the closing cycle

YieldLoop prioritizes truthful accounting over cosmetic closure.

---
### 5.1 Strategy Design Philosophy

All strategy engines share the same foundational principles:

- **Bounded execution** — every action has explicit limits  
- **Deterministic behavior** — no discretionary decision-making mid-cycle  
- **Capital isolation** — each vault is independent  
- **No dependency on future states** — only current-cycle conditions matter  

Strategies are tools, not promises.

---

### 5.2 Directional Trading Engine

**Purpose:**  
Capture defined price movements within a bounded range.

**Supported behaviors:**
- Buy-low / sell-high
- Fixed percentage take-profit targets
- Grid trading within defined bands
- Optional martingale-style scaling (explicitly capped)

**Required parameters:**
- Capital allocation percentage
- Entry conditions
- Take-profit thresholds
- Maximum scaling depth (if enabled)
- Hard stop-loss bounds

**Safety guardrails:**
- No leverage
- No borrowing
- Maximum drawdown enforced
- Maximum position size enforced
- Forced halt if bounds are breached
- No open positions allowed past cycle end

---

### 5.3 Arbitrage Engine

**Purpose:**  
Exploit deterministic price discrepancies across approved venues.

**Supported behaviors:**
- DEX-to-DEX arbitrage
- Stable asset imbalance routing
- Explicit route allowlists only

**Required parameters:**
- Approved venues
- Minimum spread threshold
- Maximum capital allocation
- Maximum retries per opportunity

**Safety guardrails:**
- Spread must exist **before** execution
- No speculative routing
- No chained arbitrage
- Immediate halt if spread collapses
- No execution if gas cost exceeds expected return

---

### 5.4 Yield Farming Engine

**Purpose:**  
Earn protocol-native yield during the active cycle.

**Supported behaviors:**
- Liquidity provision to allowlisted protocols
- Fixed-duration farming
- Single-cycle exposure only

**Required parameters:**
- Approved protocol
- Capital allocation
- Entry and exit timing

**Safety guardrails:**
- No auto-compounding
- No emissions masking losses
- All rewards must settle into USDT
- Forced exit before cycle end
- If yield does not survive costs → zero-result cycle

---

### 5.5 Stable Asset Strategy Engine

**Purpose:**  
Preserve capital while seeking conservative yield.

**Supported behaviors:**
- Stable asset routing
- Conservative yield mechanisms
- Fixed exposure

**Required parameters:**
- Asset selection
- Capital allocation
- Duration constraints

**Safety guardrails:**
- Stable assets only
- No derivatives
- No leverage
- Same settlement rules as all other strategies

There is no special treatment for “safe” strategies.

---

### 5.6 Strategy Allocation Rules

Users may allocate capital across multiple strategies within a single cycle, subject to:

- Total allocation ≤ 100%
- Explicit approval of each allocation
- Strategy-specific minimums and maximums

Unallocated capital remains idle and unexposed.

---

### 5.7 AI-Assisted Strategy Configuration

Users may optionally allow the AI layer to:

- suggest strategy selection
- propose parameter ranges
- estimate execution cost requirements
- identify constraint conflicts

AI suggestions:
- are non-binding
- must be explicitly approved
- cannot modify parameters once authorized
- cannot intervene mid-cycle

AI assists configuration — it does not control execution.

---

### 5.8 Strategy Halting Conditions

A strategy must halt if:
- execution cost funds are exhausted
- defined risk bounds are breached
- required market conditions no longer exist
- protocol or venue constraints are violated

Halting a strategy does not invalidate the cycle.  
Settlement proceeds based on realized results.

---

### 5.9 Prohibited Strategy Behaviors

The following behaviors are explicitly forbidden:

- leverage of any kind
- borrowing from any source
- derivatives trading
- rolling positions across cycles
- socialized loss handling
- discretionary intervention

Any strategy requiring these behaviors is incompatible with YieldLoop.

---

Strategy engines define **what YieldLoop is allowed to do with user capital**.

The next section defines **how AI may assist without violating determinism or consent**.

---

## 6. AI-Assisted Configuration

YieldLoop includes an optional AI-assisted configuration layer designed to help users construct valid, coherent strategy configurations **without removing user control or responsibility**.

The AI layer exists to reduce configuration errors — not to optimize outcomes or assume profit.

---

### 6.1 Purpose of the AI Layer

The AI configuration layer exists to:
- assist users in selecting compatible strategies
- propose parameter ranges consistent with system constraints
- estimate execution cost requirements
- identify configuration conflicts before authorization

The AI layer is **advisory only**.

It does not execute trades, authorize risk, or intervene during a cycle.

---

### 6.2 What the AI Is Allowed to Do

The AI layer may:
- suggest one or more strategy engines
- recommend allocation percentages
- propose entry and exit bounds
- suggest take-profit ranges
- estimate required ECW funding
- warn when parameters are incompatible or unsafe

All AI output is presented as **draft configuration data**.

---

### 6.3 What the AI Is Explicitly Forbidden From Doing

The AI layer **cannot**:
- authorize a cycle
- modify user-approved parameters
- adjust strategies mid-cycle
- override safety guardrails
- bypass minimum deposit requirements
- assume profit or project returns
- intervene in execution or settlement

The AI has **no authority** once a cycle is authorized.

---

### 6.4 User Responsibility and Approval

All AI-assisted configurations require **explicit user approval**.

Before authorization, the user must:
- review all strategies
- review all parameters
- review allocation percentages
- review ECW funding requirements
- approve profit split selection

Approval is binary and binding.

If a user approves an AI-generated configuration, the responsibility for that configuration rests with the user.

---

### 6.5 AI Failure Is Not System Failure

The AI layer may:
- produce conservative suggestions
- recommend inactivity
- decline to propose strategies if conditions are unfavorable

This behavior is correct.

If the AI cannot construct a valid configuration within system constraints, it must return **no recommendation** rather than force execution.

---

### 6.6 Determinism and Auditability

AI outputs:
- do not alter execution logic
- do not affect settlement rules
- do not change accounting behavior

All approved parameters are recorded and enforced deterministically.

The AI layer cannot introduce nondeterminism into YieldLoop.

---

The AI layer exists to **assist configuration**, not to replace judgment.

The next section defines **when configuration becomes a binding commitment**.

---

## 7. Authorization and Commitment

Authorization in YieldLoop does **not** initiate execution.

YieldLoop operates on fixed, global calendar cycles.  
Execution begins and ends at the same time for all participating vaults.

Authorization represents **binding pre-approval of configuration**, not permission to start a cycle.

By authorizing a vault, a user:
- approves strategy selection and parameters
- approves capital allocation
- approves profit handling mode
- approves Execution Cost Wallet funding
- commits deposited capital to the **next available cycle**

Authorization locks configuration in advance so execution can proceed deterministically when the global cycle begins.

---

### 7.1 Preconditions for Authorization

A vault may be authorized for a cycle only if all of the following conditions are met:

- a valid external deposit meeting the minimum requirement exists  
- one or more strategy engines are configured  
- all strategy parameters are defined and within allowed bounds  
- capital allocation totals do not exceed 100%  
- a profit split option is selected  
- the Execution Cost Wallet (ECW) meets the minimum funding requirement  

If any condition is unmet, authorization is not possible.

---

### 7.2 User Approval Requirements

Authorization requires **explicit user approval**.

The user must approve:
- selected strategy engines
- all strategy parameters
- capital allocation per strategy
- profit split selection
- ECW funding level
- acknowledgment of locked funds during execution

Approval is intentional, discrete, and auditable.

There is no implicit consent and no auto-authorization.

---

### 7.3 Effect of Authorization

Once authorization is granted:

- strategy parameters are locked  
- capital allocations are locked  
- profit split selection is locked  
- withdrawals are disabled  
- execution timing is fixed  
- AI assistance is disabled for the active cycle  

No further changes are permitted until settlement completes.

Authorization cannot be revoked.

---

### 7.4 Timing of Authorization

Authorization may occur only during an **open enrollment window** prior to the start of a monthly cycle.

- Authorization after the enrollment window applies to the **next cycle**
- Authorization does not immediately start execution
- Execution begins only at the defined cycle start time

This ensures:
- predictable execution timing
- fair treatment across users
- clean accounting boundaries

---

### 7.5 Locked Funds and Fairness

Funds committed to an authorized cycle are **locked** until settlement.

There is:
- no emergency withdrawal
- no partial exit
- no discretionary release

This lock:
- is time-bounded
- applies uniformly to all users
- is disclosed before authorization

The lock exists to preserve deterministic settlement and prevent preferential treatment.

---

### 7.6 Authorization Failure Handling

If authorization fails due to:
- insufficient ECW funding
- invalid parameters
- expired enrollment window

No state change occurs.

The vault remains configurable or idle, and funds remain withdrawable.

---

### 7.7 Authorization Is the Last Point of Control

Authorization represents the final moment of user control for the cycle.

After authorization:
- execution proceeds automatically
- outcomes are determined by reality
- neither the user nor the system may intervene

This boundary defines the contract between the user and YieldLoop.

---

Authorization converts **configuration into commitment**.

The next section defines **how profits are handled once a cycle completes**.

## 8. Profit Handling Modes

YieldLoop allows users to define a **persistent profit handling mode** that governs how verified profits are treated across trades and cycles.

A profit handling mode remains in effect until explicitly changed by the user prior to authorizing a future cycle.

Profit handling does not influence execution logic and is applied only after settlement.

---

### 8.1 Available Profit Handling Modes

Before authorizing a cycle, the user must select one of the following modes:

1. Compound All  
2. Split 50 / 50  
3. Withdraw All Profits  

This selection establishes a standing instruction for profit handling.

---

### 8.0.1 Timing of Profit Handling

Profit handling modes in YieldLoop apply **only at monthly settlement**.

During an active cycle:
- strategies may close individual trades
- realized funds may be reused for further execution within the same cycle
- no profits are withdrawn, split, or compounded externally

Profit handling is evaluated **once per cycle**, after settlement finalizes and verified net profit (if any) is determined.

YieldLoop does not apply profit handling on a per-trade, per-day, or rolling basis.

---

### 8.2 Compound All

Under the **Compound All** mode:

- 100% of verified profit remains in the vault
- Profit is continuously reinvested into subsequent trades
- Capital rolls forward from trade to trade and cycle to cycle
- No profit is withdrawn
- Principal and profits form a single growing capital base

This mode maximizes capital growth and minimizes realized withdrawals.

---

### 8.3 Split 50 / 50

Under the **50 / 50** mode:

- 50% of each verified profit is removed from active capital
- 50% of each verified profit remains in the vault
- The retained portion compounds continuously
- The withdrawn portion is made available after settlement

This mode balances capital growth with regular realized returns.

---

### 8.4 Withdraw All Profits

Under the **Withdraw All Profits** mode:

- Principal remains continuously deployed
- 100% of verified profits are removed from active capital
- Profits are made available after settlement
- Trade size remains approximately constant unless principal is adjusted

This mode is designed for users seeking ongoing profit realization without capital expansion.

---

### 8.5 Zero-Result Cycles

If no verified profit exists at settlement:

- no profit handling action occurs
- no funds are withdrawn
- no funds are compounded
- capital remains unchanged

Zero-result cycles do not alter the selected profit handling mode.

---

### 8.6 Mode Locking and Changes

Once a cycle is authorized:

- the selected profit handling mode is locked
- it cannot be changed mid-cycle
- it applies to all settlements within that cycle

The profit handling mode may be changed only before authorizing a future cycle.

---

### 8.7 Separation From Fees and Redemption

Profit handling modes:
- do not affect execution behavior
- do not alter platform fees
- do not guarantee profit or redemption timing
- do not imply yield or future performance

Profit handling governs **what happens after success**, not whether success occurs.

---

## 9. Gas and Execution Cost Funding

YieldLoop requires all execution-related costs to be **explicitly pre-funded** by the user.  
The system does not subsidize execution, borrow against user capital, or create hidden liabilities.

Execution cost funding is a prerequisite for authorization.

---

### 9.1 Execution Cost Wallet (ECW)

Each user vault includes a dedicated **Execution Cost Wallet (ECW)**.

The ECW is used exclusively to pay for:
- blockchain gas costs
- decentralized exchange swap fees
- protocol interaction fees
- execution-related overhead

The ECW is **separate from user principal and profits**.

---

### 9.2 Minimum ECW Funding Requirement

At launch, the ECW is expected to require a **minimum balance of approximately $10 USDT**, subject to adjustment by the YieldLoop team or future governance.

The minimum ECW requirement exists to:
- ensure strategies can execute meaningfully
- reduce failed or partially executed trades
- prevent premature execution halts
- preserve deterministic settlement behavior

If the ECW balance is below the minimum:
- a vault cannot be authorized for a new cycle

---

### 9.3 Pre-Funded Execution Only

YieldLoop operates on a **pre-funded execution model**.

The system will:
- deduct execution costs from the ECW as they occur
- never borrow from principal
- never borrow from expected or unrealized profit
- never borrow from system reserves

Execution never runs on credit.

---

### 9.3.1 ECW Gas Conversion and Execution Pause Behavior

Execution costs funded through the Execution Cost Wallet (ECW) may be converted as required to pay on-chain gas and execution-related fees.

The system may:
- convert ECW balances into the native gas asset as needed
- maintain small operational gas buffers for execution continuity

At no point does YieldLoop:
- subsidize gas costs
- borrow gas from other users
- execute trades without sufficient ECW funding

If available ECW funding is insufficient to safely execute a permitted action:

- the action is skipped
- execution for the affected vault pauses
- no new trades are initiated
- existing positions are not forcibly closed

Execution resumes only when sufficient ECW funding is restored.

Execution pauses due to ECW insufficiency are a valid and expected outcome.

---

### 9.4 ECW Exhaustion During Execution

If the ECW balance is exhausted during an active cycle:

- execution halts immediately
- no further trades are attempted
- settlement proceeds using realized results
- no debt or negative balance is created

ECW exhaustion is a valid outcome and is not treated as an error.

---

### 9.5 ECW Balances After Settlement

After settlement completes:

- any unused ECW balance remains under user control
- ECW funds may be withdrawn or reused for future cycles
- ECW balances do not automatically roll into execution unless authorized

---

### 9.6 Transparency and Auditability

All ECW deductions:
- are recorded on-chain
- are attributable to specific execution actions
- are visible to the user

YieldLoop does not apply:
- hidden fees
- retroactive charges
- discretionary deductions

---

### 9.7 Separation From Platform Fees

Execution costs funded through the ECW are **distinct from platform performance fees**.

- ECW costs are incurred regardless of profit
- platform fees apply only if verified profit exists
- ECW funding does not influence fee calculations

This separation ensures clarity between **costs of execution** and **fees for success**.

---

Execution cost funding defines **whether execution can occur at all**.

The next section defines **how YieldLoop enforces time boundaries through fixed monthly cycles**.

---

## 10. Monthly Cycle Rules

YieldLoop operates exclusively on **fixed, calendar-based monthly cycles**.  
Cycles define when execution may occur, when accounting is measured, and when outcomes become final.

There is no continuous execution and no rolling enrollment.

---

### 10.1 Cycle Definition

A YieldLoop cycle is defined as:

- **Start:** 00:00 UTC on the first calendar day of the month  
- **End:** 23:59 UTC on the last calendar day of the month  

All execution, settlement, and profit handling occur **within these boundaries**.

---

### 10.2 Enrollment Window

Users may authorize a vault for a cycle **only during the enrollment window** prior to cycle start.

- Authorization completed before cycle start applies to the upcoming cycle  
- Authorization completed after cycle start applies to the **next cycle**  

There is no late entry and no partial-cycle participation.

---

### 10.3 No Mid-Cycle Entry or Exit

Once a cycle begins:

- no new deposits may join the active cycle  
- no withdrawals are permitted  
- no strategy parameters may be modified  
- no profit handling modes may be changed  

This rule applies uniformly to all users.

---

### 10.4 Execution Scope

During a cycle:

- only authorized strategies may execute  
- execution occurs only within approved bounds  
- execution may occur at any time during the cycle  
- execution frequency is strategy-dependent  

Execution may halt early if:
- strategy guardrails are breached
- ECW funds are exhausted
- market conditions invalidate execution

Early halting does not invalidate the cycle.

---

### 10.5 Cycle End and Execution Boundary

At the end of a monthly cycle:

- no new trades may be initiated
- no new execution actions may begin
- all strategy evaluation halts for the closing cycle

Existing positions are **not forcibly closed** to satisfy the cycle boundary.

Any exposure that remains open at cycle end:
- is classified as inventory
- is carried forward conservatively
- is excluded from profit recognition
- does not initiate new execution without future authorization

Cycle finality applies to **accounting and profit recognition**, not forced position closure.

---

### 10.6 Inventory at Cycle End

Positions that remain open at cycle end are classified as **inventory**.

Inventory:
- is not marked to market
- is excluded from profit
- remains in the vault
- requires reauthorization for future cycles

Inventory is carried forward conservatively and does not generate profit until realized.

---

### 10.7 One Settlement Per Cycle

Each cycle has **exactly one settlement event**.

Settlement:
- occurs after cycle end
- finalizes results
- cannot be repeated
- cannot be revised

There is no rolling settlement and no interim accounting.

---

### 10.8 Cycle Independence

Each cycle is independent.

- Results from one cycle do not alter settlement rules for another  
- Losses are not carried forward  
- Profits are not assumed  

This prevents compounding of accounting errors and preserves auditability.

---

### 10.9 Cycle Inactivity Is Valid

A cycle may:
- execute few trades
- execute no trades
- resolve to zero profit

Inactivity is a valid outcome.

YieldLoop does not force execution to satisfy narrative or appearance.

---

### 10.10 Why Monthly Cycles Exist

Monthly cycles enforce:
- clean accounting boundaries
- predictable settlement timing
- fair treatment across users
- resistance to discretionary intervention

Cycles are the backbone of YieldLoop’s integrity.

---

Monthly cycles define **when execution is allowed and when truth is measured**.

The next section defines **how execution is halted, constrained, and protected at the system level**.

---

## 11. Execution and Safety Guardrails

YieldLoop enforces strict execution and safety guardrails to ensure that no strategy, user, administrator, or external condition can compromise system integrity.

These guardrails are **mandatory**, **automatic**, and **non-discretionary**.

Execution either occurs within approved bounds, or it halts.

---

### 11.1 Guardrail Philosophy

Safety in YieldLoop is achieved through **constraint**, not intervention.

The system does not attempt to rescue failing strategies, optimize mid-cycle, or react emotionally to market conditions.

Instead, YieldLoop enforces:
- hard limits
- deterministic halts
- conservative resolution
- finality over flexibility

If a strategy cannot operate safely, it must stop.

---

### 11.2 Capital Protection Constraints

All execution is subject to the following immutable constraints:

- no leverage of any kind  
- no borrowing from any source  
- no rehypothecation of assets  
- no use of derivatives  
- no exposure beyond approved allocation  

Capital cannot be expanded, substituted, or pledged.

---

### 11.3 Strategy-Level Halting Conditions

A strategy must halt immediately if any of the following occur:

- execution parameters are breached  
- maximum drawdown thresholds are reached  
- required market conditions cease to exist  
- approved venues or protocols become unavailable  
- gas or trade fee funding is exhausted  

Halting a strategy:
- does not invalidate the cycle
- does not imply failure
- triggers conservative settlement behavior

---

### 11.4 System-Level Halting Conditions

The YieldLoop system may halt execution for a vault if:

- blockchain conditions prevent safe execution  
- protocol dependencies become unsafe or non-functional  
- external market conditions invalidate deterministic execution  
- critical execution infrastructure fails  

System-level halts:
- apply only to affected vaults
- do not impact other users
- do not alter settlement rules

---

### 11.5 No Mid-Cycle Intervention

Once a cycle begins:

- users cannot modify strategies  
- users cannot add or remove capital  
- administrators cannot intervene  
- governance cannot override execution  
- AI cannot adjust parameters  

There are no emergency buttons.

Intervention is replaced by **predefined halting behavior**.

---

### 11.6 Gas and Fee Exhaustion Handling

If the Execution Cost Wallet (ECW) balance reaches zero during execution:

- all execution halts immediately  
- no further trades are attempted  
- no borrowing occurs  
- no debt is created  

Settlement proceeds using realized outcomes.

Gas exhaustion is a valid and expected edge case.

---

### 11.7 Losses and Adverse Outcomes

YieldLoop does not guarantee profit.

Losses may occur due to:
- market movement  
- slippage  
- execution timing  
- incomplete strategies  

Losses:
- are confined to the affected vault  
- are not socialized  
- are not offset by emissions  
- are not hidden  

If losses occur, they are reflected honestly at settlement.

---

### 11.8 Failure Classification, Retry, and Skip Behavior

YieldLoop distinguishes between **transient execution failures** and **structural execution failures**.

#### Transient Failures
Transient failures include conditions such as:
- temporary liquidity insufficiency
- gas price spikes beyond approved bounds
- transaction reverts due to routing or timing
- temporary protocol or RPC instability

For transient failures:
- the affected execution step may be retried once after a defined cooldown
- parameters remain unchanged
- no additional risk is assumed

If the retry fails:
- the execution step is skipped
- execution continues where permitted
- the cycle is not invalidated

#### Structural Failures
Structural failures include conditions such as:
- violated strategy constraints
- repeated deterministic reverts
- invalid or unsafe protocol conditions
- guardrail breaches

For structural failures:
- the affected strategy halts for the remainder of the cycle
- other authorized strategies may continue
- settlement proceeds normally

YieldLoop does not permit unlimited retries, recursive execution, or discretionary recovery.

---

### 11.9 Guardrails Are Not Configurable

Execution and safety guardrails:
- cannot be disabled  
- cannot be bypassed  
- cannot be relaxed by governance  
- cannot be overridden by administrators  

They are fundamental to the system’s design.

---

### 11.10 Guardrails Preserve Fairness

Guardrails exist to ensure:

- identical treatment across users  
- predictable behavior under stress  
- resistance to manipulation  
- auditability of outcomes  

YieldLoop prefers to halt rather than lie.

---

Execution guardrails define **what the system refuses to do**, even under pressure.

The next section defines **how cycles are settled and how inventory is handled once execution ends**.

---

## 12. Settlement and Inventory Handling

Settlement is the **single point of truth** for every YieldLoop cycle.  
No outcome is recognized as profit until settlement completes.  
Settlement is conservative, deterministic, and irreversible.

YieldLoop does not mark positions to market. It recognizes only what is realized.

---

### 12.1 Settlement Timing

Each cycle has **exactly one settlement event**, executed after the cycle end boundary:

- execution has fully stopped  
- no new trades may be initiated  
- no parameters may be modified  
- no withdrawals may occur until settlement finalizes  

There is no interim settlement, no rolling settlement, and no discretionary “early close” settlement.

---

### 12.2 Settlement Outputs

Settlement finalizes the cycle into three distinct buckets:

1. **Realized Vault Balance** — what is actually realized and spendable  
2. **Inventory** — unrealized exposure carried forward conservatively  
3. **Verified Net Profit** — either exists or does not exist as an accounting fact  

Only (1) and (3) are used for profit recognition.  
Inventory is excluded from profit.

---

### 12.3 Deterministic Inputs and Definitions

Settlement uses only deterministic, verifiable inputs:

- **Starting Principal (SP):** the vault’s authorized principal amount at cycle start  
- **Ending Realized Balance (ERB):** realized asset balance at cycle end, valued in USDT at settlement using deterministic conversion rules  
- **Execution Costs (EC):** gas, swap fees, and protocol interaction costs paid from the Execution Cost Wallet (ECW), attributable to the cycle  
- **Protocol / Trade Fees (PTF):** fees incurred by venues or protocols attributable to the cycle  
- **Realized Rewards (RR):** protocol-native rewards that were actually claimed and converted into USDT within the cycle  
- **Inventory (INV):** any exposure not realized at cycle end (defined in §12.6)

**Valuation rule:** Only realized assets count.  
If a value cannot be deterministically verified at settlement without mark-to-market assumptions, it is excluded from profit and treated as inventory.

---

### 12.4 Verified Net Profit Calculation

YieldLoop recognizes profit only if it survives all costs and fees.

**Verified Net Profit (VNP)** is defined as:

VNP = ERB − SP − EC − PTF

A cycle has **Verified Profit** only if:

VNP > 0

If `VNP ≤ 0`, the cycle has **No Verified Profit**.

This is an accounting fact, not a narrative.

---

### 12.5 Binary Profit Recognition (Not Binary Performance)

YieldLoop enforces binary **profit recognition**, not binary performance.

Each cycle resolves to one of two accounting outcomes:

1. **Verified Net Profit Exists** (`VNP > 0`)  
2. **No Verified Net Profit Exists** (`VNP ≤ 0`)  

A “no verified profit” cycle may include:
- a zero outcome, or  
- a loss outcome  

Both are permitted. Neither is hidden.

---

### 12.6 Inventory Definition

Any position or exposure not fully realized before cycle end is classified as **inventory**.

Inventory:

- remains inside the user vault  
- is not marked to market  
- is excluded from profit  
- carries no assumed gain  
- carries no implied recovery  

Inventory exists due to real execution constraints (liquidity, reverts, protocol outages, ECW exhaustion, or venue limits).

---

### 12.7 Forced Close Attempt and Inventory Exception

Strategies must be designed to **attempt closure** before cycle end.

However, closure may fail due to:

- insufficient liquidity  
- transaction reverts  
- protocol outages  
- ECW exhaustion  
- venue or routing constraints  

If closure cannot occur within deterministic bounds, YieldLoop does not fabricate a result.

The exposure becomes **inventory** and is carried forward.

Truth overrides optics.

---

### 12.8 Inventory Carry-Forward Rules

Inventory carries forward automatically.

If a position remains open at cycle end:
- it remains inside the user vault
- it is carried forward as inventory without mark-to-market valuation
- it is excluded from profit recognition for the closing cycle

Inventory does not require reauthorization to **exist** or to **remain held**.

Reauthorization is required only to:
- initiate new execution actions involving inventory, or
- deploy additional strategies against inventory in a future cycle.

Until reauthorized for execution, inventory may remain idle indefinitely.

---

### 12.9 Relationship to Profit Handling Modes

Profit handling modes (Compound All / Split 50–50 / Withdraw All Profits) apply **only after settlement** and only to **Verified Net Profit** after platform fees are applied.

Clarifications:

- **Intra-cycle reuse is allowed.**  
  If a trade closes during the cycle, the realized USDT becomes part of the vault’s realized balance and may be used by approved strategies for subsequent trades **within the same cycle**.

- **Profit handling is not applied trade-to-trade.**  
  It is applied once, at settlement, to the cycle’s verified net result.

---

### 12.10 Platform Fee Application Order

If `VNP > 0`:

1. Platform performance fee is calculated on `VNP`  
2. Fee is deducted  
3. Remaining net profit becomes eligible for the user’s selected profit handling mode  
4. LOOP minting rules (if applicable) are evaluated only after these steps  

If `VNP ≤ 0`:

- no performance fee is charged  
- no profit handling action occurs  
- no LOOP is minted  

---

### 12.11 Zero-Result and Loss Cycles

If a cycle resolves with **no verified profit**:

- no platform performance fee is charged  
- no profit handling action occurs  
- no LOOP is minted  
- vault unlocks as-is after settlement  
- inventory (if any) remains inventory  

This outcome is correct system behavior.

---

### 12.12 Settlement Finality

Once settlement completes:

- results are final  
- balances unlock  
- the cycle becomes immutable  
- accounting records cannot be rewritten  

There are no re-runs, reversals, discretionary corrections, or retroactive changes.

---

### 12.13 Conservative Bias

When ambiguity exists, YieldLoop resolves conservatively:

- if it cannot be verified, it is excluded  
- if it cannot be realized, it is inventory  
- if profit cannot be proven, profit does not exist  

This is integrity by design.


---

## 13. Fees and Platform Sustainability

YieldLoop charges fees **only when verified profit exists**.  
There are no management fees on principal, no subscription fees, and no charges for inactivity.

If the system produces no verified profit, the platform earns nothing.

---

### 13.1 Performance Fee Trigger

A **performance fee** is applied **only if** a cycle settles with **Verified Net Profit (VNP > 0)** as defined in §12.

- Fees are calculated on **Verified Net Profit only**
- Fees are never charged against principal
- Fees are never charged in zero-result or loss cycles

No profit, no fee.

---

### 13.2 Performance Fee Rate

The standard performance fee is:

**20% of Verified Net Profit**

This rate:
- applies uniformly to all users
- is disclosed prior to authorization
- applies prospectively only

Any change to the performance fee rate:
- applies only to future cycles
- requires explicit user reauthorization

---

### 13.3 Fee Application Order

When `VNP > 0`, fees are applied in the following deterministic order:

1. Settlement completes and VNP is calculated  
2. Performance fee is computed as `20% × VNP`  
3. Fee is deducted from VNP  
4. Remaining net profit becomes eligible for:
   - user-selected profit handling modes, and
   - any LOOP minting rules

This order is fixed and cannot be altered.

---

### 13.4 Fee Allocation Categories

The performance fee is allocated across four platform categories:

1. **Development**
   - engineering and infrastructure
   - security reviews and audits
   - tooling and maintenance

2. **Marketing**
   - education and documentation
   - user acquisition
   - community growth

3. **System Deposit**
   - platform-level capital participation
   - long-term execution capacity
   - sustainability reinforcement

4. **LoopLab (Proof of Impact)**
   - research and experimentation
   - ecosystem development
   - socially beneficial initiatives aligned with YieldLoop principles

The **category list is fixed**.  
The **percentage split within the 20% fee is configurable**.

---

### 13.5 Governance Control of Fee Splits

Governance may adjust **internal allocation percentages** of the performance fee:

- changes apply only to future cycles
- changes are publicly disclosed
- changes require user reauthorization to take effect

Governance **cannot**:
- introduce new fee categories
- charge fees without verified profit
- apply fees retroactively
- alter settlement or profit definitions

---

### 13.6 Separation From Execution Costs

Performance fees are **entirely separate** from execution costs.

- execution costs are funded by the Execution Cost Wallet (ECW)
- ECW costs are incurred regardless of profit
- performance fees are incurred only if profit exists

There is no fee cross-subsidization.

---

### 13.7 Zero-Result and Loss Cycles

If a cycle resolves with `VNP ≤ 0`:

- no performance fee is charged
- no minimum fee applies
- no deferred fee accrues
- no retroactive adjustment occurs

The platform accepts zero revenue in these cycles.

---

### 13.8 Transparency and Auditability

All performance fees:

- are calculated deterministically
- are visible to users
- are auditable on-chain
- are attributable to a specific cycle

YieldLoop does not apply:
- hidden deductions
- discretionary charges
- variable fee logic

---

### 13.9 Sustainability Without Distortion

YieldLoop’s fee model is designed to:

- align platform incentives with user success
- remove pressure to force execution
- permit inactivity during unfavorable conditions
- preserve long-term credibility

The platform is allowed to earn nothing rather than compromise integrity.

---

Fees exist to sustain the platform **only when reality permits**.

The next section defines **how LOOP is minted, what it represents, and how redemption works**.

---

## 14. LOOP Token and Redemption

LOOP is the **accounting and redemption token** of the YieldLoop system.  
It represents **verified, retained economic surplus** that has been explicitly moved into a dedicated redemption treasury after cycle settlement.

LOOP is not yield, not a promise, and not a claim on future execution.

LOOP exists only because profit actually occurred and was retained.

---

### 14.1 Purpose of LOOP

LOOP exists to:

- record verified surplus created by completed cycles  
- represent retained value in a transferable accounting unit  
- enable redemption into USDT under explicit availability rules  
- separate **execution capital** from **surplus accounting**  

LOOP is a *receipt of success*, not the incentive for it.

---

### 14.2 Preconditions for LOOP Minting

LOOP may be minted **only after settlement** and **only if all conditions below are met**:

1. the cycle produced **Verified Net Profit (VNP > 0)**  
2. platform performance fees have been applied and deducted  
3. a portion of post-fee profit is designated as **retained surplus**  
4. a portion of retained surplus is actually transferred into the **Redemption Treasury**  
5. settlement has finalized and is immutable  

If any condition is not met, **no LOOP is minted**.

LOOP is never:
- pre-minted  
- emitted on a schedule  
- minted against principal  
- minted against unrealized inventory  

---

### 14.3 Definition of Retained Surplus

**Retained Surplus (RS)** is the portion of post-fee verified profit that remains within the system after profit handling decisions.

RS may originate from:
- user profit handling modes (e.g., Compound All or the retained portion of Split 50/50)  
- platform-level retention rules (if any)  
- system deposit allocations (where applicable)

RS is always derived from **real, settled profit** — never from principal.

Retained Surplus is **accounting surplus**, not guaranteed liquidity.

---

### 14.4 Redemption Treasury (Backing Pool)

The **Redemption Treasury (RT)** is the on-chain pool backing LOOP redemption.

The RT:
- holds **USDT (or equivalent stable assets) only**  
- increases only through **verified retained surplus** transferred in after settlement  
- decreases only through **LOOP redemption** or explicitly disclosed treasury operations  
- is auditable and segregated from user vaults  

Assets in the RT are never:
- borrowed against  
- used to subsidize execution losses  
- used to fabricate profit  

The RT exists to provide **real backing**, not narrative support.

---

### 14.5 Treasury-Backed Minting (1 LOOP = 1 USDT at Mint)

LOOP minting is **treasury-backed and deterministic**.

When a settlement designates `X USDT` of retained surplus to be transferred into the Redemption Treasury:

- exactly `X LOOP` is minted  
- minting occurs **only after** the treasury transfer is finalized  
- minting is **1:1** at creation time:

**LOOP Minted = USDT Deposited into RT**

This ensures:
- no LOOP supply exists without stable backing  
- no dilution without value  
- no circular accounting based on market price  

LOOP is an accounting token whose legitimacy comes from **treasury deposits**, not market speculation.

---

### 14.6 Redemption Mechanics (1 LOOP Redeems for 1 USDT When Available)

LOOP is redeemable for USDT **only when Redemption Treasury liquidity is available**.

A valid redemption:

- burns the redeemed LOOP  
- transfers an equal amount of USDT from the RT  
- creates **no debt** and no negative balances  

**Redemption Rate:**  
When processed, redemption is **1 LOOP → 1 USDT**.

YieldLoop does not compute redemption value as “pool ÷ supply.”  
Instead, the system enforces a simpler rule:

> LOOP is minted only when USDT is placed into the RT, and LOOP is burned only when USDT leaves the RT.

---

### 14.7 Redemption Availability, Pauses, and Fairness

Redemption is constrained by operational reality.

Redemption may be subject to:
- treasury liquidity availability  
- rate limits  
- explicit redemption windows  
- temporary pauses during stress, maintenance, or safety events  

If redemption demand exceeds current capacity:

- requests are placed into a **queue**  
- fulfillment occurs **FIFO by request timestamp** (or equivalent deterministic ordering)  
- no preferential treatment is permitted  

A pause defers redemption; it does not rewrite accounting history.

Users must treat redemption timing as **conditional**, not guaranteed.

---

### 14.8 What Happens if Treasury Liquidity Is Insufficient

If the RT does not have enough USDT to process all pending redemptions:

- redemptions are partially fulfilled or delayed  
- LOOP remains outstanding and transferable  
- no synthetic liquidity is created  
- no borrowing occurs  
- no “temporary IOU” token is issued  

LOOP does not become invalid — it becomes **temporarily illiquid**, which is explicitly allowed.

---

### 14.9 No Forced Minting, No Forced Redemption

YieldLoop does not:

- force LOOP minting  
- force LOOP redemption  
- guarantee redemption timing  
- guarantee continuous liquidity  
- guarantee that the treasury will always be sufficient for all redemptions at once  

All actions remain bounded by verified surplus and available treasury liquidity.

---

### 14.10 Separation From Speculation

Any external trading or speculative use of LOOP:

- is not supported by guarantees  
- does not influence redemption rules  
- does not alter accounting reality  
- does not create claims beyond what the treasury can honor  

YieldLoop does not manage LOOP price.  
It manages **surplus truth**.

---

### 14.11 Why LOOP Exists

LOOP exists to ensure:

- retained value is measurable  
- treasury backing is explicit  
- redemption is possible without lies  
- accounting remains auditable  
- growth is earned, not implied  

LOOP is the **receipt of success**, not the incentive for it.

---

## 15. System Deposit and Reinvestment

The system deposit is YieldLoop’s **self-sustaining reinforcement mechanism**.  
It exists to strengthen long-term execution capacity and redemption resilience **without distorting user outcomes, settlement integrity, or LOOP accounting**.

The system deposit is platform capital.  
It is not user capital and is never treated as such.

---

### 15.1 Purpose of the System Deposit

The system deposit exists to:

- reinforce long-term execution capacity  
- strengthen redemption and liquidity resilience  
- support platform sustainability without external leverage  
- align platform survival with real, verified performance  

It does **not** exist to:
- subsidize user losses  
- guarantee outcomes  
- smooth returns  
- manipulate LOOP value  
- override settlement or guardrails  

---

### 15.2 Source of System Deposit Funds

System deposit funds are sourced **exclusively from verified profit**.

Specifically:
- the system deposit receives its allocation from the platform’s **performance fee**  
- no user principal is ever diverted  
- no funds are taken from zero-result or loss cycles  

If no verified profit exists, the system deposit receives **nothing**.

---

### 15.3 Separation From User Capital

System deposit funds:

- are never commingled with user vaults  
- do not alter user execution outcomes  
- do not receive execution priority  
- do not socialize risk  

Losses incurred by system deposit activity affect **only the system deposit**.

User outcomes remain isolated and unchanged.

---

### 15.4 Immutable Reinvestment Rule

The system deposit is governed by a **non-configurable reinvestment rule**:

- **50% remains liquid**
- **50% is redeployed into YieldLoop execution**

This rule:
- cannot be changed by governance  
- cannot be overridden by administrators  
- cannot be waived under any circumstance  

Immutability exists to prevent reactive or narrative-driven intervention.

---

### 15.5 Redeployed System Capital Rules

The redeployed portion of the system deposit:

- executes under the **same strategy constraints** as all other capital  
- is subject to identical guardrails, halts, and settlement rules  
- receives no execution preference  
- receives no loss protection  

System capital earns or loses exactly as execution reality dictates.

---

### 15.6 Liquid System Capital Rules

The liquid portion of the system deposit:

- remains idle unless explicitly redeployed  
- may support redemption liquidity **only through transparent treasury operations**  
- is not borrowed against  
- is not pledged or rehypothecated  

Liquidity exists for **resilience**, not intervention.

---

### 15.7 Relationship to LOOP and Redemption

System deposit behavior:

- does not mint LOOP directly  
- does not guarantee LOOP redemption liquidity  
- does not alter LOOP minting rules  
- does not influence LOOP accounting except through earned surplus  

LOOP remains strictly tied to **treasury-backed retained surplus**, not platform intent.

---

### 15.8 No Discretionary Intervention

The system deposit does not enable:

- discretionary trade intervention  
- emergency backstopping of user vaults  
- outcome smoothing  
- selective rescue of failing strategies  

All system capital is constrained by the same rules as user-approved execution.

---

### 15.9 Long-Term Effect

Over time, the system deposit:

- compounds execution capacity organically  
- improves platform durability during adverse markets  
- supports redemption sustainability  
- strengthens platform credibility through restraint  

Growth occurs through **earned surplus**, not policy manipulation.

---

### 15.10 Why the Rule Is Immutable

The immutability of the reinvestment rule ensures:

- predictability  
- auditability  
- resistance to short-term pressure  
- protection against governance drift  

YieldLoop chooses **constraint over control**.

---

The next section defines **governance authority, configuration limits, and platform participation**.

---

## 16. Governance, Configuration Limits, and Platform Membership

YieldLoop governance exists to **configure the platform prospectively** while preserving execution integrity, settlement finality, and accounting truth.

Governance is intentionally limited.  
It may shape the system’s *future*, but it may never rewrite its *past* or intervene in active execution.

Separately, YieldLoop offers a **Platform Membership program (“Supporter”)**, which represents a voluntary contribution to platform sustainability — **not** an investment, execution strategy, or yield mechanism.

---

### 16.1 Purpose of Governance

Governance exists to:

- steward long-term platform sustainability  
- curate supported assets, venues, and strategies  
- adjust non-execution operational parameters  
- manage platform-level programs and participation  

Governance does **not** exist to:

- guarantee returns  
- influence execution outcomes  
- intervene mid-cycle  
- override settlement  
- manipulate LOOP supply or redemption behavior  

Execution truth always supersedes governance preference.

---

### 16.2 Governance Authority (Prospective Only)

Governance may adjust **for future cycles only**:

- minimum external deposit thresholds  
- minimum Execution Cost Wallet (ECW) funding requirements  
- supported deposit assets  
- supported execution venues and protocols  
- availability and parameters of strategy engines  
- internal allocation of the platform performance fee  
- redemption pacing, pausing, and queue mechanics  
- parameters of platform membership programs  

All governance changes:

- are publicly disclosed  
- include a defined effective date  
- apply only to future cycles  
- require explicit user reauthorization to take effect  

No change applies silently.

---

### 16.3 Immutable System Constraints

The following elements are **non-configurable and immutable**:

- monthly calendar-based cycle structure  
- execution lock during active cycles  
- settlement finality  
- definition of Verified Net Profit  
- vault isolation  
- prohibition on leverage, borrowing, and derivatives  
- separation of execution costs and platform fees  
- LOOP minting tied solely to verified, retained surplus  
- treasury-backed LOOP redemption model  
- system deposit reinvestment rule  

Any modification that violates these constraints is not YieldLoop.

---

### 16.4 No Retroactive Authority

Governance:

- cannot retroactively alter outcomes  
- cannot reopen or revise settlements  
- cannot confiscate user funds  
- cannot invalidate completed cycles  

Completed cycles are final and immutable.

---

### 16.5 Platform Membership Program (“Supporter”)

YieldLoop may offer an optional **Supporter Membership Program**.

Supporter membership represents:

- a voluntary contribution to platform development and longevity  
- alignment with YieldLoop’s long-term mission  
- participation in platform stewardship  

Supporter membership is **not**:

- an execution strategy  
- an investment  
- a yield-generating mechanism  
- a claim on profits, surplus, or treasury assets  

---

### 16.6 Supporter Contribution Structure

Under the Supporter program:

- a user makes a **one-time fixed contribution** (e.g., $300 USDT or LOOP-equivalent)  
- the contribution grants Supporter membership status  
- the contribution is **not deposited into a user vault**  

The contribution:

- is not execution capital  
- is not deployed into strategies  
- does not participate in profit or loss  
- does not mint LOOP  
- does not create a redeemable claim  

It is treated strictly as a **platform contribution**.

---

### 16.7 Treatment of Supporter Contributions

Supporter contributions:

- are accounted for at the platform level  
- may be used for development, audits, infrastructure, or growth  
- are not segregated as user vault funds  
- are not subject to execution or settlement rules  

Supporter contributions may be **non-refundable**, or refundable only under explicitly disclosed program terms.

No assumption of liquidity, return, or recovery is implied.

---

### 16.8 Supporter Benefits

Supporter membership may provide:

- discounted platform performance fees  
- eligibility for governance-related reviews or bounties  
- early access to features, tooling, or releases  

Benefits:

- are discretionary  
- may change prospectively  
- do not affect execution behavior  
- do not influence settlement outcomes  

Eligibility does not guarantee compensation or selection.

---

### 16.9 No Preferential Execution Treatment

Supporter membership does **not**:

- alter execution priority  
- reduce execution risk  
- change strategy behavior  
- influence settlement outcomes  
- grant override authority  

All vaults execute under identical deterministic rules.

---

### 16.10 Governance Bounties and Participation

Governance may offer discretionary participation opportunities to Supporters for:

- research  
- testing  
- documentation  
- platform review  
- feedback and experimentation  

Participation:

- is voluntary  
- does not guarantee compensation  
- does not constitute yield or investment return  

---

### 16.11 Separation From LOOP and Redemption

Supporter membership:

- does not affect LOOP minting  
- does not affect LOOP redemption mechanics  
- does not create claims on the redemption treasury  
- does not influence LOOP’s accounting value  

LOOP remains strictly tied to verified, retained surplus.

---

### 16.12 Transparency and Disclosure

All governance actions and membership terms:

- are documented and public  
- include effective dates  
- are auditable  
- require user reauthorization where applicable  

Participation is always optional.

---

### 16.13 Governance Is Intentionally Limited

Governance in YieldLoop exists to **support**, not to control.

Execution logic, settlement finality, and accounting truth always dominate platform authority.

YieldLoop is governed by rules first — people second.

---

## 17. Risk Disclosure and User Responsibility

YieldLoop is a **non-custodial execution platform**, not a savings account, investment product, or guarantee of returns.

Users are solely responsible for the risks they accept when authorizing execution.

---

### 17.1 No Guarantee of Profit

YieldLoop does not guarantee:
- profit
- yield
- capital preservation
- positive outcomes in any cycle

Execution outcomes depend on:
- market conditions
- strategy behavior
- execution timing
- external protocol performance

Losses, including total loss of deployed capital, are possible.

---

### 17.2 Market Risk

Markets may:
- move rapidly
- gap unexpectedly
- behave irrationally
- remain unfavorable for extended periods

YieldLoop does not predict markets and does not override execution rules to avoid loss.

---

### 17.3 Execution Risk

Execution may be affected by:
- slippage
- liquidity constraints
- failed transactions
- protocol instability
- blockchain congestion

Execution risk is inherent and unavoidable.

---

### 17.4 Strategy Risk

Strategies may:
- underperform
- fail to execute
- halt due to guardrails
- produce zero-result cycles
- incur losses

Past performance of any strategy is not indicative of future results.

---

### 17.5 Technology Risk

YieldLoop relies on:
- smart contracts
- blockchain infrastructure
- external protocols
- decentralized exchanges

Failures, exploits, or outages may result in loss.

---

### 17.6 No Insurance or Backstops

YieldLoop does not provide:
- insurance
- loss coverage
- guarantees
- bailouts
- recovery promises

The system reflects reality as it occurs.

---

### 17.7 User Responsibility

Users are responsible for:
- understanding strategies selected
- approving configurations knowingly
- funding execution costs
- monitoring platform changes
- complying with applicable laws

Failure to understand the system does not transfer responsibility.

---

### 17.8 No Financial Advice

Nothing in YieldLoop:
- constitutes financial advice
- recommends strategies
- suggests suitability
- implies expected returns

All execution is user-directed and user-approved.

---

### 17.9 Regulatory and Legal Risk

Users are responsible for:
- understanding local laws
- assessing tax implications
- determining regulatory compliance

YieldLoop does not provide legal or tax advice.

---

### 17.10 Inactivity and Opportunity Cost

YieldLoop may:
- remain inactive during unfavorable conditions
- produce extended zero-result periods

Inactivity is intentional and may result in opportunity cost.

---

### 17.11 Acceptance of Risk

By authorizing a cycle, users acknowledge and accept:
- all associated risks
- the possibility of loss
- the absence of guarantees
- the finality of settlement

Risk acceptance is explicit and binding.

---

Risk disclosure defines **the boundaries of responsibility**.

The next section defines **how YieldLoop behaves over long time horizons and adverse conditions**.

---

## 18. Long-Term System Behavior

YieldLoop is designed to operate across **long, uneven market cycles** without requiring constant activity, intervention, or narrative maintenance.

The system is allowed to wait.

---

### 18.1 No Requirement for Continuous Activity

YieldLoop does not require:
- constant execution
- daily trades
- monthly profit
- visible activity for credibility

Inactivity during unfavorable conditions is a valid and intentional outcome.

---

### 18.2 Behavior in Flat Markets

In flat or low-volatility markets:

- execution may be limited
- strategies may halt early
- cycles may resolve to zero-result outcomes

YieldLoop does not force trades to manufacture returns.

---

### 18.3 Behavior in Down Markets

In declining markets:

- guardrails may prevent execution
- capital may remain idle
- losses may occur if strategies engage and markets move adversely

The system prioritizes constraint over optimism.

---

### 18.4 Behavior in High-Volatility Markets

In volatile markets:

- execution may be selective
- ECW exhaustion may occur more frequently
- guardrails may halt strategies rapidly

High volatility does not override safety constraints.

---

### 18.5 Compounding Over Time

Long-term growth in YieldLoop occurs only if:

- profitable cycles occur
- surplus is retained
- system deposit compounds execution capacity

Growth is earned, not assumed.

---

### 18.6 LOOP Behavior Over Time

Over extended periods:

- LOOP supply grows only with retained surplus
- redemption value reflects accumulated reality
- price behavior follows accounting, not expectation

Stagnation or decline is possible if surplus generation slows.

---

### 18.7 System Resilience

YieldLoop resilience comes from:
- isolation between vaults
- deterministic settlement
- refusal to intervene
- allowance for inactivity

The system is designed to survive boredom, not hype.

---

### 18.8 No Growth Mandate

YieldLoop has no mandate to:
- maximize assets under management
- chase trends
- expand risk profiles
- optimize for optics

Sustainability is preferred over expansion.

---

### 18.9 Failure as a Valid Outcome

YieldLoop may:
- underperform
- stagnate
- fail to attract capital

These outcomes are permitted and acknowledged.

The system does not rely on inevitability.

---

### 18.10 Longevity Through Restraint

YieldLoop’s long-term viability depends on:
- refusal to overpromise
- strict adherence to constraints
- acceptance of uncertainty
- transparency of outcomes

Restraint is the system’s advantage.

---

Long-term behavior defines **how YieldLoop survives reality instead of fighting it**.

The final section defines **what success actually looks like**.

---

## 19. Conclusion — What Success Looks Like

YieldLoop is designed to be **boring, honest, and durable**.

Success in YieldLoop is not defined by:
- constant activity
- headline returns
- exponential growth
- narrative momentum

Success is defined by **truthful execution and verifiable accounting** over time.

---

### 19.1 What YieldLoop Refuses to Be

YieldLoop refuses to be:
- a savings account
- a yield promise
- a leverage engine
- a speculative narrative
- a discretionary trading desk

The system is intentionally constrained.

---

### 19.2 What YieldLoop Is

YieldLoop is:
- a cycle-based execution system
- a deterministic settlement framework
- a platform that allows inactivity
- an accounting-first approach to DeFi

It executes only what users approve and settles only what reality produces.

---

### 19.3 User Success

User success in YieldLoop means:
- understanding the system
- accepting uncertainty
- approving configurations intentionally
- evaluating outcomes honestly

Profit may occur. Loss may occur. Both are valid.

---

### 19.4 Platform Success

Platform success means:
- surviving adverse markets
- refusing to lie under pressure
- preserving user trust
- remaining solvent and auditable

The platform is allowed to earn nothing rather than compromise integrity.

---

### 19.5 LOOP Success

LOOP succeeds if:
- it remains redeemable
- it reflects retained surplus accurately
- its value is earned, not implied
- it survives without manipulation

LOOP is a receipt, not a reward.

---

### 19.6 Final Statement

YieldLoop does not promise outcomes.

It promises:
- boundaries
- rules
- transparency
- finality

Everything else is market reality.

---

YieldLoop measures success by **what it refuses to fake**.

