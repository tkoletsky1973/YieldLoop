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

# 1. Forward — What YieldLoop Is (and Is Not)

YieldLoop exists to solve a narrow but critical problem in decentralized finance:

**How can capital be deployed into execution-based strategies without lying about outcomes, hiding risk, or manufacturing returns that do not exist?**

Most DeFi systems fail this test. They project yield, smooth losses, emit tokens to mask drawdowns, or quietly shift risk onto users. YieldLoop explicitly refuses to do that.

This system is built around **execution truth, settlement finality, and explicit consent**.

---

## 1.1 What YieldLoop Is

YieldLoop is a **monthly, cycle-based execution and settlement system** that allows users to:

- deposit capital into an isolated, non-pooled vault  
- select deterministic trading or yield strategies (or accept AI-assisted suggestions)  
- approve all parameters in advance  
- pre-fund execution costs  
- commit capital to a fixed calendar execution window  
- define how verified outcomes are handled **before execution begins**

Each cycle resolves cleanly to **what actually occurred**, and nothing more.

YieldLoop does not promise profit.  
It promises **honest accounting**.

Every cycle has:
- a defined start,
- a defined end,
- deterministic settlement,
- no mid-cycle interference,
- and no retroactive adjustment.

If profit exists, it is proven.  
If it does not, nothing is fabricated.

---

## 1.2 What YieldLoop Is Not

YieldLoop is **not**:

- a savings account  
- a yield guarantee  
- an APY product  
- a discretionary fund  
- a passive income scheme  
- a continuously adjustable vault  
- a token emission protocol  

YieldLoop does **not**:

- project returns  
- smooth losses  
- redistribute value between users  
- borrow against user funds or future profit  
- subsidize execution costs  
- rescue failing strategies  
- guarantee execution or activity  

YieldLoop is intentionally allowed to do **nothing** when conditions are unfavorable.

Inactivity is not a failure state.  
Dishonesty is.

---

## 1.3 Cycles as the Unit of Truth

YieldLoop treats **time-bounded cycles** as the only valid unit of measurement.

Each cycle:
- begins at a fixed calendar boundary,
- executes under locked parameters,
- ends once, and only once, with settlement.

There is no rolling profit, no live PnL, and no mark-to-market accounting.

Profit is recognized **only if it survives execution, costs, and settlement**.  
Anything unrealized is classified as **inventory** and excluded from profit.

Capital deposited into YieldLoop is enrolled **only into the next available cycle**.  
There is no mid-cycle entry, no partial participation, and no rolling enrollment.

---

## 1.4 Explicit Consent Over Convenience

Every meaningful action in YieldLoop requires **explicit user approval**:

- strategy selection  
- parameter bounds  
- capital allocation  
- profit handling mode  
- execution cost funding  
- cycle authorization  

Once a cycle begins:
- funds are locked,
- parameters are immutable,
- withdrawals are disabled,
- no user, administrator, governance body, or AI may intervene.

This constraint is not a limitation.  
It is the foundation of fairness.

---

## 1.5 Accounting Recognition vs. User Outcomes

YieldLoop distinguishes between **accounting recognition** and **user outcomes**.

**Accounting recognition is binary**:
- a cycle either produces **Verified Net Profit**, or  
- it produces **No Verified Net Profit**.

This binary classification governs:
- fee eligibility,
- LOOP minting,
- system deposits,
- profit handling logic.

**User outcomes are not binary.**

A completed cycle may result in:
- a net gain,
- a flat result,
- or a realized loss.

Losses are not reclassified as “zero,” smoothed, or concealed.  
They are realized, disclosed, and final when they occur.

Binary accounting exists to prevent fabrication of profit — not to obscure loss.

---

## 1.6 Interpretive Boundaries

YieldLoop is intentionally designed to resist misclassification.

Accordingly, the following statements define the system’s interpretive boundaries:

- YieldLoop is **not a savings account**, yield product, or income guarantee.  
- YieldLoop does **not** provide discretionary investment management.  
- YieldLoop does **not** promise execution, activity, or profitability.  
- YieldLoop does **not** smooth outcomes, fabricate results, or subsidize losses.  
- YieldLoop does **not** guarantee redemption timing, liquidity, or continuity.  
- Losses, inactivity, and non-execution are **valid and disclosed outcomes**.

YieldLoop executes only what users explicitly approve, only within fixed bounds, and only when conditions permit.

If conditions do not permit honest execution, the system is allowed to do nothing.

These boundaries override convenience, optics, and narrative pressure.

