# YieldLoop  
## A Redemption-Backed Trading System  
### Whitepaper & User Experience Specification

**Author:** Todd Koletsky  
**Date:** January 2026  
**Version:** v0.6.2  

---

## Table of Contents

1. Forward — Purpose of This Document

2. What YieldLoop Is (and Is Not)

3. The User Promise: Control, Cycles, and Accountability

4. System Overview (Conceptual)

5. The Monthly Cycle Model

6. User Journey Overview (End to End)

7. Wallet Connection and Eligibility

8. Deposits, Capital Segregation, and Lockups

9. Strategy Configuration and Guardrails

10. User Authorization and Risk Acceptance

11. Active Cycle Experience and Transparency

12. Profit, Loss, and Settlement UX

13. Platform Fees and Allocation Logic

14. The Redemption Reserve and Floor Growth

15. Over-Capitalization Mechanics

16. LOOP Token Design (Redemption-Based)

17. Minting Constraints and Coverage Ratios

18. Redemption UX and Value Anchoring

19. Supporter Program and Access-Based Incentives

20. What LOOP Is Not (Explicit Non-Features)

21. Risk Disclosure, Limitations, and Edge Cases

22. Governance Boundaries and Change Control

23. Transparency, Auditability, and Proofs

24. Long-Term System Behavior

25. Conclusion — YieldLoop as a New Execution Primitive

---

## 1. Forward — Purpose of This Document

This document serves two purposes at the same time:

1. It is a **whitepaper**, explaining how YieldLoop works at a system, economic, and accounting level.
2. It is a **User Experience (UX) specification**, describing what a user actually sees, agrees to, and experiences when using the platform.

These two perspectives are intentionally combined.

YieldLoop is not a theoretical protocol, a passive yield promise, or a speculative token design. It is an execution system that requires **explicit user consent**, **defined rules**, and **closed-cycle accounting**. The user experience is not separate from the economic model — it *is* the economic model.

This document is written to be readable by:
- Users who want to understand what they are agreeing to
- Builders and auditors who need clarity of behavior
- Partners and reviewers who want to understand system boundaries

No part of this document relies on assumptions, hidden behavior, or implied outcomes. Every action described here either:
- happens deterministically by rule, or
- does not happen at all.

If something is not explicitly stated in this document, it should be assumed **not to exist** in the system.

---

## 2. What YieldLoop Is (and Is Not)

### What YieldLoop Is

YieldLoop is a **calendar-month–based trading execution platform**.

Users deposit capital, define explicit trading rules, and authorize the system to execute those rules **only within a fixed calendar-month cycle**. Each cycle aligns exactly with the calendar month (e.g., January 1–31, February 1–28/29) and does not slide, overlap, or begin at arbitrary times.

All profit and loss is settled only after the calendar month fully concludes. There are no mid-cycle withdrawals, no hidden reinvestment, and no discretionary intervention.

YieldLoop is:
- Rules-based
- Time-bounded by calendar months
- Explicitly user-authorized
- Settlement-driven
- Honest about outcomes

The platform earns a fee only when users realize profit, and that fee is allocated transparently across development, operations, impact initiatives, and a permanently reserved Redemption Reserve.

At the center of the system is **LOOP**, a redemption-backed accounting token minted only from verified, realized profit and deliberately over-capitalized by design. LOOP exists to represent accumulated, provable system value — not to speculate, rebase, or promise yield.

---

### What YieldLoop Is Not

YieldLoop is **not**:
- A savings account
- A guaranteed return product
- A yield farm
- A liquidity mining scheme
- A continuously adjustable trading bot
- A discretionary asset manager

YieldLoop does not:
- Promise profits
- Hide risk
- Smooth losses
- Allow mid-cycle exits
- Rely on market liquidity to define value
- Mint tokens in advance of settled results

If a user loses money during a calendar-month cycle, that loss is recorded and settled honestly at month end. No mechanism exists to mask, defer, or offset that outcome.

This distinction is critical: YieldLoop does not exist to *manufacture* yield. It exists to **execute user-defined decisions within a fixed calendar period and account for the results truthfully**.

---

## 3. The User Promise: Control, Cycles, and Accountability

YieldLoop makes a single, narrow promise to the user:

> *You control the rules.  
> The system executes them faithfully.  
> You own the outcome.*

