# YieldLoop Whitepaper  
## Automated BTC Profit Vaults with LOOP Redemption Token

**Version:** 1.0
**Date:** January 13, 2026  
**Author:** Todd Koletsky  

---

## Table of Contents

1. **Executive Summary**
2. **What YieldLoop Is**
3. **The Problem**
4. **The YieldLoop Solution**
5. **Core User Experience (High-FOMO Walkthrough)**
6. **System Overview**
7. **Vault Model (Isolated User Vaults)**
8. **Strategy Execution (BTC Loop Engine)**
9. **Dynamic Trade Bands (SL/TP Controller)**
10. **Profit Harvesting + Profit Buffer**
11. **Claiming Profits**
12. **LOOP Token (Redemption Token Model)**
13. **Fee Model**
14. **Dynamic Fee Discount Controller**
15. **Reserve System (Liquidity Defense + Buyback + Lock)**
16. **Black Swan Mode + Drawdown Gates**
17. **Security Model**
18. **Oracle / Pricing Model (TWAP, Circuit Breakers)**
19. **Governance (Upgradeable but Sabotage-Resistant)**
20. **Proof of Impact**
21. **Transparency + Proof Dashboards**
22. **Roadmap**
23. **Risk Disclosures**
24. **Legal / Compliance Disclaimers**

---

## 1. Executive Summary

YieldLoop is a **non-custodial automated BTC profit vault system** deployed on **BNB Smart Chain (BSC)**.

Users deposit **USDT/USDC** into their own isolated vaults. Those vaults execute a BTC trading strategy using **BTCB (or an approved BTC-equivalent token on BSC)** and harvest realized profits back into stablecoins.

The defining feature of YieldLoop is how it treats profits:

- profits are **harvested** into stablecoins
- profits are stored as a user-owned **Profit Buffer**
- users can **claim profits** at any time either in:
  - stablecoins, or
  - the YieldLoop redeem token: **LOOP**

LOOP is not a meme token, not a farm emissions token, and not an LP token.
LOOP is designed as a **redemption token**, where minting occurs only through defined system actions (primarily profit claiming), and its long-term sustainability is reinforced through a **rule-based reserve engine** (liquidity defense, buybacks, locking, and continuity protection).

YieldLoop is built to generate FOMO for the correct reason:
not hype, not narrative, not artificial APY —
but because it creates a mechanical flywheel:

**Users → Deposits → Strategy Execution → Harvested Profit → Claims → Fees → Reserves → Token Support → Credibility → More Users**

YieldLoop is also built for survivability:
the strategy is governed by dynamic safety systems including volatility adaptive trade bands, cooldown logic, trend gating, drawdown gates, black swan modes, oracle safety checks, and hard-coded invariant limits that prevent governance sabotage.

---

## 2. What YieldLoop Is

YieldLoop is a decentralized automation system for executing a **rule-based BTC strategy** on BSC using stablecoin deposits.

It provides four primary capabilities:

1. **Isolated User Vaults**
   - Each user’s deposit is stored in a unique vault contract instance or isolated accounting structure.
   - Users do not share pooled funds.
   - Funds are never commingled across depositors.
   - The strategy logic is shared, but the capital remains isolated.

2. **Strategy Execution**
   - The vault enters BTC positions by swapping stablecoins into BTCB (or approved BTC token).
   - The vault exits BTC positions back into stablecoins.
   - Execution occurs on PancakeSwap (PCS), using approved routing and minimum liquidity rules.

3. **Profit Harvesting**
   - When profit is realized, it is harvested into stablecoins.
   - Harvested profits are separated from principal.
   - The system maintains a dedicated internal ledger for each user:
     - Principal
     - Unrealized PnL (informational)
     - Realized profits (Profit Buffer)

4. **Claims and Redemption Token (LOOP)**
   - Users claim their harvested profits at any time.
   - Claims can be taken as stablecoins or LOOP.
   - Claiming as LOOP provides a **reduced fee** and unlocks the token flywheel.
   - Claiming stablecoins remains available at all times to prevent token dependency and bank-run fragility.

YieldLoop therefore has two layers:

- **Product layer:** deposit stablecoins → strategy executes → profits harvested
- **Token layer:** user chooses how to extract profit → LOOP supports the system’s long-term sustainability

YieldLoop is not a custody app.
YieldLoop is not a promise.
YieldLoop is a deterministic protocol engine that turns BTC market movement into a repeatable set of executed trades, profits, and claim choices.

---

## 3. The Problem

Crypto investing is full of products that look profitable on paper and fail in the real world.

Most systems collapse for one of the following reasons:

### 3.1 APY Is Usually Fake
Most “yield” in DeFi is not yield.
It is:
- emissions
- inflation
- temporary incentives
- mercenary capital

When emissions slow, the project dies.
When incentives stop, liquidity leaves.
This is not yield.
This is a subsidy.

### 3.2 Most Protocol Tokens Have No Structural Demand
Many tokens exist because the project wants a token.
They are launched first, then utility is invented later.

As a result:
- token demand is narrative-based
- price depends on hype
- holders become exit liquidity
- “utility” is shallow and optional

### 3.3 Automated Trading Products Hide Execution Risk
Trading products often:
- conceal slippage and spread
- conceal MEV damage
- overtrade during chop
- die silently through small repeated losses

When BTC chop happens (and it always does), fixed stop-loss / take-profit systems bleed:
- stop-out
- re-enter
- stop-out again
- repeat

Over time this destroys user trust, then kills deposits, then kills the protocol.

### 3.4 Pooled Funds Create Contagion
Pooled vaults have a fatal weakness:
- bad accounting or exploit drains shared liquidity
- one user’s panic triggers everyone’s exit
- bank-run dynamics occur instantly

Protocols fail not only because they lose money, but because they lose confidence.

### 3.5 “Floor Price” Narratives Are Usually Lies
Many projects promise floors or guarantees through:
- burns
- magical reserves
- buybacks
- “price support”

Then the moment a downturn hits:
- the reserve gets drained
- support fails
- token collapses
- community turns hostile

The failure isn’t only financial — it’s reputational.
Once trust breaks, a token can’t be revived.

---

## 4. The YieldLoop Solution

YieldLoop is designed to solve these problems using three primary design principles:

### 4.1 YieldLoop Only Uses Real Profit
YieldLoop’s strategy intends to generate profit through executed BTC trading.
There are no emissions required to create the illusion of yield.

Profits may be:
- high
- low
- volatile
- sometimes absent

But they must be real.

YieldLoop is built around truth-based accounting:
- PnL is what it is
- the market does what it does
- the system does not fabricate returns

This gives YieldLoop a foundation that can survive scrutiny.

### 4.2 YieldLoop Separates Principal and Profit
When profits occur, they are harvested into stablecoins and separated from principal into the Profit Buffer.

This accomplishes several things:

- it prevents “fake compounding”
- it creates clean accounting
- it reduces the chance of catastrophic loss loops
- it creates an honest user experience

Users can always see what is happening:
- what they deposited
- what the strategy is currently holding
- what profits have been realized
- what is claimable now

This instantly improves trust and retention versus black-box vaults.

### 4.3 YieldLoop Turns Profit Claims into Token Demand
The LOOP token exists because of one specific mechanism:

> The protocol gives users a discount for claiming profits as LOOP.

This creates natural structural demand:
- if you want to maximize profit extraction efficiency, you claim in LOOP
- if you want to avoid token exposure, you claim stablecoins

This is critical:
YieldLoop does not trap users into LOOP.
YieldLoop **rewards** LOOP usage.

This is the correct design.
People do not stay in systems that trap them.
People do stay in systems that reward them.

### 4.4 YieldLoop Uses a Reserve Engine to Reinforce Token Stability
YieldLoop routes a portion of claim fees to reserve systems that operate like a central bank:

- Liquidity Defense Reserve (prevents death spirals)
- Buyback & Lock Reserve (reduces circulating supply)
- Continuity Reserve (protects long-term operations and emergencies)

YieldLoop does not claim guaranteed floors.
YieldLoop supports long-term strength through rules.

This is what separates a serious project from a hype token:
serious projects survive downturns because they have structure.

### 4.5 YieldLoop Is Governed — But Can’t Be Sabotaged
YieldLoop is designed to be upgradable and tunable.
But governance must be constrained.

