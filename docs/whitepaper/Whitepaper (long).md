## YieldLoop Whitepaper

Todd Koletsky

12-20-25

Version: v0.1.3


# Forward — Who YieldLoop Is For (and Who It Is Not)

YieldLoop was not built to compete for attention.  
It was built to survive reality.

This platform exists for a specific type of participant — and it is deliberately unsuitable for others.  
Understanding this distinction before reading the rest of this document is essential.

---

## Who YieldLoop Is For

YieldLoop is designed for people who understand one or more of the following truths.

### 1. Those Who Do Not Want to Be Bothered — Regardless of Skill Level

YieldLoop is for participants who:
- Do not want to babysit positions
- Do not want to chase yields
- Do not want to react emotionally to charts
- Do not want to micromanage strategies

This includes:
- Experienced DeFi users who are tired of constant intervention
- Novices who want clarity and containment, not complexity
- Professionals who prefer defined cycles and final outcomes

Once a cycle is authorized, nothing is required of the user until settlement.

---

### 2. Novice DeFi Users Who Want Guardrails, Not Promises

YieldLoop is suitable for users who are new to DeFi **only if** they accept that:
- Loss is possible
- Zero-result cycles are normal
- No system guarantees profit

What YieldLoop provides is not upside marketing.  
It provides:
- Isolated, non-custodial vaults
- Explicit authorization boundaries
- No leverage
- No hidden mechanics
- No moving goalposts

The system is intentionally boring so mistakes are limited and visible.

---

### 3. Experienced Degens Who Are Done With Emissions and Games

YieldLoop is for users who have:
- Seen APYs disappear overnight
- Watched emissions mask losses
- Lived through liquidity death spirals
- Learned that dashboards often lie

This platform does not reward activity, volume, or hype.

It rewards **only completed, verified profit** — and does nothing otherwise.

---

### 4. Long-Term Thinkers Who See LOOP for What It Is

YieldLoop is for users who understand that:
- LOOP is not a reward
- LOOP is not an incentive
- LOOP is not a growth promise

LOOP is a **store of realized surplus** — an accounting representation of value that already existed before it was minted.

People who understand this are not chasing returns.  
They are accumulating proof.

---

## Who YieldLoop Is Not For

YieldLoop is intentionally **not** built for the following participants.

### 1. Anyone Looking for Guaranteed or Predictable Returns

If you are seeking:
- Stable yield
- Smooth curves
- Monthly expectations
- “Passive income” narratives

You should not use this system.

YieldLoop explicitly allows for:
- Flat cycles
- Zero-profit cycles
- Extended dormancy

The system does not apologize for reality.

---

### 2. Yield Chasers and APY Optimizers

YieldLoop does not:
- Rank strategies
- Optimize allocations
- Auto-compound without consent
- React to market momentum

If your goal is to maximize short-term yield at all costs, this system will feel restrictive.

That is intentional.

---

### 3. Users Who Expect Intervention or Overrides

YieldLoop does not:
- Step in mid-cycle
- Adjust parameters after authorization
- Smooth losses
- “Fix” outcomes

Once a cycle begins, it ends only one way: by settling the truth.

---

### 4. Anyone Unwilling to Accept Zero as a Valid Outcome

A zero-result cycle is not a failure in YieldLoop.  
It is a **correct outcome**.

If you cannot tolerate inactivity, pauses, or unprofitable periods, this system will frustrate you.

That is by design.

---

## Final Word

YieldLoop is not built to impress.  
It is built to endure.

If that matters to you, continue reading.  
If it does not, this platform is not for you.


Table of Contents

1. Abstract
2. Problem
3. Solution
4. Executive Summary

5. System Architecture Overview
6. Execution Cycle & State Machine
7. Ecosystem Walkthrough (User → System → Cycle)

8. Presale Referral Program
9. NFT Program
10. Post-Launch Referral Program

11. Post-Cycle Walkthrough & Platform Fees
12. Settlement & Accounting Logic
13. LOOP Token & Mechanics

14. Strategy Modules
15. DApp / UI / UX
16. Admin & System Controls

17. Customizable Governance System (Governors)
18. Governors Bounty Program

19. Failure Modes & Safeguards
20. Open Questions & Next Steps
21. Roadmap
22. Appendix A User Lifecycle, Execution Flow, and Control
23. Appendix B System States, Permissions, and Control Boundaries
24. Appendix C — Outcome Scenarios & Zero-Result Handling
25. Appendix D — What LOOP Is / Is Not (definitions)
26. Appendix E — Time, Cycles, and Cutoffs
27. Appendix F — How Returns Work in YieldLoop — Cycles, Markets, and LOOP
28. Appendix G — Strategy Engine Specifications

## 1. Abstract

YieldLoop is a cycle-based trading and yield platform designed to turn **real, completed profit** into a persistent system.

The platform runs user-authorized strategy bots inside non-custodial vaults. Each execution cycle is discrete. At the end of a cycle, the system measures actual profit after all costs. If profit exists, a platform fee is taken, profit is converted into LOOP, and the system reinvests its share to keep the engine running. If no profit exists, nothing happens.

There are no projections, no promised APYs, no smoothing, and no automatic compounding without user consent.

LOOP is minted only when profit is real. System-owned LOOP is redeposited to generate future profit. Over time, retained surplus strengthens an internal accounting floor that never erodes due to system logic.

YieldLoop is designed to:
- Survive flat and down markets
- Avoid dependence on emissions or inflation
- Make every cycle auditable and final
- Keep user funds isolated
- Keep the system economically self-sustaining

This document explains how the system actually works, end to end, so it can be built correctly.

When this document refers to the ‘floor,’ it refers to the internal accounting floor derived from retained surplus, not the external market price of LOOP, which may fluctuate independently.

The internal accounting floor represents retained surplus per LOOP for accounting purposes only and does not constitute price support, liquidity assurance, redemption timing, or market defense.

## 2. Problem

Most trading and yield platforms fail for the same reasons:

1. They measure success using **estimates instead of reality**
2. They mix **execution, incentives, and marketing**
3. They depend on **emissions, inflation, or constant growth**
4. They hide losses through smoothing, compounding assumptions, or dashboards
5. They collapse when markets go flat or down

### 2.1 Fake Yield and Assumed Performance

Many systems advertise yield that is:
- Projected, not realized
- Based on temporary incentives
- Masking losses with emissions
- Continuously re-marked without final settlement

Users see numbers go up even when no real profit exists. When incentives end or markets shift, the system breaks.

### 2.2 No Clear End to a Trade

In most platforms:
- Trades never truly “end”
- Positions roll forward indefinitely
- Performance is constantly re-evaluated
- Losses are deferred or hidden

This makes it impossible to say what actually happened in a given period.

### 2.3 Incentives That Fight the System

Platforms often:
- Earn fees on volume, not profit
- Profit when users lose
- Encourage constant reinvestment
- Require growth to survive

These incentives push systems toward risk-taking and leverage, even when it’s not sustainable.

### 2.4 No Separation of Concerns

Execution, accounting, marketing, and token value are usually blended together:
- Tokens are used to pay yield
- Yield props up token price
- Token price props up perceived yield

This creates circular dependency and collapse risk.

### 2.5 Emissions-Based Death Spirals

Inflationary reward systems:
- Require constant new users
- Dilute existing holders
- Create artificial returns
- Fail when growth slows

Once emissions stop, yield disappears.

### 2.6 Lack of Finality

Without hard cycle boundaries:
- Users don’t know when results are final
- Developers can’t reason about state
- Auditing becomes subjective
- Trust degrades

### 2.7 The Core Problem

The core problem is simple:

> **Most systems never prove profit. They only assume it.**

YieldLoop exists to fix that by forcing every cycle to end, settle, and tell the truth.


## 3. Solution

YieldLoop solves these problems by forcing **finality, separation, and truth** into the system.

The core idea is simple:

> **Nothing counts until the cycle ends.**

### 3.1 Discrete Execution Cycles

YieldLoop operates in hard, discrete cycles.

Each cycle:
- Starts with explicit user authorization
- Runs strategy bots within fixed limits
- Ends at a known time
- Settles completely
- Produces a final, unchangeable result

There is no rolling state and no continuous re-evaluation. Every cycle either makes profit or it doesn’t.

---

### 3.2 Profit Is Real or It Is Zero

YieldLoop is not a managed trading system. It does not select strategies, adjust parameters, reallocate capital, or exercise discretion on behalf of users. All execution behavior is explicitly defined and authorized by the user prior to cycle start.

At the end of a cycle, the system calculates profit using actual balances and actual costs.

profit = end_balance
- start_balance
- gas
- protocol costs

If profit is:
- `> 0` → it is real profit
- `<= 0` → it is treated as zero

There is no partial credit, smoothing, or carryover.

LOOP issuance is governed by a dynamic mint ratio that prioritizes retained surplus as the system matures.

### 3.2.1 Two Classes of Profit Recognition

YieldLoop distinguishes between execution-level realized profit and cycle-level finalized surplus.

Execution-level realized profit refers to profit generated by a completed, discrete action during an active execution cycle (for example, a closed trade or claimed yield). Such profit is real at the moment it is realized and may be handled according to user-authorized reward routing preferences defined prior to cycle start.

Cycle-level finalized surplus refers to the net result of the entire execution cycle after all execution has stopped and all costs, losses, and expenses have been deducted. Only cycle-level finalized surplus is eligible for LOOP minting and system-level accounting.

Execution-level profit distribution does not imply that a cycle is profitable. A cycle may distribute execution-level profit during execution and still resolve to a non-positive outcome at settlement. In such cases, no LOOP is minted and no cycle-level surplus is recorded.

This distinction is intentional. Execution-level profit represents liquidity, while cycle-level finalized surplus represents proof. YieldLoop does not conflate the two.

---

### 3.3 Fees Only on Profit

The platform only earns when users earn.

- No profit → no fee
- No volume-based fees
- No incentive to churn trades
- No incentive to increase risk

This aligns the system with long-term survival instead of short-term activity.

---

### 3.4 Profit Is Minted, Not Assumed

When profit exists:
- Fees are applied first
- A portion of verified retained surplus is minted into LOOP according to the Dynamic Mint Ratio (DMR). The remainder remains unminted and retained by the system.
- LOOP represents completed, realized surplus

There is no yield token emission, no pre-mint, and no inflation schedule.

If the system does not produce profit, no LOOP is created.

---

### 3.5 Separation of Concerns

YieldLoop explicitly separates:
- Execution (bots)
- Accounting (profit calculation)
- Incentives (fees and LOOP)
- System sustainability (system deposit)

No part of the system depends on another part pretending profit exists.

---

### 3.6 No Emissions, No Death Spiral

YieldLoop does not use emissions to fake yield.

- No reward dilution
- No dependence on new users
- No APY promises
- No growth requirement to survive

The system can:
- Grow slowly
- Go sideways
- Shrink
and still function.

---

### 3.7 System Deposit Creates Longevity

A portion of platform fees is retained by the system and redeposited into future cycles.

This creates:
- A self-funding execution engine
- A growing internal surplus when markets allow
- An internal floor that never erodes due to system logic

The system does not support price.
It supports **itself**.

---

### 3.8 Finality as a Feature

Every cycle ends.
Every result is final.
Every number can be audited.

This makes the system:
- Easier to build
- Easier to reason about
- Easier to debug
- Easier to trust

YieldLoop’s solution is not more complexity.

It is **less lying**.


## 4. Executive Summary

YieldLoop is a cycle-based profit system built to survive reality.

Users authorize strategy bots to run inside isolated vaults for a fixed period. At the end of each cycle, the system settles everything, measures real profit, and moves on. If profit exists, the platform takes a fee, profit is minted as LOOP, and the system reinvests its share. If no profit exists, the cycle closes flat.

There are no projections, no rolling balances, no assumed yield, and no emissions.

The system is built around a few non-negotiable rules:

- Nothing happens without user authorization
- No profit means no fees and no LOOP
- Every cycle ends and settles completely
- Users control compounding and redemption
- The system must be able to fund itself

LOOP is not a reward token. It is a representation of completed profit. LOOP only exists because a cycle finished with real surplus after costs. System-owned LOOP is redeposited to generate future profit and keep the platform alive over long periods without relying on growth or dilution.

Platform fees are split four ways:
- Development and operations
- Marketing
- LoopLabs
- System deposit

There is no explicit price support. Any strengthening of internal floor metrics happens automatically as retained surplus accumulates relative to LOOP outstanding. The floor cannot erode due to system logic, but it is not guaranteed to rise.

YieldLoop is intentionally boring:
- No APYs
- No leverage
- No hype mechanics
- No infinite loops

What it provides instead is finality, clarity, and an engine that only grows when it actually works.

LOOP includes a core but conditional redemption mechanism that allows retained surplus to be accessed over time when system solvency permits.

This document exists to explain that engine so it can be built correctly.


## 5. System Architecture Overview

YieldLoop is built as a set of **separable, auditable components**. No single component controls the system end-to-end. Each part has a narrow responsibility.

At a high level, the system consists of:

- User Vaults
- Strategy Bots
- Execution Cycle Controller
- Settlement & Accounting Engine
- LOOP Token
- System Deposit Engine
- DApp / Admin Interfaces

---

### 5.1 User Vaults

- Each user has an isolated, non-custodial vault
- Vaults hold user assets
- Vaults enforce execution limits and permissions
- Vaults can be locked and unlocked by cycle state

Vault properties:
- No pooled user funds
- No cross-user risk
- Bots cannot act outside authorized bounds
- Vaults reject withdrawals during active cycles

Each vault tracks:
- Starting balance (cycle start)
- Ending balance (cycle end)
- Authorized strategies
- Post-cycle handling preferences

---

### 5.2 Strategy Bots

Strategy bots are execution modules.

They:
- Perform trades or yield actions
- Operate only during active cycles
- Read constraints from the vault
- Stop if constraints are violated

Bots do **not**:
- Decide allocations
- Change parameters mid-cycle
- Coordinate with other bots
- Access system-owned funds unless explicitly authorized

Bots are intentionally dumb and predictable.

---

### 5.3 Execution Cycle Controller

The Execution Cycle Controller is the state machine that drives everything.

Responsibilities:
- Transition vaults between cycle states
- Enforce timing boundaries
- Lock and unlock vault access
- Trigger settlement

Cycle states:
1. Inactive
2. Configured
3. Active
4. Settlement
5. Post-Cycle

No component can bypass this controller.

---

### 5.4 Settlement & Accounting Engine

This engine runs **once per cycle**, after execution ends.

Responsibilities:
- Snapshot vault balances
- Calculate profit or loss
- Deduct gas and protocol costs
- Determine if profit exists
- Trigger fee logic
- Trigger LOOP minting (if applicable)

Settlement is:
- Atomic
- Deterministic
- Final

Once settlement completes, results cannot be changed.

---

### 5.5 LOOP Token Contract

The LOOP contract:
- Mints LOOP only when instructed by settlement
- Never mints during execution
- Has no emissions schedule
- Does not respond to market conditions

LOOP supply grows **only** when profit is real.

---

### 5.6 System Deposit Engine

The System Deposit Engine handles system-owned funds.

It:
- Receives the system’s portion of platform fees
- Holds non-user-owned LOOP and assets
- Reauthorizes system funds into future cycles
- Enforces non-withdrawable rules

System deposit funds:
- Are never user balances
- Cannot be redeemed by users
- Exist only to keep the platform running

This is the perpetual engine.