Every aspect of the UX and system architecture is designed to reinforce this promise.

---

### User Control

Before any calendar-month cycle begins, the user must:

- Select which assets may be traded
- Define entry conditions
- Define exit conditions
- Set explicit risk guardrails
- Choose how profits are handled at settlement
- Explicitly accept responsibility for outcomes

No defaults are hidden.  
No strategies are imposed.  
No automation acts without authorization.

If a user does not explicitly approve a setting, it does not exist.

---

### Calendar Cycles, Not Continuous Exposure

YieldLoop operates exclusively in **discrete calendar-month cycles**.

This design:
- Prevents emotional interference
- Eliminates surprise withdrawals
- Forces clean, auditable accounting periods
- Makes risk visible, finite, and time-bounded

Once a calendar-month cycle begins:
- Trading capital is locked
- Strategy rules are immutable
- Execution proceeds strictly within approved boundaries
- No mid-cycle changes are permitted

At the end of the calendar month:
- All positions are settled
- Profit or loss is finalized
- Platform fees apply only if profit exists
- Participation in the next cycle requires renewed consent

---

### Accountability

YieldLoop does not take responsibility for outcomes — and does not pretend to.

The platform:
- Executes exactly what was approved
- Records every action transparently
- Settles results honestly at month end
- Takes no performance fee unless profit exists

The user:
- Chooses the strategy
- Accepts the risk
- Owns the result

This division of responsibility is explicit and intentional. It is what allows YieldLoop to remain honest, durable, and resistant to both hype and collapse.

---

These sections define the behavioral contract of the system.

Everything that follows in this document is the **mechanical implementation** of these principles.

---

## 4. System Overview (Conceptual)

YieldLoop is a **calendar-month–based execution and settlement system**.

All system behavior is anchored to fixed calendar months (e.g., January 1–31, February 1–28/29). Cycles do not slide, overlap, or begin at arbitrary times. This constraint is intentional and foundational.

Capital enters the system, is governed by user-defined rules for a **specific calendar month**, and is settled only after that month fully concludes. There is no continuous exposure model, no discretionary timing, and no hidden state.

The system is composed of five conceptual layers:

1. **User Authorization Layer**  
   Where intent, rules, and responsibility are explicitly defined *before* the month begins.

2. **Capital Segregation Layer**  
   Where funds are separated by purpose (trading capital vs execution costs).

3. **Execution Layer**  
   Where trades occur strictly according to approved rules during the active month.

4. **Settlement & Accounting Layer**  
   Where all profit, loss, fees, and inventory are finalized after month-end.

5. **Redemption & Value Layer**  
   Where verified value is accumulated, recorded, and made redeemable over time.

Each layer has clear boundaries.  
No layer can override another.  
No action can occur outside an active calendar cycle.

---

### Key System Characteristics

- Fixed **calendar-month cycles**
- Deterministic execution
- No discretionary overrides
- No mid-month exits
- No hidden leverage
- No synthetic yield

YieldLoop behaves more like a **monthly clearing and settlement engine** than a traditional DeFi protocol.

---

## 5. The Calendar Month Cycle Model

The calendar month is the **primary control surface** of YieldLoop.

All user actions, system permissions, and accounting events are tied to it.

---

### Cycle Definition

A YieldLoop cycle is defined as:

> **00:00 UTC on the first day of a calendar month  
> through  
> 23:59:59 UTC on the final day of that same month**

No exceptions.

---

### Cycle Phases

Each calendar month consists of four fixed phases:

---

### 1. Configuration Phase (Before Month Start)

Before the calendar month begins, users may:

- Connect wallets
- Deposit capital
- Configure strategies
- Set guardrails
- Choose profit handling preferences
- Review and approve all settings

No trades occur during this phase.

---

### 2. Lock-In Phase (Month Boundary)

At the moment the calendar month begins:

- The cycle opens automatically
- All configured strategies become immutable
- Trading capital becomes locked
- Execution permissions activate

No configuration changes are allowed after this point.

---

### 3. Execution Phase (During the Month)

Throughout the calendar month:

- Trades are executed only within approved parameters
- Execution timing is determined by strategy logic
- Stop-losses and exits are enforced
- All actions are logged and observable

Users may monitor activity, but **cannot intervene**.

---

### 4. Settlement Phase (After Month End)

Once the calendar month fully concludes:

- All open positions are closed
- Profit or loss is finalized
- Platform fees apply **only if profit exists**
- LOOP minting (if eligible) occurs
- Withdrawals and compounding are applied per instruction

Settlement is final and irreversible.

---

### Why Calendar Months Matter

Calendar-month cycles exist to:

- Eliminate ambiguous timing
- Prevent strategy gaming
- Create clean accounting periods
- Align with tax, audit, and reporting norms
- Force explicit user consent each month

A user always knows:
- Exactly when risk begins
- Exactly when it ends
- Exactly which rules apply
- Exactly how outcomes are recorded

---

## 6. User Journey Overview (End to End)

From the user’s perspective, YieldLoop follows a **calendar-driven, repeatable journey**.

---

### Step 1: Connect Wallet

The user connects a compatible wallet and is presented with:

- Network status
- Account balances
- Current calendar cycle status
- Eligibility indicators (e.g., Supporter badge)

No capital is committed at this stage.

---

### Step 2: Prepare for the Upcoming Month

If the next calendar month has not yet started, the user may:

- Deposit trading capital
- Deposit funds into the Execution & Cost Wallet (ECW)
- Configure strategies for the upcoming month

Two capital buckets are always visible and distinct:

- **Trading Vault**  
  Used exclusively for strategy execution during the month.

- **Execution & Cost Wallet (ECW)**  
  Used exclusively for gas, routing, and execution costs.

---

### Step 3: Configure Strategy (Pre-Month)

Before the month begins, the user defines:

- Approved assets
- Entry method (market or custom)
- Exit conditions
- Stop-loss thresholds
- Additional guardrails
- Profit handling preferences

No defaults are hidden.  
Nothing is implied.  
If a rule is not defined, it does not exist.

---

### Step 4: Review and Authorize

Before the calendar month starts, the user must:

- Review a complete, read-only strategy summary
- Accept all risks explicitly
- Authorize execution for the upcoming month

Authorization is **month-specific** and does not persist indefinitely.

---

### Step 5: Month in Progress (Observation Only)

During the active calendar month:

- Trades execute automatically
- Guardrails are enforced
- Execution is visible in real time
- Capital remains locked

No settings can be changed.  
No withdrawals are possible.

This restriction is intentional and clearly communicated.

---

### Step 6: Month-End Settlement

After the calendar month ends:

- All positions are closed
- Profit or loss is finalized
- Fees apply only if profit exists
- LOOP minting occurs only if conditions are met
- Funds are withdrawn or compounded per prior instruction

The cycle ends cleanly.

---

### Step 7: Prepare for the Next Month

The user may then:

- Repeat the previous strategy
- Modify strategy settings
- Pause participation
- Withdraw remaining funds

Nothing rolls forward automatically without consent.

---

This calendar-driven journey is the **UX expression** of YieldLoop’s economic and accounting model.

Time is explicit.  
Rules are fixed.  
Outcomes are final.

The following sections expand each step in detail, starting with wallet connection and eligibility.

---

## 7. Wallet Connection and Eligibility

The wallet connection step establishes identity, eligibility, and system context.  
No capital movement or strategy authorization occurs at this stage.

---

### Wallet Connection

When a user connects a wallet, YieldLoop verifies:

- Network compatibility
- Wallet address
- Asset balances relevant to the platform
- Existing LOOP balance (if any)

The system does **not**:
- request spending approvals
- move funds
- infer intent

Connection is read-only until the user proceeds.

---

### Eligibility Indicators

After connection, the user is shown:

- Current calendar cycle status:
  - Upcoming month (configurable)
  - Active month (locked)
  - Settlement period (read-only)
- Account state:
  - Available balances
  - Active or pending strategies
- Status indicators:
  - Supporter badge (if applicable)
  - Any account-level restrictions

Eligibility is **binary and visible**.  
If an action is not allowed, the UI explains why.

---

### UX Principle

Wallet connection is informational, not transactional.

Users are never surprised by:
- missing permissions
- hidden requirements
- implicit approvals

Nothing happens until the user explicitly chooses to continue.

---

## 8. Deposits, Capital Segregation, and Lockups

YieldLoop enforces strict capital separation to prevent misuse, ambiguity, or cross-contamination of funds.

Every deposit is labeled by **purpose**.

---

### Capital Buckets

Users deposit into two distinct buckets:

