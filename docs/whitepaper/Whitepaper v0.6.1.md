# YieldLoop  
## A Monthly, Rules-Based Execution System for Honest Returns

**Author:** Todd Koletsky  
**Date:** January 2026  
**Version:** v0.6.1  

---

## Table of Contents

1. Introduction — What YieldLoop Is (and Is Not)
2. The Problem with Savings, Yield, and Automation
3. YieldLoop in Plain English
4. How YieldLoop Works (End to End)

5. Monthly Cycles and Why They Matter
6. Deposits, Withdrawals, and Timing Rules
7. Strategies, Rules, and Execution Boundaries

8. Execution Costs, Fees, and Economic Reality
9. Why YieldLoop May Do Nothing in a Given Month

10. Profit, Loss, and Inventory
11. The LOOP Token — Accounting, Redemption, and Floor Mechanics

12. Platform Fees and Fee Allocation
13. Carry-Over Settings and Standing Authorization
14. Risks, Limitations, and Things YieldLoop Will Never Do
  
15. YieldLoop as an Alternative to Savings and Yield Products
16. Technical Overview (Developer-Readable)
17. Disclosures, Acknowledgements, and User Responsibility


---

## 1. Introduction — What YieldLoop Is (and Is Not)

YieldLoop is a rules-based financial execution system designed to deploy capital honestly, within explicit boundaries, and report outcomes without distortion.

YieldLoop does not promise growth.  
It does not guarantee execution.  
It does not assume favorable conditions.  
It does not rewrite results.

Instead, YieldLoop allows users to define how their capital may be used, commit those rules to a fixed monthly execution window, and receive a final, truthful outcome at the end of each month.

Every month is a closed system.  
Every month settles once.  
Every result is final.

YieldLoop is designed to function correctly even when:
- markets are unfavorable  
- execution does not occur  
- profit does not exist  
- loss is realized  
- nothing happens at all  

That behavior is not a flaw.  
It is the core design principle.

### What YieldLoop Is

YieldLoop **is**:

- A non-custodial, smart-contract-based execution system  
- A monthly cycle–based framework for deploying capital  
- A rules-first alternative to opaque yield and automation products  
- A system where users approve risk *before* it is taken  
- A system that can remain idle without penalty or deception  

### What YieldLoop Is Not

YieldLoop **is not**:

- A savings account or bank product  
- A yield guarantee or income promise  
- A continuously active trading bot  
- A pooled investment vehicle  
- A system that fabricates or smooths results  
- A product that requires constant user action  

YieldLoop exists to answer one question honestly, every month:

> **What actually happened under the rules that were approved?**

Nothing more.  
Nothing less.

---

## 2. The Problem with Savings, Yield, and Automation

Most people place their money into one of two flawed systems.

### Traditional Savings

Savings accounts prioritize safety and liquidity, but offer limited opportunity for growth.

- Interest rates frequently trail inflation  
- Purchasing power erodes over time  
- Depositors do not meaningfully participate in how their capital is used  

Savings accounts feel stable, but are economically passive.

### Yield and Automation Products

Many modern yield and automation platforms advertise simplicity and returns, but rely on mechanisms that obscure reality:

- Projected or estimated APYs instead of settled outcomes  
- Continuous execution that users cannot pause or audit  
- Pooled risk that masks individual performance  
- Token emissions that simulate gains  
- Loss smoothing, delayed disclosure, or reclassification  

These systems often appear productive until market conditions change.

### The Real Problem

The core issue is not volatility.  
It is **misrepresentation**.

Most financial products are not designed to say:
- “We did nothing this month.”  
- “Execution was not possible.”  
- “This lost money.”  

YieldLoop was designed to say those things clearly and immediately — because any system that cannot say “no” will eventually lie.

---

## 3. YieldLoop in Plain English

YieldLoop works on a simple idea:

You define the rules.  
The system follows them — or does nothing.  
Each month ends with a clear result.

There is no requirement to take action every month.  
There is no need to constantly manage trades.  
There is no assumption that activity equals success.

### A Simple Mental Model

Think of YieldLoop as a **monthly attempt**, not a promise.

- Your configuration carries forward unless you change it  
- Each month is evaluated independently  
- Execution may occur, or it may not  
- Profit is possible, but never assumed  

You are not paying YieldLoop to “always trade.”  
You are authorizing YieldLoop to act **only if your rules can be respected**.

### What YieldLoop Optimizes For

YieldLoop does **not** optimize for:
- trade frequency  
- constant activity  
- engagement metrics  
- perceived momentum  

YieldLoop optimizes for:
- explicit consent  
- bounded risk  
- deterministic rules  
- clean accounting  
- truthful settlement  

Sometimes the most responsible action is inaction.

---

## 4. How YieldLoop Works (End to End)