---

## 1.7 Why This Design Exists

YieldLoop was designed under a simple premise:

> **A system that cannot say “no” will eventually lie.**

By enforcing:
- hard time boundaries,
- deterministic settlement,
- explicit zero-profit and loss outcomes,
- pre-funded execution costs,
- and non-demandable redemption rules,

YieldLoop prioritizes survival, auditability, and long-term trust over short-term appeal.

This document defines the rules of that system.  
Nothing implied. Nothing hidden. Nothing softened.

---

## 2. Core Principles and Invariants

YieldLoop is governed by a small set of **non-negotiable principles**.  
These principles are enforced by system design, not discretion.  
They apply uniformly to all users, strategies, and cycles.

If any future modification violates these invariants, it is not YieldLoop.

These principles exist to prevent misinterpretation before it occurs, not to justify behavior after the fact.

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

Every cycle resolves to one of two **accounting recognition states**, while user outcomes may include gains, flat results, or losses.

1. **Verified Net Profit Exists**  
2. **No Verified Net Profit Exists**

There are no partial profits, no estimated gains, and no projected returns.

If profit does not survive:
- execution  
- gas and trade costs  
- protocol fees  
- settlement rules  

It does not exist.

These outcomes are valid and explicitly permitted.

---

### 2.2.1 Accounting Recognition vs. User Outcomes

YieldLoop distinguishes between **accounting recognition** and **user outcomes**.

**Accounting recognition is binary**:
- A cycle either produces **Verified Net Profit (VNP > 0)**, or
- It produces **No Verified Net Profit (VNP ≤ 0)**.

This binary classification governs:
- fee eligibility
- LOOP minting
- system deposits
- profit handling logic

**User outcomes, however, are not binary.**

A completed cycle may result in one of three user-visible outcomes:

1. **Net Gain**  
   - Realized balance exceeds starting principal after all costs and fees.

2. **Net Flat**  
   - No verified profit and no realized loss.

3. **Net Loss**  
   - Realized balance is less than starting principal after all costs and fees.

Unrealized positions are classified separately as **inventory** and are excluded from profit recognition regardless of outcome.

YieldLoop does not reclassify losses as “zero.”  
Losses are realized, disclosed, and final when they occur.

Binary accounting exists to prevent fabrication of profit — not to obscure loss.


---

### 2.3 No Assumed Yield

YieldLoop does not:
- promise yield  
- target APY  
- smooth returns  
- offset losses with emissions  

Profit must be earned through execution.  
If conditions do not allow profit, the system remains idle or resolves to no-profit.

This behavior is intentional.

---

### 2.4 Explicit Consent Is Required for All Risk

No capital is ever placed at risk without **prior, explicit approval**.

Users must approve:
- strategy selection  
- execution parameters  
- profit handling mode  
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
- loss cycles  
- idle or halted cycles  

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
- LOOP accounting and redemption  

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

### 2.11 Explicit Prohibitions

YieldLoop will never:
- force mid-cycle withdrawals
- intervene to rescue failing strategies
- socialize losses across users
- fabricate profit or smooth outcomes
- unlock capital early for discretionary reasons
- modify parameters during execution
- retroactively alter settlements


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

Execution is permissionless and infrastructure-agnostic.

Any party may operate a keeper or transaction submitter. YieldLoop does not guarantee execution frequency, execution timing, or continuous availability of keeper infrastructure. Failure or absence of a keeper does not create an obligation for the platform, does not invalidate a cycle, and does not alter settlement rules.

Keepers are optional infrastructure providers; their presence or absence does not create a service obligation, fiduciary duty, or performance commitment by YieldLoop.

---

### 3.1.2 Execution Availability and Non-Execution

YieldLoop does not guarantee that execution actions will occur during a cycle.

Execution is performed by permissionless transaction submitters (“keepers”) who may submit valid execution transactions when contract-defined conditions permit. The presence, frequency, or reliability of keepers is not guaranteed by the platform and does not create a service obligation.

A cycle may validly resolve with:

- partial execution,
- minimal execution,
- or **no execution at all**.

Non-execution is not a failure state.

If no keeper submits a valid execution transaction for a vault during a cycle:

- no trades are initiated,
- no capital is placed at risk,
- no execution costs are incurred,
- settlement proceeds deterministically at cycle end.

Such a cycle may resolve with:
- zero verified profit, or
- unchanged principal balances.

YieldLoop does not fabricate execution, simulate trades, or assume activity to satisfy accounting or appearance.