---

#### 1. Trading Vault

Purpose:
- Capital used exclusively for strategy execution during the active calendar month

Rules:
- Minimum deposit enforced
- Locked at month start
- Cannot be withdrawn mid-month
- Cannot be used for fees or gas
- Used only according to approved strategy rules

This capital is exposed to market risk.

---

#### 2. Execution & Cost Wallet (ECW)

Purpose:
- Covers gas costs, routing fees, and execution overhead

Rules:
- Minimum balance enforced
- Not used for trading
- Drawn down only to pay execution-related costs
- Any unused balance remains the user’s property

This capital is **not** exposed to trading risk.

If ECW balance is insufficient, execution may be delayed or halted until replenished.

---

### Deposit Timing

Deposits may be made:

- **Before the calendar month begins**  
  → eligible for the upcoming cycle

- **After the month has started**  
  → held idle until the next calendar month

No deposits are activated mid-cycle.

---

### Lockup Behavior

At 00:00 UTC on the first day of the calendar month:

- Trading Vault balances become locked
- ECW remains accessible only for execution costs
- No withdrawals are permitted from the Trading Vault
- Strategy configuration becomes immutable

Lockups are:
- time-based
- predictable
- clearly communicated before deposit

---

### Transparency Guarantees

At all times, the UI displays:

- Amount deposited per bucket
- Lock status
- Next unlock timestamp
- Intended use of funds

YieldLoop does not pool user funds for discretionary use.  
Capital segregation is enforced by design, not policy.

---

The next sections detail how users configure strategies and define the rules that govern execution.

---

## 9. Strategy Configuration and Guardrails

Strategy configuration defines the **exact boundaries** within which YieldLoop is permitted to act.  
No execution authority exists until this configuration is completed and approved.

All strategy settings are **month-specific**.

---

### Asset Selection

Before a calendar month begins, the user selects which assets the system may trade during that month.

- Only supported assets are selectable
- Each asset must be explicitly approved
- Unselected assets are completely ignored by the system

If an asset is not selected, it cannot be traded under any circumstance.

---

### Entry Method

For each approved asset, the user defines how entry may occur:

- **Market Entry**
- **Custom Buy Price**

If a custom price is selected:
- The price must be explicitly entered
- The system will wait until conditions are met
- No fallback to market execution is assumed

---

### Exit Conditions

For each asset, the user defines exit rules:

- Take-profit price or percentage
- Optional staged exits (if supported)
- Optional time-based exits

If no exit condition is defined, the system does not invent one.

---

### Risk Guardrails

Risk controls are **opt-in but explicit**.

Available guardrails may include:
- Stop-loss price or percentage
- Maximum drawdown per asset
- Maximum allocation per asset
- Optional trade frequency limits

Guardrails are enforced mechanically.  
They are not advisory.

If a guardrail is hit, execution stops or exits exactly as defined.

---

### Strategy Scope

The system may only:
- enter positions
- manage positions
- exit positions

within the constraints explicitly approved by the user.

The system may not:
- increase risk beyond defined limits
- add assets
- widen stops
- ignore exits
- override guardrails

---

### Auto-Populate (Optional)

If enabled, an optional **Auto-Populate (Conservative)** function may:

- Fill settings using conservative defaults
- Display all values clearly before approval
- Require explicit user confirmation

Auto-population does **not** reduce user responsibility.

---

## 10. User Authorization and Risk Acceptance

Before a strategy can be activated for a calendar month, the user must explicitly authorize it.

This step is mandatory and cannot be bypassed.

---

### Strategy Review Summary

Prior to authorization, the user is shown a complete, read-only summary including:

- Selected assets
- Entry methods
- Exit conditions
- Guardrails
- Profit handling preference
- Applicable platform fee
- Calendar month covered
- Lockup and settlement timing

No hidden parameters exist beyond what is shown.

---

### Explicit Acknowledgements

The user must affirm each of the following:

- This is not financial advice
- Trading involves risk and potential loss
- Settings cannot be changed once the month begins
- Capital is locked for the duration of the month
- The user is responsible for outcomes
- Execution occurs automatically based on approved rules

Each acknowledgement requires an explicit action.

---

### Authorization Scope

Authorization applies:
- Only to the specified calendar month
- Only to the displayed strategy configuration
- Only to the deposited capital