System vaults represent the on-chain manifestation of retained surplus. These vaults participate in execution cycles under the same rules as user vaults but are restricted from withdrawal. Losses incurred by system vaults reduce retained surplus and do not create obligations against user funds.

---

### 5.7 DApp & Admin Interfaces

The UI layer:
- Shows vault state
- Shows cycle status
- Shows finalized results
- Allows configuration and authorization

Admin interfaces:
- Enable / disable strategies
- Adjust fee parameters
- Control system deposits
- Pause execution in emergencies

Admins **cannot**:
- Touch user vault balances
- Modify settled results
- Mint LOOP manually

---

### 5.8 Data Flow Summary


User Vault
↓
Strategy Bots
↓
Execution Cycle Controller
↓
Settlement & Accounting
↓
LOOP Minting
↓
User Handling + System Deposit

Each arrow represents a **one-way boundary**.

---

### 5.9 Design Principle

If a component fails:
- The cycle ends
- Settlement occurs
- The system moves on

No retries that hide reality.
No silent fixes.
No magic.


## 6. Execution Cycle & State Machine (Expanded)

The execution cycle is the backbone of YieldLoop.  
Every action in the system is gated by explicit cycle state. No component is permitted to operate outside the active state, and no outcome is recognized unless it occurs within a completed cycle.

This structure is intentional and non-negotiable.

---

### 6.1 Cycle Definition

A **cycle** is a fixed, discrete execution window during which user-authorized strategy modules may operate inside a user’s vault.

Each cycle has:
- A defined start time
- A defined end time
- Immutable parameters once execution begins
- A single, final settlement event

A cycle closes the ledger and finalizes accounting value, not necessarily forced liquidation of all open positions. Any positions that persist beyond cycle end are deterministically valued at settlement using protocol-defined valuation rules and are treated as finalized for accounting purposes.

Cycles do not overlap.  
Cycles do not roll forward.  
Cycles do not partially settle.

If a cycle does not complete, it does not produce results.

---

### 6.2 Canonical Cycle Duration

By default, YieldLoop operates on **fixed calendar cycles** (e.g., one month).

Key properties:
- Cycle duration is disclosed prior to authorization
- Duration is fixed for the life of the cycle
- Duration changes (if allowed by governance) apply **prospectively only**
- Different users may participate in different cycles, but each vault participates in only one active cycle at a time

There are no discretionary extensions, early terminations, or priority exits.

---

### 6.3 Deposit Timing vs Execution Timing

Deposits and execution are deliberately decoupled.

Rules:
- Users may deposit assets into their vault at any time
- Deposits made while no cycle is active remain idle
- Deposits made during an active cycle **do not participate** in that cycle
- Mid-cycle deposits are queued automatically for the next cycle

No funds enter execution unless explicitly authorized at the start of a cycle.

This prevents partial exposure, accounting ambiguity, and mid-cycle manipulation.

---

### 6.4 Cycle States (Authoritative)

Each vault progresses through the following states, in strict order:

1. **Inactive**  
2. **Configured**  
3. **Active**  
4. **Settlement**  
5. **Post-Cycle**

States cannot be skipped, reordered, or partially entered.


Redemption availability is a conditional post-cycle substate and does not represent a separate execution state.

---

### 6.5 Inactive State

Default vault state.

Characteristics:
- No execution permitted
- Vault fully accessible to the user
- Deposits and withdrawals allowed
- No parameters locked

Transition:
- Inactive → Configured (user begins setup)

---

### 6.6 Configured State

The user has defined execution parameters but execution has not yet begun.

Locked once authorized:
- Strategy selection
- Allocation limits
- Slippage limits
- Execution frequency
- Post-cycle handling preferences

Still allowed:
- Parameter edits
- Cancellation
- Return to Inactive

Not allowed:
- Execution
- Mid-cycle authorization changes

Transitions:
- Configured → Active (user authorizes execution)
- Configured → Inactive (user cancels)

---

### 6.7 Active State (Execution)

Execution is live.

Characteristics:
- Strategy modules may operate
- Vault withdrawals are disabled
- Parameters are immutable
- Execution boundaries are strictly enforced

Rules:
- Strategies may act only within explicit authorization
- If a strategy fails, it halts
- Other authorized strategies may continue independently
- No human or administrative intervention is permitted

Not allowed:
- Withdrawals
- Parameter changes
- Strategy substitution
- Emergency “fixes”

Transition:
- Active → Settlement (cycle end or execution halt)

---

### 6.8 Settlement State

Settlement operates exclusively on realized surplus.
Unrealized gains, open exposure, and mark-to-market valuations are never treated as profit and are excluded from accounting.

During an active cycle, realized surplus generated through completed actions may be segregated into user-designated reward or reinvestment balances according to pre-authorized settings.

Such balances may belong to one of two classes:

• Execution-level reward balances, which may be withdrawable during an active cycle if explicitly authorized by the user prior to cycle start; and
• Cycle-level accounting balances, which remain escrowed, auditable, and non-withdrawable until cycle completion.

Withdrawal of execution-level reward balances does not affect settlement accounting, cycle-level profit determination, LOOP minting eligibility, or system surplus calculations.

Cycle completion finalizes the ledger, authorizes reward claims, and determines LOOP minting. No profit exists outside this process.

Execution has ended. Accounting begins.

Characteristics:
- No execution permitted
- Vault remains locked
- Settlement logic runs exactly once

Settlement actions:
- Snapshot starting and ending balances
- Deduct gas and protocol costs
- Determine profit or non-profit outcome
- Apply platform fees (if applicable)
- Authorize LOOP minting (if applicable)

Settlement is:
- Atomic
- Deterministic
- Final

If settlement fails, the cycle does not advance.

Transition:
- Settlement → Post-Cycle (successful completion)

---

### 6.8.1 Settlement Retry and Recovery (Fail-Closed Guarantee)

Settlement is designed to be deterministic and final; however, the system must not permit user funds to become permanently locked due to settlement failure.

Accordingly, the following rules apply:

- Settlement execution is permissionless and may be retried by any caller.
- If settlement fails due to transient conditions (e.g., gas limits, external dependency reverts), it may be retried until successful.
- If settlement cannot complete after a governance-defined timeout or retry threshold, the vault enters a Recovery state.

In the Recovery state:
- No LOOP minting may occur.
- No platform fees may be collected.
- Execution is permanently halted for the affected cycle.
- User vault withdrawals are re-enabled.
- Accounting is finalized using the last verifiable state.

The Recovery state exists solely to prevent indefinite fund lock while preserving accounting integrity. No recovery path may mint LOOP or retroactively alter outcomes.

### 6.9 Post-Cycle State

The cycle is complete.

Characteristics:
- Vault unlocks
- Results are final and immutable
- User regains full control

Allowed actions:
- Withdraw assets (partial or full)
- Withdraw LOOP (if minted)
- Compound LOOP (if selected)
- Configure a new cycle
- Remain idle

Not allowed:
- Modifying settled results
- Reopening or replaying a completed cycle

Transitions:
- Post-Cycle → Configured (new cycle)
- Post-Cycle → Inactive (do nothing)

Redemption is only evaluated and permitted when a vault is in a post-cycle or redemption-available state and is never permitted during Active or Settlement states.

---

### 6.10 Zero or Non-Positive Cycles

If net profit ≤ 0:
- No platform fee is charged
- No LOOP is minted
- No system allocation occurs
- The cycle closes flat

This is a valid, expected, and correct outcome.

Remaining user assets stay in the vault, reduced only by actual execution losses and costs.

---

### 6.11 Failure Handling During Active State

If any of the following occur:
- Strategy execution error
- External protocol failure
- Chain instability
- Gas limit breach

Then:
1. Execution halts immediately
2. The vault remains locked
3. The system transitions directly to Settlement
4. Reality is recorded as-is

No retries.  
No smoothing.  
No overrides.

Settlement after execution halt does not attempt to normalize, rebalance, or compensate partial execution. Incomplete actions are treated as non-events for accounting purposes.

---

### 6.12 Emergency Halt Semantics

Administrators may:
- Prevent new cycles from starting
- Halt active execution globally

Emergency halt sequence:
1. Execution is stopped
2. Vaults remain locked
3. Settlement proceeds using current state
4. Vaults unlock post-settlement

Administrators may NOT:
- Modify parameters
- Re-route funds
- Alter settlement outcomes
- Resume execution mid-cycle

Emergency controls exist to preserve safety, not performance.

---

### 6.13 Withdrawal & Exit Policy (Canonical)

Withdrawals are permitted only when a vault is **not** in Active or Settlement state.

During Active and Settlement:
- Withdrawals are disabled
- Partial exits are not allowed

After settlement:
- Full withdrawal is permitted
- Partial withdrawal is permitted
- Account exit is immediate and unrestricted

All withdrawal constraints are disclosed prior to authorization and cannot be altered mid-cycle.

---

### 6.14 Why This Matters

This state machine enforces:
- Finality
- Auditability
- Predictability
- User sovereignty

If something did not occur within a completed cycle, it does not exist.

That is the rule.

---
## 7. Ecosystem Walkthrough

This section explains how all parts of the YieldLoop ecosystem interact over time, from a user’s first touch through long-term system operation.

This is not a user guide. It is a system flow explanation.

---

### 7.1 Entry Points

There are three primary entry points into the ecosystem:

- User deposits and cycle participation
- NFT participation (optional)
- Referral programs (pre- and post-launch)

None of these paths are required to use the core system except direct user authorization of execution cycles.

---

### 7.2 User Lifecycle

A typical user lifecycle looks like this:

1. User connects a wallet
2. User deploys or accesses a personal vault
3. User deposits assets
4. User configures a cycle
5. User authorizes execution
6. System runs a cycle
7. Cycle settles
8. User reviews results
9. User withdraws, compounds, or reauthorizes

At no point does the system act without user authorization.

---

### 7.3 Vault-Centric Design

Everything in YieldLoop revolves around the user vault.

- Strategies execute from the vault
- Profit is measured at the vault level
- LOOP is credited at the vault level
- Withdrawals and compounding occur at the vault level

There are no shared balances between users.

---

### 7.4 System-Owned Participation

In parallel with users, the system itself participates:

- The system accumulates LOOP from platform fees
- System-owned LOOP is deposited into cycles
- System profit feeds future cycles
- This creates a self-sustaining execution engine

System participation follows the same cycle rules as users but uses system-owned vaults.

---

### 7.5 Optional Programs

Optional ecosystem programs include:
- NFTs
- Referrals
- Governor participation
- Bounty programs

These programs:
- Do not affect execution logic
- Do not change strategy behavior
- Do not change profit calculation
- Do not grant execution privileges

They exist to support growth, coordination, and long-term development.

---

### 7.6 Long-Term Loop

Over time, the ecosystem forms a loop:

User Capital + System Capital
↓
Execution Cycles
↓
Real Profit
↓
LOOP Minting
↓
System Deposit Grows
↓
Stronger Internal Floor
↓
More Durable System

This loop can slow down, pause, or reverse in bad markets without breaking the system.

---

### 7.7 Key Takeaway

YieldLoop is not designed to maximize short-term yield.

It is designed to:
- Make profit only when possible
- Tell the truth when it is not
- Keep running without dilution
- Let users decide when to participate

Everything else is optional.


## 8. Presale Referral Program

The presale referral program exists to bootstrap early awareness and community participation before public launch.

This program is optional, time-limited, and separate from core system execution.

---

### 8.1 Purpose

The goals of the presale referral program are:

- Seed an initial community
- Reward early outreach and effort
- Identify high-signal contributors before launch
- Create distribution without emissions

This program does not affect trading, yield, execution priority, or profit mechanics.

---

### 8.2 Structure

The presale referral program is milestone-based, not volume-based.

Participants earn eligibility by:
- Inviting real people
- Verifying they are human
- Participating meaningfully (not bots or drive-bys)

There is no passive earning.

---

### 8.3 Verification Requirements

A referral is considered valid only if the referred participant:

- Is a unique, real human
- Joins official community channels
- Verifies identity as a human (method defined by ops)
- Introduces themselves
- Acknowledges who referred them
- Engages meaningfully (questions, discussion, feedback)

Spam, automation, or fake accounts invalidate eligibility.

---

### 8.4 Presale Referral Tiers

#### Tier 1 — Early Outreach

- Requirement: 25 verified human referrals
- Limit: First 10 participants to reach the threshold
- Reward: Eligibility to receive 1 Supporter NFT at launch

#### Tier 2 — Early Leadership

- Requirement: 100 verified human referrals
- Limit: First 3 participants to reach the threshold
- Reward: Eligibility to receive 1 Governor NFT at launch

Governor NFTs granted through this program follow the same rules as all Governor NFTs (non-transferable, revocable, advisory only).

---

### 8.5 No Financial Claims

Presale referral rewards:

- Are not income
- Are not yield
- Are not compensation
- Do not represent profit-sharing
- Do not imply future benefits

They are recognition for early effort only.

---

### 8.6 Enforcement and Revocation

The team may:
- Disqualify referrals for abuse
- Revoke eligibility if fraud is discovered
- Modify or terminate the program

All decisions are final.

---

### 8.7 Expiration

The presale referral program:
- Exists only before public launch
- Ends automatically at launch
- Does not carry forward

Unmet thresholds expire without rollover.

---

### 8.8 Key Constraint

Presale referrals do not:
- Affect platform fees
- Affect execution logic
- Affect LOOP issuance
- Affect future referral eligibility

They exist entirely outside the core engine.


## 9. NFT Program

The NFT program is an **optional utility and coordination layer** within the YieldLoop ecosystem.

NFTs do not affect:
- Strategy execution
- Yield generation
- Risk exposure
- Profit calculation
- LOOP minting
- Cycle timing or priority

NFTs are not required to use the platform.

---

### 9.1 Purpose

The NFT program exists to:

- Provide protocol-fee discounts
- Signal participation and trusted roles
- Gate access to specific UI and community areas
- Support marketing, partnerships, and early funding

NFTs do **not**:
- Represent ownership or equity
- Grant profit rights
- Guarantee benefits
- Grant execution, admin, or settlement authority

---

### 9.2 NFT Tiers

YieldLoop supports two NFT tiers:

1. **Supporter NFT**
2. **Governor NFT**

Each tier has clearly defined and limited utility.

---

### 9.3 Supporter NFT

**What it is**
- A general-purpose utility NFT for supporters of the YieldLoop platform

**Pricing**
- Initial proposed mint price: **$300 USD equivalent**
- Implemented as a **BNB-denominated mint price**
- The mint price is **adjustable over time via governance**
- Price changes apply **prospectively only**
- No on-chain oracle is required in v1

**Supply**
- Unlimited

**Discount**
- Grants a **5% platform-fee discount**
- Applied:
  - Only at settlement
  - Only on profitable cycles
  - Only to the platform fee
- Does not apply to gas, slippage, execution losses, or third-party fees

**Access**
- Unlocks a **Supporter-only community channel**
- May unlock Supporter-only UI visibility or features

**Minting**
- Public mint when enabled
- The team may **admin-mint and award Supporter NFTs** for:
  - Marketing
  - Partnerships
  - Promotions
  - Onboarding
  - Community initiatives

**Transferability**
- Freely transferable
- Benefits follow the wallet holding the NFT

Supporter NFTs do not grant governance, advisory, or decision-making authority.

---

### 9.4 Governor NFT

**What it is**
- A role-based NFT representing a trusted advisory and support position

**Acquisition**
- Not publicly sold by default
- Typically bestowed by the team via admin mint
- Any future public availability must be explicitly disclosed