---

### Execution Attempt Definition

YieldLoop does not require a minimum number of trades, actions, or execution attempts for a cycle to be considered valid.

Execution is defined strictly as:
- a successfully submitted and executed on-chain transaction,
- that satisfies all contract-defined conditions and guardrails.

Failed, reverted, or skipped transactions:
- do not constitute execution,
- do not create obligations,
- do not invalidate a cycle.

---

### No Duty to Execute

YieldLoop explicitly disclaims any duty to:
- ensure that execution occurs,
- ensure that a minimum level of activity is reached,
- ensure profitability or engagement,
- intervene to stimulate execution.

The system is permitted to remain idle.

Idleness preserves integrity when conditions are unfavorable or infrastructure participation is absent.

---

### Fairness and Determinism Under Non-Execution

Non-execution:
- affects only the vaults for which no execution occurs,
- does not advantage or disadvantage other users,
- does not alter settlement rules,
- does not trigger special handling or compensation.

Settlement under non-execution follows the same deterministic rules as any other cycle.

---

### Incentives and Infrastructure Neutrality

YieldLoop may, but is not required to:
- offer protocol-defined incentives for keeper participation,
- publish recommended execution tooling,
- operate reference keeper infrastructure.

Any such measures:
- do not alter execution rules,
- do not guarantee availability,
- do not create performance obligations.

Execution remains permissionless and infrastructure-agnostic by design.

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
- No strategy may initiate new execution actions involving carried inventory across cycles without explicit reauthorization

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
- All cycle boundaries and settlement timing are defined in UTC.
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

Vaults are non-custodial smart-contract accounts.

YieldLoop does not take custody of user funds in an off-chain account, does not hold user balances on a company ledger, and cannot manually transfer user assets outside the contract’s allowed paths.

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

At launch, the minimum external deposit is expected to be **approximately $100 USDT (or equivalent in LOOP)**, subject to prospective adjustment via governance or publicly disclosed platform policy, effective only for future cycles.

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

### 4.10 Vault Closure

A vault is considered closed when the user withdraws all principal, realized balances, inventory (if liquidated), and Execution Cost Wallet funds, and no active authorization exists.

Upon vault closure:
- any unused ECW balance is returned to the user
- inventory must be explicitly liquidated or withdrawn where possible
- LOOP balances remain independent and are not affected by vault status

---

## 5. Strategy Engines

Strategy engines are the **only components authorized to deploy user capital** during an active YieldLoop cycle.  
They operate strictly within **user-approved parameters**, under deterministic rules, and without discretionary intervention.

Strategy engines are **execution mechanisms**, not profit guarantees.

They exist to:
- attempt execution where conditions permit,
- halt conservatively when conditions do not,
- and never fabricate outcomes to satisfy accounting, optics, or timing constraints.

---

### 5.1 Core Strategy Invariants

All strategy engines are bound by the following **non-negotiable invariants**:

- No leverage of any kind  
- No borrowing from any source  
- No derivatives or synthetic exposure  
- No cross-vault interaction or shared state  
- No discretionary mid-cycle parameter adjustment  
- No forced liquidation to satisfy cycle boundaries  

If a strategy cannot operate safely within its approved bounds, it must halt.

---

### 5.2 Position Lifecycle and Cycle Boundaries

Strategy engines operate within fixed cycle boundaries but are **not required to force position closure** at cycle end.

A strategy engine may initiate a position closure **only if all of the following conditions are satisfied at the time of evaluation**:

- the closure transaction is permitted under approved execution parameters,
- sufficient market liquidity exists to complete the transaction within defined slippage bounds,
- execution does not violate approved risk constraints,
- sufficient Execution Cost Wallet (ECW) funding exists to safely complete the transaction.

If any condition is not satisfied:
- the closure action is not attempted,
- no forced liquidation occurs,
- the position remains open and is classified as inventory at cycle end.

Position closure is never initiated solely to satisfy accounting, reporting, or calendar timing.

---

### 5.3 Inventory Classification (Solves #1 and #2)

Any position not fully realized before cycle end is classified as **inventory**.

Inventory:
- remains inside the user vault  
- is **not marked to market**  
- is **excluded from profit recognition**  
- carries **no assumed gain or recovery**  
- does not affect settlement profit calculations  

Inventory is a valid and expected outcome of constrained execution.

Unrealized exposure is not profit.

---

### 5.4 Inventory Carryover Rules

Inventory carries forward automatically and conservatively.