Authorization does **not**:
- persist indefinitely
- apply to future months automatically
- grant discretionary control to the platform

---

### Failure to Authorize

If authorization is not completed before the calendar month begins:

- No trades occur
- Capital remains idle
- The user must reconfigure for a future month

No partial authorization exists.

---

This authorization process forms the **contractual boundary** between the user and the system.

The following sections describe the user experience during the active month and how execution transparency is maintained.

---

## 11. Active Month Experience and Transparency

Once the calendar month begins, the system enters **execution mode**.

From this point until month-end settlement, the user experience is intentionally limited to **observation and verification**. This is a design choice to prevent emotional interference and to preserve the integrity of the approved strategy.

---

### Execution State

During an active calendar month:

- Trading Vault capital is locked
- Strategy settings are immutable
- Execution authority is active
- Trades may occur at any time, subject to rules

The system does not request additional approvals mid-month.

---

### User Visibility

Throughout the month, the user can view:

- Current cycle status (active)
- Executed trades with timestamps
- Entry and exit prices
- Guardrail triggers (if any)
- Current unrealized P/L
- Remaining ECW balance

All execution data is:
- time-stamped
- attributable
- verifiable

There are no hidden trades and no off-ledger activity.

---

### Non-Interference Principle

During the active month, the user **cannot**:

- Modify strategy settings
- Add or remove assets
- Adjust stops or exits
- Withdraw trading capital
- Force liquidation
- Pause execution

These actions are disabled by design and clearly labeled in the UI.

This restriction is not a limitation — it is a safeguard.

---

### System Guarantees During Execution

The system guarantees that it will:

- Execute only approved actions
- Enforce guardrails mechanically
- Record all actions immutably
- Avoid discretionary intervention
- Respect capital segregation

The system makes **no guarantee** regarding performance or profitability.

---

## 12. Profit, Loss, and Settlement UX

Settlement is the moment when outcomes become final.

This occurs **only after the calendar month fully concludes**.

---

### Settlement Trigger

At 23:59:59 UTC on the final day of the month:

- Execution permissions end
- No new trades may be opened
- All open positions are prepared for closure

Settlement begins automatically.

---

### Settlement Actions

During settlement, the system:

- Closes all open positions
- Calculates realized profit or loss
- Aggregates execution costs
- Applies platform fees only if profit exists
- Applies profit handling preferences
- Determines LOOP mint eligibility

Settlement is deterministic and irreversible.

---

### Settlement Summary (User View)

After settlement completes, the user is shown a clear breakdown:

- Starting capital
- Ending capital
- Net profit or loss
- Platform fee (if applicable)
- Net amount credited
- LOOP minted (if any)
- Amount withdrawn or compounded

If no profit exists:
- No platform fee is charged
- No LOOP is minted

Losses are recorded honestly and without smoothing.

---

### UX Principle at Settlement

Settlement is designed to be:

- Clear
- Auditable
- Unemotional
- Final

There are no animations designed to exaggerate outcomes.  
There are no projected returns.  
There is no attempt to mask results.

---

### Post-Settlement State

After settlement:

- Capital is unlocked
- Instructions do not automatically roll forward
- The system awaits user input for the next calendar month

Participation always requires renewed consent.

---

The next sections describe how fees are applied, how value is accumulated long-term, and how LOOP functions as a redemption-backed accounting instrument.

---

## 13. Platform Fees and Allocation Logic

YieldLoop charges a **single performance-based platform fee**.

Fees are applied:
- **Only on realized profit**
- **Only after calendar month settlement**
- **Never on deposits**
- **Never on withdrawals**
- **Never on losses**

If a month ends with no profit, no platform fee is charged.

---

### Standard Fee

- **Platform fee:** 20% of realized net profit
- **Supporter fee:** 19% of realized net profit

The fee is calculated after:
- all positions are closed
- all execution costs are accounted for
- net profit is verified

---

### Internal Allocation Structure

Platform fees are distributed across five internal allocation buckets.  
The *percentages may change*, but the **structure does not**.

1. **Development**
   - Core protocol development
   - Strategy engines
   - Security upgrades
   - Maintenance and improvements

2. **Operations**
   - Infrastructure
   - Monitoring
   - Audits
   - Legal, compliance, accounting
   - Incident response

3. **Marketing**
   - User acquisition
   - Education
   - Documentation
   - Strategic partnerships