**Supply**
- Limited by policy, not hard-capped

**Discount**
- Grants a **10% platform-fee discount**
- Overrides Supporter discount if both are present

**Role**
- Advisory and support only
- May participate in:
  - Strategy discussion (non-binding)
  - Risk review
  - Education and onboarding
  - Partnerships and ecosystem support

**Transferability**
- **Non-transferable by default**
- Transfer allowed only if:
  - Explicitly authorized by team multisig
  - Approved for a specific token and recipient
- Unauthorized transfers must revert

**Revocation**
- Governor NFTs may be revoked and burned by admin action
- Reasons include inactivity, abuse, misrepresentation, or loss of trust

**One-per-wallet / person**
- Intended limit: one Governor NFT per wallet
- Contract-level enforcement recommended
- One-per-person enforced by policy (no KYC required)

Governor NFTs grant **no binding authority** over:
- Contracts
- Treasury
- Execution
- Settlement
- Admin controls

---

### 9.5 Mint Proceeds and Treasury

- All NFT mint proceeds route to the **team treasury**
- Used for:
  - Development
  - Audits
  - Infrastructure
  - Operations
  - Long-term platform support

No refunds under any circumstances.

---

### 9.6 Discount Enforcement

- Discounts are applied **on-chain at settlement**
- Discounts apply only if profit exists
- Discounts cannot reduce protocol fees below system minimums
- Governor discount overrides Supporter discount

NFT ownership does not affect execution behavior or outcomes.

---

### 9.7 Separation From Core Engine

The NFT system is intentionally isolated from:
- Strategy execution
- Yield generation
- Profit measurement
- LOOP issuance
- System deposit mechanics

Removal of the NFT system does not affect core platform operation.

---

### 9.8 Relationship to Governance and Bounties

- Governor NFTs may participate in advisory processes
- Governor NFTs may be eligible for discretionary bounties
- Bounties are:
  - Not automatic
  - Not guaranteed
  - Sourced from the marketing budget
  - Defined separately (see Sections 17 and 18)

NFT ownership alone does not entitle holders to bounties.

---

### 9.9 Summary

NFTs are optional tools for:
- Fee discounts
- Access
- Recognition
- Coordination

They are **not** part of the yield engine and do not affect how the system generates or records profit.


## 10. Post-Launch Referral Program

The post-launch referral program exists to encourage organic growth **after** the YieldLoop platform is live.

This program is optional and operates entirely outside the core execution, settlement, and accounting engine.

---

### 10.1 Purpose

The goals of the post-launch referral program are:

- Reward users for successful outreach
- Encourage long-term platform adoption
- Avoid emissions, ponzi-style incentives, or perpetual payouts
- Keep referral rewards bounded and auditable

The referral program does not affect:
- Strategy execution
- Risk exposure
- Profit calculation
- LOOP minting rules
- Cycle behavior

---

### 10.2 Eligibility

A user becomes eligible to participate in the post-launch referral program only after:

- Completing their first deposit
- Completing at least one full execution cycle

Referral codes are not issued pre-deposit.

---

### 10.3 Referral Code Issuance

- Each eligible user receives a unique referral code
- Referral codes may be shared voluntarily
- Use of a referral code is optional for referred users

Referral codes do not expire unless revoked for abuse.

---

### 10.4 Qualified Referral

A referral is considered qualified only if:

- A referred user completes a deposit
- The referred user completes execution cycles
- The referred user produces net positive outcomes

If no positive cycle occurs, no referral credit is generated.

---

### 10.5 Referral Credit Mechanics

Referral rewards are calculated as:

- **5% of the platform fees** generated by the referred user
- Applies only to the referred user’s **first six (6) positive execution cycles**

Key constraints:
- Credits are sourced **only from platform fees**
- Credits do not reduce the referred user’s profit
- Credits do not affect execution behavior
- Credits are capped and non-recurring

After six positive cycles, no further referral credits accrue for that referred user.

---

### 10.6 Settlement and Timing

- Referral credits are calculated only after settlement
- Credits are recorded as finalized accounting entries
- No estimates or projections are displayed

Referral credits are issued in LOOP or as platform credit (implementation-defined).

---

### 10.7 Non-Financial Nature

Referral credits:
- Are not income
- Are not yield
- Are not profit-sharing
- Do not represent compensation for services
- Do not create agency or employment relationships

They are promotional offsets sourced from platform fees.

---

### 10.8 Anti-Abuse Controls

The system and administrators may:

- Reject self-referrals
- Detect circular referral patterns
- Revoke referral eligibility for abuse
- Freeze or cancel referral credits

All determinations are final.

---

### 10.9 Change Management

The referral program may be:

- Modified
- Paused
- Replaced
- Discontinued

All changes:
- Apply prospectively only
- Do not affect settled cycles
- Are disclosed prior to activation

---

### 10.10 Summary

The post-launch referral program is:

- Bounded
- Optional
- Fee-sourced
- Non-inflationary

It rewards real growth without distorting the core execution engine.


## 11. Post-Cycle Walkthrough & Platform Fees

This section describes how all major components of YieldLoop interact over time.
It is written for builders and reviewers who need to understand **system flow**, not marketing.

---

### 11.1 High-Level Flow

At a high level, YieldLoop consists of four interacting layers:

1. User-owned vaults
2. Execution strategies
3. Settlement and accounting
4. LOOP issuance and system recycling

Optional programs (NFTs, referrals, governors) sit **outside** this flow and do not interfere with it.

---

### 11.2 User Entry

A user enters the system by:

1. Connecting a wallet
2. Deploying or accessing a personal vault
3. Depositing assets into that vault
4. Configuring execution parameters
5. Explicitly authorizing a cycle

No pooled capital exists at any point.

---

### 11.3 Execution Layer

Once a cycle is authorized:

- Strategy modules operate only within the vault
- All actions are bounded by user parameters
- No human intervention occurs mid-cycle
- No configuration changes are allowed

Execution halts automatically at cycle end or on failure conditions.

---

### 11.4 Settlement and Accounting Layer

After execution ends:

- All positions are accounted for and results are finalized.
- Costs are accounted for
- Start and end vault balances are compared
- A definitive result is produced

There are only two possible outcomes:
- Positive cycle
- Non-positive cycle (zeroed)

No smoothing or carryover occurs.

---

### 11.5 LOOP Issuance Layer

If a cycle is positive:

- A portion of verified retained surplus is minted into LOOP according to the Dynamic Mint Ratio (DMR), with the remaining retained surplus remaining unminted and recycled via the system deposit.
- Each unit of LOOP represents a proportional claim on historically realized surplus, not on total profit from a single cycle.
- LOOP is fully backed by realized profit
- LOOP is issued to the vault according to user-selected settings:
  - Withdraw
  - Compound
  - Partial split

If a cycle is not positive:
- No LOOP is issued

---

### 11.6 Platform Participation

In parallel with users:

- Platform fees are collected from positive cycles
- Fees contribute to retained surplus, a portion of which may be minted into LOOP according to the Dynamic Mint Ratio.
- Platform-owned LOOP is deposited into system vaults
- System vaults participate in future cycles

This creates a **self-reinforcing execution loop** without emissions.

---

### 11.7 Capital Recycling Loop

Over time, the system forms this loop:

User Capital + System Capital
↓
Execution Cycles
↓
Realized Profit
↓
LOOP Issuance
↓
System Deposit Grows
↓
More Capital per Cycle
↓
Greater System Resilience

This loop can shrink, pause, or reverse without breaking the protocol.

---

### 11.8 Optional Programs (Isolated)

NFTs, referrals, governors, and bounties:

- Do not alter execution
- Do not affect settlement
- Do not mint LOOP
- Do not change strategy behavior

They operate purely at the **coordination and incentive layer**.

---

### 11.9 Key Design Result

YieldLoop does not depend on:
- Continuous inflows
- Emissions
- Narrative APYs
- User churn

It survives by:
- Executing only when authorized
- Issuing LOOP only when profit exists
- Recycling capital deterministically

This is the core ecosystem logic.


## 12. Post-Cycle Walkthrough & Platform Fees

This section describes **exactly what happens at the end of an execution cycle**, how results are processed, and how platform fees are handled.

Everything in this section occurs **after execution has fully stopped**.

---

### 12.1 Cycle Completion

An execution cycle ends when:
- The predefined cycle duration expires, or
- Execution halts due to failure conditions

At this point:
- No further trades or actions may occur
- Vault state is frozen for settlement
- No user intervention is possible

---

### 12.2 Outcome Determination

The system compares:
- Vault balance at cycle start
- Vault balance at cycle end

After subtracting:
- Gas costs
- Protocol interaction fees
- Any execution-related expenses

Two outcomes are possible:

- **Non-positive cycle**  
  - No profit  
  - No LOOP minted  
  - No platform fee charged  

- **Positive cycle**  
  - Net profit exists  
  - LOOP minting proceeds  
  - Platform fee applies  

There is no partial credit.

Finalized accounting refers to finalized valuation, not mandatory position closure. Positions that remain open after cycle end are valued using deterministic pricing rules, conservative oracle inputs, and protocol-defined haircuts. Once valued, these positions may persist operationally, but their accounting contribution to the completed cycle is immutable.

### 12.2.1 

All settlement valuation follows deterministic rules:

- Spot assets are valued using a protocol-approved price source at a defined snapshot block.
- LP positions are valued using underlying asset balances minus protocol-defined impermanent loss and slippage assumptions.
- Lending positions are valued at redeemable principal plus accrued interest minus protocol-defined risk haircuts.
- Any asset lacking a reliable price source is valued at zero for settlement purposes.

These rules are conservative by design and applied uniformly. No discretionary overrides are permitted.

---

### 12.3 Positive Cycle Flow (User Side)

If a cycle is positive:

1. Net profit is finalized
2. A portion of verified surplus is converted into LOOP according to the current Dynamic Mint Ratio, with the remainder retained by the system.
4. LOOP is fully backed by realized profit
5. LOOP is issued to the user vault

The user’s **pre-selected post-cycle setting** determines how issued LOOP is handled:

- Withdraw LOOP
- Compound LOOP
- Partial split (withdraw / compound)

No other behavior is permitted.

---

### 12.4 Platform Fee Application

After profit is finalized but **before user LOOP distribution**:

- A platform fee is calculated as a percentage of net profit
- The fee applies **only to profit**
- No fees are taken from principal

If no profit exists, this section is skipped entirely.

Fee Timing Clarification

Platform fees apply uniformly to realized profit regardless of when that profit is distributed.

Profit distributed at the execution level (for example, via immediate USDT rewards) is subject to the platform fee at the time of distribution.

Profit distributed at the cycle level (via LOOP minting at settlement) is subject to the platform fee during settlement prior to LOOP issuance.

Fee rates, discount mechanisms, and fee splits are identical across both distribution paths unless explicitly modified by prospective governance action. No fee is ever assessed on principal, unrealized gains, or non-positive cycle outcomes.

---

### 12.5 Platform Fee Split (4-Way)

Collected platform fees are split **equally across four destinations**:

1. **Dev / Ops**  
   - Engineering
   - Infrastructure
   - Audits
   - Maintenance

2. **Marketing**  
   - Growth
   - Partnerships
   - Community programs
   - Referral funding
   - Governor bounties

3. **LoopLabs**  
   - Research
   - Experimental strategy development
   - Long-term system design
   - Non-production testing

4. **System Deposit**  
   - Converted to LOOP
   - Deposited into system-owned vaults
   - Re-enters future execution cycles

Each destination receives **25% of the platform fee**.

---

### 12.6 System Deposit Mechanics

The **System Deposit** is critical.

- Platform-owned LOOP is treated exactly like user LOOP
- It enters execution cycles
- It earns or loses based on real performance
- It compounds over time when profitable

This creates a **perpetual internal participant** without emissions.

If the system deposit performs poorly:
- It shrinks
- It does not get subsidized
- It does not get replenished by minting

The system deposit cannot incur losses beyond its own retained assets and never creates obligations against user funds.

---

### 12.7 No Floor Manipulation

There is:
- No artificial price support
- No buyback-and-burn
- No guaranteed floor movement

The LOOP floor strengthens **only** by:
- Real profit
- System deposits
- Backed issuance

The floor may:
- Rise
- Flatten
- Temporarily decline

No guarantees exist.

---

### 12.8 Accounting Finalization

Once all splits and distributions are complete:

- Accounting records are finalized
- Results become immutable
- Users regain full control
- Withdrawals and reauthorization become available

Nothing from this cycle carries assumptions into the next.

---

### 12.9 Key Takeaway

YieldLoop does not promise yield.

It:
- Executes
- Measures
- Settles
- Issues LOOP only when real profit exists
- Recycles capital deterministically

Everything else is noise.

---

# 13. LOOP — System Accounting Token

Redemption logic is enforced by a dedicated Redemption Controller that operates independently of execution and settlement.

## 13.1 What LOOP Actually Is

LOOP is the system’s internal unit for tracking **real, verified surplus that the platform has already earned and retained**.

That’s it.

It is not a reward.  
It is not an emission.  
It is not printed in advance.  
It is not promised to anyone.

LOOP only exists **after** profit already happened.

If YieldLoop never produces surplus, LOOP never grows.

---

## 13.2 Why LOOP Exists at All

LOOP exists to solve one problem:

> How do we permanently track and accumulate verified value inside the system without lying to ourselves or users?

Most platforms fake this with:
- APYs
- emissions
- rebasing
- smoothing losses
- “line goes up” dashboards

YieldLoop refuses to do that.

LOOP is the accounting artifact that remains **after reality is accepted**.

---

## 13.3 Verified Surplus (The Hard Gate)

YieldLoop follows a single rule:

**If profit cannot be verified, it does not exist.**

Before surplus is acknowledged:
- all gas is paid
- all slippage is paid
- all execution costs are paid
- all user allocations are honored
- all platform fees are calculated

If anything is unclear, the cycle resolves to **zero**.

Only surplus that survives this filter is considered real.

---

## 13.4 Where Surplus Goes

When surplus exists, it is split according to the platform’s allocation rules:
- user portion
- platform portion

The **platform portion does not leave the system**.

Instead:
- part compounds
- part is withdrawn
- the withdrawn portion is **re-deposited back into the system**
- this repeats across successive execution cycles through settlement and reauthorization.

All system deposit movements occur automatically through settlement logic and cycle authorization; no discretionary withdrawal or re-deposit decisions are made by operators.

This is the “loop.”

The system is feeding itself with *verified* value only.

Retained surplus exists at the protocol level, not the user level. It is held in a system-owned accounting ledger and corresponding system vaults. Retained surplus is never commingled with user principal and never attributed to individual users until LOOP is minted and assigned.

---

## 13.5 LOOP Minting (How It Actually Happens)

LOOP is minted **only** when:
1. A cycle closes
2. Verified surplus exists
3. The system’s retained portion is finalized
4. Settlement logic authorizes minting

There is:
- no fixed mint rate
- no schedule
- no inflation clock
- no admin mint

Minting is a consequence, not a goal.

If no surplus exists, minting does not happen.

---

13.5.1 — Dynamic Mint Ratio (DMR) and Rising-Floor Mechanics

LOOP issuance is governed by a Dynamic Mint Ratio (DMR) that determines how much LOOP is minted relative to verified retained surplus at the end of each profitable execution cycle.

Let:
	•	R = verified retained surplus finalized at settlement for a cycle
	•	m = current mint ratio, where 0 < m < 1

The protocol mints:

LOOP_minted = m × R

The remaining surplus:

Retained_surplus_unminted = (1 − m) × R
This unminted retained surplus remains within the system and participates in future execution cycles via the system deposit mechanism.

The mint ratio m is not fixed. It is:
	•	Dynamically adjustable within governance-defined bounds
	•	Applied prospectively only
	•	Evaluated at settlement
	•	Designed to decrease over time or under system pressure

As a result, retained surplus may grow faster than LOOP supply, causing the internal accounting floor per LOOP to strengthen over time when conditions allow.

The Dynamic Mint Ratio does not guarantee floor appreciation, market price appreciation, or redemption availability. It exists solely to enforce issuance discipline and prevent dilution of retained value.


The Dynamic Mint Ratio (DMR) operates within the following constraints:

- The mint ratio m is bounded by protocol-defined minimum and maximum values.
- Changes to m apply prospectively only and cannot affect completed cycles.
- m may be adjusted based on system-defined pressure indicators, including but not limited to:
  - Retained surplus growth rate
  - System vault drawdown
  - Volatility of realized outcomes
  - Liquidity stress indicators

DMR adjustments may be automated or governance-directed but must follow disclosed rules and rate-of-change limits. No adjustment may result in minting LOOP in excess of verified retained surplus.

---

## 13.6 Initial Supply and Supply Lifecycle

At launch, the LOOP token supply is **zero**.

There is no genesis mint, bootstrap allocation, founder allocation, or pre-minted supply of any kind.

The first LOOP tokens can only be created after:
- the platform completes at least one execution cycle, and
- verified net surplus exists, and
- the system’s retained portion of that surplus is finalized.

Until those conditions are met, LOOP does not exist.

Subsequent LOOP supply is created only through the minting process described in Section 13.5.  
Supply growth is therefore:
- event-driven, not time-based
- constrained by verified retained surplus
- independent of deposits, TVL, or user count

If no verified surplus exists in a given period, LOOP supply remains unchanged.

There is no mechanism for:
- arbitrary minting
- discretionary inflation
- dilution without retained value

Unless explicitly added by future governance, LOOP supply cannot be reduced, rebased, or burned.

---
## 13.7 LOOP Supply

LOOP has:
- no fixed maximum supply
- no minimum supply
- no emissions curve

Supply expands **only** as retained surplus expands.

If surplus slows, LOOP slows.  
If surplus stops, LOOP stops.  
If surplus reverses, LOOP simply does nothing.

There is no rebasing.  
There is no negative minting.  
There is no dilution without value.

---

## 13.8 How LOOP Is “Valued” Internally

Internally, LOOP has a simple accounting floor:

Accounting Floor = Total Verified Retained Surplus / Total LOOP Supply

Because LOOP issuance may be intentionally throttled relative to retained surplus via the Dynamic Mint Ratio, the accounting floor per LOOP may strengthen over time as retained surplus grows faster than LOOP supply. This behavior is mechanical and does not imply guaranteed appreciation, price support, or redemption timing.

This is not a market price.  
This is not a guarantee.  
This is not a promise.

It is simply math.

Each LOOP represents a proportional unit of already-existing surplus.

Nothing more.  
Nothing less.

The accounting floor is not an economic guarantee. It does not imply liquidity, redemption availability, market price support, or protection against loss. It exists solely as a mechanical accounting ratio derived from finalized retained surplus.

---

## 13.9 Why the Floor Is Structurally Stable

The floor does not erode by design because:
- LOOP is only minted after surplus exists
- surplus is retained, not emitted
- supply cannot grow faster than retained value

This does **not** mean the system is risk-free.  
It means the accounting cannot lie.

Losses don’t get hidden.  
They just result in no mint.

A flat or non-rising accounting floor over extended periods does not indicate malfunction; it indicates insufficient verified retained surplus.


---

## 13.10 What LOOP Is NOT Used For

LOOP does not:
- entitle holders to profits
- grant governance rights
- affect execution
- change strategy outcomes
- replace deposits
- represent principal

Those systems are intentionally separate.

---

## 13.11 Relationship to NFTs

NFTs:
- do not mint LOOP
- do not affect LOOP supply
- do not change LOOP accounting

NFTs only influence:
- platform fee discounts
- access
- governance participation
- bounty eligibility

LOOP remains untouched.

---

## 13.12 Emergency and Halt Conditions

If the system pauses:
- LOOP minting halts
- LOOP supply freezes
- retained surplus remains untouched

There is no unwind.  
There is no forced action.  

The system simply stops moving.

---

## 13.13 Why This Matters

LOOP is not designed to excite people.

It is designed to be **boring, honest, and irreversible**.

If YieldLoop succeeds, LOOP becomes a historical record of that success.  
If it fails, LOOP exposes that failure without disguise.

That is the point.

---

### LOOP Redemption (Core, Conditional Feature)

Redemption is a core feature of LOOP.

LOOP exists to represent historically verified, retained surplus, and redemption is the mechanism by which that retained surplus may be accessed over time.

Redemption is subject to the following constraints:

- Redemption is never immediate by default
- Redemption is never subsidized
- Redemption is always bounded by available retained surplus
- Redemption may be rate-limited or queued to preserve system solvency
- Redemption availability applies only to LOOP that has been finalized and assigned to a user’s claimable balance

Any LOOP minted into a user’s claimable balance represents finalized, user-owned surplus. Such LOOP is redeemable in principle and cannot be arbitrarily revoked, permanently frozen, or rendered non-redeemable. Redemption timing may be delayed or throttled by system-wide constraints, but claimable LOOP must remain eligible for redemption when sufficient retained surplus exists.

Redemption does not represent a promise of liquidity, price, or timing.  
It represents a controlled release of already-earned surplus when system conditions allow.

If redemption conditions are not met, LOOP remains valid as a record of retained value but cannot be extracted at that time.

### Redemption Mechanics (High-Level)

When enabled, redemption operates as follows:

1. The system evaluates available retained surplus
2. A redemption pool or window is defined by governance or protocol rules
3. Eligible LOOP holders may redeem up to an allowed amount
4. Redeemed LOOP is permanently removed from circulation
5. Redeemed value exits the system

Redemption cannot exceed retained surplus and cannot require liquidation of active user positions.

The system may prioritize:
- Fairness across holders
- Rate limits
- Long-term solvency

No redemption schedule or price is implied.

Redemption parameters may not be configured in a manner that permanently prevents eligible, claimable LOOP from redemption in principle.

---
## 14. Strategy Modules

Strategy modules are **predefined execution programs** that operate inside user-owned vaults during an authorized execution cycle.

They define *what actions are allowed*, not *what outcomes are expected*.

---

### 14.1 Purpose

Strategy modules exist to:

- Execute deterministic actions on user-authorized assets
- Interact with approved external protocols
- Operate within strict, inspectable rules
- Produce measurable outcomes at cycle end

Strategy modules do not:
- Make decisions on behalf of users
- Adapt or optimize dynamically
- Predict market behavior
- Guarantee outcomes

---

### 14.2 Strategy as Capability, Not Advice

A strategy module represents an **execution capability**.

It is inert unless:
- Explicitly selected by the user
- Explicitly authorized for a specific cycle
- Explicitly bounded by user parameters

The system does not:
- Recommend strategies
- Rank strategies
- Auto-select strategies
- Substitute strategies mid-cycle

This prevents the system from functioning as managed trading or discretionary execution.

---

### 14.3 Deterministic Behavior

Each strategy module is deterministic:

- Given the same inputs and on-chain conditions, behavior is consistent
- No learning
- No AI-driven modification
- No mid-cycle mutation

If a rule fails, the module halts.

The system never improvises.

---

### 14.4 Execution Boundaries (Global)

All strategy modules share the following hard limits:

- No leverage
- No borrowing
- No derivatives
- No margin
- No shorting
- No mid-cycle parameter changes
- No human intervention during execution

These boundaries are non-overridable.

---

### 14.5 Initial Strategy Set

The initial strategy set is intentionally limited.

#### 14.5.1 Spot Trading — Major Assets

**Purpose**
- Execute simple buy/sell spot trades on approved venues

**Assets**
- BTC
- ETH
- SOL
- Additional assets may be added prospectively

**Behavior**
- Spot only
- User-defined limits on size, frequency, slippage

**Exclusions**
- No leverage
- No derivatives
- No shorting

---

#### 14.5.2 Spot Trading — PAXG

**Purpose**
- Spot trading of tokenized gold (PAXG)

**Behavior**
- Spot only
- Approved venues only
- User-defined limits apply

**Notes**
- No claims about physical redemption
- Issuer and custody risks are external

---

#### 14.5.3 LP / Yield Vault Deployment

**Purpose**
- Deploy assets into approved LPs or vault-style protocols

**Behavior**
- Deposit and withdraw only
- Reward claiming only if explicitly enabled
- No forced compounding unless authorized

**Risks**
- Impermanent loss
- Protocol risk
- Liquidity risk

---

#### 14.5.4 Stablecoin Yield Deployment

**Purpose**
- Deploy stablecoins into non-staking yield sources

**Behavior**
- Lending markets or vaults only
- Approved venues only
- Withdraw per authorization

**Notes**
- No peg guarantees
- No insolvency protection

---

### 14.6 User-Controlled Parameters

Users define, per cycle:
- Strategy selection
- Asset inclusion
- Capital allocation per strategy
- Slippage limits
- Execution frequency
- Reward handling (claim / idle)

Defaults may exist but imply no recommendation.

---

### 14.7 Halt Conditions

Execution halts if:
- Slippage exceeds limits
- Liquidity checks fail
- External protocol fails
- Execution errors occur
- Emergency controls activate

Halt means:
- No retries
- No substitution
- Proceed to settlement

---

### 14.8 Strategy Isolation

Strategies:
- Do not share state
- Do not coordinate implicitly
- Do not rebalance against each other
- Do not migrate capital mid-cycle

Each strategy’s effect is visible only at settlement.

---

### 14.9 Strategy Lifecycle

1. Defined and audited
2. Approved for availability
3. User-selected
4. User-authorized
5. Executed during cycle
6. Halted at cycle end
7. Measured in settlement

No shortcuts.

---

### 14.10 Removal and Change

Strategies may be:
- Disabled
- Modified
- Replaced

All changes:
- Apply prospectively only
- Do not affect active cycles
- Are documented

---

### 14.11 Key Takeaway

Strategies are **tools**, not promises.

They execute rules.
They do not manage outcomes.

Any automated or AI-assisted guidance, if present, is informational only. Such guidance operates outside execution logic and has no ability to modify strategy parameters, execution timing, allocation behavior, or settlement outcomes.


## 15. DApp / UI / UX

The YieldLoop DApp exists to **accurately reflect system behavior**, enforce authorization boundaries, and ensure users act with **clear awareness of risk and limitations**.

The interface must not persuade, optimize, recommend, or imply outcomes.  
It must surface **explicit warnings, disclosures, and constraints** at all relevant decision points.

Withdrawals are disabled while a cycle is active. Full withdrawal and account exit are available immediately after cycle completion.

---

### 15.1 Core UI Principles

The UI must:

- Never imply expected returns or yield
- Never display projected performance
- Never rank strategies or users
- Never gamify execution
- Never obscure risk or constraints
- Never auto-authorize actions

Clarity and correctness take priority over engagement.

---

### 15.2 Mandatory Global Disclosures

The following disclosures must be **visible and accessible at all times**, including via a persistent footer or modal link:

- YieldLoop executes user-authorized actions only
- YieldLoop does not provide investment advice
- YieldLoop does not guarantee profit or capital preservation
- YieldLoop is non-custodial
- Loss of funds is possible, including total loss
- Smart contract and protocol risks exist
- Past results do not predict future outcomes
- System failure, shutdown, or discontinuation does not guarantee profit, capital preservation, compensation, or redemption beyond available retained surplus.
- YieldLoop may distribute execution-level rewards (such as USDT) during an active cycle based on completed actions. Such rewards do not indicate that a cycle is profitable and do not guarantee that LOOP will be minted at settlement.


Users must be able to view these disclosures without authorizing execution.

---

### 15.3 Primary Screens

The DApp includes:

1. Wallet Connection
2. Vault Overview
3. Cycle Configuration
4. Authorization & Confirmation
5. Active Cycle Status
6. Post-Cycle Results
7. History & Records
8. Optional Programs (NFTs, referrals, governors)
9. Admin (restricted)

Warnings and notices appear contextually within these screens.

---

### 15.4 Wallet Connection

Wallet connection screen must display:

- Supported networks
- Non-custodial notice
- “Connecting a wallet does not initiate trading” notice

No execution may occur on wallet connection alone.

---

### 15.5 Vault Overview

Displays:
- Vault address
- Asset balances
- Idle vs authorized capital
- Current cycle state
- LOOP balance (if any)

Must include a notice:
> “Assets in this vault remain under your control. Execution occurs only when you explicitly authorize a cycle.”

No performance projections are shown.

---

### 15.6 Cycle Configuration

During configuration, the UI must:

- Clearly label all parameters as user-selected
- Display default values as defaults, not recommendations
- Prevent configuration if inputs are invalid

Mandatory notice:
> “These settings define what actions may occur. YieldLoop will not modify or optimize them.”

---

### 15.7 Authorization & Confirmation (Critical)

Before authorization, the UI must present a **blocking confirmation screen** that includes:

- Full parameter summary
- Strategy modules enabled
- Assets involved
- Capital allocation
- Cycle duration
- Platform fee rate
- NFT discount (if applicable)
- Statement that execution cannot be modified mid-cycle
- Statement that withdrawals are disabled during execution
- Statement that losses are possible

The user must explicitly acknowledge:
- “I understand that YieldLoop does not guarantee profit.”
- “I understand that I may lose some or all of my funds.”
- “I understand that execution cannot be stopped once authorized.”

Authorization requires an affirmative action (checkbox + confirm).

---

### 15.8 Active Cycle Status

During an active cycle:

- UI must clearly show “EXECUTION IN PROGRESS”
- Configuration controls must be disabled
- Withdrawal controls must be disabled

Mandatory notice:
> “Execution is active. Parameters cannot be changed and funds cannot be withdrawn until settlement completes.”

No metrics, charts, or live P&L are shown.

The absence of live performance metrics, projections, or interim profit indicators during execution is intentional. YieldLoop does not display speculative or mark-to-market data during active cycles. Results are shown only after settlement.

---

### 15.9 Post-Cycle Results

After settlement, the UI displays:

- Starting vault balance
- Ending vault balance
- Net result
- LOOP issued (if any)
- Platform fee charged (if any)

Mandatory notice:
> “Results shown are historical and final. They do not predict future performance.”

---

### 15.10 History and Records

Users may view:
- Prior cycles
- Authorization parameters
- Settlement records
- Accounting entries

Records are read-only and immutable.

---

### 15.11 Optional Programs

NFTs, referrals, and governor features:

- Must be visually separated from execution controls
- Must include notices stating they do not affect trading outcomes
- Must not be framed as profit opportunities

---

### 15.12 Error Handling and Failure Notices

Errors must:

- Clearly describe what failed
- Explain whether execution occurred or halted
- Never retry silently
- Never hide partial failures

If execution halts, the UI must state:
> “Execution stopped due to a failure condition. Settlement will proceed using current vault state.”

---

### 15.13 UX Safeguards

The UI must prevent:

- Accidental authorization
- Confusing terminology
- Implicit guarantees
- Hidden dependencies

All irreversible actions must be clearly labeled.

---

### 15.14 Accessibility and Simplicity