Specifically:
- inventory remains idle unless explicitly reauthorized for execution in a future cycle  
- inventory does not initiate new trades on its own  
- inventory does not compound  
- inventory does not mint LOOP  
- inventory does not affect platform fees  

Reauthorization is required **only** to deploy inventory into new execution activity.

Inventory may persist indefinitely without penalty or forced resolution.

---

### 5.5 Intra-Cycle Reuse vs. Settlement Recognition

During an active cycle:
- realized funds from closed trades may be reused by approved strategies
- capital may roll trade-to-trade within the same cycle

At settlement:
- **only realized balances count**
- **only verified net profit is recognized**
- **inventory is excluded entirely**

There is no trade-level profit recognition and no rolling settlement.

---

### 5.6 Strategy Halting Conditions

A strategy must halt immediately if any of the following occur:

- execution bounds are breached  
- approved risk limits are reached  
- required market conditions cease to exist  
- approved venues or protocols become unavailable  
- Execution Cost Wallet (ECW) funds are insufficient  

Halting is conservative and final for the cycle.

A halted strategy does not invalidate the cycle.

---

### 5.7 Prohibited Strategy Behaviors

The following behaviors are explicitly forbidden:

- forced liquidation to satisfy cycle timing  
- rolling positions across cycles without reauthorization  
- borrowing from principal, profit, or system funds  
- socializing losses or redistributing outcomes  
- discretionary override by users, AI, governance, or administrators  

Any strategy requiring these behaviors is incompatible with YieldLoop.

---

### 5.8 Strategy Truth Principle

Strategy engines are governed by a single principle:

> **If a result cannot be realized honestly, it is not recognized.**

YieldLoop prefers open inventory over false closure,  
and conservative accounting over optimistic storytelling.

This is intentional.

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

All off-chain interfaces — including dashboards, notifications, AI suggestions, alerts, emails, or visual telemetry — are informational only.

They do not authorize execution, modify on-chain state, alter parameters, initiate trades, or affect settlement outcomes. On-chain state alone governs execution and accounting.

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

---

### 7.8 Standing Authorization and Cycle Re-Enrollment

YieldLoop distinguishes between **configuration persistence** and **cycle authorization**.

Strategy selections, parameters, capital allocations, and profit handling modes may persist across cycles.  
Authorization to deploy capital, however, always applies to a **specific cycle**.

To balance explicit consent with operational continuity, YieldLoop supports **standing authorization**.

Under standing authorization:

- the user explicitly opts in to authorize execution for the next cycle using the **unchanged, previously approved configuration**,
- authorization is applied automatically at the next enrollment boundary,
- no parameters may change without renewed explicit approval,
- standing authorization may be revoked or modified **only during an enrollment window**.

Standing authorization:
- is optional,
- is disabled by default unless explicitly enabled by the user,
- applies only when configuration remains identical.

If any configuration element changes — including strategy selection, parameters, capital allocation, profit handling mode, or ECW requirements — standing authorization is invalidated and fresh approval is required.

Standing authorization never applies mid-cycle and never bypasses execution locks.

---

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

### 8.1.1 Timing of Profit Handling

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

Under the **Split 50 / 50** profit handling mode:

- **50% of verified net profit** is retained inside the vault
- **50% of verified net profit** is removed from active capital
- The retained portion **continues to compound** across trades and cycles
- The withdrawn portion becomes available to the user **after settlement**
- Principal remains continuously deployed unless explicitly withdrawn

Important clarifications:

- The split occurs **only at monthly settlement**, never trade-to-trade  
- During the active cycle, all realized funds may be reused by strategies  
- If a cycle produces **no verified net profit**, no split occurs  
- Inventory is excluded entirely from the split calculation  

This mode balances long-term capital growth with periodic realized returns, without altering execution behavior or settlement integrity.

---

### 8.4 Withdraw All Profits

Under the **Withdraw All Profits** mode:

- **100% of verified net profit** is removed from active capital at settlement
- Principal remains continuously deployed across cycles
- Trade sizing remains approximately constant unless the user adjusts principal
- Withdrawn profits become available to the user **after settlement**

Important clarifications:

- Profit withdrawal occurs **only once per cycle**, at settlement  
- No profits are withdrawn mid-cycle or per trade  
- If a cycle resolves with **no verified net profit**, nothing is withdrawn  
- Inventory does not count as profit and is never withdrawn  

This mode is designed for users who want consistent profit realization while keeping execution capital stable and constrained.

---

Both modes operate strictly **after settlement**, apply only to **verified net profit**, and do not influence execution logic, risk exposure, or strategy behavior.

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