YieldLoop includes protocol-level invariants:
- SL/TP ranges hard-capped
- trade frequency hard-capped
- discount ranges hard-capped
- reserve spending capped per epoch/day
- timelocks on parameter changes
- emergency veto ability only against malicious proposals

This prevents an angry community from voting the protocol into the ground.

---

## 5. Core User Experience (High-FOMO Walkthrough)

YieldLoop is designed so that a normal person can use it without understanding trading, DeFi mechanics, or token economics.

The UX goal is simple:

> Deposit stablecoins, let the vault do the work, watch profit accumulate, claim profit when you want.

YieldLoop builds FOMO by combining three things:
1) **simplicity**
2) **visible progress**
3) **profit ownership clarity**

This section explains the user flow exactly as the protocol intends it to feel.

---

### 5.1 The User’s Mental Model

YieldLoop is not presented as “a complicated strategy platform.”
It is presented as:

- a BTC profit engine
- with stablecoin deposits
- with profits harvested in stablecoins
- with optional LOOP claims for optimized extraction

The key psychological difference is that users do not feel like:
- they’re locking money into a black box
- they’re buying a token and hoping
- they’re chasing narrative

They feel like:
- they’re putting money into a machine
- they’re watching profits build up
- they’re choosing when and how to extract

---

### 5.1A Vault Architecture (Isolation Guarantee)

YieldLoop uses a vault-per-user architecture.

Each user deposit is deployed into a dedicated vault contract instance created via a minimal proxy clone pattern (EIP-1167 or equivalent).

This ensures:
- user assets are not commingled with other users
- each vault maintains its own positions, state, and accounting
- vault execution is strategy-identical across users but capital is physically separated at the smart contract level

YieldLoop may execute the same strategy logic across many vaults, but each vault is independent and isolated.

This design reduces systemic contagion and limits the blast radius of any vault-specific failure.

---
#### NOTE: Future Optimization, A pooled execution model MAY be introduced in future versions for gas efficiency. If introduced, it will require explicit user consent and will include additional accounting and systemic risk disclosures.

### 5.2 First-Time User: 60-Second Walkthrough

A user arrives and sees:

- Deposit vaults
- Strategy explanation in plain English
- Current system stats:
  - AUM
  - 30-day profit harvested
  - total claims paid
  - LOOP supply + locked supply
  - reserve balances
  - current claim fee rates

The user presses “Start.”

**Step 1 — Connect Wallet**
No account.
No KYC.
No signup.

**Step 2 — Choose Deposit Asset**
- USDT
- USDC

**Step 3 — Deposit**
The user deposits into their own vault:
- “Your vault: 0x1234…abcd”
- “Principal deposited: $X”

Immediately the user sees:
- vault status: ACTIVE
- strategy status: READY
- principal: stablecoin

**Step 4 — Choose Profit Handling Preference**
YieldLoop offers a simple slider:

> **Compound Rate: 5% → 100%**

Meaning:
- the vault will automatically reinvest a percentage of harvested profits
- the remainder is stored in the Profit Buffer for withdrawal/claims

Defaults can be set by governance but always remain user-controlled.

Examples:
- Conservative: compound 25%, keep 75% as withdrawable buffer
- Balanced: compound 50%
- Aggressive: compound 90%+
- Full compound: 100%

The user confirms.

**Step 5 — Confirm Risk Acknowledgement**
YieldLoop forces truth:
- “BTC can drop”
- “Trading can lose”
- “No guaranteed profit”
- “You can withdraw principal at any time subject to vault rules”
- “Past performance is not predictive”

User signs once.

Now the vault is live.

---

### 5.3 What The User Sees Over Time (This Creates FOMO)

Once live, the user sees a dashboard with three obvious columns:

1) **Principal**
2) **Profit Buffer (stablecoin profits harvested)**
3) **Optional LOOP Claim Preview**

This is the “FOMO engine.”
Because the user watches the Profit Buffer rise like a scoreboard.

#### Example View
- Principal: $5,000
- Profit Buffer: $127.40
- Current BTC exposure: 32% (informational)
- Next trade band: active
- Strategy mode: normal

And they see an always-visible button:

> **Claim Profit**

This turns YieldLoop into a system users check daily, even when not withdrawing.
That alone is a retention weapon.

---

### 5.3.1 Withdrawals (Truth-Based Liquidity Rules)

YieldLoop does not fake liquidity.

A user may request withdrawal at any time, but withdrawal execution depends on the vault’s current exposure state.

#### Withdrawal Types

**A) Stable-Only Withdrawal (Instant)**
If the vault is currently in stablecoin-only state (no BTC exposure):
- the user can withdraw principal instantly (subject only to normal gas constraints)
- the protocol does not delay or gate this

**B) BTC-Exposed Withdrawal (Unwind Required)**
If the vault currently holds BTC exposure:
- the vault must unwind to stablecoin before principal withdrawal can occur
- unwind occurs only when execution constraints are satisfied:
  - slippage within bounds
  - liquidity thresholds met
  - oracle/TWAP validity met
  - circuit breakers not active

This is non-negotiable. It prevents forced-loss exits and MEV exploitation.

#### Withdrawal Request Model (Deterministic)
When a user requests withdrawal during BTC exposure:
- vault state becomes: WITHDRAWAL_PENDING
- vault stops opening new BTC exposure
- vault attempts unwind as soon as constraints allow
- once fully in stablecoin, principal is withdrawn

#### Maximum Unwind Latency
YieldLoop may enforce a maximum unwind latency window.
If conditions remain unsafe:
- vault enters STABLE MODE
- vault prioritizes capital preservation over speed
- user withdrawal remains pending until safe execution is possible

YieldLoop is not a bank.
It is a safety-constrained execution system.

---

### 5.4 Claiming Profit (The Token Flywheel Moment)

When users press “Claim Profit,” they see two choices:

#### Option A: Claim as Stablecoin
- fee: 20% (example baseline)
- user receives: stablecoin
- no token exposure
- no lock requirement

This path ensures YieldLoop does not trap anyone.
It is mandatory for credibility.

#### Option B: Claim as LOOP (Discounted)
- dynamic fee: 19% → 15% (based on AUM + volume + LP health)
- user receives: LOOP
- LOOP can be:
  - held
  - redeemed (under protocol rules)
  - locked for enhanced rewards/discount

This is the key:
YieldLoop makes LOOP the better deal, but never mandatory.

This is how you create demand without coercion.

---

### 5.5 Why Users Will Choose LOOP (Even If They Don’t “Love Tokens”)

Most people do not want exposure to random tokens.
So YieldLoop gives them rational reasons:

- lower claim fee
- better long-term extraction efficiency
- access to lock incentives
- participation in the system’s value reinforcement loop

LOOP is positioned as:
> “profit receipt with protocol support”

Not as:
> “buy now before it pumps.”

This matters because it creates *serious buyers*, not tourists.

---

### 5.6 Compounding vs Withdrawing (The Most Important Control Lever)

YieldLoop gives users one power lever:

> **How much profit do you keep vs reinvest.**

This produces four types of users:

1) **Income Users**
Compound 5–25%, withdraw regularly.

2) **Balanced Users**
Compound 40–60%, withdraw occasionally.

3) **Growth Users**
Compound 75–95%, withdraw rarely.

4) **Aggressive Compounders**
Compound 100%, only withdraw when LOOP value support has matured.

All four users can coexist.
YieldLoop becomes a universal machine.

This is what creates scale.

---

### 5.7 The “Smart Default” That Creates Viral Growth

YieldLoop defaults should be set so the system grows:

- default compound: 50%
- default claim method: stablecoin preview shown first, LOOP shown as “optimized option”
- default strategy: volatility adaptive bands

As AUM grows:
- fee discounts improve automatically
- reserves grow automatically
- LOOP support improves automatically

So every new depositor strengthens the system for everyone.

This produces the key viral dynamic:

> “The earlier you are, the cheaper you extract profits in LOOP and the larger your upside in system maturation.”

That is organic FOMO based on mechanism, not story.

---

## 6. System Overview

YieldLoop is composed of three functional layers:

1) **Vault Layer**
2) **Strategy + Execution Layer**
3) **Token + Reserve Layer**

Each layer is isolated in responsibility so that failures do not cascade.

---

### 6.1 Vault Layer (User Capital Isolation)

Every deposit creates an isolated vault position.

This means:
- users do not share pooled liquidity
- no shared accounting errors
- no bank-run contagion
- exploit damage radius is minimized per vault

