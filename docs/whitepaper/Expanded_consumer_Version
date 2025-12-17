## YieldLoop — The Truth-Based Yield Engine
## Whitepaper (Expanded, Complete)

1. What YieldLoop Is (In One Paragraph)
2. The Core Rule: Cycles, Not Assumptions
3. User Flow: From Deposit to Settlement
4. Profit Verification (Real or Zero)
5. Fees: When They Apply, How They’re Calculated, and Where They Go
6. Post-Cycle Outcomes: Withdraw, Compound, or Split
7. LOOP Token: Minting Rules, Backing, Redeemability
8. The Accounting Floor: What It Is, What It Isn’t, How It Moves
9. System Deposit Automation: The Perpetual Engine (and its Limits)
10. NFTs: Tiers, Prices, Supply, Discounts, and What They Do NOT Do
11. Referrals: Presale Program and Post-Launch Program (Bounded)
12. Risk, Failure Modes, Safeguards, and Bad Markets
13. What YieldLoop Refuses to Do (Explicit Non-Goals)
14. Final Summary + TL;DR


## 1. What YieldLoop Is (In One Paragraph)

YieldLoop is a cycle-based execution and accounting system designed to convert real, completed profit into a persistent internal asset called LOOP.
It does not project yield, estimate APYs, smooth returns, or reward activity. Instead, YieldLoop forces every execution period to end, settle completely, and record reality. If profit exists after all costs, it is recognized. If it does not, the system records zero and moves on. Nothing carries forward unless it actually happened.

⸻

## 2. The Core Rule: Cycles, Not Assumptions

YieldLoop rejects continuous accounting.

Most platforms keep positions open indefinitely, re-mark performance, and blur time to hide losses. YieldLoop does the opposite.
	•	Execution occurs in discrete, fixed cycles
	•	Every cycle has a known start and a hard end
	•	Results are final, atomic, and auditable
	•	No cycle can be reopened, revised, or smoothed

This rule is non-negotiable because it enforces truth.
If something cannot be finalized, it does not count.

The system only ever asks one question per cycle:

Did real profit exist after everything was paid?

There is no concept of “almost,” “unrealized,” or “expected” profit.

⸻

## 3. User Flow: From Strategy Selection to Execution

YieldLoop only acts with explicit user authorization.
Nothing is automatic, inferred, or discretionary.

A typical cycle begins as follows:

Step 1 — Strategy Selection

The user selects which execution capabilities the system is allowed to use, such as:
	•	Spot trading
	•	Yield / LP deployment
	•	Stablecoin strategies

These are tools, not advice. The system does not recommend or optimize strategies.

Step 2 — Parameter Definition

Before execution, the user defines:
	•	Which assets may be used
	•	Allocation limits
	•	Slippage limits
	•	Execution bounds
	•	Post-cycle handling preferences

Defaults may exist, but defaults are not recommendations.

Step 3 — Risk Acknowledgment

Before a cycle can start, the user must explicitly acknowledge:
	•	Loss is possible, including total loss
	•	Execution cannot be modified mid-cycle
	•	Withdrawals are disabled during execution
	•	YieldLoop does not guarantee outcomes

This acknowledgment is a hard gate, not a disclaimer.

Step 4 — Deposit and Authorization

Assets are deposited into a personal, non-custodial vault:
	•	No pooled funds
	•	No cross-user exposure
	•	No shared risk

Once the user authorizes the cycle:
	•	The vault locks
	•	Parameters freeze
	•	Execution begins

No human, admin, or AI can intervene mid-cycle.

⸻

## 4. Profit Verification: Real, Settled, or Zero

When the cycle ends, execution stops completely and settlement begins.

Settlement happens once and only once.

The system calculates:

Net Result = Ending Balance − Starting Balance − All Costs

Costs include:
	•	Gas
	•	Protocol fees
	•	Execution expenses
	•	Slippage

There are only two valid outcomes:

Non-Positive Cycle

If the result is zero or negative:
	•	No profit is recorded
	•	No platform fee is charged
	•	No LOOP is minted
	•	The cycle closes flat

This is a valid and expected outcome.

Positive Cycle

If the result is greater than zero:
	•	Profit is considered real
	•	Settlement finalizes
	•	Fee logic is triggered
	•	Remaining profit is eligible to become LOOP

There is no partial credit, no carryover, and no retroactive adjustment.

Once settlement completes, results are immutable.

## 5. Fees: When They Apply, How They’re Calculated, and Where They Go