Profit handling modes may persist across cycles but do not authorize execution unless a cycle is explicitly authorized or covered by standing authorization.

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

At launch, the ECW is expected to require a **minimum balance of approximately $10 USDT**, subject to prospective adjustment via governance or publicly disclosed platform policy, effective only for future cycles.

The minimum ECW requirement exists to:
- ensure strategies can execute meaningfully
- reduce failed or partially executed trades
- prevent premature execution halts
- preserve deterministic settlement behavior

If the ECW balance is below the minimum:
- a vault cannot be authorized for a new cycle

This requirement mirrors the ECW minimum described in §4.7 and applies uniformly.

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

A vault participates in a cycle only if explicitly authorized for that cycle, either through manual authorization or valid standing authorization.

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

Retries are permitted only where explicitly defined and never escalate execution risk, slippage tolerance, or capital exposure.

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

A strategy that halts, retries once, skips execution, or carries inventory is not considered a failed cycle.

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

Binary profit recognition does not imply binary performance; realized losses are explicitly permitted, disclosed, and final.

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

Strategies evaluate position closure at defined evaluation points prior to cycle end.

If closure conditions are not satisfied at the time of evaluation, the position is not closed and is classified as inventory. YieldLoop does not retry closure beyond defined evaluation rules and does not escalate risk to achieve realization.

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

> **Important Definition — Nature of LOOP**

> LOOP is an **accounting receipt token**, not a claim, obligation, or debt instrument.

> Holding LOOP does not entitle the holder to demand assets, require redemption, or assert priority over any pool or participant.

> LOOP may be converted into USDT only when and if redemption capacity is available under protocol-defined rules.

LOOP is the **accounting and redemption token** of the YieldLoop system.  
It represents **verified, retained economic surplus** produced by completed cycles and recorded under deterministic rules.

LOOP is **not** yield, not a promise, and not a claim on future execution.

---

### 14.1 Purpose of LOOP

LOOP exists to:

- record verified surplus created by completed cycles  
- represent retained value in a transferable accounting unit  
- enable redemption into USDT under explicit liquidity constraints  
- separate execution capital from surplus accounting  

LOOP exists only because profit actually occurred and was retained.

---

### 14.2 Preconditions for LOOP Minting

LOOP may be minted **only after settlement** and only if all conditions below are met:

1. the cycle produced **Verified Net Profit (VNP > 0)**  
2. platform performance fees have been applied and deducted  
3. a portion of post-fee net profit is designated as **retained surplus**  
4. settlement has finalized and is immutable  

If any condition is not met, **no LOOP is minted**.

---

### 14.3 Definition of Retained Surplus

**Retained Surplus (RS)** is the portion of **post-fee verified profit** that remains inside the system after the user’s profit handling choice is applied.

RS may originate from:
- user-selected profit handling modes (e.g., Compound All or the retained portion of Split 50/50)  
- platform-level retention rules (if any are defined)  
- system deposit allocations (where applicable)

RS is always derived from **real profit**, never from principal.

---

### 14.4 Redeemable Surplus Pool (RSP)

The **Redeemable Surplus Pool (RSP)** is the on-chain pool that backs LOOP redemption.

The RSP:
- holds **USDT (or equivalent stable assets) only**  
- increases **only** through retained, verified surplus  
- decreases **only** through LOOP redemption or explicitly authorized system deployment  
- is auditable and segregated from user vaults  

Assets in the RSP are never borrowed against and are never used to subsidize execution losses.

---

### 14.5 LOOP Minting Rule (1:1 With Retained Surplus)

LOOP minting is deterministic and non-discretionary.

At settlement, if `RS > 0`:

**LOOP Minted = RS**

(Where RS is denominated in USDT-equivalent units at settlement.)

This ensures:
- LOOP supply expands **only** when real, verified surplus is retained  
- no dilution without corresponding retained value  
- no arbitrary emissions  
- no narrative-based token printing  

---

### 14.6 Redemption Value (Fixed)

The accounting redemption parity of LOOP is defined as:

**1 LOOP = 1 USDT (accounting parity, not a guaranteed payout).**

This parity defines how retained surplus is recorded and how conversion is calculated when redemption occurs.  
It does not guarantee immediate, continuous, or unconditional redemption.

LOOP is a **receipt of retained, verified surplus**, redeemable at par value subject only to **liquidity availability and fairness rules**.