YieldLoop is a strategy *framework* applied across vaults.
But the money itself remains isolated.

This structure makes YieldLoop easier to secure and easier to audit.

---

### 6.2 Strategy + Execution Layer

This layer does the work:
- trade decision rules
- dynamic SL/TP bands
- trend gating
- cooldown enforcement
- drawdown gating
- MEV-resistant execution routing

It is designed to:
- avoid overtrading
- reduce chop bleed
- protect principal survival first

This layer can be upgraded by governance within hardcoded invariants.

---

### 6.3 Token + Reserve Layer

This layer turns YieldLoop from “just a vault” into a long-term ecosystem.

It includes:
- LOOP minting rules
- redemption logic
- claim discount controller
- reserve routing and actions (liquidity defense + buyback + lock)
- proof-of-impact routing

This layer exists to:
- prevent token death spirals
- create long-term structural demand
- give LOOP credible backing mechanics
- reward participation without trapping users

---

## 7. Vault Model (Isolated User Vaults)

YieldLoop’s core safety architecture is **vault isolation**.

Each user vault maintains:

- deposited principal (USDC/USDT)
- current BTC exposure (if any)
- profit buffer accounting
- user preferences (compound %, claim mode, etc.)
- strategy state tracking (cooldown status, trade count, etc.)

YieldLoop vaults are designed to be:

- deterministic
- inspectable
- auditable
- non-custodial
- upgradable only by strict governance with safeguards

The vault is the user’s property envelope.
The strategy is simply a set of rules applied inside it.

---

### 7.1 Why Isolation Matters

Most DeFi failures become catastrophic because:

- pooled funds create shared failure
- one exploit drains everything
- one user exit becomes everyone’s exit

YieldLoop avoids this by design.

Isolation gives YieldLoop the ability to:

- scale without increasing systemic fragility
- deliver clean accounting per user
- reduce exploit blast radius
- support partial pauses without total collapse

---

### 7.2 Shared Strategy ≠ Shared Funds

YieldLoop uses shared strategy logic because:
- it simplifies execution
- it improves consistency
- it reduces complexity

But it does not merge funds.

This is key:
The protocol runs one “brain” but each user has their own “body.”

---

### 7.3 Vault States (High Level)

A vault has a lifecycle:

1) DEPOSITED
2) READY
3) ACTIVE (executing strategy)
4) STABLE MODE (paused risk mode)
5) WITHDRAWAL / CLAIM
6) CLOSED (or re-deposited)

These are not marketing states.
These are engineering states enforced by code.

---

## 8. Strategy Execution (BTC Loop Engine)

The BTC Loop Engine is the execution core.

It is responsible for:
- entering BTC positions
- exiting BTC positions
- harvesting realized profit into stablecoins
- preserving principal under adverse market conditions

YieldLoop’s strategy is not “degenerate trading.”
It is controlled execution with rule-based risk management.

---

### 8.1 Supported Markets

YieldLoop trades BTC exposure on BSC.

Primary trading pair examples:
- BTCB/USDT
- BTCB/USDC

Execution venue:
- PancakeSwap (PCS)

Routing must meet minimum liquidity thresholds and slippage constraints.

---

### 8.2 Strategy Intent

The goal is not constant trading.
The goal is survival + capture.

YieldLoop intends to:
- trade less when conditions are chaotic
- trade more when conditions are favorable
- avoid repeating stop-out loops
- preserve capital during black swan events

---

### 8.3 Trade Decision Cycle

YieldLoop follows a strict decision cycle:

1) Read current market state (price, volatility, trend)
2) Validate execution conditions (liquidity, oracle sanity, slippage)
3) Check safety gates (cooldowns, max trades/day, drawdown)
4) Decide action:
   - hold stable
   - buy BTC
   - sell BTC
5) Execute trade using guardrails
6) Harvest profit (if applicable)
7) Update vault accounting and states

This cycle is deterministic.
It is not discretionary.

---

### 8.4 Why This Works

Most trading systems die because they:
- trade too much
- trade when it is not safe
- bleed in chop
- become emotional

YieldLoop is the opposite:
- constrained
- gated
- measurable
- engineered for survival first

This is what makes it investable.

---

## 8.5 Vault Lifecycle, NAV, and Settlement Rules (Accounting Truth Model)

YieldLoop is a cycle-based vault system.

The system enforces an accounting truth model:
- principal is never redefined
- profits are only recognized when realized
- settlement is deterministic

### 8.5.1 Key Terms

**Principal (P):**
- the amount of stablecoin deposited by the user (net of deposit fees, if any)

**Vault NAV:**
- the current total value of the vault expressed in stablecoin terms, computed using valid oracle inputs

**Realized Profit (RP):**
- profit that is locked-in and recorded only when the vault is fully settled into stablecoin

**Unrealized PnL (UPnL):**
- floating profit/loss while BTC exposure exists

**Profit Eligibility:**
- profit is eligible for fee calculation only at settlement

### 8.5.2 Cycle Overview (Monthly Execution)

Each vault runs in deterministic cycles:
1) Cycle Start
2) Execution Window (strategy trading permitted)
3) Cycle End (stop opening new exposure)
4) Mandatory Settlement
5) User Claim / Compound Routing
6) Cycle Repeat (if user opts-in)

YieldLoop does not smooth returns.
Each cycle produces the real result of the strategy.

### 8.5.3 Settlement Rule (Non-Negotiable)

At Cycle End:
- the vault MUST unwind to stablecoin
- the vault MUST finalize NAV in stablecoin
- the vault MUST compute realized profit using final settled NAV

No profit is recognized during BTC exposure.

This prevents:
- fake profits based on manipulated oracle values
- partial settlement ambiguity
- price-attack exploitation during open exposure

### 8.5.4 Profit Computation

At settlement:

Let:
- P = Principal
- NAV_settled = vault NAV after unwind (stable-only)
- RP = Realized Profit

Then:
- RP = max(0, NAV_settled - P)

If NAV_settled <= P:
- RP = 0
- no performance fee is charged
- loss is directly reflected in user vault NAV

### 8.5.5 Performance Fee Application (Only on Realized Profit)

Performance fee applies ONLY on RP.

Performance fee is computed only at settlement and only if RP > 0.

Fees never apply to:
- principal
- unrealized gains
- transient price spikes

### 8.5.6 Compound vs Withdraw Routing

At settlement, the user’s selected action applies to RP only:

- Compound All: RP remains in vault as reinvestable stablecoin
- Compound 50% / Withdraw 50%: RP split deterministically
- Withdraw All Profit: RP paid out (stablecoin or LOOP claim route if selected)

Principal treatment:
- principal remains in vault unless user requests withdrawal
- principal withdrawal follows the deterministic withdrawal rules (Section 5.X)

### 8.5.7 Loss Handling (Truth-Based Loss Accounting)

If the cycle ends in loss:
- the loss reduces NAV
- principal reference remains P (original principal)
- no fees apply
- the next cycle begins with reduced NAV

YieldLoop does not “make up” losses.
There is no insurance system.

---

## 9. Dynamic Trade Bands (SL/TP Controller)

YieldLoop does not use fixed “stop loss = 2% / take profit = 3%” logic as a permanent rule.

Fixed bands can look correct on paper and still bleed the vault to death in real markets due to BTC chop and wick behavior.

Instead YieldLoop uses a **Dynamic Trade Band Controller** that adapts to volatility and enforces survival-first constraints.

This controller exists for one reason:

> Make the strategy behave like a disciplined machine across different BTC regimes — trend, chop, panic.

---

### 9.1 The Core Problem YieldLoop Solves

BTC does not move smoothly.
BTC frequently:
- wicks down
- recovers
- breaks levels by 1–3%
- triggers naïve stops
- reverses and continues upward

A system with tight, fixed stop-loss logic will repeatedly:
- stop out at a loss
- re-enter higher
- stop out again
- churn capital into losses

This is “chop bleed.”
It kills most automated vault systems.

YieldLoop’s controller is built specifically to prevent that outcome.

---

### 9.2 Dynamic Band Inputs

The band controller uses three categories of data:

#### A) Volatility Measurement
YieldLoop uses a volatility proxy such as:
- ATR(14) or similar
- or an alternative volatility estimator approved by governance

The volatility value is normalized into a usable percentage range.

#### B) Trend / Regime Filter
YieldLoop identifies whether market conditions support long exposure.