This section describes the full lifecycle of a YieldLoop user, from first deposit to ongoing use.

No steps are hidden.  
No behavior is implied.

### Step 1: Connect Wallet

You connect a compatible wallet to the YieldLoop application.

YieldLoop is non-custodial.  
All permissions, balances, and constraints are enforced by smart contracts.

### Step 2: Deposit Funds and Fund Execution Costs (Any Time)

Each vault has **two separate balances**:

1. **Vault Principal** — the capital that may be deployed under your rules  
2. **Execution Cost Wallet (ECW)** — funds used exclusively to pay execution costs such as gas and trade fees  

You may deposit into either balance at any time.

- Common principal deposits include USDT or LOOP  
- ECW deposits are typically made in stable assets  
- A minimum deposit and minimum ECW balance apply for economic viability  

Depositing funds does **not** automatically place them at risk.

Funds deposited during an active month:
- are credited immediately to your vault or ECW  
- are **not** enrolled in the current cycle  
- apply automatically to the **next available monthly cycle**  

Execution costs are **never** borrowed from principal, profits, or the system.  
If ECW funds are insufficient, execution halts.

### Step 3: Configure Rules (Set Once, Change When Needed)

You define how your principal may be used.

Configuration may include:
- selecting assets or asset pairs  
- choosing market or limit-style entries  
- defining take-profit and stop-loss bounds  
- selecting execution styles (including DCA-like approaches)  
- choosing how profits are handled (compound, withdraw, or split)  

Configuration persists from month to month until changed.  
You are not required to reconfigure unless you want to.

### Step 4: Authorize Monthly Cycles

Execution occurs only after you authorize your vault for a monthly cycle.

Authorization means:
- your rules are locked for that month  
- your enrolled principal is committed  
- withdrawals are temporarily disabled  
- no mid-cycle changes are possible  

Authorization applies **per cycle**, even when settings carry forward.

### Step 5: Monthly Execution (or Inaction)

During the month, the system evaluates whether it can operate within your approved rules and available ECW funding.

- If conditions permit, execution may occur  
- If conditions do not permit, the system may remain idle  

Both outcomes are valid.  
Execution is allowed — never required.

### Step 6: Month-End Settlement

At the end of the month:
- all execution stops  
- realized balances are finalized  
- results settle once and permanently  

Each month resolves independently as:
- a net gain  
- a flat result  
- or a net loss  

Open positions that cannot be safely closed are classified as **inventory** and carried forward without being counted as profit.

### Step 7: After Settlement

Once settlement completes:
- withdrawals are re-enabled  
- additional deposits may be made  
- ECW balances may be topped up or withdrawn  
- rules may be changed  
- or nothing may be done at all  

If no changes are made, the next month proceeds under the same configuration — subject to a new cycle authorization.

YieldLoop does not force continuity.  
Every month is a separate, explicit attempt governed by rules you approved.

---

## 5. Monthly Cycles and Why They Matter

YieldLoop operates on **fixed, calendar-based monthly cycles**.

A cycle always corresponds to **one full calendar month**, beginning on the first day of the month and ending on the last day of the month, measured in UTC.

Cycles are the **only unit of execution, risk, and settlement** in the system.

This design is intentional and non-negotiable.

### What a Cycle Is

A cycle is a defined execution window with:

- a fixed calendar start  
- a fixed calendar end  
- locked rules  
- locked enrolled capital  
- a single settlement event  

Once a cycle begins, it runs to completion without interruption.

There is:
- no rolling participation  
- no mid-cycle entry  
- no mid-cycle exit  
- no mid-cycle reconfiguration  

Every cycle ends.  
Every cycle settles once.  
No cycle is ever revised after settlement.

### Why Cycles Exist

Calendar-bound cycles exist to eliminate ambiguity and unfairness.

They ensure:
- equal treatment of all participants  
- clean accounting boundaries  
- deterministic execution behavior  
- auditable historical results  
- strict separation between realized outcomes and unrealized exposure  

Without fixed cycles, systems drift into:
- partial participation  
- blended accounting  
- hidden timing advantages  
- continuous exposure users cannot clearly reason about  

YieldLoop explicitly rejects that model.

### What Is Locked at Cycle Start

At the start of each monthly cycle, the following are locked for that cycle:

- enrolled principal balance  
- approved execution rules  
- selected strategies  
- profit handling preferences  
- withdrawal availability  

No user, administrator, automated agent, or governance process may modify these during an active cycle.

The lock is:
- time-bounded to one calendar month  
- disclosed in advance  
- applied uniformly to all users  

### What Is Not Locked

The following are **not** locked by a cycle:

- deposits intended for future cycles  
- configuration changes for future cycles  
- ECW top-ups for future cycles  
- withdrawal decisions after settlement  

YieldLoop separates **current-cycle commitment** from **future intent**.