YieldLoop charges a platform fee **only when a cycle produces verified net profit**.
If a cycle does not produce profit, **no fees are charged** — full stop.

There are:
- No volume-based fees
- No activity fees
- No fees on principal
- No fees during execution
- No fees on losing or flat cycles

The platform earns only when users earn.

---

### 5.1 When Fees Apply

Fees apply **only after a cycle has fully ended** and settlement has confirmed:

- Execution is complete
- All positions are closed
- All costs are accounted for
- **Net profit > 0**

If net profit is **zero or negative**:
- The cycle closes flat
- No fee is taken
- No LOOP is minted
- No system allocation occurs

This alignment is intentional and non-negotiable.

---

### 5.2 What Fees Are Calculated On

Fees are calculated on **net profit only**, defined as:

Net Profit =
- Ending vault balance  
- minus starting vault balance  
- minus gas costs  
- minus protocol fees  
- minus execution-related expenses  

Fees are **never** applied to:
- User principal
- Unrealized gains
- Rolling balances
- Estimated performance

If profit cannot be proven, it does not exist.

---

### 5.3 Fee Order of Operations (Critical)

The order matters to prevent artificial yield.

1. Cycle execution ends  
2. Net profit is finalized  
3. Platform fee is calculated from net profit  
4. Platform fee portion is removed  
5. Remaining profit is converted into LOOP for the user  

Fees are taken **before** LOOP issuance, never after.

---

### 5.4 Platform Fee Split (Four-Way)

When a fee is charged, it is split evenly across four system destinations:

1. **Development & Operations (25%)**
   - Engineering
   - Infrastructure
   - Audits
   - Maintenance

2. **Marketing & Growth (25%)**
   - User acquisition
   - Partnerships
   - Community programs
   - Referral funding
   - Governor bounties

3. **LoopLabs (25%)**
   - Research and experimentation
   - Strategy design and testing
   - Long-term system improvement
   - Non-production validation

4. **System Deposit (25%)**
   - Converted into LOOP
   - Deposited into system-owned vaults
   - Re-enters future execution cycles
   - Competes under the same rules as users

No destination receives preferential treatment.
No destination can bypass settlement rules.

---

### 5.5 System Deposit Is Not a Treasury

The System Deposit is **not**:
- A reserve fund
- A bailout pool
- A yield stabilizer
- A price support mechanism

It is a **participating actor**.

System-owned LOOP:
- Can gain or lose like user capital
- Receives no protection
- Is never subsidized
- Is never replenished by minting

This ensures the platform shares execution risk over time.

---

### 5.6 Fee Discounts (NFT-Based)

Fee discounts apply **only to the platform fee** and **only on profitable cycles**.

- Discounts do not apply to:
  - Gas
  - Slippage
  - Protocol fees
  - Execution losses

Discounts are enforced on-chain at settlement and cannot reduce fees below system minimums.

(See Section 10 for NFT tiers and pricing.)

---

### 5.7 What Fees Do NOT Do

Platform fees do not:
- Influence strategy behavior
- Affect execution priority
- Change risk exposure
- Create guaranteed returns
- Alter settlement outcomes

They exist solely to:
- Fund the platform
- Sustain operations
- Reinvest proven surplus
- Keep the system alive without emissions

---

### 5.8 Key Takeaway

YieldLoop’s fee model is deliberately boring:

- No profit → no fee  
- Real profit → fee shared transparently  
- System earns only by surviving honestly  

The platform does not need users to trade more.
It needs reality to cooperate — or it waits.


## 6. Post-Cycle Outcomes: Withdraw, Compound, or Split

Once a cycle has ended and settlement is complete, control returns fully to the user.
Nothing happens automatically beyond what the user explicitly authorized before the
cycle began.

This is intentional. YieldLoop does not assume user intent after execution.

---

### 6.1 Post-Cycle State (What Unlocks)

After settlement:
- The vault unlocks
- Execution stops permanently for that cycle
- Results become immutable
- LOOP balances (if any) are finalized and visible

At this point, the user is no longer constrained by the cycle.

---

### 6.2 LOOP Handling Options (Chosen Before Execution)

Before a cycle starts, the user must pre-select how any issued LOOP will be handled
*if* profit exists.

There are only three valid options:

1. **Withdraw**
   - LOOP is issued to the vault
   - User may withdraw it
   - No automatic reinvestment occurs