The UI favors:
- Plain language
- Minimal steps
- Explicit state indicators
- Clear warnings over aesthetics

---

### 15.15 Key Takeaway

The DApp is a **truthful interface**, not a promise.

If something is risky, irreversible, or constrained, the UI must say so clearly and repeatedly.


## 16. Admin

Administrative functions exist solely to maintain **system operability, security, and continuity**.

Admins do not control user assets, execution outcomes, or profit distribution.

---

### 16.1 Scope of Administrative Authority

Admins may perform the following actions:

- Deploy new versions of contracts
- Enable or disable strategy modules for future cycles
- Update supported asset and protocol lists
- Adjust protocol fee parameters prospectively
- Update NFT pricing and discount parameters
- Manage treasury wallets
- Trigger emergency controls

Admins may not:
- Modify active execution cycles
- Alter settled outcomes
- Move user funds
- Override user authorization
- Mint LOOP outside settlement rules

---

### 16.2 Multisig Requirement

All privileged actions must be controlled by a **multisig wallet**.

- No single admin key
- No unilateral execution
- Threshold defined by policy

This applies to:
- Contract upgrades
- Treasury actions
- Emergency pauses
- Governor minting and revocation

---

### 16.3 Prospective-Only Changes

All admin changes:
- Apply only to future cycles
- Do not affect active cycles
- Do not alter settled accounting

If a change cannot be applied prospectively, it is not permitted.

---

### 16.4 Emergency Controls

Admins may activate emergency controls if:
- A critical vulnerability is discovered
- A dependent protocol fails
- Settlement integrity is at risk

Emergency actions may:
- Pause new cycle authorization
- Halt active execution

Emergency actions may not:
- Re-route assets
- Complete execution after halt
- Modify accounting

---

### 16.5 Transparency and Logging

All admin actions must:
- Emit on-chain events
- Be logged and inspectable
- Be attributable to multisig approval

Hidden admin behavior is not allowed.

---

### 16.6 Admin UI

Admin interfaces are:
- Access-controlled
- Isolated from user UI
- Logged
- Non-public by default

No admin function is exposed to end users.

---

### 16.7 Removal and Rotation

Admin keys may be:
- Rotated
- Revoked
- Reassigned

Rotation does not affect system behavior.

---

### 16.8 What Admins Are Not

Admins are not:
- Traders
- Asset managers
- Advisors
- Fiduciaries

They operate the system — they do not participate in outcomes.

---

### 16.9 Key Takeaway

Admins keep the system **running and honest**.

They do not make money for users.


## 17. Customizable Governance System for Governors

YieldLoop includes an **advisory governance framework** designed to collect structured input without surrendering operational control or creating implied authority.

At launch, YieldLoop is **not a DAO**.

Governance exists to inform decisions, not to execute them.

---

### 17.1 Purpose

The governance system exists to:

- Gather informed feedback from trusted participants
- Stress-test system changes before deployment
- Improve long-term design and risk awareness
- Create structured discussion without binding power

Governance does not:
- Control execution
- Control funds
- Approve trades
- Override admin authority
- Create ownership or fiduciary duty

---

### 17.2 Governor Role Recap

Governors are holders of the **Governor NFT** and serve as:

- Advisors
- Reviewers
- Contributors
- Thought partners

They are not:
- Operators
- Trustees
- Controllers
- Decision-makers

---

### 17.3 Scope of Governance Topics

Governance discussions may include:

- Strategy module enablement or removal
- Risk boundaries and constraints
- Fee structure changes
- NFT program adjustments
- UI/UX clarity improvements
- Roadmap prioritization
- Emergency response post-mortems

Governance may not vote on:
- Live execution
- User funds
- Individual outcomes
- Treasury withdrawals
- Contract keys

---

### 17.4 Governance Mechanics

Governance input may be collected via:

- Non-binding votes
- Structured proposals
- Comment periods
- Think-tank sessions
- Written reviews

All governance outputs are **advisory only**.

---

### 17.5 Customizability

Governance mechanics are configurable:

- Voting weights (if any)
- Participation thresholds
- Topic scope
- Session frequency
- Visibility (public vs private)

Changes to governance mechanics:
- Apply prospectively
- Do not imply retroactive authority
- Do not grant rights

---

### 17.6 No Reliance or Expectation

Participation in governance:

- Does not guarantee influence
- Does not guarantee compensation
- Does not imply responsibility
- Does not create reliance by users

The team retains final authority.

---

### 17.7 Transparency

Governance discussions may be:
- Logged
- Published
- Archived

Transparency is encouraged but not required for all sessions.

---

### 17.8 Removal and Participation Limits

Governor participation may be:
- Limited
- Rotated
- Revoked

Inactivity, abuse, or misrepresentation may result in removal.

---

### 17.9 Key Takeaway

Governance is a **signal channel**, not a control plane.

The system listens — it does not obey.


## 18. Governors Bounty Program

The Governors Bounty Program exists to **reward meaningful advisory and ecosystem contributions** without creating employment, compensation, revenue-sharing, or yield expectations.

Bounties are discretionary, bounded, and non-recurring.

---

### 18.1 Purpose

The purpose of the Governors Bounty Program is to:

- Incentivize high-quality advisory input
- Reward time-bound, outcome-specific contributions
- Encourage honest critique and risk discovery
- Support ecosystem growth and coordination

The program is not designed to:
- Provide income
- Create recurring payments
- Substitute for employment or contracting
- Distribute protocol revenue

---

### 18.2 Eligibility

Eligibility requires:
- Holding a valid Governor NFT
- Being invited or approved for a specific bounty activity
- Completing defined participation requirements

Holding a Governor NFT alone does **not** guarantee eligibility.

---

### 18.3 Bounty Types

Bounties may be issued for activities such as:
- Think-tank participation
- Strategy review and critique
- Risk analysis and adversarial testing
- Documentation review
- Educational content creation
- Partnerships and outreach support
- Post-incident or post-mortem analysis

Each bounty is tied to a **specific task or session**.

---

### 18.4 Funding Source

Governor bounties are funded **exclusively from the marketing budget**.

- Marketing budget is funded from the platform fee split
- A configurable **0.5%–1.0% of the marketing allocation** may be reserved for bounties
- No additional token minting occurs for bounties

Bounties are a **use of funds**, not a revenue stream.

---

### 18.5 Bounty Definition (Per Instance)

Each bounty instance must define in advance:
- Purpose or task
- Eligibility requirements
- Participation window
- Verification criteria
- Total bounty pool amount
- Distribution method

No open-ended or perpetual bounties are allowed.

---

### 18.6 Distribution Mechanics

Bounties are distributed:
- Manually in v1
- Via multisig approval
- In LOOP or another designated token

Distribution may be:
- Equal split among verified participants
- Fixed amounts per participant
- Other predefined structures

No retroactive changes.

---

### 18.7 Cool-Down and Rotation

To prevent concentration and implied compensation patterns:

- A Governor who receives a bounty becomes **ineligible for the immediately following bounty**
- Cool-down applies regardless of bounty type
- Governors who do not receive a bounty are not affected

This enforces rotation and diversity of input.

---

### 18.8 No Entitlement, No Reliance

Bounties:
- Are not guaranteed
- Do not accrue
- Do not imply future eligibility
- Do not create expectations of continuity

Failure to receive a bounty carries no penalty.

---

### 18.9 No Employment or Agency

Participation in the bounty program:
- Does not create employment
- Does not create contractor status
- Does not create agency
- Does not create fiduciary duty
- Does not authorize representation of YieldLoop

All participation is voluntary.

---

### 18.10 Transparency and Logging

Bounty distributions may be:
- Logged
- Summarized
- Audited internally

Public disclosure is optional and policy-defined.

---

### 18.11 Termination and Modification

The bounty program may be:
- Modified
- Paused
- Discontinued

All changes:
- Apply prospectively only
- Do not affect completed distributions

---

### 18.12 Key Takeaway

Governor bounties are **discretionary recognition**, not compensation.

They reward contribution — not position, ownership, or expectation.


## 19. Failure Modes & Safeguards

This section enumerates known failure modes and the safeguards designed to contain them.

YieldLoop does not assume continuous success.  
It is designed to **fail closed**, not fail optimistically.

---

### 19.1 Strategy-Level Failures

**Failure Modes**
- Slippage exceeds bounds
- Liquidity disappears mid-execution
- External protocol reverts or pauses
- Unexpected price movement

**Safeguards**
- Hard slippage caps
- Pre-trade liquidity checks
- Immediate execution halt on violation
- Proceed directly to settlement

No retries. No substitutions.

---

### 19.2 Smart Contract Failures

**Failure Modes**
- Contract bugs
- Unexpected state transitions
- Reentrancy attempts

**Safeguards**
- Audited contracts
- Minimal state mutation
- No external callbacks during settlement
- Emergency pause controls

---

### 19.3 Oracle and Data Failures

**Failure Modes**
- Price feed manipulation
- Oracle outages
- Stale data

**Safeguards**
- Minimal oracle dependence
- Conservative validation
- Execution halt on inconsistent data

Execution does not proceed on uncertain inputs.

---

### 19.4 Execution Engine Failures

**Failure Modes**
- Gas spikes
- Network congestion
- Partial execution

**Safeguards**
- Gas ceiling enforcement
- Pre-flight gas estimation
- Abort on partial completion
- Settlement using last valid state

If execution halts mid-cycle due to partial completion, settlement proceeds using the last verifiable on-chain state. Actions that completed successfully are accounted for. Actions that did not complete are ignored. No retries are performed to “finish” execution. The system records reality exactly as it exists at halt.

---

### 19.5 Accounting and Settlement Failures

**Failure Modes**
- Inconsistent balance snapshots
- Fee miscalculation
- LOOP mint mismatch

**Safeguards**
- Deterministic accounting paths
- Single settlement authority per cycle
- Settlement reversion on mismatch
- No manual overrides

---

### 19.6 Admin and Governance Failures

**Failure Modes**
- Compromised admin key
- Malicious or negligent admin action
- Governance capture attempts

**Safeguards**
- Multisig enforcement
- Role separation
- Prospective-only changes
- Event logging and review

---

### 19.7 Economic and Market Failures

**Failure Modes**
- Prolonged unprofitable conditions
- Market regime shifts
- Liquidity fragmentation

**Safeguards**
- No emissions
- No obligations to execute
- Cycle pause capability
- Dormant-but-solvent design

The system can wait.

---

### 19.8 User Error

**Failure Modes**
- Misconfiguration
- Over-allocation
- Misunderstanding risk

**Safeguards**
- Explicit warnings
- Hard parameter bounds
- Confirmation steps
- Immutable authorization

Users cannot accidentally authorize unsafe behavior.

---

### 19.9 External Dependency Failure

**Failure Modes**
- DEX outages
- Bridge failures
- Stablecoin depegs

**Safeguards**
- Whitelisted dependencies
- Rapid disablement of affected strategies
- Execution halt on detection

No forced exposure.

---

### 19.10 Catastrophic Failure

**Failure Modes**
- Chain halt
- Severe exploit
- Unrecoverable state corruption

**Safeguards**
- Global emergency pause
- Preservation of vault ownership
- No post-halt execution

Recovery prioritizes fund safety over continuity.

---

### 19.11 Design Philosophy

YieldLoop assumes:
- Things will break
- Markets will change
- Humans will make mistakes

Safeguards exist to **stop damage**, not to save face.

---

### 19.12 Key Takeaway

When something goes wrong, the system:
- Stops
- Records what happened
- Preserves ownership
- Refuses to guess

Failure is contained, not hidden.

---

### 19.13 If YieldLoop ceases operation: 

Permanently, no new execution cycles will occur. User vaults remain non-custodial and under user control. No future LOOP minting occurs. Settlement proceeds only for completed cycles. Unclaimed LOOP remains valid as a record of finalized surplus but redemption availability depends on remaining retained surplus and system solvency. Platform discontinuation does not create an obligation to unwind positions, compensate losses, or guarantee redemption beyond available surplus.


## 20. Assumptions & Constraints

YieldLoop is built on explicit assumptions and hard constraints.  
Anything outside these bounds is intentionally unsupported.

---

### 20.1 Market Assumptions

The system assumes:

- Markets are volatile
- Liquidity can disappear without warning
- Profit is intermittent, not continuous
- Lossless execution is impossible

YieldLoop does not assume:
- Efficient markets
- Stable correlations
- Continuous profitability
- Predictable outcomes

---

### 20.2 User Assumptions

The system assumes users:

- Understand they may lose some or all of their funds
- Are capable of authorizing actions knowingly
- Accept irreversible execution once a cycle starts
- Are responsible for their own configuration choices

The system does not assume:
- Financial sophistication
- Risk tolerance
- Homogeneous user behavior

Hence the UI enforces guardrails.

---

### 20.3 Technical Assumptions

The system assumes:

- Underlying blockchains continue to operate
- Smart contract execution is deterministic
- External protocols behave within documented bounds
- Network congestion may occur

YieldLoop does not assume:
- Zero bugs
- Perfect uptime
- Instant finality
- Infinite throughput

---

### 20.4 Legal and Regulatory Constraints (Internal)

Internally, the system is constrained to:

- Avoid representations of guaranteed returns
- Avoid projections or promises
- Avoid discretionary control over user assets
- Avoid retroactive modification of outcomes

These constraints shape architecture, not marketing.

---

### 20.5 Execution Constraints

Hard constraints include:

- No leverage
- No borrowing
- No derivatives
- No margin
- No shorting
- No mid-cycle modification
- No discretionary execution

These are architectural limits, not policy choices.

---

### 20.6 Accounting Constraints

Accounting is constrained to:

- End-of-cycle settlement only
- Binary outcome recognition (profit or zero)
- No smoothing
- No carryover assumptions
- No retroactive changes

This prevents narrative accounting.

---

### 20.7 Token Constraints

LOOP is constrained to:

- Mint only from realized profit
- Never decrease its accounting floor
- Never inflate supply arbitrarily
- Never burn or reprice retroactively

LOOP cannot be used as an incentive lever.

---

### 20.8 Admin Constraints

Admins are constrained to:

- Prospective-only changes
- Multisig-controlled actions
- No access to user funds
- No override of settlement

Admin power is deliberately limited.

---

### 20.9 Economic Constraints

The system accepts:

- Periods of zero growth
- Extended dormancy
- Reduced participation
- Slow recovery

YieldLoop does not require constant inflows to survive.

---

### 20.10 What YieldLoop Refuses to Do

YieldLoop will not:

- Promise yield
- Mask losses
- Smooth returns
- Emit inflationary rewards
- Depend on hype-driven growth

These are not oversights. They are design choices.

---

### 20.11 Key Takeaway

YieldLoop is not optimized for upside narratives.

It is optimized for:
- Truth
- Durability
- Auditability
- Survival


## 21. Roadmap

This roadmap reflects **build order, dependency order, and risk order** — not marketing milestones.

Dates are intentionally omitted. Progress is gated by correctness, not speed.

---

### 21.1 Phase 0 — Foundations (Complete or In Progress)

Focus: correctness and survivability.

- Core execution cycle logic
- Deterministic settlement engine
- LOOP minting from realized profit only
- Non-decreasing accounting floor
- Vault isolation per user
- Platform fee routing and system deposit
- Emergency pause and halt controls
- Internal documentation and threat modeling

Exit condition:
- System can execute, halt, settle, and remain solvent under failure.

---

### 21.2 Phase 1 — MVP Launch

Focus: minimal surface area, maximum clarity.