### Cycle Independence

Each calendar month stands alone.

- Results from one month do not carry assumptions into the next  
- Profit is not automatically compounded  
- Losses are not automatically recovered  
- Inventory does not imply future gain  

Each cycle answers one question only:

> What happened during this calendar month under the rules that were approved?

No projections.  
No implied momentum.  
No narrative smoothing.

---

## 6. Deposits, Withdrawals, and Timing Rules

YieldLoop allows deposits at any time, while strictly controlling **when funds are actually placed at risk**.

This section defines those rules precisely.

### Minimum Deposit Requirements

At launch, the following minimums apply:

- **Minimum principal deposit:**  
  **$100 USDT or equivalent value in LOOP**

- **Minimum Execution Cost Wallet (ECW) balance:**  
  **$10 USDT (or equivalent)**

- **ECW low-balance alert threshold:**  
  **$2.50 USDT (or equivalent)**

These values are **not hardcoded economic promises**.

They may be adjusted prospectively by:
- the YieldLoop team, or  
- future governance mechanisms  

Any changes apply **only to future cycles** and are disclosed in advance.

### Deposit Types

Each vault maintains two separate balances:

1. **Vault Principal**  
   Capital eligible for execution under approved rules.

2. **Execution Cost Wallet (ECW)**  
   Funds used exclusively to pay execution-related costs such as blockchain gas and trade fees.

Deposits are credited immediately to the appropriate balance.

### Deposit Timing and Enrollment

Depositing funds does **not** automatically place them into execution.

Enrollment follows strict rules:

- Deposits made **before authorizing a cycle**  
  → eligible for that upcoming cycle  

- Deposits made **after authorization or during an active cycle**  
  → held safely and applied to the **next calendar cycle**  

There is:
- no partial enrollment  
- no pro-rated participation  
- no mid-cycle exposure  

This prevents:
- timing-based advantages  
- blended accounting  
- confusion over participation  

### Execution Cost Wallet (ECW) Rules

The ECW is strictly isolated from principal.

- Execution costs are paid **only** from the ECW  
- Costs are never borrowed from principal  
- Costs are never borrowed from profit  
- Costs are never subsidized by the system  

If the ECW balance drops below the low-balance threshold:
- execution may pause for that vault  
- alerts may be shown to the user  

If the ECW balance is exhausted:
- execution halts immediately for that vault  
- no new trades are initiated  
- no debt is created  
- settlement proceeds normally  

ECW exhaustion is a valid and expected system outcome.

### Withdrawals

Withdrawal availability is determined strictly by vault state.

- **Before cycle authorization**  
  - full withdrawal of principal and ECW allowed  

- **During an active calendar cycle**  
  - withdrawals are disabled  
  - funds are locked until settlement  

- **After settlement**  
  - withdrawals are re-enabled  
  - principal, realized balances, inventory (where applicable), and ECW funds may be withdrawn  

There are no emergency or discretionary withdrawals during a cycle.

This rule:
- is disclosed before authorization  
- applies uniformly to all users  
- prevents preferential exits  

### After Settlement

Once a cycle settles:

- withdrawals become available  
- additional deposits may be made  
- ECW may be topped up or withdrawn  
- configuration may be changed  
- or no action may be taken  

If no changes are made, existing settings persist and may be authorized again for a future calendar cycle.

YieldLoop does not require monthly micromanagement.  
It requires only that rules and commitments are explicit before capital is placed at risk.

---

## 7. Strategies, Rules, and Execution Boundaries

YieldLoop does not deploy capital arbitrarily.  
All execution is governed by **explicit strategies**, **user-defined rules**, and **hard system boundaries**.

Strategies are execution mechanisms — not promises of profit.

### Strategy Selection

Before authorizing a cycle, a user selects one or more strategies that may operate on their enrolled principal.

Examples may include:
- spot market buying and selling
- rule-based entry and exit logic
- DCA-style execution over time
- conservative range-bound strategies

Strategies may differ in behavior, but all are subject to the same constraints defined below.

### User-Defined Rules

Every strategy operates only within **rules explicitly approved by the user**, which may include:

- eligible assets or asset pairs  
- entry conditions (market, limit, or rule-based)  
- take-profit thresholds  
- stop-loss thresholds  
- maximum allocation per strategy  
- maximum exposure limits  

These rules define the **outer bounds** of what the system is allowed to do.

If a strategy cannot operate within these bounds, it must not execute.

### Configuration Persistence

Strategy selections and rules persist from month to month unless changed by the user.

However:
- persistence does not imply execution
- persistence does not imply reauthorization
- persistence does not override cycle boundaries

Each cycle still requires explicit authorization.

### Execution Boundaries

All strategies in YieldLoop are subject to strict, non-negotiable boundaries.

