# YieldLoop
## A Cycle-Based System for Executing and Verifying Real Profit

**Consumer Whitepaper**  
**Date:** 2025-12-16  
**Version:** 1.0  
**Status:** Public Overview  

---

## Table of Contents

1. What YieldLoop Is  
2. What YieldLoop Is Not  
3. The Core Rule: Verified Profit Only  
4. How a Cycle Works (Start to Finish)  
5. What Happens When a Cycle Is Profitable  
6. What Happens When a Cycle Is Not Profitable  
7. What LOOP Is — and What It Is Not  
8. Fees, Simply Explained  
9. Risks You Must Understand  
10. What YieldLoop Cannot Do  
11. Optional Programs (NFTs, Referrals, Governors)  
12. Transparency, Records, and Verification  
13. Who Controls the System  
14. Who Should Not Use YieldLoop  
15. Summary: Why YieldLoop Exists  

---

## 1. What YieldLoop Is

YieldLoop is a system that lets you **authorize actions on your own crypto**, run those actions in **fixed cycles**, and then see **what actually happened** after the cycle ends.

It is not always running.
It does not guess outcomes.
It does not show fake numbers.

You decide:
- Whether a cycle runs
- What strategies are allowed
- How profits are handled if they exist

The system then:
- Executes only what you approved
- Stops at the end of the cycle
- Records the final result

YieldLoop exists to answer one simple question honestly:

**Did real profit occur — yes or no?**

Nothing is counted until the cycle is over.

---

## 2. What YieldLoop Is Not

YieldLoop is **not** a bank.  
It is **not** a hedge fund.  
It is **not** a savings account.  
It is **not** financial advice.

YieldLoop does not:
- Hold your funds
- Pool your assets with others
- Promise returns
- Show estimated APYs
- Smooth losses
- Guarantee outcomes
- Trade without your permission

There is no “always earning.”
There is no “number going up” during execution.
There is no hiding bad cycles.

If a cycle makes nothing after costs, it is recorded as **zero**.

You are always in control of whether another cycle happens.

---

## 3. The Core Rule: Verified Profit Only

YieldLoop runs on one non-negotiable rule:

> **If profit cannot be verified after the cycle ends, it does not exist.**

That means:
- No projections
- No unrealized gains
- No “pending” rewards
- No assumptions

At the start of a cycle, your vault has a known balance.  
At the end of the cycle, your vault has a final balance.

If the ending balance is higher **after fees and costs**, the difference is real profit.  
If it is not, the result is recorded as zero.

There is no carry-forward.
There is no makeup.
There is no narrative.

YieldLoop does not try to convince you it’s working.

It simply records what happened.


## 4. How a Cycle Works (Start to Finish)

YieldLoop does not run continuously.  
Everything happens inside a **cycle**.

A cycle is a fixed window of time during which the system is allowed to execute actions you have explicitly approved. When the cycle ends, execution stops completely and results are finalized.

This design exists to remove ambiguity. There is no question of whether something is still “in progress” or whether results might change later.

---

### Step 1: Configuration

Before a cycle can begin, you choose what is allowed to happen.

This includes:
- Which strategies may run
- Which assets may be used
- How much capital may be involved
- How profits should be handled if they occur

Nothing is hidden. The system shows you exactly what will be permitted.

---

### Step 2: Authorization

Once configuration is complete, you must explicitly authorize the cycle.

Authorization is:
- Required for every cycle
- Time-bounded
- Revocable only by letting the cycle end

If you do not authorize, nothing happens.

---

### Step 3: Execution

During execution:
- The system performs only the actions you approved
- No parameters can be changed
- No withdrawals are allowed
- No human discretion is applied

Execution continues until the cycle reaches its end condition.

---

### Step 4: Stop and Settle

When the cycle ends:
- All execution halts
- No further trades or actions occur
- Costs are finalized
- Results are locked

Nothing continues running in the background.

---

### Step 5: Accounting

Only after settlement does YieldLoop calculate the outcome.

The system compares:
- The vault’s starting state
- The vault’s ending state
- All execution-related costs

The result is recorded as a completed fact.

This final record is what you see — not estimates, not projections, and not interim values.


## 5. What Happens When a Cycle Is Profitable

A YieldLoop cycle is considered profitable only if, after the cycle ends, the final vault balance is higher than the starting balance **after all execution-related costs** are accounted for.

There are no partial credits and no interim rewards. Profit is determined only once execution has fully stopped and settlement is complete.

If profit exists, it is handled exactly according to the choices you made **before the cycle began**.

---

### Profit Handling Is Pre-Selected

Before authorizing a cycle, you choose how any potential profit should be treated. Common options include:

- Full compounding back into the vault
- Partial compounding and partial payout
- Full payout

The system does not decide this for you, and it does not change behavior mid-cycle. If profit occurs, it follows your pre-selected instructions. If profit does not occur, nothing is issued.

---

### LOOP Issuance

When a cycle is profitable, the realized profit is converted into **LOOP**.

This is a key design feature.

LOOP is issued **only** when real profit exists. It is not emitted on a schedule, not granted as a reward for participation, and not created during losing cycles.

Because LOOP is minted from realized profit:
- It is fully backed at issuance
- It represents completed value, not expectation
- It is redeemable inside the YieldLoop platform

No profit → no LOOP.

---

### Platform Fee Application

A platform fee is applied only to the verified profit portion of a profitable cycle.

The fee:
- Is never applied to deposits or principal
- Is never applied to losing cycles
- Is calculated only after settlement

After the platform fee is applied, the remaining profit belongs entirely to you and is handled according to your selected parameters.

---

### Internal Fee Allocation (High-Level)

The platform fee is internally split to support system operation:

- Development and operations
- Marketing and user education
- LoopLabs (research and ecosystem tooling)
- System deposits that keep execution cycles operational

These allocations support the platform’s continued operation but do not affect how your individual cycle executes.

---

## 6. What Happens When a Cycle Is Not Profitable

If a cycle ends without profit — meaning the final vault balance does not exceed the starting balance after costs — the result is recorded as **zero**.

This outcome is treated as final.

There is no:
- LOOP issuance
- Platform fee
- Carry-forward credit
- Loss smoothing
- Adjustment in later cycles

The system does not attempt to recover losses or compensate for them in future execution.

---

### Why Zero Is Explicitly Recorded

Recording a zero outcome is intentional.

Many platforms obscure losing periods by blending results, projecting future recovery, or continuing to show estimated returns. YieldLoop does none of this.

A non-profitable cycle is recorded plainly so that:
- You can evaluate performance honestly
- There is no confusion about whether value was created
- Decisions about future cycles are based on facts, not assumptions

---

### User Control After a Non-Profitable Cycle

Once settlement is complete and the cycle ends, full control returns to you.

At that point, you may:
- Withdraw some or all assets
- Change configuration
- Select different strategies
- Authorize a new cycle
- Stop using the system entirely

YieldLoop does not pressure continuation and does not automatically reauthorize execution.

The decision to proceed always remains with you.

---

### No Narrative, No Recovery Promises

YieldLoop does not attempt to explain away losses or frame them as temporary setbacks.

A cycle either produced verified profit or it did not.

That clarity is the point of the system.


## 7. What LOOP Is — and How the Floor Mechanism Works

LOOP is the internal settlement token used by YieldLoop to represent **real, completed profit**.

It is not a reward for participation and it is not issued in advance of results. LOOP exists only because value was already created.

---

### What LOOP Is

LOOP is issued **only at the end of a profitable cycle**.

When a cycle finishes and verified profit exists:
- That profit is converted into LOOP
- LOOP is issued in an amount equal to the realized profit
- LOOP represents completed value, not expectation

This design ensures that LOOP is:
- Fully backed at the moment it is created
- Tied directly to completed execution
- Not dependent on future performance

If a cycle is not profitable, no LOOP is issued.

---

### What LOOP Is Not

LOOP is not:
- A staking reward
- An emissions token
- A speculative yield token
- A promise of future profit
- Issued on a schedule
- Created during losing cycles

There is no inflation mechanism unrelated to profit.

The system cannot mint LOOP unless profit already exists.

---

### Redemption and Use

LOOP is redeemable inside the YieldLoop platform.

Depending on user configuration, LOOP may be:
- Redeemed to the underlying asset value
- Compounded into future cycles
- Held within the system for later use

LOOP redemption is tied to system settlement rules and available liquidity. It is not a guarantee of instant liquidity under all conditions.

---

### The Floor Mechanism (Plain Language)

The LOOP “floor” is not a market promise or a price guarantee.

It is a **structural property** of how LOOP is created and handled.

Because:
- LOOP is minted only from realized profit
- No unbacked LOOP is created
- The system does not emit LOOP during losses

The system does not dilute existing LOOP with unearned issuance.

---

### System Deposits and Structural Support

A portion of platform fees is routed back into the system as **system deposits**.

These deposits:
- Provide execution capital for future cycles
- Increase the amount of real value supporting the system
- Prevent hollow or extractive issuance

This mechanism strengthens the system itself rather than artificially supporting market price.

---

### Does the Floor Go Down?

The structural floor does not weaken through issuance.

However:
- LOOP market price can fluctuate
- Redemption timing depends on system conditions
- External market forces still apply