2. **Compound**
   - LOOP is issued to the vault
   - LOOP is automatically authorized for use in the next cycle
   - No withdrawal occurs unless the user later chooses to exit

3. **Split**
   - A user-defined percentage is withdrawn
   - The remaining percentage is authorized for compounding
   - This choice is fixed for the cycle

These choices:
- Apply only if profit exists
- Cannot be changed mid-cycle
- Are executed mechanically at settlement

---

### 6.3 What Happens If No Profit Exists

If a cycle produces zero or negative results:
- No LOOP is minted
- No post-cycle handling occurs
- The vault simply unlocks

The user may:
- Withdraw assets
- Reconfigure parameters
- Authorize a new cycle
- Remain idle

There is no penalty for flat cycles.

---

### 6.4 No Forced Compounding

YieldLoop never:
- Forces reinvestment
- Rolls balances automatically
- Re-authorizes execution without consent

Every cycle is opt-in.
Every reinvestment is explicit.

This prevents:
- Hidden risk accumulation
- Silent exposure increases
- “Set it and forget it” traps

---

### 6.5 Redemption and Liquidity Reality

LOOP redemption is subject to:
- Available liquidity
- Execution constraints
- External protocol conditions

There is:
- No promise of instant redemption
- No guarantee of constant liquidity
- No obligation to prioritize exits over safety

This constraint is disclosed upfront and enforced equally for users and the system.

---

### 6.6 Why This Matters

Most platforms blur the line between:
- Earning
- Reinvesting
- Withdrawing

YieldLoop separates them cleanly.

- Profit is earned only at settlement
- Reinvestment is a choice, not a default
- Liquidity is respected, not faked

This keeps users in control and prevents the system from drifting into managed behavior.

---

### 6.7 Key Takeaway

After a cycle ends:
- Nothing is assumed
- Nothing is rolled automatically
- Nothing is hidden

You decide what happens next — every time.


## 7. LOOP Token: Minting Rules, Backing, Supply, and Redeemability

LOOP is the accounting and settlement token of the YieldLoop system.
It is not a reward, not an emission, and not a speculative incentive.

LOOP exists for one reason only:
to represent **verified, settled profit** after a cycle has fully completed.

---

### 7.1 What LOOP Is — and Is Not

LOOP **is**:
- A receipt for real profit
- Minted only after settlement
- Backed by completed execution
- Issued deterministically by contract logic
- Used to enable compounding without custody

LOOP **is not**:
- A yield token
- An APY promise
- An incentive emission
- A governance token
- A price-supported asset

There is no narrative attached to LOOP.
It records outcomes — nothing more.

---

### 7.2 When LOOP Is Minted

LOOP is minted **only at the end of a cycle** and **only if all conditions are met**:

- Execution has fully stopped
- Settlement has completed successfully
- Net profit exists after all costs
- Platform fees have been applied

If **any** condition fails:
- No LOOP is minted
- No partial issuance occurs
- No retroactive correction is allowed

This rule cannot be bypassed by users, admins, or governance.

---

### 7.3 Source and Backing of LOOP

Every unit of LOOP is minted directly from realized profit.

The flow is rigid:

1. Cycle execution ends  
2. Net profit is finalized  
3. Platform fee is deducted  
4. Remaining profit is converted into LOOP  
5. LOOP is issued to the vault  

There is:
- No pre-mint
- No discretionary minting
- No emission schedule
- No inflation lever

If profit does not exist, LOOP cannot exist.

---

### 7.4 LOOP Supply Characteristics

LOOP supply is:
- Variable
- Performance-dependent
- Non-inflationary

Supply behavior:
- Increases only when real profit exists
- Pauses automatically when profit does not exist
- Has no hard cap and no target growth rate

This prevents dilution and removes pressure to manufacture yield.

---

### 7.5 System-Owned LOOP (Important)

The system itself accumulates LOOP from the **System Deposit** portion of platform fees.

System-owned LOOP:
- Is deposited into system vaults
- Participates in execution cycles
- Gains or loses exactly like user capital
- Receives no protection or subsidy
- Cannot be withdrawn by users

The platform shares execution risk over time.
It does not extract value and exit.

---

### 7.6 Redeemability and Use

LOOP is redeemable **inside the YieldLoop system**, subject to real constraints.

LOOP may be:
- Withdrawn by the user
- Authorized as capital in a future cycle
- Converted through execution logic into underlying assets

Redemption is subject to:
- Liquidity availability
- Execution timing
- External protocol conditions