- Limited strategy modules (spot, LP, stable yield)
- Full DApp UI with warnings and disclosures
- Manual cycle authorization
- Immutable post-cycle records
- NFT minting (Supporter + Governor)
- Post-launch referral program
- Multisig admin controls
- Logging and observability

Exit condition:
- Real users can complete full cycles without ambiguity or intervention.

---

### 21.3 Phase 2 — Hardening and Audit

Focus: adversarial validation.

- Independent smart contract audits
- Stress testing under adverse conditions
- Failure injection and halt testing
- UI/UX clarity review
- Governance dry runs (non-binding)
- Bounty-based review sessions

Exit condition:
- Known failure modes are bounded and documented.

---

### 21.4 Phase 3 — Strategy Expansion

Focus: controlled capability growth.

- Additional approved assets
- Additional LP / vault integrations
- Strategy parameter refinement
- Conservative execution optimizations
- Improved capital efficiency (within constraints)

All strategy additions:
- Are opt-in
- Are audited
- Apply prospectively only

Exit condition:
- Expanded capability without expanded risk surface.

---

### 21.5 Phase 4 — Automation and Tooling

Focus: reducing friction without adding discretion.

- Improved authorization UX
- Cycle scheduling tools
- Reporting and export tools
- Better system observability
- Admin tooling improvements

No automation may:
- Select strategies
- Modify user parameters
- Execute without authorization

Exit condition:
- Reduced friction, unchanged trust model.

---

### 21.6 Phase 5 — Ecosystem Maturity

Focus: longevity.

- Governance refinement
- Governor program evolution
- LoopLabs research outputs
- Documentation and education
- External integrations (selective)

Growth is measured by:
- System uptime
- Accounting integrity
- User understanding
- Survival through bad markets

---

### 21.7 Explicit Non-Goals

YieldLoop does not aim to:

- Chase APYs
- Maximize TVL at all costs
- Compete on hype or speed
- Become a generalized trading platform
- Promise returns

These remain non-goals.

---

### 21.8 Final Note

YieldLoop advances when:
- The system is correct
- The risks are understood
- The truth is preserved

If progress slows, that is acceptable.
If correctness fails, it is not.

---

# Appendix A  
## User Lifecycle, Execution Flow, and Control Boundaries

This appendix describes the full end-to-end user experience within YieldLoop, including all decision points, acknowledgements, execution boundaries, and post-cycle outcomes. This section is descriptive only and does not constitute financial advice or performance guarantees.

---

### 1. Arrival & Access

1. The user arrives at the YieldLoop interface.
2. The user is presented with a high-level description of the system, including:
   - The absence of guaranteed returns
   - The use of fixed execution cycles
   - The possibility of zero-profit cycles
3. The user connects a compatible wallet.

No funds are transferred at this stage.

---

### 2. Risk Disclosure & Acknowledgement

4. Prior to any deposit, the user must review and acknowledge:
   - General risk disclosures
   - Strategy execution risks
   - Market volatility
   - Smart contract risk
   - The possibility of zero or negative outcomes
5. The user must explicitly acknowledge that:
   - YieldLoop does not promise profits
   - Past performance does not imply future results
   - All strategies operate at the user’s risk

Progression is blocked until acknowledgements are completed.

---

### 3. Deposit Phase (Queue State)

6. The user deposits funds into a YieldLoop vault.
7. Deposits may be made at any time.
8. Deposited funds do not enter active execution immediately.
9. All deposits are placed into a pending state until the start of the next execution cycle.

Deposits added mid-cycle will queue for the following cycle.

---

### 4. Strategy Configuration & Guidance (Optional)

10. Prior to the cycle start, the user configures execution parameters, which may include:
    - Risk level
    - Strategy mix
    - Allocation preferences
    - Post-cycle handling preferences
11. YieldLoop may optionally provide automated or AI-assisted guidance.
12. Any guidance provided is:
    - Non-binding
    - Informational only
    - Used entirely at the user’s discretion and risk

The user remains fully responsible for all selected parameters.

---

### 5. Final Acknowledgement & Lock-In

13. Before the cycle begins, the user must:
    - Review all selected parameters
    - Review post-cycle options
    - Acknowledge that parameters will be locked for the duration of the cycle
14. The user digitally signs all acknowledgements.

Once confirmed:
- Parameters are locked
- Funds are committed for the upcoming cycle
- No changes are possible until cycle completion

---

### 6. Cycle Start (Execution Begins)

15. At the start of the calendar cycle:
    - All queued deposits are activated
    - Execution begins simultaneously across the system
16. The execution cycle runs for a fixed calendar duration (e.g., one month).

During this period:
- Users cannot modify parameters
- Users cannot withdraw active funds
- No discretionary intervention occurs

---

### 7. Cycle Execution (No-Action Period)

17. Authorized strategy modules may execute predefined, rule-based actions or abstain from action according to their encoded logic.

18. Users are not required to take any action.
19. Inactivity does not penalize the user.

The system may generate profit, break even, or incur losses.

---

### 8. Cycle End & Settlement

20. At cycle completion:
    - All positions are accounted for and settled for profit and loss purposes.
    - Gas costs, fees, and execution costs are accounted for
21. Profit (if any) is calculated only after full settlement.
22. If no verifiable profit exists, results are recorded as zero.

No estimates or projections are used.

---

### 9. Results Presentation

23. The user is shown:
    - Net cycle result
    - Fees applied (if any)
    - Whether surplus was generated
24. If surplus exists:
    - Platform fees are applied
    - System deposit is allocated
    - LOOP may be minted
25. If no surplus exists:
    - No LOOP is minted
    - No fees are taken

---

### 10. Post-Cycle Options

26. After results are finalized, the user may:
    - Leave funds in the vault for the next cycle
    - Withdraw funds
    - Redeem LOOP (if available and eligible)
    - Take no action

Any action taken applies only to the next cycle.

---

### 11. Redemption (If Applicable)

27. LOOP redemption, when available:
    - Is optional
    - Is not guaranteed
    - Is subject to system conditions
28. Redemption reflects historical retained surplus only.
29. Redemption availability may change over time based on system design.

---

### 12. Next Cycle Preparation

30. Funds remaining in the system return to a queued state.
31. Users may update parameters for the next cycle.
32. The process repeats from the next cycle start.

---

### Key Principles Reinforced

- Deposits do not imply immediate execution  
- No mid-cycle control exists  
- Profit is verified, not assumed  
- LOOP reflects history, not expectation  
- Inaction is always a valid choice  

---

# Appendix B  
## System States, Permissions, and Control Boundaries

This appendix formally defines all YieldLoop system states and the permissions associated with each state. These definitions exist to eliminate ambiguity regarding user control, system behavior, and execution authority at any point in time.

System states are mutually exclusive. Actions permitted in one state are explicitly disallowed in others.

---

## 1. Overview of State-Based Design

YieldLoop operates as a state-driven system.  
User funds, strategy parameters, and execution rights are governed by the current system state.

At no time does YieldLoop permit:
- Mid-cycle parameter changes
- Mid-cycle withdrawals
- Discretionary human intervention
- Price or outcome guarantees

---

## 2. Defined System States

### 2.1 Wallet Connected (Pre-Deposit)

**Description:**  
The user has connected a wallet but has not deposited funds.

**Permitted Actions:**
- View system information
- Review disclosures
- Simulate or preview configuration options

**Prohibited Actions:**
- Strategy execution
- Fund commitment
- Cycle participation

No funds are at risk in this state.

---

### 2.2 Pending Deposit (Queued State)

**Description:**  
Funds have been deposited but are not yet active in an execution cycle.

**Permitted Actions:**
- Add additional funds
- Modify strategy parameters
- Modify post-cycle preferences
- Withdraw pending (non-active) funds

**Prohibited Actions:**
- Strategy execution
- Profit generation
- Mid-cycle participation

Funds in this state are idle and awaiting the next cycle start.

---

### 2.3 Configuration Locked (Pre-Cycle Lock)

**Description:**  
The user has finalized parameters and acknowledged all disclosures prior to cycle start.

**Permitted Actions:**
- Review locked parameters
- Review upcoming cycle start

**Prohibited Actions:**
- Parameter changes
- Fund withdrawal
- Execution control

This state exists to ensure informed consent before execution begins.

---

### 2.4 Active Cycle (Execution State)

**Description:**  
The system is actively executing strategies for the current cycle.

**Permitted Actions:**
- View status indicators
- Monitor non-actionable informational data

**Prohibited Actions:**
- Parameter changes
- Withdrawals
- Deposits entering execution
- Strategy overrides
- Manual intervention

This is a **no-control state**.  
All execution is autonomous.

---

### 2.5 Settling (Post-Cycle Accounting)

**Description:**  
The execution cycle has ended and positions are being closed, reconciled, and accounted for.

**Permitted Actions:**
- View settlement progress

**Prohibited Actions:**
- Withdrawals
- Redemptions
- Parameter changes
- New execution commitments

Settlement must complete before results are finalized.

---

### 2.6 Finalized Results

**Description:**  
Cycle outcomes have been fully calculated and verified.

**Permitted Actions:**
- View final results
- View fees (if any)
- View LOOP minting status

**Prohibited Actions:**
- Retroactive changes
- Dispute of verified accounting via protocol

Results reflect realized outcomes only.

---

### 2.7 Post-Cycle Decision State

**Description:**  
The user may choose how funds and LOOP are handled going forward.

**Permitted Actions:**
- Withdraw funds
- Leave funds queued for the next cycle
- Redeem LOOP (if available and eligible)
- Update parameters for the next cycle

**Prohibited Actions:**
- Reopening or altering completed cycles

Actions taken apply only to future cycles.

---

### 2.8 Redemption Available (Conditional State)

**Description:**  
LOOP redemption is available only if system conditions permit.

**Permitted Actions:**
- Redeem eligible LOOP at the accounting rate

**Prohibited Actions:**
- Forced redemption
- Guaranteed redemption
- Redemption exceeding available surplus

Redemption availability is not guaranteed and may change over time.

---

### 2.9 Dormant / No-Action State

**Description:**  
The user takes no action after cycle completion.

**Permitted Actions:**
- None required

**Effect:**
- Funds remain queued
- Parameters persist or reset based on prior selection
- No penalty is applied

Inaction is always a valid state.

2.10 Recovery State (Exceptional)

Description:
Settlement failed beyond retry thresholds.

Permitted Actions:
- User withdrawals
- View finalized accounting

Prohibited Actions:
- Execution
- LOOP minting
- Fee collection

Purpose:
Prevent indefinite fund lock while preserving accounting integrity.


---

## 3. Control Authority Summary

| State | User Control | System Control |
|-----|-------------|----------------|
| Wallet Connected | Full | None |
| Pending Deposit | Full | None |
| Configuration Locked | None | Partial |
| Active Cycle | None | Full |
| Settling | None | Full |
| Finalized Results | View Only | Full |
| Post-Cycle Decision | Full | None |
| Redemption Available | Conditional | Conditional |

---

## 4. Explicit Non-Permissions

At no time does YieldLoop allow:
- Mid-cycle withdrawals
- Mid-cycle parameter changes
- Manual trade intervention
- Price support actions
- Outcome manipulation
- Guaranteed profit mechanisms

---

## 5. Design Intent

This state-based model exists to:
- Protect users from impulsive intervention
- Prevent execution interference
- Ensure consistent accounting
- Eliminate ambiguity regarding control and responsibility

YieldLoop prioritizes determinism, transparency, and constraint over flexibility.

## 6. — Recovery State

State Name: Recovery

Description:
The Recovery state is entered if settlement cannot complete after repeated retries or a defined timeout.

Entry Conditions:
- Settlement execution fails beyond permitted retry thresholds.
- External dependencies prevent deterministic settlement completion.

Permitted Actions:
- User withdrawals from affected vaults.
- Viewing finalized accounting data.

Prohibited Actions:
- Execution or re-execution of strategies.
- LOOP minting.
- Platform fee collection.

Exit Conditions:
- None. Recovery is terminal for the affected cycle.

Purpose:
Prevent indefinite fund lock while preserving accounting integrity.

---

# Appendix C  
## Outcome Scenarios, Zero-Result Handling, and Failure Conditions

This appendix enumerates all possible execution outcomes within YieldLoop and defines how each outcome is handled, recorded, and presented to users. This section exists to eliminate ambiguity regarding system behavior, user expectations, and result interpretation.

YieldLoop records outcomes based on realized execution only. No projections, estimates, or implied performance are used.

A cycle in which no trades occur due to risk constraints is considered a successful execution with zero activity.

---

## 1. Principle of Verified Outcomes

YieldLoop recognizes only **verifiable, realized outcomes** after:
- All positions are settled
- All execution costs are accounted for
- All fees are applied

If an outcome cannot be verified, it is treated as **zero**.

---

## 2. Primary Outcome Categories

Each execution cycle results in exactly one of the following outcome categories.

---

### 2.1 Positive Net Profit

**Definition:**  
Total realized proceeds exceed total costs, including:
- Gas
- Slippage
- Fees
- Execution overhead

**System Handling:**
- Net profit is recorded
- Platform fees are applied
- System deposit is allocated
- LOOP may be minted

**User Presentation:**
- Net profit displayed
- Fees itemized
- LOOP minting status shown

Positive profit does not imply future performance.

---

### 2.2 Break-Even Outcome

**Definition:**  
Total realized proceeds approximately equal total costs.

**System Handling:**
- Outcome recorded as zero
- No fees applied
- No LOOP minted

**User Presentation:**
- Result shown as zero
- Explanation provided that costs consumed gains

Break-even cycles are considered successful executions with no surplus.

---

### 2.3 Zero-Activity Outcome

**Definition:**  
No trades or yield actions are executed due to system logic, risk constraints, or market conditions.

**System Handling:**
- No profit recorded
- No fees applied
- No LOOP minted

**User Presentation:**
- Clear indication that execution was intentionally withheld
- Explanation that abstention is a valid system decision

YieldLoop is not required to trade in every cycle.

---

### 2.4 Negative Outcome (Loss)

**Definition:**  
Total realized proceeds are less than total costs.

**System Handling:**
- Loss recorded
- No platform fees applied
- No LOOP minted

**User Presentation:**
- Loss amount shown
- No attempt is made to offset or mask losses

Losses are possible and expected in some market conditions.

---

## 3. Zero-Profit Rule

YieldLoop enforces a strict **zero-profit rule**:

- If net profit ≤ 0:
  - Fees are not taken
  - LOOP is not minted
  - No surplus is recorded

This rule prevents dilution, accounting distortion, and artificial reward issuance.

---

## 4. Partial Execution Scenarios

In some cycles:
- Only a subset of strategies may execute
- Some capital may remain idle
- Risk constraints may limit activity

**Handling:**
- Only executed portions are accounted for
- Idle capital neither gains nor loses
- Final outcome reflects aggregate realized result

---

## 5. Gas and Cost Dominance Scenarios

**Definition:**  
Execution gains are outweighed by gas, slippage, or overhead.

**Handling:**
- Treated as break-even or negative
- No adjustments are made to compensate
- No LOOP minted

YieldLoop does not subsidize inefficiency.

---

## 6. Strategy Abstention Scenarios

Strategies may abstain from execution when:
- Risk thresholds are exceeded
- Liquidity is insufficient
- Market conditions are unfavorable
- Internal safeguards are triggered

**Handling:**
- Abstention is logged as intentional
- No profit or loss is recorded
- No LOOP minted