YieldLoop does not promise that LOOP will increase in price or remain stable in secondary markets.

The “floor” refers to **backing discipline**, not market valuation.

---

### Why This Matters

Most systems issue tokens first and hope value follows.

YieldLoop reverses that order.

Value must exist **before** LOOP can exist.

That inversion is what makes the system auditable, disciplined, and resistant to dilution — without making promises it cannot keep.


## 8. Fees, Simply Explained

YieldLoop charges a platform fee, but only under very specific conditions.

There are no upfront fees, no subscription fees, and no fees for holding assets in a vault.

The platform earns fees **only when you earn real profit**.

---

### When Fees Apply

A platform fee is charged **only if** all of the following are true:

- A cycle has fully completed  
- Settlement and accounting are finalized  
- The cycle produced verified profit after all execution costs  

If any of these conditions are not met, **no platform fee is charged**.

That includes:
- Losing cycles
- Break-even cycles
- Cycles that fail due to execution or market conditions

---

### What Fees Are Not Charged On

YieldLoop does **not** charge fees on:

- Deposits
- Withdrawals
- Principal
- Idle balances
- Configuration or authorization
- Non-profitable cycles

If nothing is earned, nothing is taken.

---

### How Fees Are Calculated

When a cycle is profitable, the platform fee is calculated as a percentage of the **verified profit only**.

That calculation happens:
- After execution has stopped
- After costs are deducted
- After results are finalized

Fees are never estimated or reserved ahead of time.

---

### Where the Fee Goes

The platform fee is split internally to support the system:

- **Development & Operations**  
  Maintaining and improving the software and infrastructure.

- **Marketing & Education**  
  User education, documentation, and growth initiatives.

- **LoopLabs**  
  Research, tooling, and ecosystem development.

- **System Deposits**  
  Capital used to keep execution cycles operational and sustainable.

These allocations support the platform’s existence but do not affect how your individual cycle executes.

---

### Fee Transparency

For every profitable cycle, you can see:
- The total profit
- The fee applied
- The net amount remaining after fees

Nothing is hidden, blended, or deferred.

Fees are a consequence of success — not a cost of participation.

---

### Why the Fee Model Is Structured This Way

The fee model exists to align incentives.

If the system does not produce verified profit, it does not get paid.

This removes pressure to:
- Overtrade
- Inflate results
- Mask losses
- Encourage reckless execution

The platform survives by producing real outcomes, not by charging access.


## 9. Risks You Must Understand

YieldLoop is software that executes actions on digital assets.  
That means **risk is unavoidable**.

The system is designed to make outcomes clear — not to eliminate risk.

Before using YieldLoop, you should understand the following categories of risk.

---

### Market Risk

Markets move unpredictably.

Even simple strategies can lose money due to:
- Sudden price changes
- Low liquidity
- Slippage
- Failed arbitrage windows
- Rapid volatility

YieldLoop does not pause execution to avoid losses and does not change strategy mid-cycle based on market movement.

If market conditions turn unfavorable during a cycle, the outcome reflects that reality.

---

### Execution Risk

Execution is performed on live blockchain networks and external protocols.

Risks include:
- Failed or reverted transactions
- Partial execution
- Delayed confirmations
- Unexpected protocol behavior
- Changes in external platform conditions

If execution fails or performs worse than expected, the system records the outcome as-is. It does not retry indefinitely or compensate for execution failures.

---

### Smart Contract Risk

YieldLoop relies on smart contracts — both its own and those of third-party protocols.

Risks include:
- Bugs or vulnerabilities
- Unexpected interactions
- Contract upgrades or changes by external protocols
- Exploits or failures outside YieldLoop’s control

Audits and reviews reduce risk but do not eliminate it.

---

### Asset-Specific Risk

Different assets carry different risks.

These may include:
- Stablecoin depegs
- Issuer freezes or blacklisting
- Token volatility
- Liquidity shortages
- Protocol insolvency

YieldLoop does not assess asset quality or protect against asset-specific failures.

---

### System and Infrastructure Risk

YieldLoop depends on:
- Blockchain networks
- Validators
- RPC providers
- Wallet software
- User key management

Failures or congestion in any part of the infrastructure can delay or prevent execution, settlement, or withdrawal.

---

### No Guarantees or Protection

YieldLoop provides:
- No insurance
- No capital protection
- No guaranteed liquidity
- No guaranteed execution success

A cycle can end at zero or worse.

That possibility is part of using the system.

---

### User Responsibility

You are responsible for:
- Understanding what you authorize
- Selecting strategies and parameters
- Managing your private keys
- Accepting execution outcomes

YieldLoop does not decide what is appropriate for you.

---

### Why These Risks Are Stated Clearly