4. **Proof of Impact (LoopLab)**
   - Research
   - Education initiatives
   - Public-good tooling
   - Impact-aligned programs

5. **Redemption Reserve (Floor Growth)**
   - Permanently reserved capital
   - Used exclusively to back LOOP redemptions
   - Cannot be accessed for any other purpose

---

### Fee Transparency

The user is always shown:
- the total platform fee charged
- the effective fee rate
- confirmation that no fee is charged on losses

Internal allocation is visible at the system level and auditable.

---

## 14. The Redemption Reserve and Floor Growth

The **Redemption Reserve** is the structural anchor of YieldLoop.

It exists to:
- back LOOP redemptions
- provide conservative value accounting
- ensure long-term system stability

---

### Reserve Characteristics

Funds allocated to the Redemption Reserve are:

- Protocol-owned
- Irreversible
- Non-withdrawable
- Non-speculative
- Non-discretionary

Once value enters the reserve, it **never leaves** except through explicit LOOP redemption.

---

### Floor Definition

The system defines a **redemption floor**, calculated as:

Redemption Floor = Redemption Reserve ÷ Redeemable LOOP Supply

This value:
- is always visible
- is always conservative
- cannot be reduced by protocol actions

Market prices, if they exist, are non-authoritative.

---

### How the Floor Grows

The redemption floor increases when:

- Profit is allocated to the Redemption Reserve
- Minting is constrained by coverage ratios
- Redeemable supply grows slower than reserves
- LOOP is locked or used for utility instead of redemption

The floor is not managed.
It is **allowed to rise** through discipline.

---

## 15. Over-Capitalization Mechanics

Over-capitalization is a **deliberate system property**, not a marketing term.

---

### Definition

Over-capitalization exists when:

> The value held in the Redemption Reserve exceeds the value represented by redeemable LOOP.

This excess value is **unissued backing**.

---

### How Over-Capitalization Is Created

Over-capitalization is created through:

1. **Reserve Allocation**
   - A portion of platform fees flows directly into the Redemption Reserve

2. **Minting Constraints**
   - LOOP minting is capped by a minimum coverage ratio
   - Not all reserve growth results in new LOOP issuance

3. **User Behavior**
   - Users compound instead of redeem
   - LOOP is held for utility or future use
   - Redeemable supply grows slowly

---

### Coverage Ratio

The system enforces a minimum **coverage ratio**:

Coverage Ratio = Redemption Reserve ÷ Redeemable LOOP Value

LOOP may only be minted if this ratio remains above a conservative threshold.

If reserve growth exceeds minting capacity:
- the excess remains unissued
- over-capitalization increases
- the redemption floor rises automatically

---

### Why Over-Capitalization Matters

Over-capitalization ensures that:

- Redemption demand cannot break the system
- No death spiral can occur
- Losses cannot be masked by inflation
- Long-term holders are structurally favored
- The system remains solvent under stress

This is not leverage.
This is restraint.

---

The next sections describe LOOP itself — how it is minted, what it represents, and what it explicitly is not.

---

## 16. LOOP Token Design (Redemption-Based)

LOOP is a **redemption-backed accounting token**.

It exists to represent accumulated, verifiable value inside the YieldLoop system. LOOP is not designed to generate yield, speculate on price, or grant governance rights. Its purpose is accounting, redemption, and controlled value carry-forward across calendar cycles.

LOOP derives its value exclusively from the **Redemption Reserve**.

---

### What LOOP Represents

Each unit of LOOP represents a **claim on protocol-held assets**, subject to redemption rules and coverage constraints.

LOOP is:
- Backed by real, held value
- Minted only after verified profit
- Over-capitalized by design
- Conservative in issuance

LOOP is not a promise.  
It is a record.

---

### LOOP Supply Categories

The system distinguishes between:

- **Total LOOP Supply**  
  All LOOP tokens in existence.

- **Redeemable LOOP Supply**  
  LOOP that is immediately eligible for redemption.

Not all LOOP is redeemable at all times. Some LOOP may be:
- locked
- reserved
- assigned to utility functions
- pending eligibility

This distinction is critical to maintaining a rising floor.

---

## 17. Minting Constraints and Coverage Ratios

LOOP minting is **strictly constrained**.

The system does not mint LOOP simply because profit exists.

---