There is:
- No promise of instant liquidity
- No forced market-making
- No obligation to prioritize exits over safety

---

### 7.7 No Burn, No Buyback, No Price Games

YieldLoop does not:
- Burn LOOP
- Buy back LOOP
- Artificially support price
- Reprice past issuance

Supply changes only through:
- Minting from verified profit
- Redemption by users

The system refuses to manipulate perception.

---

### 7.8 Why LOOP Exists at All

Without LOOP:
- Profit must be constantly withdrawn
- Compounding requires custody or pooling
- History is harder to preserve

With LOOP:
- Profit becomes reusable capital
- Compounding remains opt-in
- Past success is preserved without promises

LOOP is not designed to excite markets.
It is designed to **outlive them**.

---

### 7.9 Key Takeaway

LOOP does not speculate.
It does not predict.
It does not promise.

LOOP records truth.

If the system performs, LOOP grows.
If it does not, LOOP waits.
Nothing is faked.


## 8. The Accounting Floor: What It Is, How It Moves, and Its Limits

The YieldLoop “floor” is not a market price, not a guarantee, and not a defense mechanism.
It is an **internal accounting construct** derived entirely from settled history.

Understanding this correctly is critical, because it is where most yield systems quietly lie.
YieldLoop does not.

---

### 8.1 What the Floor Is

The accounting floor is defined as:

> The cumulative total of all verified, settled profit ever minted into LOOP,
> minus any LOOP that has been redeemed or withdrawn.

This floor:
- Exists at the accounting level, not the market level
- Is derived only from completed execution
- Reflects historical truth, not expectation

Once profit is recorded into LOOP, that contribution to the floor is **locked**.

---

### 8.2 What the Floor Is NOT

The floor is not:
- A price floor
- A buyback target
- A market support mechanism
- A guarantee of appreciation
- A promise of liquidity

YieldLoop does not:
- Defend price
- Intervene in markets
- Smooth volatility
- Reprice past profit

Any implication otherwise is explicitly rejected by system design.

---

### 8.3 How the Floor Moves

The floor has only two valid states of motion:

1. **Upward**
2. **Flat**

It never moves downward due to execution losses.

#### Upward movement occurs only when:
- A cycle ends with real profit
- That profit is settled
- LOOP is minted from that profit

Each profitable cycle adds another verified step to the cumulative floor.

#### Flat movement occurs when:
- Cycles are unprofitable or flat
- Execution is paused
- Markets are hostile
- The system chooses not to run

No profit means no new floor movement.

---

### 8.4 Why Losses Don’t Lower the Floor

YieldLoop does not apply losses retroactively.

- Losses affect future cycles only
- Previously settled profit is never clawed back
- LOOP is not burned due to bad performance
- Accounting history is immutable once recorded

This prevents:
- Narrative accounting
- “Give-back” math
- Hidden dilution
- Silent erasure of past success

Bad markets stop growth.
They do not rewrite the past.

---

### 8.5 Relationship Between the Floor and LOOP Supply

LOOP supply and the accounting floor are directly linked.

- When LOOP is minted, the floor increases
- When LOOP is redeemed, the floor adjusts accordingly
- When no LOOP is minted, the floor remains unchanged

There is no mechanism to inflate LOOP without increasing the floor.
There is no mechanism to increase the floor without real profit.

---

### 8.6 Why This Is Rare

Most platforms maintain the illusion of a rising baseline by:
- Emissions
- Rebasing
- Smoothing returns
- Rolling unrealized gains forward

YieldLoop refuses all of these.

Instead:
- Time is discretized
- Profit is finalized
- History is locked

This makes growth slower — and far more durable.

---

### 8.7 The Floor and the System Deposit

The System Deposit does not directly move the floor.

It does something more defensible:
- It reinvests proven surplus
- It increases execution capacity over time
- It shares execution risk with users

If — and only if — this increased capacity produces future real profit,
the floor may step upward again.

There is no forced growth loop.

---

### 8.8 What Happens in Long Downturns

In prolonged unfavorable conditions:
- LOOP issuance pauses
- Platform fees drop to zero
- System deposits stop growing
- Execution frequency may decrease

Result:
- The accounting floor stays flat
- Previously recorded profit remains valid
- The system remains solvent and honest

Dormancy is a valid operating mode.

---

### 8.9 Key Takeaway

The YieldLoop floor is **monotonic, not optimistic**.

It:
- Moves only when reality allows
- Never moves backward due to losses
- Does not promise price or liquidity
- Encodes history without distortion