YieldLoop does not promise price appreciation and does not imply LOOP “goes up.”  
It promises that LOOP represents accounted surplus and is redeemable at **par** when liquidity is available.

---

### 14.7 Redemption Mechanics

Conversion of LOOP into USDT is a **capacity-limited protocol action**, not a withdrawal right.

LOOP does not confer a right to demand assets, initiate repayment, or require redemption on request.  
Redemption occurs only when protocol-defined conditions permit and only to the extent that verified surplus liquidity is available.

Specifically:

- Redemption converts LOOP into USDT at the defined accounting parity of **1 LOOP = 1 USDT**.
- Redemption draws **exclusively** from the Redeemable Surplus Pool (RSP).
- Redeemed LOOP is **permanently removed from circulation**.
- Redemption never borrows from user vaults, system deposits, or any external source.
- Redemption never creates debt, credit, or negative balances.

Redemption may be subject to one or more of the following constraints:

- insufficient available liquidity in the RSP  
- protocol-defined rate limits  
- redemption queues  
- temporary pauses during instability, stress, or adverse conditions  

If redemption cannot be fulfilled immediately:

- the request is deferred according to the protocol’s queue and pacing rules,
- no assets are fabricated or advanced,
- no obligation is created to fulfill the request within any fixed time frame.

Redemption availability reflects **actual retained surplus**, not expectation or promise.

LOOP represents accounted surplus that *may* be converted when capacity exists.  
It does not represent a payable liability and does not guarantee redemption timing or fulfillment.

---

### 14.8 Redemption Availability, Queues, and Fairness

Queueing does not create an obligation to satisfy all requests, nor does it guarantee eventual fulfillment.

Redemption availability may be subject to:

- liquidity constraints  
- rate limits  
- defined redemption windows  
- conservative system pauses during instability  

When redemption demand exceeds capacity:

- requests are queued by **request epoch**  
- fulfillment occurs in strict **FIFO by epoch**, with **pro-rata** distribution inside an epoch if required  
- no preferential treatment is applied  
- no administrator may reorder requests for advantage  

Temporary unavailability defers redemption timing; it does not fabricate liquidity, and it does not create debt.

Redemption pacing, pauses, or queues may be enacted only through predefined protocol rules or prospectively disclosed governance actions and may not target individual users or requests.

---

### 14.9 What Happens if Surplus Liquidity Declines

If the Redeemable Surplus Pool becomes depleted or illiquid:

- redemption **timing may slow, queue, or pause**  
- LOOP remains an accounting record of retained surplus  
- no artificial support is provided  
- no borrowing occurs to satisfy redemptions  

YieldLoop does not mask deterioration. If liquidity is not available, the system says so.

---

### 14.10 No Forced Minting, No Forced Redemption

YieldLoop does not:

- force LOOP minting  
- force LOOP redemption  
- guarantee redemption timing  
- guarantee redemption windows remain open  

LOOP minting occurs only when retained surplus exists.  
Redemption occurs only when pool liquidity is available.

---

### 14.11 Separation From Speculation

Any external trading or speculative use of LOOP:

- is not supported by guarantees  
- does not influence redemption rules  
- does not alter accounting reality  
- does not create claims beyond redemption at par under queue rules  

LOOP is designed to be slow, boring, and verifiable.

---

### 14.12 Why LOOP Exists

LOOP exists to ensure:

- retained value is measurable  
- redemption is possible without lies  
- accounting remains honest  
- growth is earned, not implied  

LOOP is the **receipt of success**, not the incentive for it.

### 14.13 LOOP Is Not a Claim on Assets

LOOP does not represent:
- a claim on user vault funds,
- a claim on platform revenue,
- a claim on future profits,
- a claim on system deposits,
- a claim on the Redeemable Surplus Pool.

The Redeemable Surplus Pool is a **conversion source**, not collateral.


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

The system deposit operates under a **fixed, non-configurable reinvestment rule** designed to prevent discretionary intervention and preserve long-term system integrity.

All funds allocated to the system deposit are handled as follows:

- **50% remains liquid**
- **50% is redeployed into YieldLoop execution**

This rule applies universally and cannot be altered.

Specifically:

- The reinvestment split **cannot be changed** by governance  
- The reinvestment split **cannot be overridden** by administrators  
- The reinvestment split **cannot be paused, delayed, or selectively applied**  
- The reinvestment split **cannot be modified in response to market conditions or performance**

The redeployed portion:

- executes under the **same strategy constraints** as user capital  
- is subject to identical guardrails, halting conditions, and settlement rules  
- receives no execution priority and no loss protection  