Many platforms minimize or obscure risk.

YieldLoop states risk plainly so you can decide whether to participate with full awareness.

Clarity is not a promise of safety — it is a commitment to honesty.


## 10. What YieldLoop Cannot Do

YieldLoop is deliberately constrained. These limits are not accidents or missing features — they are design choices.

YieldLoop cannot predict outcomes, forecast performance, or promise profit. It does not evaluate whether a strategy is “good” or “bad,” and it does not attempt to protect users from market movement once execution begins.

The system cannot intervene mid-cycle. Once you authorize a cycle, execution proceeds according to the rules you approved until the cycle ends or is halted by predefined safeguards. There are no stop-loss overrides, discretionary pauses, or human decisions inserted during execution.

YieldLoop also cannot hide losses or smooth results. If a cycle produces no profit after costs, the result is recorded as zero. There is no carry-forward, no averaging, and no narrative framing to soften outcomes.

Finally, YieldLoop cannot act on your behalf beyond what you explicitly authorize. It does not reauthorize itself, does not change configurations automatically, and does not compel you to continue using the system.

These constraints exist to ensure that outcomes are factual, auditable, and unambiguous — even when results are unfavorable.

---

## 11. Optional Programs (NFTs, Referrals, Governors)

YieldLoop includes optional ecosystem programs that exist alongside the core execution system. Participation in these programs is not required to use YieldLoop, and opting out does not limit access to core functionality.

These programs are operational and community-oriented. They do not change how strategies execute, how profit is generated, or how risk is managed.

---

### Supporter NFT

The **Supporter NFT** is an optional utility membership.

- **Proposed starting price:** $300 (adjustable prospectively by governance)
- **Primary benefit:** 5% discount on the protocol fee
- **Additional benefit:** access to a Supporter-only community channel and platform visibility features
- **Transferability:** transferable; benefits follow the wallet holding the NFT

The YieldLoop team may mint Supporter NFTs for marketing, partnerships, or community initiatives. Supporter NFTs do not grant ownership, governance authority, or profit rights.

---

### Governor NFT

The **Governor NFT** represents a high-trust advisory role.

- Not publicly sold by default
- Typically bestowed by the team
- **Primary benefit:** 10% protocol fee discount
- **Role:** advisory participation, feedback, and think-tank involvement
- **Transferability:** non-transferable by default; revocable by the team

Governor NFTs do not grant control over funds, execution, or protocol decisions. Governance input from Governors is advisory only.

---

### Referrals

Referral programs may reward outreach and education.

Referral benefits:
- Are sourced from platform fees
- Do not reduce another user’s profit
- Are limited in duration and scope
- Do not create ongoing compensation or income streams

Referral participation does not alter execution behavior.

---

## 12. Transparency, Records, and Verification

YieldLoop is designed so that results can be independently verified.

For each completed cycle, the system records:
- The vault state at the start of the cycle
- The vault state at the end of the cycle
- All execution-related costs
- The final net outcome

These records are generated only after settlement is complete. They are immutable and reflect completed execution only — not estimates, projections, or interim values.

YieldLoop does not publish leaderboards, rankings, or comparative performance claims. Historical records exist to document what happened, not to imply future results.

Transparency in YieldLoop means clarity of facts, not performance marketing.

---

## 13. Who Controls the System

Control within YieldLoop is intentionally separated.

You, the user, control:
- Whether a cycle runs
- What strategies and assets are authorized
- How profit is handled
- Whether to continue or stop after a cycle ends

The YieldLoop team controls:
- Software maintenance and upgrades
- Which strategies are available for future cycles
- Emergency safeguards
- Platform configuration and parameters

No one — including the team — can:
- Move your assets without authorization
- Change an active cycle mid-execution
- Alter settled results
- Reauthorize execution on your behalf

This separation exists to reduce conflicts of interest and prevent ambiguity about responsibility.

---

## 14. Who Should Not Use YieldLoop

YieldLoop is not suitable for everyone.

You should not use YieldLoop if you:
- Expect guaranteed or predictable returns
- Want passive, always-on yield
- Cannot tolerate losses
- Expect the system to make decisions for you
- Prefer real-time performance feedback
- Are uncomfortable with non-custodial execution risk

YieldLoop assumes users who are willing to make deliberate choices, accept outcomes, and evaluate results based on completed cycles rather than expectations.

---

## 15. Summary: Why YieldLoop Exists

YieldLoop exists to separate **authorization**, **execution**, and **outcomes** — and to treat each honestly.

You decide what may happen.  
The system executes exactly that.  
The result is recorded after everything stops.

No projections.  
No smoothing.  
No assumptions.

YieldLoop does not exist to promise upside.  
It exists to prove what actually happened.