Abstention is considered a successful risk outcome.

---

## 7. System-Level Failure Conditions

### 7.1 Smart Contract Failure

**Handling:**
- Execution halts
- Funds remain in contract custody
- Recovery follows predefined contract logic

No performance assumptions are made.

---

### 7.2 External Dependency Failure

Examples include:
- Oracle outages
- DEX unavailability
- Network congestion

**Handling:**
- Execution may pause or abort
- No forced execution occurs
- Outcome recorded based on realized state only

---

## 8. LOOP Issuance Constraints

LOOP is minted **only if**:
- Net profit is positive
- Platform fees are successfully collected
- System deposit allocation completes

If any step fails, LOOP is not minted.

---

## 9. User Dispute Limitation

Users acknowledge that:
- Outcomes are final once verified
- The protocol does not arbitrate performance dissatisfaction
- Disputes regarding market behavior are not grounds for reversal

---

## 10. Design Intent

This outcome framework exists to:
- Prevent performance misrepresentation
- Eliminate reward issuance during losses
- Preserve accounting integrity
- Ensure users understand that inactivity and zero outcomes are valid

YieldLoop prioritizes truthful reporting over continuous reward generation.

---

# Appendix D  
## LOOP Definition, Scope, and Explicit Limitations

This appendix defines the LOOP token precisely and establishes explicit boundaries regarding its function, purpose, and limitations. This section exists to prevent misinterpretation, implied guarantees, or unintended financial representations.

LOOP is designed as an internal accounting artifact that records verified system surplus. It is not designed to function as a yield instrument, governance token, or investment contract.

---

## 1. What LOOP Is

LOOP represents a proportional record of **historically verified, retained surplus** generated by the YieldLoop system.

LOOP exists only when:
- A cycle completes
- Net profit is positive after all costs
- Platform fees are collected
- A system deposit is allocated

LOOP is minted **after profit exists**, not before.

---

## 2. What LOOP Is Not

LOOP is explicitly **not**:

- A promise of future profit
- A yield-bearing instrument
- A claim on future revenue
- A governance token
- An equity share
- A debt instrument
- A stable asset
- A price-backed or price-supported token
- A guaranteed redemption asset

Holding LOOP does not entitle the holder to:
- Guaranteed returns
- Priority withdrawals
- Voting rights
- Dividends
- Price appreciation

---

## 3. LOOP and Value Interpretation

Any perceived value of LOOP arises from:
- Historical system performance
- User interpretation of retained surplus
- External market behavior (if applicable)

YieldLoop does not:
- Set a target price
- Maintain a price floor
- Defend market value
- Guarantee liquidity
- Guarantee redemption

---

## 4. Accounting Floor Clarification

The accounting floor represents:

> The ratio of total verified retained surplus to total LOOP supply.

The accounting floor:
- Is informational only
- Is not a price guarantee
- Is not a redemption promise (except where explicitly allowed)
- Does not imply minimum market value

Market prices, if they exist, may differ materially from the accounting floor.

---

## 5. LOOP Supply Characteristics

- LOOP supply is variable
- LOOP has no fixed maximum supply
- LOOP minting is constrained by real profit
- LOOP is never emitted or pre-allocated
- LOOP is never minted in anticipation of performance

If no profit exists, no LOOP exists.

---

## 6. LOOP Redemption (When Applicable)

When redemption is enabled:
- Redemption is optional
- Redemption reflects historical surplus only
- Redemption availability is conditional
- Redemption may be paused or rate-limited based on system conditions; however, LOOP that has been finalized and assigned to a user’s claimable balance cannot be permanently disabled from redemption in principle. 

Redemption is not guaranteed and may change as system design evolves.

---

## 7. LOOP and Market Trading

LOOP may or may not be tradable depending on system phase.

If trading exists:
- Prices are market-determined
- YieldLoop does not intervene
- YieldLoop does not provide price support
- YieldLoop does not ensure liquidity

Trading outcomes do not affect accounting outcomes.

---

## 8. No Reliance Statement

Users acknowledge that:
- LOOP should not be relied upon for income
- LOOP should not be relied upon for appreciation
- LOOP may have limited or no liquidity
- LOOP may have no market value

Participation in YieldLoop should not be based on LOOP expectations.

---

## 9. Design Intent

LOOP exists to:
- Record truth, not project outcomes
- Reflect success, not promise it
- Preserve accounting integrity
- Avoid narrative-driven incentives

YieldLoop prioritizes system correctness over token attractiveness.

---

# Appendix E  
## Time, Cycle Duration, Cutoff Rules, and Calendar Definitions

This appendix defines how time is measured, how execution cycles are scheduled, and how cutoff rules are enforced within YieldLoop. These definitions exist to eliminate ambiguity regarding timing, eligibility, and execution boundaries.

All timing rules are deterministic and system-enforced.

---

## 1. Cycle Duration Definition

YieldLoop operates on fixed execution cycles.

- Each cycle has a defined start timestamp and end timestamp
- Cycle duration is expressed as a fixed calendar period (e.g., one calendar month)
- The exact duration and schedule are defined by the protocol and disclosed in advance

Cycle length is not adjustable by individual users.

---

## 2. System Time Standard

All system time references use a single authoritative standard:

- Coordinated Universal Time (UTC)

User local time zones do not affect:
- Cycle boundaries
- Deposit cutoffs
- Execution start or end times
- Settlement timing

Displayed local times are informational only.

---

## 3. Deposit Timing Rules

### 3.1 Deposit Eligibility

- Deposits may be made at any time
- Deposits do not enter execution immediately
- Deposits are placed into a queued (pending) state

---

### 3.2 Cycle Inclusion Cutoff

- Deposits must be confirmed on-chain **before** the cycle start timestamp to be included in the upcoming cycle
- Deposits confirmed after the cutoff timestamp are queued for the following cycle

No exceptions are made for:
- Network congestion
- User error
- Wallet delays
- Gas pricing issues

---

## 4. Parameter Configuration Cutoffs

- Strategy parameters must be finalized before the cycle lock timestamp
- Parameters not finalized by the cutoff are:
  - Retained from the prior cycle, or
  - Set to system defaults (as disclosed)

Once parameters are locked:
- They cannot be changed until cycle completion

---

## 5. Acknowledgement Deadlines

- All required acknowledgements must be completed before the cycle lock timestamp
- Failure to complete acknowledgements results in:
  - Funds remaining queued
  - Non-participation in the upcoming cycle

No execution occurs without explicit acknowledgement.

---

## 6. Cycle Start and Execution Window

- At the cycle start timestamp:
  - All eligible queued funds enter execution
  - Execution parameters become active
- Execution continues until the cycle end timestamp

Execution does not pause for:
- User activity
- Market conditions
- External events

---

## 7. Cycle End and Settlement Window

- At cycle end:
  - No new execution actions are initiated
  - Positions are closed or settled
- Settlement may require additional time after the official cycle end timestamp

Settlement duration:
- Does not affect cycle eligibility
- Does not extend execution
- Must complete before results are finalized

---

## 8. Result Finalization Timing

- Results are considered final only after:
  - Settlement completes
  - All costs are accounted for
  - Verification checks pass
- Preliminary or estimated results are not shown as final

Users should rely only on finalized results.

---

## 9. Withdrawal Timing

- Withdrawals are permitted only after results are finalized
- Withdrawal requests submitted during:
  - Active cycle
  - Settlement phase  
  are queued until permitted

Withdrawal processing time depends on:
- Network conditions
- Contract execution

YieldLoop does not guarantee instant withdrawals.

---

## 10. Redemption Timing (When Applicable)

- Redemption availability is evaluated after result finalization
- Redemption windows, if enabled:
  - May be continuous
  - May be periodic
  - May be paused or discontinued

Redemption timing is system-defined and not user-controlled.

---

## 11. Missed Cycle Scenarios

If a user:
- Deposits after cutoff
- Fails to acknowledge risks
- Fails to finalize parameters

Then:
- Funds remain queued
- No execution occurs
- No penalty is applied

Participation resumes in the next eligible cycle.

---

## 12. System Downtime and Exceptional Timing Events

In the event of:
- Network outages
- Blockchain congestion
- External dependency failures

The system may:
- Delay execution start
- Extend settlement time
- Abort execution for the affected cycle

In such cases:
- Funds remain in custody
- No forced execution occurs
- Outcomes are recorded based on realized state only

---

## 13. Design Intent

These timing rules exist to:
- Enforce fairness across users
- Prevent edge-case disputes
- Eliminate discretionary timing decisions
- Preserve deterministic execution

YieldLoop prioritizes consistency over convenience.

---

## Appendix F - How Returns Work in YieldLoop — Cycles, Markets, and LOOP

This document explains how returns function in YieldLoop **without framing them as promises**.

YieldLoop does not sell upside.  
It enforces truth.

---

## 1. YieldLoop Does Not Produce Continuous Returns

YieldLoop does not operate on:
- APYs
- Rolling balances
- Projected performance
- Smoothed outcomes

Instead, it operates on **discrete execution cycles**.

Each cycle ends with one of two outcomes:
- **Positive**: verifiable surplus exists after all costs
- **Non-positive**: surplus does not exist and is treated as zero

There is no partial credit and no carryover.

---

## 2. Positive Cycles Follow Market Conditions

YieldLoop does not attempt to outperform markets.  
It participates **within** them.

As a result:
- Positive cycles tend to occur during favorable market conditions
- Flat or zero cycles tend to occur during sideways or adverse conditions

The system does not manufacture profit when markets do not offer it.

This behavior is intentional.

---

## 3. History Is Informational, Not Predictive

Once operational, YieldLoop may display historical cycle results.

These records:
- Show how the system behaved under past conditions
- Demonstrate how often profit was achievable
- Allow users to make their own judgments

They do **not** imply:
- Future performance
- Expected frequency of positive cycles
- Guaranteed outcomes

History provides context, not guidance.

---

## 4. What Happens When a Cycle Is Positive

When a cycle produces verified surplus:
1. All gas, protocol, and execution costs are paid
2. Platform fees are applied
3. Remaining surplus is finalized
4. A portion of verified retained surplus is minted into LOOP according to the Dynamic Mint Ratio (DMR). The remainder remains unminted and retained by the system.

LOOP is minted **only after** profit is real.

If no surplus exists, nothing is minted.

---

## 5. LOOP as a Store of Value

LOOP represents:
- Retained, verified surplus
- Already-earned value
- A proportional record of system success

LOOP is not created in anticipation of future performance.

Because LOOP is minted only after surplus exists:
- It cannot be inflated without value
- Its internal accounting floor cannot be diluted by design

LOOP may be redeemable under defined system conditions.  
Any redemption reflects **history**, not expectation.

---

## 6. Why YieldLoop Is Slow by Design

YieldLoop does not chase:
- Growth
- TVL
- Volume
- Market cycles

It is built to:
- Survive bad markets
- Remain solvent without emissions
- Tell the truth every cycle

If positive cycles occur frequently, the system grows.  
If they do not, the system waits.

That is the model.

---

## Closing Note

YieldLoop is not an answer to the question:

“How do I make money quickly?”

It is an answer to a different question:

“How do we build a system that doesn’t lie about whether it worked?”

If that distinction matters to you, this system may be worth your time.

# Appendix G — Strategy Engine Specifications

This appendix defines the deterministic strategy modules (“Strategy Engines”) that may be executed within a YieldLoop cycle.
Each Strategy Engine is a bounded, auditable state machine with explicit inputs, safety constraints, execution rules, settlement logic, and failure behavior.
Strategy Engines do not perform discretionary managed trading.
Artificial intelligence may be used only to recommend configuration parameters and may never bypass user authorization or system guardrails.

---

## G1 — Spot Strategy Engine (SSE)

### G1.1 Purpose
The Spot Strategy Engine (SSE) allocates a defined portion of a user’s cycle capital into approved spot assets and manages those holdings using deterministic, rule-based execution.
The SSE may rebalance or hold positions based on the authorized configuration but does not guarantee profits and does not smooth outcomes across cycles.

### G1.2 Supported Assets (Initial Whitelist)
- PAXG
- BTC
- ETH
- XRP
- BNB
- SOL

Additional assets may be added only through governance or administrative configuration and must meet liquidity, oracle reliability, and risk criteria.

### G1.3 Inputs and Decision Rights

#### G1.3.1 User Inputs (Cycle-Authorized)
The following inputs are selected by the user and locked at cycle start:
- Risk tier selection
- Spot allocation percentage (portion of cycle capital routed to the SSE)
- Asset allowlist (subset of supported assets)
- Rebalancing mode: Disabled / Threshold-based / Scheduled
- Global profit handling preference: Compound All / 50-50 / Withdraw All

#### G1.3.2 Strategy Parameters (AI-Recommended, User-Approved)
The following parameters may be proposed by AI systems or selected manually by the user.
All parameters must be approved prior to cycle start:
- Target allocation weights per asset
- Maximum single-asset exposure limit
- Rebalance threshold (basis-point deviation from target weights)
- Minimum time between trades (trade cadence)
- Optional risk-off behavior configuration (pause or hold rules)

#### G1.3.3 Execution Parameters (System-Enforced)
The following parameters are enforced by the system and cannot be overridden:
- Maximum allowed slippage
- Maximum allowed price impact
- Minimum liquidity threshold for execution venues
- Maximum gas cost per trade or per execution window
- Approved venue, router, and aggregator allowlist
- Mandatory MEV-protection requirements (minimum output, deadlines, protected routing where available)

### G1.4 State Machine
The Spot Strategy Engine operates as a deterministic state machine:

Idle → Configured → Active → Paused → SettlementPending → Settled

State transitions are recorded on-chain.
Settlement logic must be idempotent, allowing safe retries without double-counting or duplicate payouts.

### G1.5 Core Logic

#### G1.5.1 Allocation (Cycle Start)
1. Determine SSE capital allocation based on the authorized spot allocation percentage.
2. Resolve target asset weights from the approved configuration.
3. Execute spot purchases to reach target allocations, subject to all execution guardrails.
4. If guardrails fail, the affected action is skipped and logged without degraded execution.

#### G1.5.2 Rebalancing (Optional)
Rebalancing may occur only if enabled and only when all conditions are satisfied.
Rebalance triggers may include:
- Asset weight deviation beyond the authorized threshold
- Scheduled rebalance window
- Risk-off or safety condition triggers

All rebalancing actions are subject to execution guardrails and safety checks.

### G1.6 Safety Guardrails

#### G1.6.1 Portfolio Caps
- Maximum single-asset exposure (hard cap)
- Maximum trading frequency enforced via cooldowns
- Drawdown-based behavior:
  - Soft drawdown: suspend new buys and rebalancing
  - Hard drawdown: pause engine execution without forced liquidation unless explicitly permitted by policy

#### G1.6.2 Market Integrity Checks
- Oracle validity and staleness checks
- Cross-oracle deviation thresholds
- Minimum liquidity and volume requirements
- Spread and route-quality validation

#### G1.6.3 Execution Protection
- Mandatory minimum-output enforcement
- Strict execution deadlines
- Slippage and price-impact limits
- MEV-aware execution routing
- Failed checks result in skipped execution and audit logging

#### G1.6.4 Kill Switch
The SSE enters a paused state upon detection of:
- Oracle failure or unreliability
- Repeated transaction reverts
- Abnormal gas conditions
- Liquidity collapse or route anomalies
- Administrative or emergency pause events

### G1.7 Settlement and Valuation

#### G1.7.1 Snapshot
At cycle end, the SSE records:
- Asset balances
- Approved oracle prices with staleness metadata
- Applicable valuation haircuts