Strategies **may not**:

- borrow capital  
- use leverage  
- use derivatives  
- pool funds across users  
- override user rules  
- override ECW funding limits  
- execute outside approved assets  
- execute mid-cycle changes  

Strategies **must**:

- respect user-approved bounds  
- halt when conditions are not met  
- halt if ECW funds are insufficient  
- halt if execution would violate constraints  

### No Forced Execution

Strategies are never required to act.

If market conditions, liquidity, volatility, or execution costs make an action unsafe or non-compliant:
- the strategy must skip execution
- the vault may remain idle for the cycle

Inactivity is a valid and expected outcome.

### No Forced Closure

Strategies are not required to close positions simply because a cycle is ending.

A position may remain open if:
- closing it would violate slippage limits  
- closing it would violate user-defined rules  
- sufficient ECW funds are not available  

Such positions are carried forward as **inventory** and excluded from profit calculations.

### Strategy Failure and Halting

If a strategy encounters a condition that makes continued execution unsafe or invalid:
- execution halts for that strategy
- no new actions are taken
- existing positions are left unchanged where possible

A halted strategy does not invalidate the cycle.

### Responsibility Boundary

YieldLoop executes strategies exactly as approved.

- Users are responsible for the rules they authorize  
- The system is responsible for respecting those rules  
- No discretion exists after authorization  

This separation is deliberate and absolute.

---

## 8. Execution Costs, Fees, and Economic Reality

All execution in YieldLoop has real, unavoidable costs.

This section explains how those costs are handled — transparently and without subsidy.

### Execution Costs

Execution costs include, but are not limited to:
- blockchain gas fees  
- decentralized exchange fees  
- protocol interaction costs  

These costs are paid **only** from the Execution Cost Wallet (ECW).

Execution costs are:
- not estimated as profit  
- not smoothed  
- not deferred  
- not subsidized  

They are real expenses incurred to attempt execution.

### Execution Cost Wallet (ECW) Enforcement

The ECW is the **sole source of execution funding**.

Rules governing ECW usage:

- principal is never used for execution costs  
- profits are never used for execution costs  
- the system never fronts or advances costs  
- no negative balances are possible  

If ECW funds are insufficient:
- execution pauses or halts
- no debt is created
- settlement still occurs normally

### Fees and Their Relationship to Profit

YieldLoop does not charge fees for inactivity.

Fees, if any, are assessed **only when verified profit exists**, and only at settlement.

If no verified profit exists:
- no performance fees are taken

Fees are never charged against:
- principal  
- unrealized inventory  
- ECW balances  

Fee structures and percentages are configurable and may evolve over time, subject to disclosure and prospective application.

### Economic Tradeoffs

Because execution costs are real, it is possible that:

- execution occurs but produces no net profit  
- execution costs exceed gains  
- a cycle resolves flat or at a loss  

These outcomes are not errors.

They are the natural result of honest execution under real market conditions.

### No Subsidies, No Illusions

YieldLoop will never:

- mint LOOP to disguise losses or simulate yield (LOOP may only be created from verified, settled profit and never to cover deficits)  
- borrow against future expectations  
- redistribute gains between users  
- hide costs inside pricing  
- fabricate net-positive outcomes  

If execution costs consume potential profit, that profit does not exist.

### User Awareness

Before authorizing a cycle, users are made aware that:

- execution costs are real and unavoidable  
- costs may exceed gains  
- profit is not guaranteed  
- inactivity may be preferable to forced execution  

YieldLoop does not optimize for appearances.

It optimizes for truth.

---

## 9. Why YieldLoop May Do Nothing in a Given Month

YieldLoop is explicitly designed to allow **inaction**.

Doing nothing is not a failure mode.  
It is a valid, intentional outcome.

### Inaction Is a Feature

Most financial systems are built to appear active at all times.
They trade continuously, rebalance constantly, or simulate engagement — even when conditions are poor.

YieldLoop rejects that behavior.

If execution cannot occur **honestly and safely** within approved rules, the system must not act.

This protects:
- user capital
- accounting integrity
- long-term system survivability

### Common Reasons for Inaction

A vault may experience little or no execution during a calendar month for reasons including:

- market prices never reach approved entry conditions  
- volatility exceeds acceptable bounds  
- liquidity is insufficient to meet slippage limits  
- execution would violate user-defined risk constraints  
- ECW funding is insufficient to safely execute  
- execution costs would likely exceed potential gains  

In all such cases, the correct behavior is to **skip execution**.

### No Penalty for Inaction

If no execution occurs during a cycle:

- no trades are opened  
- no capital is placed at risk  
- no execution costs are incurred  
- no fees are charged  

The cycle still settles cleanly at month end.

An idle month is not wasted.
It is simply a month where conditions did not justify action.

### No Implied Momentum