Trend filters may include:
- BTC price relative to moving average (e.g., 50MA, 200MA)
- slope of MA
- multi-timeframe confirmation
- volatility regime classification

YieldLoop is not required to trade when conditions are unfavorable.

#### C) Strategy State
Each vault tracks:
- recent stop-outs
- recent trade count
- cooldown status
- current exposure
- drawdown status

The controller uses this to adjust aggressiveness.

---

### 9.3 Dynamic Band Calculation (Default Model)

The default implementation is volatility adaptive:

- `SL_pct = clamp(1.2 * ATR_pct, SL_min, SL_max)`
- `TP_pct = clamp(1.8 * ATR_pct, TP_min, TP_max)`

Recommended initial bounds:

- SL_min: 1.0%
- SL_max: 12.0%
- TP_min: 1.5%
- TP_max: 20.0%

And a mandatory relationship constraint:

- `TP_pct >= 1.2 * SL_pct`

This prevents sabotage configurations like:
- SL = 10%, TP = 2% (guaranteed loss)
or:
- SL = 0.5%, TP = 30% (chop bleed and never taking profit)

---

### 9.4 Cooldown Logic (Prevents Death Spirals)

Cooldown exists to prevent “revenge trading.”

When a stop-out occurs:
- vault enters cooldown state for `cooldown_minutes`

Default recommendation:
- 30–120 minutes depending on volatility

Cooldown ensures:
- the system does not immediately re-enter into the same chop condition
- the system is not constantly buying the same failing setup

---

### 9.5 Max Trade Limits

YieldLoop enforces hard caps:

- max entries per day
- max exits per day
- max total trades per day

This matters for:
- slippage
- MEV exposure
- trading fees
- chop bleed prevention

Defaults should be conservative:
- 6–12 trades per day max per vault

These caps can be tuned but always bounded.

---

### 9.6 Trend Gating (When To Trade vs When To Hold Stables)

YieldLoop includes optional **trend gating**.

If trend gating is enabled:
- the vault does not take long BTC exposure unless conditions are favorable

Example gating logic:
- only buy BTC if BTC price is above 200MA
- or if 50MA > 200MA and slope is positive

If the trend filter is bearish:
- the vault enters stable-mode behavior
- it holds stablecoin and avoids unnecessary drawdown

This turns the strategy from:
> “always trading”
into:
> “only trading when it’s rational.”

That is how you survive.

---

### 9.7 Governance Control Without Sabotage

Governance can configure:

- band bounds (within hardcoded limits)
- volatility model selection
- trend gating thresholds
- cooldown periods
- max trade limits

However YieldLoop includes:
- invariant constraints
- timelocks
- veto-only emergency override

So governance can improve performance but cannot destroy protocol safety.

---

## 10. Profit Harvesting + Profit Buffer

YieldLoop treats realized profit as a separate system asset.

This is a core design feature.
It is not optional.

---

### 10.1 Profit Harvesting Definition

A profit harvest occurs when:
- the vault exits a BTC position into stablecoin, and
- the stablecoin value exceeds the vault’s tracked principal reference under the strategy’s accounting rules

When profit exists:
- profit is separated immediately
- profit is not “mixed back into principal” invisibly
- profit becomes explicit user-owned value

This creates trust, auditability, and clarity.

---

### 10.2 Profit Buffer Definition

Profit Buffer is:

> The user’s harvested profits held in stablecoins inside the protocol until claimed or compounded.

Profit Buffer is denominated in stablecoin units:
- USDT / USDC

Profit Buffer is not:
- subject to token market price fluctuations
- dependent on LOOP liquidity
- forced into any token conversion

YieldLoop intentionally stores profit in stables to prevent:
- token reliance
- panic exits
- bank runs
- manipulation attacks

---

### 10.3 Why Profit Buffer Matters (Truth-Based UX)

YieldLoop forces honest accounting.

Users see:
- principal
- unrealized exposure
- realized harvested profit
- claimable balance

Most protocols hide this.
YieldLoop exposes it.

This creates trust and long-term retention.

---

### 10.4 Compounding Logic

YieldLoop allows user-controlled compounding:

- user selects compound percentage (5% to 100%)

Example:
- harvested profit = $100
- compound = 60%

Then:
- $60 reinvested into principal allocation
- $40 retained in Profit Buffer

This lets YieldLoop serve both:
- income users
- growth users

The compound preference is stored per vault and can be updated by user at any time.

---

### 10.5 Profit Buffer Is Not Principal

YieldLoop enforces accounting separation.

At no time should the protocol represent profit buffer as principal.

This prevents misleading reporting and maintains clean settlement logic.

---

## 11. Claiming Profits

YieldLoop implements profit claiming as a first-class feature.

The system is designed so that profits are:
- visible
- claimable
- configurable in extraction method

---

### 11.1 The Claim Event

A claim event occurs when:
- user triggers a claim
- protocol validates available Profit Buffer
- fee is computed
- payout is processed
- accounting is updated

Claiming does not require:
- withdrawing principal
- exiting the vault permanently
- changing strategy settings

Claims can happen at any time.

---

### 11.2 Claim Options (Two Payout Paths)

Users can claim profits in one of two forms:

#### A) Stablecoin Claim
- user receives USDT/USDC
- claim fee applies (default baseline 20%)
- simplest path
- no token exposure

#### B) LOOP Claim
- user receives LOOP tokens
- dynamic discounted fee applies (example 19% → 15%)
- LOOP can then be held, locked, or redeemed under protocol rules

This dual-path structure is essential.

It prevents token capture.
It creates voluntary token demand.

YieldLoop refuses to trap users into LOOP.
YieldLoop rewards LOOP usage but does not force it.

---

### 11.3 Claim Fees (Sustainable Protocol Economics)

Claims generate protocol revenue.

This is intentional.
YieldLoop is not built on emissions.
It is built on real fee flow.

Claim fees are routed to:
- reserve systems (liquidity defense, buyback, continuity)
- operations (dev, marketing)
- proof-of-impact

This is the sustainability loop.

---

### 11.4 Why Claims Are The Flywheel

Every time profit is claimed:
- fee is collected
- reserves grow
- LOOP support improves
- system credibility strengthens

This creates a reflexive loop:
- more users → more claims → stronger ecosystem

YieldLoop does not rely on “launch hype.”
It relies on usage loops.

---

## 12. LOOP Token (Redemption Token Model)

LOOP is the YieldLoop redeem token.

It is not a farm token.
It is not a liquidity token.
It is not a memecoin.

LOOP exists to convert harvested profit into:
- a protocol-aligned asset
- a claim receipt
- a supported token with reserve reinforcement

---

### 12.1 LOOP’s Purpose

LOOP has one core purpose:

> Provide an optimized profit extraction rail that strengthens the system as usage scales.

Users claim profits as LOOP because:
- fees are lower
- benefits increase when LOOP is locked
- the token is supported by reserve mechanics

---

### 12.2 LOOP Minting Rules (Critical Anti-Ponzi Design)

LOOP minting is constrained.

LOOP is minted only through defined protocol events.
The primary mint event is:

- **Profit claim in LOOP**

This is essential.

LOOP does not print because the protocol feels like it.
LOOP does not emit on a timer.
LOOP is not designed to inflate forever.

Supply increases only when:
- real user profit exists, and
- user chooses LOOP extraction

This makes LOOP supply growth directly tied to real protocol usage.

---

### 12.3 LOOP Redemption Model (The Value Spine)

YieldLoop implements LOOP as a redemption-aligned token.

Redemption means:

- LOOP can be exchanged for value from protocol-controlled reserves
- redemptions follow strict rules to prevent draining the system
- redemption pricing uses TWAP + circuit breakers
- redemption windows/rates can be governed but not weaponized

YieldLoop does not promise a guaranteed floor price.
YieldLoop creates a structured system of support.

The goal is:
- prevent death spirals
- create long-term belief stability
- build a token that survives downturns

---

### 12.4 LOOP Locking (Value Retention Mechanism)

LOOP is designed to gain strength when locked.

Users can choose:
- hold LOOP
- or lock LOOP in protocol vaults

Locking LOOP can provide:
- lower claim fees in the future
- enhanced redemption priority
- boosted claim value mechanics (optional)
- access to ecosystem benefits

Locking converts LOOP from:
- claim receipt
into:
- a long-term participation asset

This is intentional.
It reduces circulating supply and increases stability.

---