The liquid portion:

- remains idle unless explicitly deployed under transparent treasury operations  
- is never borrowed against  
- is never pledged or rehypothecated  

This immutability ensures that system reinforcement is **predictable, auditable, and resistant to narrative-driven intervention**.

YieldLoop strengthens itself only through **earned surplus**, not discretion.

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

Redemption pacing, pauses, or queues may be enacted only through predefined protocol rules or prospectively disclosed governance actions and may not target individual users or requests.

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

Any governance bounties are discretionary compensation for specific work or contributions, not a return on a Supporter contribution, and may be zero.

Any Supporter-related fee discounts apply only to the user’s platform performance fee portion after settlement and do not alter profit calculation, LOOP minting rules, or system deposit allocations.

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

Any governance bounties are discretionary compensation for specific work or contributions, not a return on a Supporter contribution, and may be zero.

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

YieldLoop is an execution and accounting system for decentralized finance.  
It does **not** eliminate risk, guarantee outcomes, or insure capital.

All participation occurs at the user’s sole discretion and risk.

---

### 17.1 No Guarantees

YieldLoop makes **no guarantees** regarding:

- profitability  
- frequency of profit  
- redemption timing  
- continuous liquidity  
- strategy success  
- market behavior  

A cycle may result in profit, zero outcome, or loss.

---

### 17.2 Market and Execution Risk

Users acknowledge exposure to risks including, but not limited to:

- market volatility  
- adverse price movement  
- slippage and liquidity fragmentation  
- protocol or venue instability  
- smart contract vulnerabilities  
- oracle delays or failures  
- network congestion and gas volatility  

Execution occurs only within defined constraints, but constraints do not remove risk.

---

### 17.3 Strategy Risk

Strategies:

- may underperform or fail to produce profit  
- may carry inventory across cycles  
- may halt due to guardrail breaches or structural failures  
- may pause due to insufficient ECW funding  

Past performance does not predict future outcomes.

---

### 17.4 Inventory and Liquidity Risk

Open positions classified as inventory:

- may remain open for extended periods  
- may not be liquidatable at favorable prices  
- may experience prolonged illiquidity  

Inventory carries **without mark-to-market valuation** and produces **no profit recognition** until realized.

---

### 17.5 LOOP and Redemption Risk

LOOP:

- represents retained, verified surplus  
- is redeemable at par **only when liquidity is available**  
- may be subject to queues, pauses, or delays  

YieldLoop does **not** guarantee immediate redemption or continuous liquidity.

LOOP does not represent insured value or a risk-free asset.

Holding LOOP does not create a right to repayment, redemption on demand, or asset recovery.

---

### 17.6 No Insurance, No Bailouts

YieldLoop does not provide:

- insurance  
- capital protection  
- principal guarantees  
- emergency withdrawals  
- discretionary bailouts  

Losses, if they occur, are borne by the vault to which they apply.

---

### 17.7 User Responsibility

By participating, users affirm that they:

- understand the system mechanics  
- understand that capital is at risk  
- understand that execution is deterministic, not discretionary  
- understand that settlement outcomes are final  
- understand that delays and pauses are possible  

Users are responsible for:

- maintaining sufficient ECW funding  
- selecting or approving strategies  
- monitoring their vault state  
- complying with applicable laws and regulations  

A cycle that produces no verified profit may still produce a realized loss; YieldLoop does not conceal, offset, or reframe losses.

---

### 17.8 Not Financial Advice

YieldLoop does not provide:

- investment advice  
- trading recommendations  
- portfolio management services  

All strategy descriptions are technical explanations, not endorsements.

Users act independently and at their own risk.

---

### 17.9 Jurisdictional Restrictions

Participation may be restricted based on jurisdiction.

YieldLoop may:

- geoblock sanctioned or restricted regions  
- restrict access based on compliance requirements  
- update restrictions prospectively  

Users are responsible for ensuring lawful participation.

---

### 17.10 Acceptance of Risk

Participation constitutes explicit acknowledgment that:

- outcomes are uncertain  
- losses are possible  
- system rules govern all execution and settlement  
- transparency does not imply safety  

YieldLoop prioritizes **truthful outcomes over comforting narratives**.

### 17.11 Fiat On-Ramp and Off-Ramp Providers

Fiat on-ramp and off-ramp services (including but not limited to providers such as Stripe or Transak) are operated by independent third parties.