Inactivity does not imply:
- failure
- system malfunction
- missed opportunity
- future obligation to “catch up”

Each month is evaluated independently.
YieldLoop does not attempt to compensate for inactivity by increasing future risk.

### The Principle Behind Inaction

YieldLoop operates on a simple rule:

> If a system is not allowed to do nothing, it will eventually do something stupid.

By permitting inaction, YieldLoop preserves:
- discipline
- predictability
- honesty

---

## 10. Profit, Loss, and Inventory

YieldLoop treats profit, loss, and unrealized exposure as **distinct and non-interchangeable concepts**.

This separation is critical.

### Realized vs. Unrealized Outcomes

At the end of each calendar cycle, all positions fall into one of two categories:

1. **Realized Results**
   - positions that were fully closed
   - balances that are settled on-chain
   - costs that are fully accounted for

2. **Inventory**
   - positions that remain open
   - exposure that is unrealized
   - assets that have not been safely closed

Only **realized results** are used to determine profit or loss.

Inventory is excluded entirely.

### Profit

A cycle is considered profitable **only if**:

- positions were closed during the cycle  
- execution costs were paid  
- all applicable fees were deducted  
- the remaining balance exceeds the starting principal  

Profit is calculated at **cycle settlement**, not trade-by-trade.

There is no:
- projected profit
- unrealized profit
- estimated profit
- rolling PnL

Profit either exists at settlement, or it does not.

### Loss

A cycle may resolve at a loss if:

- execution occurred and prices moved unfavorably  
- execution costs exceeded gains  
- stop-loss rules were triggered  
- market conditions deteriorated after entry  

Losses are:
- realized
- disclosed
- final for that cycle  

Losses are not:
- smoothed
- deferred
- hidden
- offset by token emissions  

Loss is an allowed outcome.

### Flat Outcomes

A cycle may also resolve flat, meaning:

- no verified profit exists  
- no realized loss occurred  
- principal remains largely unchanged  

Flat outcomes are common and expected in conservative systems.

### Inventory

Inventory consists of positions that remain open at cycle end because closing them would violate approved constraints.

Inventory:
- remains inside the user’s vault  
- is not marked to market  
- is not treated as profit  
- does not trigger fees  
- does not mint tokens  
- does not compound  

Inventory does not imply recovery or future gain.

It is simply unrealized exposure.

### Inventory Carryover Rules

Inventory carries forward conservatively:

- inventory remains idle by default  
- inventory does not auto-trade next cycle  
- inventory requires explicit reauthorization to be used again  
- inventory may persist across multiple cycles  

Inventory exists to prevent forced liquidation for accounting convenience.

### Settlement Finality

Once a cycle settles:

- realized outcomes are final  
- accounting is closed  
- results are immutable  

There are no retroactive adjustments.

Each cycle produces a permanent record of:
- execution (or lack thereof)
- realized outcome
- remaining inventory

This finality is non-negotiable.

---

## 11. The LOOP Token — Retained Assets, Accounting, and Floor Mechanics

LOOP is a system token used to represent **real, realized, and permanently retained surplus** generated by YieldLoop.

LOOP does not generate profit.  
LOOP does not promise appreciation.  
LOOP does not influence execution behavior.  

LOOP exists solely as a **post-settlement accounting and redemption layer** that reflects surplus already earned — never assumptions about future performance.

### What Retained Assets Are

Retained assets are **real assets captured from verified net profit** at the end of a completed calendar cycle.

Retained assets may include:
- stable assets such as USDT (or equivalent)
- other explicitly approved base assets

Retained assets **do not include**:
- user principal
- execution cost wallet (ECW) balances
- unrealized inventory
- deposits
- borrowed capital
- marked-to-market or speculative values

Retained assets only exist **after**:
- the cycle has ended
- all execution has stopped
- all execution costs have been paid
- all applicable platform fees have been applied
- verified net profit exists

If no verified profit exists, no retained assets exist.

### The Role of LOOP

LOOP is an **accounting representation of retained surplus**, not a yield mechanism.

It exists to:
- separate realized surplus from active capital
- prevent artificial or projected yield reporting
- enable transparent accounting of retained value
- support long-term system sustainability
- provide a redemption reference tied to real backing

LOOP is optional.

Users may use YieldLoop without ever holding LOOP.  
Users may hold LOOP without actively using YieldLoop.

### When LOOP Is Created (And When It Is Not)

LOOP supply may be created, reduced, or otherwise modified **only at cycle settlement**, and only as the result of verified accounting.

LOOP may be created only when all of the following are true:

- a calendar cycle has fully settled
- verified net profit exists
- a portion of that profit is designated for retention
- retained assets are allocated to permanent system backing

There is:
- no pre-mint
- no emission schedule
- no inflation tied to deposits
- no minting during execution
- no minting to cover losses, simulate yield, or smooth outcomes