The floor does not chase markets.
It remembers them.


## 9. System Deposit Automation: Recursive Reinvestment (Corrected & Precise)

The System Deposit is not a treasury, not a reserve, and not a lockbox.
It is a **recursive reinvestment mechanism** that ensures the platform never extracts
value outward and always participates under the same rules as users.

This section replaces all prior descriptions of the System Deposit.

---

### 9.1 Fixed Allocation Rule (Authoritative)

When a cycle produces verified net profit and a platform fee is applied:

- The system’s portion of the platform fee is allocated to the **System Deposit**
- The System Deposit follows a **50 / 50 handling rule by default**
- This ratio may be modified only by future governance

The 50 / 50 rule applies **only to system-earned funds**, never to user profit.

---

### 9.2 Recursive Handling Mechanism (Core Behavior)

System-earned funds are handled as follows:

1. **50% is authorized for compounding**
   - Immediately eligible for execution in the next cycle

2. **50% is treated as a withdrawal**
   - This portion is **not extracted**
   - It is immediately **redeposited back into the system**
   - Upon redeposit, it is again subject to the same 50 / 50 rule

This process repeats continuously.

There is no terminal “exit” state for system-earned LOOP.

---

### 9.3 What This Means in Practice

Functionally, the system:

- Never withdraws profit externally
- Never distributes system-earned LOOP to users
- Never removes system capital from execution
- Never converts system profit into private benefit

Instead, system-earned surplus is **continuously recycled back into execution**.

This makes the platform a permanent participant in its own strategies.

---

### 9.4 System-Owned LOOP Characteristics

System-owned LOOP produced through this mechanism is:

- Non-withdrawable by users
- Restricted to protocol execution only
- Subject to the same risks as user capital
- Able to grow or shrink based on real performance
- Never burned
- Never sold
- Never price-managed

This LOOP is **active**, not locked.
It circulates internally through execution, not markets.

---

### 9.5 Relationship to the Accounting Floor

This mechanism does **not** directly move the accounting floor.

Instead, it creates a structural condition where:

- Verified profit is never removed from participation
- Execution capacity grows when profit exists
- Future profitable cycles may occur with greater capital
- Each additional profitable cycle can mint additional LOOP

Only when a future cycle produces real profit does the accounting floor step upward.

There is no forced growth and no compounding of assumptions.

---

### 9.6 What This Mechanism Is NOT

The recursive system deposit does not:

- Create a price floor
- Guarantee appreciation
- Remove supply from circulation
- Engineer scarcity
- Stabilize returns
- Bail out losses

Any implication of market manipulation is explicitly false.

---

### 9.7 Why This Is Unusual

Most platforms:
- Extract fees and sell them
- Depend on new users
- Rely on emissions
- Reset risk asymmetrically

YieldLoop does none of this.

By continuously redeploying system-earned surplus:
- The platform shares execution risk indefinitely
- Incentives remain aligned
- Growth is conditional on reality

The system only grows if it deserves to.

---

### 9.8 Governance Control

The default 50 / 50 recursive handling rule:
- Applies at launch
- Is enforced mechanically
- Cannot be bypassed by admins

Future governance may:
- Adjust the split ratio
- Modify redeposit behavior
- Change handling rules prospectively only

No governance action may:
- Extract previously system-earned LOOP
- Retroactively alter settled cycles
- Convert system surplus into private benefit

---

### 9.9 Key Takeaway

The System Deposit is not storage.
It is motion.

It ensures that:
- The platform never exits its own game
- Earned surplus stays at risk
- Accounting growth is earned, not engineered
- The internal accounting floor can rise only through real performance

If execution works, the system compounds honestly.
If it doesn’t, the system waits.
Nothing is faked.


## 10. NFTs: Tiers, Prices, Discounts, and Limits

NFTs in YieldLoop are optional.
They do not affect execution, strategy behavior, risk exposure, profit calculation,
LOOP minting, or cycle outcomes.

They exist as a **utility and coordination layer**, not as a yield mechanism.

---

### 10.1 What NFTs Do — and Do NOT Do

NFTs **do**:
- Provide platform fee discounts
- Gate access to specific UI and community areas
- Signal trusted or early participation
- Support funding, partnerships, and coordination

NFTs **do not**:
- Grant ownership or equity
- Guarantee profit
- Affect strategy execution
- Change settlement logic
- Grant control over funds or contracts
- Create yield, rewards, or emissions