### Minting Preconditions

LOOP may only be minted if all of the following are true:

- The calendar month has fully settled
- Net realized profit exists
- Platform fees have been allocated
- Redemption Reserve has been updated
- The minimum coverage ratio is maintained

If any condition fails, no LOOP is minted.

---

### Coverage Ratio Enforcement

The system enforces a minimum coverage ratio:

Coverage Ratio = Redemption Reserve ÷ Redeemable LOOP Value

A configurable but conservative threshold is maintained at all times.

If minting new LOOP would cause the ratio to fall below this threshold:
- minting is reduced or halted
- excess value remains in the reserve
- over-capitalization increases

---

### Consequences of Constraint

Because minting is throttled:
- Not all profit becomes LOOP
- Excess value accumulates silently
- The redemption floor rises without issuance

This is intentional.

---

## 18. Redemption UX and Value Anchoring

Redemption is the **value anchor** of LOOP.

It defines the only authoritative value in the system.

---

### Redemption Value

The redemption value is calculated as:

Redemption Value = Redemption Reserve ÷ Redeemable LOOP Supply

This value:
- is displayed explicitly
- updates only at settlement
- cannot be manipulated by trading activity

Market prices, if present, are informational only.

---

### Redemption Actions

Depending on configuration, users may be able to:

- Redeem LOOP for protocol value
- Apply LOOP to platform fees
- Apply LOOP to deposits or withdrawals
- Hold LOOP as a value record

Redemption rules are visible before any action is taken.

---

### UX Guarantees

The user is never shown:
- speculative price charts
- projected returns
- market-based valuations

Only redemption value is emphasized.

---

## 19. Supporter Program and Access-Based Incentives

The Supporter Program is an **access and participation program**, not an investment product.

---

### Supporter Entry

Users may opt into the Supporter Program by paying a fixed fee.

In exchange, supporters receive:
- A visible Supporter badge
- A reduced platform fee rate
- Access to private discussion channels
- Eligibility for bounties and contribution-based rewards

---

### Supporter Boundaries

Supporter status:
- Does not grant profit guarantees
- Does not grant governance rights
- Does not affect redemption mechanics
- Does not influence execution outcomes

It is a participation layer, not a financial one.

---

## 20. What LOOP Is Not (Explicit Non-Features)

To avoid ambiguity, LOOP explicitly does **not** include:

- Yield promises
- Rebasing mechanics
- Algorithmic price targeting
- Liquidity mining
- Mandatory liquidity pools
- Governance voting rights
- Bailout or insurance guarantees

If a feature is not listed in this document, it does not exist.

---

## 21. Risk Disclosure, Limitations, and Edge Cases

YieldLoop involves real market risk.

Users may:
- lose money in a given month
- experience drawdowns
- have months with no execution
- receive no LOOP issuance

No mechanism exists to:
- smooth losses
- offset drawdowns
- manufacture returns

---

### System Limitations

The system does not:
- react emotionally
- adapt mid-cycle
- override approved rules
- intervene to protect capital

These limitations are intentional.

---

## 22. Governance Boundaries and Change Control

YieldLoop enforces strict boundaries on change.

---

### What Can Change

- Supported assets
- Fee allocation percentages
- Coverage ratio thresholds
- UX improvements

---

### What Cannot Change Retroactively

- Active month rules
- Settled outcomes
- Past redemption values
- Minting history

Changes apply only to **future calendar months**.

---

## 23. Transparency, Auditability, and Proofs

YieldLoop is designed to be auditable.

Users and reviewers can verify:
- Deposits and withdrawals
- Trade execution
- Settlement math
- Fee application
- Reserve balances
- LOOP issuance

No off-ledger accounting is required.

---

## 24. Long-Term System Behavior

Over time, YieldLoop is expected to:

- Accumulate reserves gradually
- Increase redemption value conservatively
- Remain solvent under stress
- Reward discipline over speculation

Growth is slow by design.

---

## 25. Conclusion — YieldLoop as a New Execution Primitive

YieldLoop is not a shortcut to yield.

It is a **discipline-first execution system** that prioritizes:
- explicit consent
- honest accounting
- conservative value accumulation
- irreversible settlement

LOOP is not a bet on price.

It is a record of what the system has actually earned.

This document defines the full behavioral contract between the user and the system.  
Nothing more is implied.

---