### 12.5 LOOP Is Optional But Strongly Incentivized

YieldLoop’s success does not depend on forcing LOOP.

YieldLoop succeeds because:
- stablecoin claims are always possible
- LOOP is simply the better deal long term

This maintains credibility while still building token demand.

---

## 12.6 Discount Controller (Anti-Dump Incentive Logic)

YieldLoop supports discounted performance fees for users who claim profits in LOOP.
However, the system does not subsidize LOOP dumping.

Discount eligibility is controlled by a deterministic Discount Controller.

### 12.6.1 Purpose
The Discount Controller exists to:
- reward users who strengthen the LOOP ecosystem
- prevent claim-driven sell pressure
- protect reserve integrity
- prevent whale extraction through fee arbitrage

### 12.6.2 Base Fee vs Discounted Fee
Let:
- F_base = baseline performance fee (e.g., 20%)
- F_loop = discounted fee when claiming in LOOP

F_loop is bounded:
- F_loop_min <= F_loop <= F_base

Example bounds:
- F_loop_min = 15%
- F_base = 20%

Exact values are configurable, but bounded.

### 12.6.3 Discount Eligibility Conditions (Must All Pass)

A LOOP-discounted claim is only allowed if all conditions pass:

**A) Oracle Validity**
- LOOP TWAP oracle must be valid
- deviation checks must pass
If invalid → LOOP-discount route is disabled.

**B) Liquidity Health**
- LOOP/stable pool liquidity must exceed minimum threshold
- pool age and trade cadence must pass allowlist rules
If not healthy → LOOP-discount route is disabled.

**C) Discount Capacity Limit (Anti-Whale Control)**
Discounted claims may be capped per epoch:
- max discounted claim amount per vault per epoch
- max discounted claim amount protocol-wide per epoch

Claims above capacity:
- may still claim in LOOP
- but without discount (revert to base fee)

**D) Cooldown / Rate Limit**
A vault may enforce a cooldown between discounted LOOP claims:
- prevents repeated rapid claim cycles
- reduces structural sell pressure

### 12.6.4 Discount Degradation Under Stress
If system conditions degrade (liquidity thins, volatility spikes, circuit breakers activate):
- discounted fee automatically increases toward F_base
- discount may be suspended entirely

### 12.6.5 Always-Available Claim Path
Stablecoin claim route remains available at all times.
No user is forced into LOOP.

---

## 13. Fee Model

YieldLoop’s economics are designed to be:
- sustainable without emissions
- transparent
- mechanically tied to real usage
- sufficient to fund protocol strength over time

YieldLoop does not rely on:
- inflationary reward tokens
- “temporary APY subsidies”
- mercenary liquidity incentives

YieldLoop funds itself through **profit claim fees**.

This creates a clean model:

> If the protocol generates profit for users, the protocol earns revenue.
> If the protocol generates no profit, the protocol earns less.

This alignment is intentional.

---

### 13.1 YieldLoop Fee Philosophy

YieldLoop follows three principles:

1) **Fees are paid only when profit exists**
   - users are not bled by constant fee leakage without results

2) **Fees fund token stability, not just developers**
   - reserves exist to defend the ecosystem, not enrich founders

3) **Fees scale with usage**
   - growth strengthens the system rather than weakening it

---

### 13.2 Core Fee Event: Profit Claim Fee

YieldLoop charges fees primarily during **profit claiming**.

When a user claims profit:
- profit buffer is reduced
- fee is computed
- payout is processed

This fee is **not a deposit fee** and not a withdrawal fee on principal.
It is a performance-aligned fee on extracted profit.

---

### 13.3 Claim Fee Rates

YieldLoop supports two claim paths:

#### A) Claim Profits as Stablecoins
- baseline claim fee: **20%** (initial example default)

This is the “pure exit” path.
It preserves user freedom and credibility.

#### B) Claim Profits as LOOP
- discounted claim fee: dynamic range **19% → 15%**
- discount determined by objective protocol health metrics

This is the “aligned extraction” path.
It encourages LOOP demand in a rational, voluntary way.

---

### 13.4 Fee Routing (How Fees Are Used)

YieldLoop fees are divided into two major categories:

#### A) Protocol Strength & Token Support (Reserve Allocation)
This allocation exists to:
- prevent token death spirals
- defend liquidity
- create buyback mechanisms
- build long-term sustainability

#### B) Operations & Mission Allocation
This allocation exists to:
- fund development
- fund marketing/community growth
- fund proof-of-impact

---

### 13.5 Example Baseline Allocation

A sample split (subject to governance tuning within bounds):

**Profit Claim Fee = 20% (or discounted)**

Of that fee:

**1) 50% goes to Reserve Systems**
- Liquidity Defense Reserve (LDR)
- Buyback & Lock Reserve (BLR)
- Continuity / Insurance Reserve (ICR)

**2) 50% goes to Operations**
- Dev
- Marketing
- Proof of Impact

YieldLoop explicitly discloses fee routing on-chain using transparent wallets/contracts and dashboards.

---

### 13.6 Hard Guardrails on Fees

YieldLoop enforces hard-coded fee bounds.

Example:
- max claim fee: 25%
- min claim fee: 10% (or higher depending on design)
- max fee discount: capped to prevent starving the protocol

This ensures:
- governance cannot vote fees to exploit users
- governance cannot vote fees so low that protocol collapses
- the protocol remains economically viable

---

## 14. Dynamic Fee Discount Controller

YieldLoop’s discounted LOOP claim fee is not arbitrary and not manually set.

It is governed by a **Fee Discount Controller** that adjusts fees based on protocol scale and health.

The intent is simple:

> As YieldLoop becomes larger, safer, and more liquid,
> it rewards aligned LOOP claims with better extraction efficiency.

This creates organic, mechanism-based FOMO:
- early adoption benefits
- later adoption strengthens reserves
- growth improves user economics

---

### 14.1 Why Dynamic Discount Matters

A static discount creates problems:
- too small early → token demand stays weak
- too large early → protocol starves itself

YieldLoop solves this by scaling the discount based on reality.

---

### 14.2 Metrics Used by The Controller

YieldLoop uses objective metrics such as:

1) **AUM (Assets Under Management)**
   - total stablecoin principal across all active vaults

2) **30-Day Claims Volume**
   - total realized profit claims over trailing 30 days
   - this is preferred over DEX volume because it is harder to spoof

3) **LOOP Liquidity Depth**
   - liquidity in LOOP/stable pools
   - used to prevent discounts from draining stables when liquidity is weak

These metrics represent:
- system scale
- system activity
- system token health

---

### 14.3 Fee Discount Range

YieldLoop defines a discounted fee range:

- Max discounted fee (small protocol): **19%**
- Min discounted fee (mature protocol): **15%**

Meaning:
- early stage: LOOP claim discount exists but is modest
- growth stage: discount improves naturally
- mature stage: LOOP claim becomes meaningfully cheaper

This turns LOOP into a rational choice, not a gamble.

---

### 14.4 Controller Calculation (High-Level)

YieldLoop uses a weighted score model:

- normalize metrics to 0–1 scale:
  - `aum_score`
  - `vol_score`
  - `liq_score`

- compute growth score:
  - `growth_score = w1*aum_score + w2*vol_score + w3*liq_score`

- compute fee:
  - `fee_loop_claim = 19% - 4% * growth_score`
  - clamp to [15%, 19%]

This is deterministic and auditable.

---

### 14.5 Safety Controls Against Manipulation

Because fee discounts influence user behavior, YieldLoop includes anti-exploit mechanisms:

- TWAP-based pricing for liquidity scoring
- minimum liquidity threshold before discounts reach the low end
- metric smoothing:
  - AUM computed using 7-day average
  - volume computed using 30-day rolling sum
- change rate limits:
  - fee cannot adjust more than X% per day (example 0.25%)

This prevents:
- flash loan manipulation
- whales spoofing fee conditions
- sudden instability from abrupt discounts

---

### 14.6 Governance Control Without Governance Capture

Governance may tune:
- weights
- caps
- ranges

But cannot violate invariants such as:
- minimum protocol revenue floors
- minimum reserve routing
- minimum liquidity safeguards

This prevents “vote to drain” sabotage.

---

## 15. Reserve System (Liquidity Defense + Buyback + Lock)

YieldLoop does not rely on blind token burns or hype “floor price” promises.

Instead YieldLoop uses a **Reserve System** designed like a central bank.