Holding no NFT does not restrict core platform usage.

---

### 10.2 NFT Tiers (Two Only)

YieldLoop supports two NFT tiers:

1. **Supporter NFT**
2. **Governor NFT**

Each tier has fixed, narrow utility.
There are no hidden benefits.

---

### 10.3 Supporter NFT

**Purpose**
- General supporter utility
- Fee discount
- Community access

**Pricing**
- Initial proposed mint price: **$300 USD equivalent**
- Minted in BNB
- Price is **adjustable prospectively** via governance

**Supply**
- Unlimited

**Fee Discount**
- **5% discount on the platform fee**
- Applies:
  - Only on profitable cycles
  - Only at settlement
  - Only to the platform fee
- Does not apply to gas, slippage, protocol fees, or losses

**Access**
- Supporter-only community channels
- Optional UI visibility features

**Transferability**
- Freely transferable
- Benefits follow the wallet holding the NFT

---

### 10.4 Governor NFT

**Purpose**
- Advisory participation
- Trusted coordination
- Deeper platform involvement

**Availability**
- Not publicly sold by default
- Typically awarded by admin mint
- Any future public availability must be explicitly disclosed

**Supply**
- Limited by policy, not hard-capped

**Fee Discount**
- **10% discount on the platform fee**
- Overrides Supporter discount if both are present

**Role**
- Advisory only
- May participate in:
  - Strategy discussion (non-binding)
  - Risk reviews
  - Education and onboarding
  - Ecosystem support

**Transferability**
- Non-transferable by default
- Transfer requires explicit multisig approval

**Revocation**
- May be revoked and burned by admin action
- Reasons include inactivity, abuse, or loss of trust

---

### 10.5 Mint Proceeds

All NFT mint proceeds:
- Route to the platform treasury
- Fund:
  - Development
  - Audits
  - Infrastructure
  - Operations
  - Long-term support

NFTs are non-refundable under all circumstances.

---

### 10.6 Discount Enforcement

NFT-based discounts:
- Are enforced on-chain
- Apply only if profit exists
- Cannot reduce fees below system minimums
- Cannot be stacked beyond defined limits

NFT ownership never changes execution behavior.

---

### 10.7 Why NFTs Are Isolated

NFTs are intentionally separated from:
- Execution logic
- Profit generation
- LOOP issuance
- System deposit mechanics

Removing the NFT system entirely would not break YieldLoop.

This separation prevents:
- Implied guarantees
- Yield expectations
- Governance capture
- Regulatory ambiguity

---

### 10.8 Key Takeaway

NFTs are optional tools for:
- Reduced fees
- Access
- Recognition
- Coordination

They are not part of the yield engine.
They do not affect outcomes.
They do not promise anything.


## 11. Referrals: Presale Program and Post-Launch Program (Bounded & Non-Inflationary)

Referral programs in YieldLoop are optional, finite, and isolated from the core execution
engine. They exist to encourage **real participation and real growth**, not to manufacture
yield or extract value from users.

Referrals do not affect:
- Strategy execution
- Risk exposure
- Profit calculation
- LOOP minting rules
- Cycle timing or outcomes

---

### 11.1 Presale Referral Program (Pre-Launch Only)

The presale referral program exists **only before public launch** and expires
automatically at launch.

**Purpose**
- Seed an initial community
- Reward real outreach effort
- Identify high-signal early contributors
- Avoid emissions or financial incentives

**How It Works**
Eligibility is milestone-based, not volume-based.

To qualify, referrals must be:
- Unique, real humans
- Verified as non-bots
- Joined official channels
- Introduced themselves
- Acknowledged who referred them
- Engaged meaningfully (questions, discussion, feedback)

Spam, automation, or fake accounts invalidate eligibility.

**Presale Referral Tiers**
- **Tier 1 — Early Outreach**
  - Requirement: 25 verified human referrals
  - Limit: First 10 participants to qualify
  - Reward: Eligibility to receive **1 Supporter NFT** at launch

- **Tier 2 — Early Leadership**
  - Requirement: 100 verified human referrals
  - Limit: First 3 participants to qualify
  - Reward: Eligibility to receive **1 Governor NFT** at launch

**Important Constraints**
Presale referral rewards:
- Are not income
- Are not yield
- Do not represent profit-sharing
- Do not imply future benefits
- Do not affect platform economics

The team may modify, revoke, or terminate the program at any time prior to launch.

---