No profit → no LOOP.

### The LOOP Floor

The LOOP floor represents the **minimum redemption value per LOOP token**, derived exclusively from retained backing assets.

The floor:
- is not a market price
- is not a promise
- is not guaranteed to rise
- does not respond to speculation or trading activity

Conceptually:

> **LOOP Floor = Retained Backing Assets ÷ Effective LOOP Supply**

Only assets that are:
- realized
- retained
- locked
are included in floor calculations.

### How the Floor Can Rise (And Why That Matters)

The LOOP floor may rise only through verified, post-settlement changes to one or both sides of the equation:

1. **Backing increases** (numerator increases)  
2. **Supply decreases** (denominator decreases)

The floor cannot rise due to:
- user deposits
- inventory carryover
- execution activity
- secondary market trading
- speculative demand
- price narratives

Only **settled, retained surplus** affects the floor.

### Floor Stagnation or Non-Increase

The LOOP floor:
- may remain flat indefinitely
- may increase slowly
- may never increase at all

There is no obligation or expectation of appreciation.

LOOP reflects what the system has already earned — nothing more.

### Redemption (High-Level)

LOOP may be redeemable for underlying retained assets, subject to:
- available backing liquidity
- system-defined rules
- rate limits or throttling
- prospective policy changes

Redemption:
- does not affect active cycles
- does not affect execution behavior
- is conservative by design
- prioritizes system solvency

Redemption availability and timing are governed by policy and may be limited to preserve long-term system integrity.

---

## 12. Platform Fees, Allocation, and Supply Treatment

YieldLoop applies a **platform fee only when verified net profit exists**.

There are no platform fees on:
- deposits
- withdrawals
- principal
- inventory
- execution cost wallet (ECW) balances
- inactive cycles
- losing cycles

### Platform Fee Overview

At the time of publication, YieldLoop applies:

- **20% of verified net profit**, assessed at cycle settlement

This fee:
- is calculated only after all execution costs
- applies only to realized profit
- is never applied during execution
- is never applied retroactively

Fee parameters may be adjusted prospectively by the team or future governance, with advance disclosure.

### Fee Allocation (Five-Way Split)

Platform fees are allocated across **five distinct categories**, representing uses of **already-earned surplus**, not yield creation:

1. **Development**
2. **Marketing & Partnerships**
3. **Proof of Impact**
4. **System Backing (Locked)**
5. **Supply Reduction (Burn)**

Allocations are configurable prospectively but are applied deterministically at settlement.

### Development Allocation

Funds allocated to development are used to:
- maintain infrastructure
- improve execution systems
- fund audits and security
- support ongoing engineering and maintenance

### Marketing & Partnerships Allocation

Funds allocated to marketing and partnerships are used for:
- education and documentation
- ecosystem growth
- strategic partnerships
- user acquisition and distribution

### Proof of Impact Allocation

Funds allocated to Proof of Impact are used for:
- externally visible economic or social initiatives
- non-extractive deployment of surplus
- value creation beyond the platform itself

Proof of Impact allocations:
- do not affect execution behavior
- do not affect LOOP minting
- do not affect floor calculations

### System Backing Allocation (Locked)

Funds allocated to system backing are used to build **permanent, non-risk-bearing backing** for LOOP.

These assets are:
- locked permanently
- never deployed into execution
- never traded
- never withdrawn
- never used for discretionary spending

System backing exists solely to:
- support LOOP redemption
- increase the LOOP floor
- provide long-term credibility and solvency

Backing assets are **not exposed to market risk**.

### Supply Reduction (Burn Allocation)

The supply reduction allocation is used to permanently reduce LOOP supply.

Mechanism:
- LOOP allocated under this category is **irreversibly burned**
- burned LOOP is destroyed permanently
- total LOOP supply decreases
- retained backing remains unchanged

This results in:
- increased backing per remaining LOOP
- mathematically higher floor value
- accelerated floor growth without added risk

Burn behavior:
- is policy-defined
- is irreversible per event
- occurs only at settlement
- may be adjusted prospectively by governance

### Why YieldLoop Does Not Use a System Execution Vault

YieldLoop does **not** deploy system-retained surplus into execution strategies.

This design choice is intentional.

The system prioritizes:
- backing integrity over compounding risk
- floor reliability over speculative growth
- accounting clarity over philosophical symmetry

Retained surplus is either:
- locked as backing, or
- removed from supply via burn

It is never re-exposed to market risk.

### Fee Transparency and Finality

All platform fees:
- are disclosed before cycle authorization
- are applied only at settlement
- are reported explicitly
- are final once settled

There are:
- no hidden fees
- no discretionary overrides
- no retroactive changes

YieldLoop charges fees **only when real value is created** — and treats that value conservatively once earned.