#### G1.7.2 Deterministic Valuation
End-of-cycle valuation is computed using the approved oracle policy and haircut configuration.
If a reliable oracle price is unavailable under policy rules, the asset is valued at zero for settlement purposes.

#### G1.7.3 Profit and Loss Calculation
Net Profit = End Value − Start Value − All Execution Costs

- If Net Profit ≤ 0: no rewards or minting are generated by the SSE for the cycle.
- If Net Profit > 0: profits are processed according to the user’s global cycle preference, and system-level minting logic may apply under the defined DMR rules.

### G1.8 AI Integration and Audit Trail
Artificial intelligence systems may recommend strategy parameters but may not execute trades or modify configurations without user authorization.
AI systems cannot bypass safety guardrails or alter authorized configurations mid-cycle unless explicitly permitted by governance policy.

All AI-assisted configurations must generate an audit trail including:
- Input data summary
- Recommendation output hash
- Final user-approved configuration
- Timestamp and cycle identifier


## G2 — LP Farming Strategy Engine (LPSE)

### G2.1 Purpose
The LP Farming Strategy Engine (LPSE) allocates a defined portion of a user’s cycle capital into liquidity provider (LP) positions and manages those positions using deterministic, rule-based execution.
The LPSE is designed to generate yield from swap fees and protocol incentives while enforcing strict controls around impermanent loss, liquidity quality, and protocol risk.
The LPSE does not guarantee returns and does not subsidize losses.

### G2.2 Supported Protocol Model
LPSE supports LP deployments that meet the following baseline criteria:
- Non-custodial, audited AMM or vault-based LP protocols
- Transparent accounting of principal, fees, and rewards
- Reliable oracle coverage for underlying assets
- Permissionless exit capability

Specific protocols may be allowlisted by governance or administrative configuration.

### G2.3 Recommended LP Pair Classes (Initial)
The following LP pair classes are permitted in the initial configuration, subject to governance approval:

- BTC / ETH
- ETH / BNB
- BTC / USDC
- ETH / USDC
- USDC / USDT
- USDC / DAI

Pairs must meet minimum liquidity, volume, and volatility criteria to remain active.

### G2.4 Inputs and Decision Rights

#### G2.4.1 User Inputs (Cycle-Authorized)
- Risk tier selection
- LP allocation percentage (portion of cycle capital routed to LPSE)
- LP pair allowlist (subset of approved pairs)
- LP mode: Direct LP / Vault-managed LP (if supported)
- Global profit handling preference: Compound All / 50-50 / Withdraw All

#### G2.4.2 Strategy Parameters (AI-Recommended, User-Approved)
- Target LP pair weights
- Maximum exposure per LP pair
- Impermanent loss tolerance thresholds
- Minimum fee APR and/or incentive APR thresholds
- Rebalance or redeploy cadence
- Optional exit-on-condition rules

#### G2.4.3 Execution Parameters (System-Enforced)
- Minimum pool liquidity and volume thresholds
- Maximum slippage on LP entry and exit
- Maximum gas-cost thresholds
- Approved protocol and router allowlists
- Mandatory oracle validation for underlying assets

### G2.5 State Machine
Idle → Configured → Active → Paused → SettlementPending → Settled

State transitions are recorded on-chain.
Settlement logic must be idempotent and resilient to partial failures.

### G2.6 Core Logic

#### G2.6.1 Allocation (Cycle Start)
1. Determine LPSE capital allocation based on authorized percentage.
2. Resolve LP pair weights from approved configuration.
3. Enter LP positions using approved protocols and routes.
4. Stake or deploy LP tokens into yield-generating contracts where applicable.

#### G2.6.2 Position Monitoring
The LPSE continuously evaluates:
- Fee generation rate
- Incentive yield (if applicable)
- Impermanent loss relative to hold baseline
- Pool liquidity and volatility
- Protocol health indicators

#### G2.6.3 Rebalance and Exit
LP positions may be partially or fully exited if:
- Impermanent loss exceeds authorized thresholds
- Fee and incentive yield fall below minimum thresholds
- Liquidity degrades below safety minimums
- Risk-off or emergency conditions are triggered

Exited capital may be held idle or redeployed only if permitted by the authorized configuration.

### G2.7 Safety Guardrails

#### G2.7.1 Impermanent Loss Controls
- Continuous IL estimation versus spot-hold baseline
- Soft IL breach: suspend new LP entry
- Hard IL breach: exit LP position subject to execution guards

#### G2.7.2 Protocol and Market Integrity
- Protocol allowlist and audit requirements
- Oracle sanity checks for underlying assets
- Pool composition and imbalance checks
- Volume and spread validation

#### G2.7.3 Execution Protection
- Slippage and price-impact caps on LP entry/exit
- Gas-cost ceilings
- MEV-aware routing where applicable
- Failed guardrail checks result in skipped actions and logged events

#### G2.7.4 Kill Switch
The LPSE enters a paused state upon:
- Protocol exploit or emergency alerts
- Oracle failure
- Repeated transaction reverts
- Liquidity collapse
- Administrative or emergency pause events

### G2.8 Settlement and Valuation

#### G2.8.1 Snapshot
At cycle end, the LPSE records:
- LP token balances
- Underlying asset composition
- Accrued fees and incentives
- Oracle prices and valuation haircuts

#### G2.8.2 Deterministic Valuation
LP positions are valued based on:
- Underlying asset quantities
- Approved oracle prices
- Configured haircuts reflecting IL and protocol risk

If valuation data is incomplete or unreliable, the affected LP position may be conservatively valued at zero.

#### G2.8.3 Profit and Loss Calculation
Net Profit = End Value − Start Value − All Execution and Protocol Costs

- If Net Profit ≤ 0: no rewards or minting are generated by the LPSE for the cycle.
- If Net Profit > 0: profits are processed according to the user’s global cycle preference, and system-level minting logic may apply under the defined DMR rules.

### G2.9 AI Integration and Audit Trail
AI systems may recommend LP pair selection, weighting, and exit thresholds but may not execute trades or bypass guardrails.
All AI-assisted configurations require user authorization and generate a full audit trail including input summaries, recommendation hashes, and approved parameters.


## G3 — Stable Yield Strategy Engine (SYSE)

### G3.1 Purpose
The Stable Yield Strategy Engine (SYSE) allocates a defined portion of a user’s cycle capital into stablecoin-based yield strategies.
The SYSE prioritizes capital preservation, liquidity, and predictability over yield maximization.
The engine operates deterministically and does not guarantee returns.

### G3.2 Supported Stable Assets (Initial)
- USDC
- USDT
- DAI
- FDUSD (optional, governance-approved)
- Other stables may be added only via governance and must meet strict solvency, liquidity, and oracle requirements.

Algorithmic or reflexive stablecoins may be explicitly excluded by policy.

### G3.3 Supported Yield Mechanisms
The SYSE may deploy capital into one or more of the following mechanisms, subject to allowlisting:
- Lending markets (overcollateralized, non-custodial)
- Stablecoin vaults with transparent accounting
- Low-volatility stable AMM pools
- Protocol-native staking or savings modules

Each mechanism must support permissionless exit and reliable valuation.

### G3.4 Inputs and Decision Rights

#### G3.4.1 User Inputs (Cycle-Authorized)
- Risk tier selection
- Stable allocation percentage (portion of cycle capital routed to SYSE)
- Stable asset allowlist
- Yield mechanism allowlist
- Global profit handling preference: Compound All / 50-50 / Withdraw All

#### G3.4.2 Strategy Parameters (AI-Recommended, User-Approved)
- Target allocation weights across stable assets and yield mechanisms
- Maximum exposure per protocol or vault
- Minimum acceptable yield threshold
- Redeployment cadence
- Optional risk-off or capital-hold rules

#### G3.4.3 Execution Parameters (System-Enforced)
- Maximum protocol exposure caps
- Minimum liquidity thresholds
- Maximum gas-cost thresholds
- Approved protocol and router allowlists
- Mandatory oracle and peg validation requirements

### G3.5 State Machine
Idle → Configured → Active → Paused → SettlementPending → Settled

All state transitions are recorded on-chain.
Settlement logic must be idempotent and resilient to partial failures.

### G3.6 Core Logic

#### G3.6.1 Allocation (Cycle Start)
1. Determine SYSE capital allocation based on authorized percentage.
2. Resolve asset and mechanism weights from approved configuration.
3. Deploy capital into selected yield mechanisms subject to all guardrails.

#### G3.6.2 Position Monitoring
The SYSE continuously evaluates:
- Yield performance versus minimum thresholds
- Liquidity availability
- Protocol health indicators
- Stablecoin peg deviation metrics

#### G3.6.3 Reallocation and Exit
Positions may be partially or fully exited if:
- Yield falls below minimum thresholds
- Liquidity deteriorates
- Peg deviation exceeds authorized limits
- Risk-off or emergency conditions are triggered

Exited capital may be held idle or redeployed only if permitted by configuration.

### G3.7 Safety Guardrails

#### G3.7.1 Stablecoin Integrity Controls
- Continuous peg monitoring
- Soft peg deviation: suspend new deployment
- Hard peg deviation: exit affected positions subject to execution guards

#### G3.7.2 Protocol Risk Controls
- Protocol allowlist and audit requirements
- Exposure caps per protocol
- Oracle sanity and staleness checks

#### G3.7.3 Execution Protection
- Slippage and price-impact caps
- Gas-cost ceilings
- MEV-aware routing where applicable
- Failed checks result in skipped execution and audit logging

#### G3.7.4 Kill Switch
The SYSE enters a paused state upon:
- Stablecoin depeg events
- Protocol exploit alerts
- Oracle failure
- Repeated transaction reverts
- Administrative or emergency pause events

### G3.8 Settlement and Valuation

#### G3.8.1 Snapshot
At cycle end, the SYSE records:
- Stable asset balances
- Accrued interest or rewards
- Oracle prices and peg status
- Applicable valuation haircuts

#### G3.8.2 Deterministic Valuation
Stable assets are valued using approved oracle prices with peg validation.
If a stable asset fails peg validation under policy rules, it may be conservatively valued at zero for settlement purposes.

#### G3.8.3 Profit and Loss Calculation
Net Profit = End Value − Start Value − All Execution and Protocol Costs

- If Net Profit ≤ 0: no rewards or minting are generated by the SYSE for the cycle.
- If Net Profit > 0: profits are processed according to the user’s global cycle preference, and system-level minting logic may apply under the defined DMR rules.

### G3.9 AI Integration and Audit Trail
AI systems may recommend stable allocation and yield mechanism selection but may not execute transactions or bypass guardrails.
All AI-assisted configurations require user authorization and produce a complete audit trail including input summaries, recommendation hashes, and final approved parameters.


---

## G4 — Risk Tier Definitions and Default Strategy Templates

Risk tiers define default constraints, allocations, and behavior across all Strategy Engines.
Users may override defaults only within the bounds of system-enforced guardrails.

### G4.1 Ultra Low Risk

**Primary Objective:** Capital preservation  
**Expected Behavior:** Minimal volatility, frequent zero-profit cycles  

**Default Engine Allocation**
- Stable Yield Engine (SYSE): 70–90%
- Spot Strategy Engine (SSE): 10–30%
- LP Farming Engine (LPSE): 0–10%

**Spot Defaults**
- Allowed assets: PAXG, BTC, ETH
- Max single-asset exposure: 30%
- Rebalancing: Disabled or infrequent
- Drawdown behavior: Immediate soft drawdown on minor losses

**LP Defaults**
- Pairs limited to stable/stable or BTC/ETH only
- Strict impermanent loss thresholds
- LP allocation capped at minimal exposure

**Stable Defaults**
- Overcollateralized lending or low-volatility pools only
- Tight peg deviation thresholds

---

### G4.2 Low Risk

**Primary Objective:** Capital preservation with modest yield  
**Expected Behavior:** Low volatility, intermittent profits  

**Default Engine Allocation**
- SYSE: 50–70%
- SSE: 20–40%
- LPSE: 10–20%

**Spot Defaults**
- Allowed assets: PAXG, BTC, ETH, BNB
- Max single-asset exposure: 35%
- Rebalancing: Threshold-based (wide bands)

**LP Defaults**
- BTC/ETH, ETH/USDC, BTC/USDC
- Conservative IL thresholds

**Stable Defaults**
- Diversified stable mechanisms
- Moderate yield floor requirements

---

### G4.3 Medium Risk

**Primary Objective:** Balanced growth and yield  
**Expected Behavior:** Mixed outcomes across cycles  

**Default Engine Allocation**
- SSE: 40–60%
- LPSE: 20–40%
- SYSE: 10–30%

**Spot Defaults**
- Allowed assets: BTC, ETH, BNB, SOL
- Max single-asset exposure: 40%
- Rebalancing: Threshold-based (moderate bands)

**LP Defaults**
- ETH/BNB, BTC/ETH, ETH/USDC
- Moderate IL tolerance

**Stable Defaults**
- Used primarily as liquidity buffer and fallback

---

### G4.4 High Risk

**Primary Objective:** Growth maximization  
**Expected Behavior:** Higher volatility, higher variance outcomes  

**Default Engine Allocation**
- SSE: 50–70%
- LPSE: 30–50%
- SYSE: 0–20%

**Spot Defaults**
- Allowed assets: BTC, ETH, BNB, SOL, XRP
- Max single-asset exposure: 50%
- Rebalancing: Active

**LP Defaults**
- Volatile pairs allowed
- Higher IL tolerance

**Stable Defaults**
- Minimal defensive allocation

---

### G4.5 Unrestricted Risk

**Primary Objective:** Maximum upside  
**Expected Behavior:** High volatility, large dispersion of outcomes  

**Default Engine Allocation**
- Any mix permitted within global system caps

**Spot Defaults**
- All supported assets allowed
- High concentration permitted

**LP Defaults**
- All approved LP pairs permitted
- IL exits only on hard breach

**Stable Defaults**
- Optional only

---

### G4.6 Risk Tier Enforcement
Risk tier selection:
- Sets default templates
- Controls maximum overrides
- Does not guarantee performance
- Cannot bypass system-enforced guardrails

All risk tiers may experience zero-profit or loss cycles.
YieldLoop does not smooth, subsidize, or average outcomes across users or cycles.

---

## G5 — Market Regime Coverage and System Completeness

YieldLoop is designed to operate across multiple market regimes without assuming continuous profitability.

The platform does not guarantee positive returns in every cycle or every market condition.
Instead, YieldLoop is engineered to ensure that at least one authorized Strategy Engine may remain viable in each broad market regime, while allowing other engines to reduce activity, hold capital, or pause execution entirely.

The system recognizes the following high-level market regimes:
- Bull markets with sustained upward price movement
- Range-bound or volatile markets
- Bear markets with sustained downward pressure
- Crisis or liquidity-shock conditions

Strategy Engines are not required to trade continuously.
Engines may intentionally idle, pause, or skip execution when opportunity does not meet configured safety or return thresholds.

Capital preservation and deterministic settlement take precedence over forced activity.
Zero-profit cycles are considered a valid and expected outcome under this design.

No Strategy Engine is permitted to rely on leverage, forced liquidation, emissions subsidies, or accounting assumptions to manufacture yield.
YieldLoop prioritizes survivability, auditability, and honest accounting over continuous yield claims.

This design ensures the system remains operable, transparent, and non-degenerate across market regimes, while allowing returns to emerge naturally when genuine opportunity exists.