YieldLoop does not custody fiat funds and does not control fiat processing times, approvals, rejections, or availability. Delays or failures in fiat conversion do not alter cycle execution, settlement finality, LOOP accounting, or redemption rules.

---

## 18. Long-Term System Behavior

YieldLoop is designed to operate across extended time horizons without requiring constant activity, intervention, or narrative maintenance.

The system is allowed to wait.

---

### 18.1 No Activity Mandate

YieldLoop does not require:

- continuous execution  
- daily or weekly trading  
- monthly profitability  
- visible activity to appear functional  

Periods of inactivity are a valid and intentional outcome when conditions are unfavorable.

---

### 18.2 Behavior in Flat Markets

In low-volatility or range-bound markets:

- execution may be minimal or nonexistent  
- strategies may halt early  
- cycles may resolve with zero verified profit  

The system does not force trades to manufacture results.

---

### 18.3 Behavior in Declining Markets

In adverse or declining markets:

- guardrails may prevent execution entirely  
- capital may remain idle  
- losses may occur if strategies are active and markets move unfavorably  

YieldLoop prioritizes constraint over optimism.

---

### 18.4 Behavior in Volatile Markets

In highly volatile markets:

- execution may be selective and limited  
- ECW exhaustion may occur more frequently  
- guardrails may halt strategies rapidly  

Volatility does not override safety constraints.

---

### 18.5 Compounding Over Time

Long-term growth occurs only if:

- profitable cycles occur  
- surplus is verified and retained  
- system deposits compound execution capacity  

Growth is earned through execution reality, not assumed through modeling.

---

### 18.6 LOOP Over Long Horizons

Over extended periods:

- LOOP supply increases only with retained surplus  
- redemption value reflects accumulated accounting reality  
- stagnation or decline is possible if surplus generation slows  

LOOP mirrors system truth, not expectation.

---

### 18.7 System Resilience

YieldLoop resilience is achieved through:

- vault isolation  
- deterministic settlement  
- refusal to intervene mid-cycle  
- allowance for inactivity  

The system is designed to survive prolonged unfavorable conditions without distortion.

---

### 18.8 No Growth Obligation

YieldLoop has no obligation to:

- maximize assets under management  
- chase market trends  
- expand risk exposure  
- optimize for marketing optics  

Sustainability is preferred over scale.

---

### 18.9 Failure as a Permitted Outcome

YieldLoop may:

- underperform  
- stagnate  
- fail to attract capital  

These outcomes are permitted and acknowledged by design.

The system does not rely on inevitability.

---

### 18.10 Longevity Through Restraint

YieldLoop’s durability depends on:

- strict adherence to constraints  
- transparency of outcomes  
- acceptance of uncertainty  
- refusal to overpromise  

Restraint is the system’s primary defensive mechanism.

---

## 19. Conclusion — What Success Looks Like

YieldLoop is designed to be **boring, honest, and durable**.

Success in YieldLoop is not defined by activity, optics, or narrative momentum.  
It is defined by **truthful execution and verifiable accounting over time**.

---

### 19.1 What YieldLoop Refuses to Be

YieldLoop refuses to be:

- a savings account  
- a yield promise  
- a leverage engine  
- a speculative narrative  
- a discretionary trading desk  

The system is intentionally constrained to prevent distortion.

---

### 19.2 What YieldLoop Is

YieldLoop is:

- a cycle-based execution system  
- a deterministic settlement framework  
- a platform that permits inactivity  
- an accounting-first approach to decentralized execution  

It executes only what users explicitly approve and settles only what reality produces.

---

### 19.3 User Success

User success in YieldLoop means:

- understanding the system’s constraints  
- accepting uncertainty and inactivity  
- authorizing execution intentionally  
- evaluating outcomes honestly  

Profit may occur.  
Loss may occur.  
Both outcomes are valid and disclosed.

---

### 19.4 Platform Success

Platform success means:

- surviving adverse market conditions  
- refusing to fabricate or smooth outcomes  
- preserving auditability and finality  
- remaining solvent without hidden liabilities  

The platform is allowed to earn nothing rather than compromise integrity.

---

### 19.5 LOOP Success

LOOP succeeds if:

- it remains redeemable when surplus exists  
- it reflects retained surplus accurately  
- its value is earned, not implied  
- it survives without manipulation  

LOOP is a receipt of success — not an incentive for it.

---

### 19.6 Final Statement

YieldLoop does not promise outcomes.

It promises:

- boundaries  
- rules  
- transparency  
- finality  

Everything else is market reality.

YieldLoop measures success by **what it refuses to fake**.