---

## 13. Carry-Over Settings and Standing Authorization

YieldLoop is designed to minimize unnecessary user intervention while preserving explicit consent.

This section explains how settings persist safely across cycles and how standing authorization works without creating automatic or uncontrolled risk.

### Configuration Persistence

All user-defined configuration persists from cycle to cycle unless explicitly changed.

This includes:
- selected strategies
- asset eligibility
- entry and exit rules
- risk bounds
- profit handling preferences

Persistence exists for convenience only.

Persistence does **not** imply:
- automatic execution
- guaranteed activity
- assumed profitability
- perpetual authorization

Rules carry forward.  
Risk does not — unless explicitly reauthorized.

### Standing Authorization Concept

YieldLoop allows users to opt into **standing authorization** for future cycles.

Standing authorization means:
- the user approves the same configuration for repeated monthly cycles
- authorization renews automatically at the start of each new calendar month
- no mid-cycle changes are permitted

Standing authorization exists to reduce friction — not to obscure consent.

### Limits of Standing Authorization

Standing authorization does **not**:

- override execution boundaries
- force execution
- allow rule changes mid-cycle
- bypass ECW funding requirements
- enroll new deposits automatically mid-cycle

Each cycle remains:
- discrete
- time-bounded
- independently settled

Standing authorization may be revoked at any time **between cycles**.

### Deposits and Standing Authorization

When standing authorization is enabled:

- new deposits made between cycles may be enrolled in the next cycle
- deposits made during an active cycle remain excluded until the following cycle
- minimum deposit and ECW requirements still apply

Standing authorization does not alter enrollment rules.

### Safety Rationale

Standing authorization exists because:

- forcing monthly manual approval increases error
- repetitive authorization adds friction without reducing risk
- risk is already bounded by cycle locks and execution rules

YieldLoop favors:
- fewer decisions
- clearer boundaries
- stronger defaults

Explicit rules + bounded cycles are the true risk controls.

---

## 14. Risks, Limitations, and Things YieldLoop Will Never Do

YieldLoop is an execution system, not a guarantee.

This section outlines risks explicitly, without minimization or marketing language.

### Market Risk

YieldLoop operates in open markets.

Prices may:
- move against positions
- gap unexpectedly
- remain stagnant
- become illiquid

Loss is possible in any cycle.

### Execution Risk

Execution depends on:
- blockchain conditions
- network congestion
- decentralized exchange liquidity
- slippage constraints
- ECW funding availability

Execution may:
- fail
- partially execute
- halt early
- not occur at all

These outcomes are expected and valid.

### Strategy Risk

Strategies operate only within approved rules, but that does not eliminate risk.

- rules may be poorly chosen
- market conditions may change
- stop-losses may trigger unfavorably
- conservative strategies may underperform

YieldLoop does not optimize strategies on the user’s behalf unless explicitly stated.

### Inactivity Risk

YieldLoop may remain idle for extended periods.

Inactivity may result in:
- no profit
- opportunity cost
- flat outcomes over multiple cycles

YieldLoop prioritizes safety over forced activity.

### Inventory Risk

Inventory represents unrealized exposure.

Inventory:
- may persist across cycles
- may take extended time to resolve
- may eventually resolve at a loss
- does not imply future recovery

Inventory is not marked as profit.

### Token and Redemption Risk

LOOP:
- is not guaranteed to appreciate
- may never increase in floor value
- may be subject to redemption limits
- may experience low liquidity

Redemption may be:
- delayed
- throttled
- paused under defined conditions

### Platform Risk

YieldLoop depends on:
- smart contract correctness
- infrastructure availability
- operational discipline
- governance decisions

While designed conservatively, no system is risk-free.

### No Guarantees

YieldLoop makes no guarantees regarding:
- profit
- frequency of execution
- strategy performance
- LOOP appreciation
- redemption timing

Any outcome — including loss or inactivity — is possible.

### The Core Tradeoff

YieldLoop chooses:
- honesty over appearance
- bounded risk over constant motion
- final outcomes over projections

This means results may be slower, flatter, or less exciting than other systems.

It also means results are real.

### User Responsibility

By using YieldLoop, users acknowledge that:
- they define the rules
- they approve execution
- they accept outcomes
- they bear risk

YieldLoop enforces rules faithfully.  
It does not assume responsibility for outcomes beyond those rules.

YieldLoop is designed to be conservative, rule-bound, and resistant to manipulation.

Accordingly, YieldLoop will never:

- custody user funds off-chain  
- pool user funds across unrelated vaults  
- borrow or lend user principal without explicit product-level disclosure and user opt-in  
- use leverage or derivatives  
- front-run user execution or trade against users  
- force trades simply to appear active  
- force-close positions for accounting convenience  
- mark unrealized inventory as profit  
- charge performance fees on flat or losing cycles  
- charge performance fees on principal, ECW funds, or unrealized inventory  
- mint LOOP to cover losses, create fake yield, or smooth outcomes  
- apply rule changes retroactively to active or completed cycles  
- allow mid-cycle parameter changes once a cycle is authorized  
- create hidden fees that are not disclosed before authorization  
- guarantee returns, execution frequency, or LOOP appreciation  

YieldLoop is allowed to do nothing.  
YieldLoop is allowed to be wrong.  
YieldLoop is not allowed to lie.

---

## 15. YieldLoop as an Alternative to Savings and Yield Products

Any comparison to savings products is descriptive only and does not imply equivalent risk, protection, or guarantees.

YieldLoop is not a savings account.

It is also not a traditional yield product.

It exists in the space between the two.

### Comparison to Savings

Savings accounts prioritize:
- capital preservation
- liquidity
- predictability

They typically offer:
- low returns
- limited transparency into how funds are used
- little or no participation in upside

YieldLoop differs in that:
- capital may be actively deployed
- outcomes vary month to month
- profit is possible but not guaranteed
- inactivity is allowed when conditions are poor

YieldLoop does **not** replace savings.
It offers an alternative for capital that the user is willing to place at risk under explicit rules.

### Comparison to Yield and Automation Platforms

Many yield platforms emphasize:
- projected APYs
- continuous execution
- automated compounding
- constant activity

YieldLoop rejects these assumptions.

Instead:
- execution is optional
- cycles are fixed
- results are settled once
- profit is reported only when realized

YieldLoop does not attempt to look productive.
It attempts to be correct.

### Who YieldLoop Is For

YieldLoop may be appropriate for users who:

- want transparency over projections  
- are comfortable with bounded risk  
- prefer rules over promises  
- do not want to micromanage execution  
- accept that some months may produce no result  

### Who YieldLoop Is Not For

YieldLoop is likely **not** appropriate for users who:

- expect guaranteed returns  
- require continuous activity  
- cannot tolerate inactivity  
- want leverage or borrowing  
- want speculative token incentives  

YieldLoop is intentionally conservative.

That conservatism is the product.

---

## 16. Technical Overview (Developer-Readable)

This section provides a high-level technical description suitable for implementation.

### Core Components

YieldLoop consists of the following core components:

- User Vaults  
- Execution Cost Wallets (ECW)  
- Monthly Cycle Controller  
- Strategy Modules  
- Settlement Engine  
- Accounting and Reporting Layer  
- LOOP Token Contract  
- Governance and Configuration Layer  

### Vault Architecture

Each user vault maintains:
- a principal balance
- an ECW balance
- configuration state
- inventory state

Vaults are isolated.
No pooling occurs between users.

### Cycle Controller

The Cycle Controller:
- defines calendar month boundaries
- locks vault state at cycle start
- enforces execution eligibility
- triggers settlement at cycle end

Cycle state is immutable once active.

### Strategy Modules

Strategies are modular and stateless.

They:
- receive read-only vault configuration
- check execution eligibility
- request execution
- halt when constraints are violated

Strategies cannot:
- override rules
- borrow funds
- persist state outside inventory

### Settlement Engine

At cycle end, the Settlement Engine:
- halts execution
- finalizes realized balances
- classifies inventory
- applies fees (if profit exists)
- allocates retained assets
- records final outcomes

Settlement occurs once per cycle.

### LOOP and Fee Integration

LOOP minting or burning occurs only:
- after settlement
- after profit verification
- according to current policy

Fee routing is applied deterministically and prospectively.

### Configuration and Governance

Configurable parameters include:
- minimum deposits
- ECW thresholds
- fee percentages
- allocation splits
- burn behavior
- supported assets
- strategy availability

All changes:
- apply prospectively
- are disclosed
- do not affect active cycles

---

## 17. Disclosures, Acknowledgements, and User Responsibility

This document is provided for informational purposes only.

### No Financial Advice

YieldLoop does not provide:
- financial advice
- investment advice
- tax advice
- legal advice

Users are responsible for consulting qualified professionals as needed.

### Jurisdictional Limitations

YieldLoop may restrict access based on:
- jurisdiction
- sanctions
- regulatory requirements
- platform policy

Users are responsible for complying with local laws.

### Smart Contract Risk

YieldLoop relies on smart contracts.

While designed conservatively:
- bugs may exist
- exploits are possible
- losses may occur

No system is risk-free.

### Final Acknowledgement

By interacting with YieldLoop, users acknowledge that:

- they understand the system is risk-bearing  
- they approve execution rules explicitly  
- they accept outcomes as final  
- they bear full responsibility for their decisions  

YieldLoop enforces rules faithfully.

It does not promise outcomes.  
It reports them.

---