The purpose is:

- defend LOOP against death spirals
- convert usage into permanent strength
- reduce circulating supply through locking
- maintain long-term operational continuity

YieldLoop does not guarantee a floor.
It guarantees a structure.

---

### 15.1 Reserve Structure (3 Compartment Model)

Reserve funds are separated into three compartments:

#### A) Liquidity Defense Reserve (LDR)
Purpose:
- protect LOOP liquidity during stress
- prevent cascading collapses due to thin liquidity

Allowed actions:
- add liquidity
- stabilize pools
- buy LOOP during extreme dislocations (subject to caps)

Hard limits:
- max spend per epoch/day
- cannot exceed reserve share limits
- only acts under defined triggers

---

#### B) Buyback & Lock Reserve (BLR)
Purpose:
- systematically convert protocol fees into LOOP demand
- reduce circulating supply by locking protocol-owned LOOP

Allowed actions:
- buy LOOP from market (TWAP-based limit orders)
- lock LOOP into protocol vaults
- optionally burn a portion (rarely recommended vs locking)

Key principle:
> Buyback + lock builds long-term strength.
> Burning is optional optics, locking is real structure.

---

#### C) Continuity / Insurance Reserve (ICR)
Purpose:
- black swan continuity
- emergency execution recovery
- stable-mode operation funding
- auditing, security remediation, exploit response capability

Allowed actions:
- cover emergency operational needs
- cover exploit-related response
- cover execution failures

ICR exists because serious protocols plan for catastrophe.

---

### 15.2 Why This Reserve System Works

Most tokens die because:
- they have no defense
- they have no demand loop
- they have no capital buffer

YieldLoop converts profit claim fees into:
- reserves
- liquidity depth
- locked supply

So as long as usage exists, the token ecosystem strengthens.

---

### 15.3 Reserve Trigger Logic (Rule-Based)

Reserve actions must be rule-based, not discretionary.

Examples of valid triggers:

- LOOP price falls below a TWAP threshold relative to long-term average
- liquidity depth falls below minimum safe threshold
- volatility spikes beyond protocol-defined range
- repeated “sell pressure indicator” breach

All triggers are:
- auditable
- deterministic
- capped

---

### 15.4 Reserve Spend Limits (Sabotage Protection)

Reserve cannot be drained by emotion or governance mania.

YieldLoop includes:
- maximum spend per day (e.g., 1% of reserve per day)
- maximum spend per week (e.g., 5% of reserve per week)
- timelocks on reserve policy changes
- emergency veto rights for malicious proposals

This prevents:
- “community rage spending”
- “buyback everything now” stupidity
- slow-motion reserve depletion

---

### 15.5 Protocol-Owned LOOP (Locked Supply)

When YieldLoop buys LOOP:
- it locks the LOOP
- it does not dump it
- it reduces circulating supply permanently (or for very long durations)

This creates a self-reinforcing effect:
- usage increases fees
- fees grow reserves
- reserves buy LOOP
- LOOP supply tightens
- token becomes harder to collapse

---

## 16. Black Swan Mode + Drawdown Gates

BTC can drop 10–30% quickly.
It can do it without warning.
It can do it through wicks that destroy naïve stop systems.

YieldLoop treats this as normal reality, not an exception.

The protocol includes explicit survival systems:

- Drawdown Gates
- Stable Mode
- Trade Halts
- Risk Reduction Logic

---

### 16.1 Core Goal

YieldLoop’s black swan systems are designed to:

1) prevent principal death spirals  
2) reduce exposure during panic volatility  
3) preserve long-term vault survivability  
4) prevent overtrading losses during chaos  

---

### 16.2 Drawdown Gate Logic

Each vault tracks drawdown relative to:
- cycle high watermark
- rolling peak value

Example gates:

- **Gate 1 (Moderate Stress)**
  - if drawdown > 5%
  - reduce position sizing
  - widen SL/TP bands
  - reduce max trades/day

- **Gate 2 (High Stress)**
  - if drawdown > 10%
  - enter Stable Mode
  - avoid new BTC exposure
  - allow only exits + harvesting

- **Gate 3 (Extreme Stress)**
  - if drawdown > 15%
  - full trading halt
  - preserve principal
  - require cooldown period before resuming

Exact thresholds are governance-configurable but bounded.

---

### 16.3 Stable Mode

Stable Mode means:
- vault holds stablecoins
- vault avoids new BTC exposure
- vault prioritizes safety
- vault remains active, transparent, and user-controlled

Stable Mode prevents:
- “catching falling knives”
- repeated stop-outs
- liquidation-like behavior

---

### 16.4 Volatility Shock Trigger

YieldLoop can trigger Stable Mode based on volatility regime:

Example:
- if 24h ATR exceeds X threshold
- or if price change exceeds X% in Y hours

This allows the system to pause trading during chaos even if drawdown gates have not yet triggered.

---

### 16.5 Recovery Logic

YieldLoop does not instantly resume trading after panic stops.

Recovery includes:
- cooldown windows
- trend confirmation
- gradual exposure restoration

This prevents:
- whipsaw re-entry into continuing selloff
- repeated capital loss loops

---

## 17. Security Model

YieldLoop is designed to survive hostile environments.

That means the security model is not treated as a feature.
It is treated as the foundation.

YieldLoop’s security posture follows three principles:

1) **Minimize blast radius**
2) **Make system behavior deterministic**
3) **Assume adversaries exist at all times**

This includes adversaries such as:
- MEV bots and sandwich attackers
- flash loan price manipulators
- governance capture attempts
- internal key compromise attempts
- malicious proposals disguised as “improvements”
- liquidity attacks against LOOP

---

### 17.1 Isolation Architecture (Primary Security Spine)

YieldLoop uses **isolated user vaults**.

This is a major security upgrade over pooled vaults.

Benefits:
- exploits do not automatically drain pooled capital
- users are not exposed to shared accounting errors
- withdrawal behavior does not instantly create system-wide bank runs
- the protocol can pause selectively without locking the entire ecosystem

In short:

> one user vault is a compartment.
> pooled vaults are a powder keg.

---

### 17.2 Deterministic Strategy Control

YieldLoop strategy logic must be:
- rule-based
- auditable
- bounded

This prevents discretionary behavior.
And it prevents “strategy drift” that becomes impossible to analyze.

YieldLoop therefore enforces:
- deterministic trade decision cycle
- bounded SL/TP controller outputs
- bounded max trades/day
- bounded slippage limits
- bounded reserve spend rules

This makes the protocol easy to audit and hard to exploit.

---

### 17.3 Contract Compartmentalization

YieldLoop is not built as “one mega contract.”

It is composed of distinct modules:

- Vault module (holds user funds)
- Strategy controller module (signals actions)
- Execution module (performs swaps)
- Profit buffer module (accounting of realized profits)
- Claim module (profit extraction)
- LOOP token module (mint/redemption)
- Fee router module (splits fees)
- Reserve engine module (liquidity defense + buyback + lock)
- Oracle adapter module (TWAP + circuit breakers)
- Governance module (timelocks, bounds, veto)

This structure creates two crucial security advantages:
- reduced complexity per module
- easier audit + reduced attack surface

---

### 17.4 Execution Protection (MEV + Slippage Guards)

YieldLoop assumes that any on-chain trade will be attacked if profitable to attack.

Execution protection is therefore mandatory and is treated as a hard security layer,
not as an optional optimization.

YieldLoop execution MUST enforce:
- strict slippage caps
- maximum price impact caps
- minimum-out enforcement for every swap
- liquidity depth checks prior to routing
- trade size gating (avoid large swaps into thin liquidity)

Execution MUST NOT occur if:
- liquidity depth is below minimum threshold
- oracle sanity checks fail
- TWAP deviation exceeds allowed bounds
- price impact exceeds cap
- volatility shock conditions are triggered
- circuit breakers are active

If conditions are unsafe, the protocol skips execution.
YieldLoop prefers survival over forced execution.

Optional upgrade path (non-required for v1):
- private execution / protected routing methods may be used where available to reduce sandwiching risk,
but YieldLoop is designed to remain safe even without them.

---

### 17.5 Pause / Circuit Breakers

YieldLoop includes “pause” systems at multiple levels.

Examples:
- per vault pause
- global strategy pause
- oracle price safety pause
- claim pause for LOOP-only claim route

Pausing must be possible without:
- stealing funds
- preventing stablecoin claims forever
- trapping user principal