### 11.2 Post-Launch Referral Program (After First Cycle)

The post-launch referral program becomes available **only after a user completes their
first deposit and at least one full execution cycle**.

This prevents referral farming without real participation.

---

### 11.3 Referral Code Issuance

Once eligible:
- Each user receives a unique referral code
- Codes may be shared voluntarily
- Use of a referral code is optional for referred users
- Codes may be revoked for abuse

Referral codes do not expire unless revoked.

---

### 11.4 Qualified Referrals

A referral is considered qualified **only if** the referred user:
- Completes a deposit
- Completes execution cycles
- Produces net positive cycles

If the referred user never produces profit:
- No referral credit is generated

---

### 11.5 Referral Credit Mechanics

Referral rewards are calculated as:

- **5% of the platform fees generated by the referred user**
- Applies only to the **first six (6) positive cycles**
- Credits are sourced **only from platform fees**
- Credits do not reduce the referred user’s profit
- Credits do not affect execution behavior

After six positive cycles, referral rewards permanently stop for that referred user.

There are no infinite tails.

---

### 11.6 Settlement and Issuance

Referral credits:
- Are calculated only after settlement
- Are recorded as finalized accounting entries
- Are never estimated or projected

Credits may be issued in:
- LOOP, or
- Platform credits (implementation-defined)

---

### 11.7 Anti-Abuse Controls

The system and administrators may:
- Reject self-referrals
- Detect circular referral patterns
- Freeze or revoke referral eligibility
- Cancel unearned referral credits

All determinations are final.

---

### 11.8 What Referrals Are NOT

Referral programs do not:
- Create yield
- Create income
- Create employment or agency
- Create entitlement
- Affect execution or settlement
- Depend on new users for system survival

They are bounded, optional incentives — not economic drivers.

---

### 11.9 Key Takeaway

YieldLoop referrals reward **real growth only**.

- No emissions
- No dilution
- No infinite loops
- No distortion of the core engine

If users win, the platform earns.
If the platform earns, referrals may receive a share — briefly and transparently.


## 12. Risk, Failure Modes, and Bad Markets (What Happens When Things Go Wrong)

YieldLoop is designed around the assumption that **markets will fail**, strategies will
underperform, and execution will sometimes break. The system does not attempt to hide,
smooth, or reframe these events.

When reality is unfavorable, YieldLoop records it and stops.

---

### 12.1 Core Risk Acknowledgment

By using YieldLoop, users explicitly acknowledge:

- Loss of funds is possible, including total loss
- No strategy is guaranteed to be profitable
- Smart contract and protocol risks exist
- Liquidity may be constrained
- Execution cannot be modified mid-cycle

YieldLoop does not provide investment advice and does not manage outcomes.

---

### 12.2 Execution-Level Failures

Execution may fail due to:

- Slippage exceeding user-defined limits
- Liquidity disappearing mid-cycle
- External protocol pauses or reverts
- Gas spikes or network congestion
- Unexpected market movement

**What the system does:**
- Execution halts immediately
- No retries are attempted
- No substitution occurs
- The cycle proceeds directly to settlement

Partial execution is recorded as-is.

---

### 12.3 Settlement and Accounting Failures

Settlement is atomic and deterministic.

If settlement detects:
- Inconsistent balances
- Fee mismatches
- LOOP minting errors

Then:
- Settlement reverts
- The cycle does not advance
- No partial state is accepted

There are no manual overrides.

---

### 12.4 Strategy Risk

All strategies are:

- Non-leveraged
- Non-borrowed
- Spot-only or deposit-based
- Executed within strict bounds

Despite these constraints, strategies still carry:
- Market risk
- Impermanent loss (for LPs)
- Protocol insolvency risk
- Asset-specific risks

YieldLoop does not mitigate these risks beyond enforcing boundaries.

---

### 12.5 System Deposit Risk Symmetry

System-owned capital:
- Uses the same strategies as users
- Is subject to the same risks
- Can lose value
- Receives no protection

The platform shares downside risk over time.

---

### 12.6 Extended Bad Market Conditions

In prolonged unfavorable environments:

- Profitable cycles may cease
- LOOP issuance pauses automatically
- Platform fees drop to zero
- System deposit growth stops
- Execution frequency may decrease or pause

This is expected behavior.

YieldLoop does not force execution to “chase yield.”

---

### 12.7 Dormant-but-Solvent Mode

If conditions remain unfavorable, YieldLoop may enter a dormant state:

- No new cycles are authorized
- Vaults remain accessible
- Previously issued LOOP remains valid
- Accounting history is preserved

Dormancy prioritizes safety over activity.

---

### 12.8 What YieldLoop Will Not Do Under Stress

In bad conditions, YieldLoop will not:

- Smooth losses
- Roll losses forward
- Inflate rewards
- Mint tokens to offset failures
- Change past results
- Hide execution outcomes

There is no emergency yield lever.

---

### 12.9 User Responsibility

Users are responsible for:
- Strategy selection
- Parameter configuration
- Risk tolerance
- Timing of participation

YieldLoop enforces constraints, not judgment.

---

### 12.10 Key Takeaway

When things go wrong, YieldLoop:
- Stops
- Records what happened
- Preserves ownership
- Refuses to guess

Failure is contained, not disguised.


## 13. What YieldLoop Refuses to Do (Explicit Non-Goals)

YieldLoop is defined as much by what it refuses to do as by what it does.
These refusals are not omissions or future roadmap items — they are **architectural
constraints**.

They exist to prevent the system from drifting into hype-driven, fragile, or misleading
behavior.

---

### 13.1 No Promised Yield

YieldLoop will not:
- Promise returns
- Advertise APYs
- Display expected performance
- Project future profit

If profit cannot be verified at settlement, it is treated as zero.
Expectation is not a system input.

---

### 13.2 No Emissions or Inflation

YieldLoop will not:
- Emit reward tokens
- Inflate supply to mask losses
- Subsidize participation
- Require constant user growth

LOOP exists only when real profit already exists.
There is no emission schedule and no dilution lever.

---

### 13.3 No Continuous or Rolling Accounting

YieldLoop will not:
- Roll positions indefinitely
- Re-mark unrealized gains
- Smooth losses across time
- Blur cycle boundaries

Every cycle must end.
Every result must finalize.

---

### 13.4 No Managed Trading or Discretion

YieldLoop will not:
- Select strategies for users
- Optimize parameters mid-cycle
- Intervene in execution
- Override settlement results
- Act as an asset manager

Execution is mechanical, bounded, and user-authorized only.

---

### 13.5 No Retroactive Changes

YieldLoop will not:
- Rewrite past results
- Claw back previously settled profit
- Burn LOOP due to losses
- Reprice history

Once recorded, accounting history is immutable.

---

### 13.6 No Price Engineering

YieldLoop will not:
- Defend token price
- Target a floor price
- Perform buybacks
- Create artificial scarcity
- Manipulate supply to influence markets

The system records outcomes.
Markets do what they do.

---

### 13.7 No Hidden Incentives

YieldLoop will not:
- Profit from user losses
- Earn fees on volume
- Encourage churn
- Obscure fee mechanics
- Hide risk behind UX tricks

If users do not win, the platform does not earn.

---

### 13.8 No Forced Participation

YieldLoop will not:
- Auto-compound without consent
- Reauthorize cycles automatically
- Lock funds indefinitely
- Penalize inactivity

Participation is opt-in every time.

---

### 13.9 No Narrative Accounting

YieldLoop will not:
- Use marketing math
- Frame hypothetical upside
- Promote best-case scenarios
- Replace reality with storytelling

Truth is the product.

---

### 13.10 Key Takeaway

YieldLoop refuses to lie — even when lying would be profitable.

These non-goals are guardrails.
They exist so the system can survive bad markets, hostile scrutiny,
and its own success.


## 14. Final Summary + Ultra-Short TL;DR

YieldLoop is a cycle-based execution and accounting system built to turn
**verified, completed profit** into reusable capital — and nothing else.

Users:
- Choose strategies
- Define limits
- Authorize execution
- Accept risk knowingly

The system:
- Executes deterministically
- Ends every cycle
- Settles once
- Charges fees only on real profit
- Mints LOOP only from verified surplus
- Reinvests its own earnings recursively
- Records history without distortion

There are:
- No emissions
- No projections
- No smoothing
- No guarantees
- No price games

Growth is conditional.
Failure is acknowledged.
Time is respected.

---

### TL;DR

- Fixed execution cycles  
- Profit is real or zero  
- Fees only if users win  
- Profit becomes LOOP  
- LOOP records settled history  
- The accounting floor never moves backward  
- The system reinvests its own earnings  
- Nothing is promised  
- Nothing is hidden  

YieldLoop does not chase yield.

It waits for reality — and compounds only when reality allows it.