The system is designed to pause execution while maintaining safe exits.

---

### 17.6 Auditability Requirements

YieldLoop must be built to prove what it is doing.

This means:
- clear event emissions
- transparent internal ledgers
- reproducible accounting

The goal is that any external party can verify:
- how profits were harvested
- how fees were charged
- where fees were routed
- how reserves were used
- how LOOP supply was minted / locked / redeemed

YieldLoop is designed to survive hostile scrutiny, not avoid it.

---

## 18. Oracle / Pricing Model (TWAP, Circuit Breakers)

Any token system that:
- uses price feeds
- mints tokens based on price
- allows redemption based on price
will eventually be attacked.

YieldLoop treats pricing as a security layer, not a convenience.

---

### 18.1 Oracle Philosophy

YieldLoop follows one core oracle rule:

> never trust spot price.

Spot price can be manipulated with:
- flash loans
- low liquidity trades
- short term price distortions
- sandwich attacks

YieldLoop therefore uses **TWAP (time-weighted average price)** as its baseline.

---

### 18.2 LOOP Pricing Requirements (Deterministic Oracle Spec)

LOOP pricing is a security primitive.

LOOP price is used for:
- profit claim conversion into LOOP
- redemption calculations
- reserve triggers
- discount controller liquidity scoring

Therefore LOOP pricing MUST be:
- TWAP-based (never spot)
- liquidity-weighted
- deviation-gated
- fallback-safe

#### 18.2A Oracle Inputs (Allowed Sources)
YieldLoop only accepts pricing from approved on-chain sources.

Primary oracle source:
- PancakeSwap (PCS) LOOP/stable pool TWAP

Optional secondary sources (upgrade path):
- additional PCS LOOP/stable pools
- cross-check pools (e.g., LOOP/WBNB paired with WBNB/stable TWAP)
- external oracle feed for sanity checks (if provably robust)

Each oracle source must be explicitly whitelisted and meet minimum liquidity standards.

#### 18.2B Pool Allowlist Rules (No “Any Pool” Garbage)
Only designated PCS pools may be used for LOOP TWAP.

A pool is eligible only if:
- it is explicitly whitelisted by governance within hardcoded bounds
- liquidity depth exceeds minimum threshold ($X stable equivalent)
- pool age exceeds minimum time threshold (prevents freshly-created scam pools)
- pool volume and trade cadence meet minimum criteria

If the primary pool fails eligibility checks, the oracle may:
- fail over to the next eligible pool in the allowlist
- OR enter oracle-fail safe mode (Section 18.2D)

#### 18.2C TWAP Definition (Exact)
TWAP is computed on a fixed window:
- baseline TWAP window: 30–60 minutes (configurable within bounds)

TWAP must NOT be computed from a single observation.
It must use multiple observations over time.

All TWAP results must pass:
- deviation checks vs previous TWAP
- deviation checks vs secondary oracle source (if enabled)

#### 18.2D Oracle Fail-Safe Mode (Non-Negotiable)
If oracle validity fails:
- LOOP claims are paused
- LOOP mint for claims is paused
- reserve buybacks are paused
- stablecoin claims remain available (always)

Oracle failure MUST NOT:
- trap user principal indefinitely
- allow minting based on manipulated price

Oracle fail-safe mode remains active until oracle validity is restored.

---

### 18.3 Minimum Liquidity Requirements

YieldLoop refuses to trust a price feed if liquidity is too thin.

Example rule:

- LOOP LP depth must exceed $X (stablecoin equivalent)
- price impact estimate must be below Y%

If liquidity is below threshold:
- LOOP claims may be disabled temporarily
- stablecoin claims remain available
- reserve actions may pause or enter defense mode

This prevents token death spirals caused by thin liquidity.

---

### 18.4 Circuit Breakers (Non-Negotiable)

YieldLoop includes circuit breakers such as:

#### A) Price Deviation Breaker
If TWAP deviates beyond limit relative to previous TWAP:
- pause LOOP mint for claims
- allow stablecoin claim only
- notify protocol dashboards

Example threshold:
- >5% deviation within 1 hour triggers pause

#### B) Liquidity Shock Breaker
If liquidity depth drops under threshold:
- pause reserve buys
- pause LOOP claims
- allow stablecoin claims only

#### C) Volatility Shock Breaker
If BTC volatility exceeds threshold:
- widen trade bands
- reduce trade frequency
- optionally stable-mode

These breakers exist because market events can be violent.

#### D) Oracle Integrity Breaker
If oracle input data becomes invalid:
- missing observations / stale values
- pool not eligible (liquidity too thin, pool removed, pool frozen)
- TWAP computation cannot be completed

Then:
- pause LOOP claim route
- pause reserve buybacks
- allow stablecoin claims only
- enter ORACLE_FAILSAFE state

---

### 18.5 Oracle Redundancy (Optional Upgrade)

YieldLoop may incorporate:
- multiple PCS pools
- aggregator feeds
- cross-check feeds

However, redundancy must not become complexity theater.
The key is:
- TWAP
- liquidity thresholds
- circuit breakers
- deterministic fallbacks

---

## 19. Governance (Upgradeable but Sabotage-Resistant)

Governance is necessary.
But governance is also an attack vector.

YieldLoop therefore uses governance as:
- improvement mechanism
not:
- uncontrolled democracy

---

### 19.1 Governance Goals

Governance exists to:
- tune strategy parameters
- upgrade modules over time
- adjust fee weights within bounds
- adjust reserve triggers within bounds
- fund proof-of-impact and ecosystem growth

Governance must not be able to:
- drain reserves
- disable safety guards
- turn protocol into reckless leverage
- rug users through parameter sabotage

---

### 19.2 Governance Architecture

YieldLoop governance includes:

1) **Proposal system**
2) **Voting**
3) **Timelock**
4) **Invariant enforcement layer**
5) **Emergency veto (veto-only)**

This creates layered security.

---

### 19.3 Invariant Guardrails (Hardcoded Safety)

Governance can only modify parameters inside **hardcoded bounds**.

Examples:

- SL range must remain within [1%, 12%]
- TP range must remain within [1.5%, 20%]
- TP must remain >= 1.2×SL
- max trades/day capped
- slippage caps bounded
- reserve spend/day bounded
- minimum reserve allocation protected
- minimum stablecoin claim availability protected

This prevents “mad community” sabotage.

---

### 19.4 Timelocks (Mandatory)

All major parameter changes are delayed.

Example:
- 48–96 hour timelock

This provides:
- time for the community to react
- time for security review
- time for withdrawals if a change is hostile

Timelocks are one of the most effective forms of decentralization safety.

---

### 19.5 Emergency Veto (Veto-Only)

YieldLoop may include a limited emergency veto mechanism.

This mechanism can:
- stop execution of a malicious proposal

It cannot:
- change parameters directly
- withdraw user funds
- override claims

The veto role is designed to protect, not control.

This balances decentralization with survival.

---

### 19.6 Upgradeability

YieldLoop is built to upgrade over time.

However upgrades must be:
- explicit
- timelocked
- audited
- announced
- reversible where possible

Upgrades cannot be:
- silent
- instant
- opaque

YieldLoop cannot survive long-term without the ability to evolve.
But it must evolve without becoming untrustworthy.

---

## 20. Proof of Impact

YieldLoop includes Proof-of-Impact for one reason:

> convert protocol success into measurable real-world benefit without sacrificing protocol survival.

Proof-of-Impact is not marketing fluff.
It is not “vibes.”
It is on-chain, measured, and disclosed.

---

### 20.1 Why Proof-of-Impact Exists

Many crypto projects claim impact.
Few prove it.

YieldLoop designs impact as:
- mechanically funded
- transparently routed
- independently verifiable

YieldLoop’s impact model creates:
- credibility
- mission-driven participation
- long-term public legitimacy

---

### 20.2 How Proof-of-Impact Is Funded

A portion of fees is routed to Proof-of-Impact.

Example:
- profit claim fee split includes PoI allocation
- PoI wallet/contract is publicly viewable
- PoI disbursements occur only under rules

PoI is funded from:
- real usage
- real profit extraction
- real fee flow

It is not funded by printing tokens.

---

### 20.3 Proof-of-Impact Ledger (Transparency)

YieldLoop maintains an on-chain PoI ledger.

The ledger displays:
- funds routed to PoI
- recipient addresses
- transaction links
- date and descriptions
- evidence links (off-chain docs, receipts, publications)

This allows third parties to verify impact without trusting the team.

---

### 20.4 Impact Governance (Bounded)

PoI allocation selection can be governed, but constrained.

Rules may include:
- approved charity registry
- approved causes list
- maximum disbursement per epoch
- prevention of self-dealing
- multi-sig confirmation for disbursement execution

PoI governance must be resistant to:
- grifting
- political capture
- treasury draining schemes

---

### 20.5 Why This Strengthens YieldLoop

Proof-of-Impact strengthens the protocol by:

- building long-term trust
- creating mission-aligned users
- improving retention and loyalty
- differentiating YieldLoop from typical DeFi hype cycles

Impact is used as a legitimacy engine, not a gimmick.

---

## 21. Transparency + Proof Dashboards

YieldLoop cannot succeed long-term without credibility.

Crypto markets punish opacity.
Regulators punish opacity.
Serious users punish opacity.

YieldLoop therefore treats transparency as a core product feature.

It is not a “nice-to-have.”
It is part of the survival design.

---

### 21.1 Transparency Philosophy

YieldLoop is built around truth-based accounting.

That means:
- profits must be measurable
- claims must be provable
- fees must be traceable
- reserves must be visible
- LOOP supply changes must be auditable
- governance decisions must be trackable

This ensures that YieldLoop can withstand:
- public scrutiny
- investor scrutiny
- auditor scrutiny
- hostile committee scrutiny

Transparency makes the system defensible.

---

### 21.2 Required Dashboards

YieldLoop provides public-facing dashboards that show:

#### A) System AUM
- total assets under management
- AUM breakdown by stablecoin type (USDT/USDC)
- AUM trend over time

#### B) Harvested Profit Metrics
- total profit harvested (lifetime)
- profit harvested (30-day)
- profit harvested (7-day)
- profit harvested (24-hour)

#### C) Claims Metrics
- total claimed profits
- claimed as stablecoins vs claimed as LOOP
- average claim fee rate
- claim frequency

#### D) Strategy Metrics
- trade frequency
- win rate (informational only)
- average trade profit/loss (informational only)
- stable-mode % time
- drawdown triggers count

#### E) LOOP Token Metrics
- total LOOP supply
- LOOP circulating supply
- LOOP locked supply
- LOOP minted from claims
- LOOP redeemed / burned / locked by protocol

#### F) Reserve Metrics
- Liquidity Defense Reserve balance (LDR)
- Buyback & Lock Reserve balance (BLR)
- Continuity Reserve balance (ICR)
- reserve inflows (fees)
- reserve outflows (actions)
- buyback amounts and lock amounts

#### G) Proof-of-Impact Metrics
- total PoI funds routed
- PoI disbursements
- recipient ledger and proof links

YieldLoop intends for these dashboards to be:
- simple enough for normal users
- detailed enough for auditors

---

### 21.3 On-Chain Proof Links

YieldLoop dashboards must include on-chain proof links:

- contract addresses
- transaction hashes
- reserve wallet holdings
- mint/burn/lock events

YieldLoop does not ask users to trust the team.
It provides a ledger that can be inspected.

---

### 21.4 Event Emissions (Protocol Logging)

YieldLoop emits events such as:

- VaultDeposited
- VaultWithdrawn
- TradeExecuted
- ProfitHarvested
- ProfitClaimedStable
- ProfitClaimedLoop
- FeeRouted
- ReserveActionExecuted
- LoopLocked
- LoopRedeemed
- CircuitBreakerTriggered
- GovernanceConfigUpdated

Events make it possible for:
- analytics providers
- community dashboards
- independent auditors
to verify behavior without internal access.

---

### 21.5 Truth Over Optics

YieldLoop will show real performance.
Not “smoothed” performance.
Not “marketing curves.”

Users do not need to be lied to.
They need reality.

If profits are low:
- show it
- explain it
- show the system behavior
- show risk logic

This builds durability and long-term trust.

---

## 22. Roadmap

YieldLoop is designed to launch in phases.

The roadmap is built around one constraint:
security and correctness must come before expansion.

YieldLoop will not attempt to launch as a “do everything” protocol on Day 1.

It will launch as a simple, secure, survivable system and expand iteratively.

---

### 22.1 Phase 0 — Specification & Test Infrastructure

Objectives:
- finalize full protocol spec (this document)
- contract architecture design
- test framework
- simulations of chop / trend / dump regimes
- adversarial oracle manipulation simulations
- MEV / slippage simulations
- governance model implementation

Outputs:
- dev spec release
- system architecture diagram
- testnet prototype

---

### 22.2 Phase 1 — Core MVP Launch

Objectives:
- launch isolated vault deposits
- implement strategy execution on PCS
- implement profit harvesting + profit buffer
- implement claim system (stablecoin + LOOP)
- implement fee routing + reserve accounting
- implement transparency dashboards

Constraints:
- limited supported pairs (BTCB/USDT, BTCB/USDC)
- strict risk bounds
- conservative trade limits

Outputs:
- live mainnet protocol
- fully inspectable reserve + claim flows

---

### 22.3 Phase 2 — Token Support Expansion

Objectives:
- implement full reserve automation
- implement buyback + lock engine
- implement LOOP lock vaults
- implement enhanced discount controller
- implement additional guardrails and failovers

Outputs:
- robust liquidity defense system
- deeper LOOP participation mechanics
- more mature token support structure

---

### 22.4 Phase 3 — Governance Maturity & Ecosystem Growth

Objectives:
- governance improvements
- improved proposal review systems
- expanded proof dashboards
- advanced risk classification and regime detection
- optional community tool ecosystem

Outputs:
- decentralized tuning capability within safety bounds
- independent third-party analytics integrations
- stronger community coordination

---

### 22.5 Phase 4 — Optional Expansions (Only If Safe)

Possible expansions:
- additional BTC routing venues (if secure)
- additional stablecoins
- additional low-risk strategy variations
- more advanced execution routing
- enhanced oracle redundancy

YieldLoop refuses expansion that compromises:
- vault isolation
- oracle security
- claim integrity
- reserve safety

---

## 23. Risk Disclosures

YieldLoop is a risk product.
It must be treated as such.

YieldLoop is not a savings account.
It is not a bank.
It is not insured.
It is not guaranteed.

This section exists to set reality.

---

### 23.1 Market Risk

BTC is volatile.
BTC can:
- drop rapidly
- wick violently
- remain irrational longer than expected

Profit is not guaranteed.

Stablecoins also carry risk:
- peg risk
- issuer risk
- market risk

---

### 23.2 Strategy Risk

Automated strategy execution can:
- produce low profit
- produce losses
- underperform BTC holding
- be harmed by slippage and MEV
- fail during extreme market regimes

YieldLoop implements guardrails but cannot eliminate risk.

---

### 23.3 Smart Contract Risk

All DeFi protocols have smart contract risk.

This includes:
- vulnerabilities
- oracle manipulation attempts
- integration failures with PCS routing
- unknown unknowns

YieldLoop mitigates risk via:
- modular design
- audits
- circuit breakers
- vault isolation

But cannot eliminate it.

---

### 23.4 Governance Risk

Governance introduces risk such as:
- capture attempts
- malicious proposals
- incompetence

YieldLoop mitigates this by:
- invariant constraints
- timelocks
- veto-only emergency override

But governance risk remains.

---

### 23.5 LOOP Token Risk

LOOP is a crypto asset.
It can:
- lose value
- experience low liquidity
- experience volatility spikes

YieldLoop supports LOOP via reserves and locking, but:
- LOOP is not guaranteed
- LOOP is not insured
- LOOP is not a promise

Users claiming profits as LOOP accept token exposure.

---

### 23.6 Reserve Risk

Reserves exist to support the ecosystem.
However:
- reserves can be depleted
- reserves may be ineffective under extreme circumstances
- buybacks may fail to stabilize price

Reserves improve survivability, not guarantee outcomes.

---

## 24. Legal / Compliance Disclaimers

YieldLoop is a software protocol.
It provides automated strategy execution tools.

YieldLoop does not provide:
- investment advice
- financial advice
- guarantees of profit
- insured accounts

Users interact with YieldLoop at their own risk.

Users must:
- understand the risks
- comply with local laws
- determine whether participation is legal in their jurisdiction

YieldLoop is provided “as is” with no warranty.

---

# End of Whitepaper
