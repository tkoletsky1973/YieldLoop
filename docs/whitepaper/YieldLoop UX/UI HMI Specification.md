# YieldLoop UX/UI HMI Specification (Unabridged, Dev-Ready)

**Document Title:** YieldLoop UX/UI HMI Master Specification  
**Version:** 1.0  
**Date:** January 16, 2026  
**Author:** Todd Koletsky  
**Output Type:** UX / UI / HMI + Screen Map + State + Guardrail Transparency  
**Scope:** Frontend user experience + admin/operator HMI (non-custodial, deterministic, audit-friendly)  
**Based On:** YieldLoop v0.8.0 + Dev Handoff v0.8.0 + Appendix A/B/C  

> This is the frontend spec that eliminates guesswork.
> If a dev builds exactly what is written here, the YieldLoop UI will be complete.

---

## Section 1 — UX/UI Core Principles (Non-Negotiable)

This section defines the **laws** of the HMI.  
If the UI violates these principles, the protocol becomes misleading, legally sloppy, and exploitable.

### 1.1 Disclosure-First UI (No Dark Patterns)
YieldLoop UI must behave like:
- a **financial control panel**
- a **transparent vault dashboard**
- a **risk-aware execution monitor**

It must not behave like:
- a casino UI
- a hype funnel
- a meme token site
- a “trust us” yield page

**Rule:** Every feature that can affect money must show the risk and rules *before commitment.*

---

### 1.2 Deterministic and Verifiable (UI must match on-chain truth)
The UI must never show “estimated profit” as if it is real.

Allowed:
- realized profit
- claimable balances
- compounded balances
- actual fees charged
- actual executed trades

Forbidden:
- “profit today” if it isn’t realized net USDT on-chain
- “APY” unless it is clearly labeled as a projection
- “unrealized PnL” shown as if withdrawable

**Rule:** UI must default to displaying *what is provable on-chain.*

---

### 1.3 Profit is Realized-Only (UI must enforce the protocol’s truth rule)
YieldLoop’s core “truth rule” is:

> No profit exists unless it is realized in USDT after all costs.

Therefore:
- the UI must teach this upfront
- the UI must repeat this in the Strategy Preview
- the UI must anchor every dashboard metric to this rule

---

### 1.4 No Trading Before Acceptance (Acceptance Gate is a UX pillar)
YieldLoop requires:
- Deposit
- Strategy Preview
- Accept/Decline checkpoint
- Only then execution begins

Therefore:
- UI must force this in flow design
- UI must show vault state clearly:
  - `PENDING_ACCEPTANCE` means “NO execution possible”
  - `ACTIVE` means eligible for execution (subject to guardrails)
- UI must never hide or auto-pass this checkpoint

---

### 1.5 Guardrails Must Be Visible (Rejection reasons are not optional)
YieldLoop is conservative. It will reject a lot of execution attempts.

The UI must not make that look like:
- a bug
- broken protocol
- “stuck vault”

Instead the UI must show:
- rejection reason codes
- explanation in plain English
- what the user should do (usually: nothing)
- whether it is temporary vs escalated

**Rule:** Guardrail rejections must be treated as “system working correctly.”

---

### 1.6 “Claim Anytime” Must Be Simple and Always Discoverable
Claiming is a primary feature, not an advanced option.

UI must:
- always show claimable balances
- have a “Claim” CTA visible on vault dashboard
- show claim history
- show receipts (tx links)

---

### 1.7 Principal ≠ Profit (UI must never confuse them)
UI must display separate compartments clearly:
- Principal (never fee’d)
- Inventory (exposure)
- Claimable (profit)
- Compound (profit being reinvested)

**Rule:** Users must never think they can claim principal as profit.

---

### 1.8 Minimal Cognitive Load (Normie friendly without lying)
Normie mode must hide complexity *without hiding truth.*

Required:
- plain language explanations
- safe defaults
- hard bounds
- “advanced” toggles for optional items

Forbidden:
- removing risk warnings
- hiding execution stoppage logic
- hiding fee terms

---

### 1.9 UI is a Legal Defense Tool
The Strategy Preview screen must read like:
- a compliance disclosure panel
- a Howey-friendly consent layer

Not:
- “click accept for gains”

---

### 1.10 Everything Important Must Produce an Indexable Trail
UI must assume:
- users will dispute
- users will audit
- YouTubers will investigate
- regulators will review

Therefore:
- UI must point to event logs and receipts
- UI must show vault ID + config hash + acceptance timestamp

---

## Section 2 — Global UX Structure (App Shell + Navigation + Modes)

This section defines how the app is structured and how the user moves through it.

### 2.1 App Shell Layout (Desktop + Mobile)
Required global layout regions:

- **Top Bar**
  - YieldLoop logo
  - network indicator (BNB Chain)
  - wallet status (Connected / Not connected)
  - current address (short format)
  - notification bell (system + vault)
  - settings icon

- **Primary Navigation**
  - Home
  - Vaults
  - Deposit
  - Supporter
  - Referral
  - Docs
  - Status (System Monitor)

- **Global Footer**
  - risk disclosure link
  - contract addresses
  - audit status
  - version hash
  - “View on BscScan” shortcuts

---

### 2.2 Modes: Normie vs Advanced
YieldLoop has two UI modes:

#### Mode A — Normie Mode (default)
Shows:
- deposit
- accept strategy
- vault balance
- claim
- simple performance chart
- guardrail status (simple)

Hides:
- raw config bounds
- reject code enumeration
- route details
- oracle details

#### Mode B — Advanced Mode (toggle)
Adds:
- config hash details
- bounds tables
- execution feed (per attempt)
- keeper activity
- route trace
- price sanity view
- reject reason log

**Rule:** advanced mode can only reveal more detail.  
It cannot override safety, logic, or acceptance gate.

---

### 2.3 Vault-Centric Navigation
The core UX object is a **Vault**.

Therefore:
- everything important must be anchored to a Vault ID
- vaults list view must exist
- vault dashboard must exist
- vault-level actions must be centralized:
  - claim
  - change compounding %
  - change reward mode (if allowed)
  - request exit
  - pause vault (optional)

---

### 2.4 Required Global System Status Panel
YieldLoop must include a system-level panel called:

**System Status (HMI Monitor)**

It must show:
- protocol paused? yes/no
- enabled venues (PCS, BiSwap)
- enabled tokens (BTCB, SOL, XRP)
- current guardrail config name/version
- oracle status and freshness
- ECW funding status (execution budget health)
- last incident banner (if any)

This prevents rumors and panic when the system is conservative.

---

### 2.5 UI Versioning and Trust Surfaces
UI must display:
- UI build version
- contract deployment version
- config hash version (active)

These must be visible in:
- footer
- vault strategy preview screen
- vault dashboard advanced panel

---

### 2.6 Notifications Rules
Notifications must include:
- Strategy awaiting acceptance
- Vault pause/unpause
- Trade executed
- Profit realized
- Claim successful
- Guardrail rejection spike (optional)
- Referral qualified
- Referral reward credited

Notification delivery:
- in-app
- optional email/web push later (not MVP required)

---

## Section 3 — Identity, Wallet, Network, and Security UX

This section defines wallet connection, chain enforcement, and safety UX.

### 3.1 Wallet Connection Requirements
UI must support:
- MetaMask
- Trust Wallet
- WalletConnect providers

User sees:
- connect button
- if connected: wallet + chain badge

---

### 3.2 Chain Gate (BNB Chain Enforcement)
If user is not on BNB Chain:
- show warning banner
- disable all money-moving CTAs
- provide “Switch Network” button

---

### 3.3 Token Address Transparency (USDT)
UI must display:
- the canonical USDT contract address used
- a copy button
- a BscScan link

This reduces support tickets and fake token mistakes.

---

### 3.4 Permission UX (Approvals)
Deposit requires:
- USDT approval
- then deposit transaction

UI must show:
- “Step 1: Approve USDT”
- “Step 2: Deposit to VaultFactory”
- confirmation receipts for both

Rules:
- no hidden approvals
- no infinite approvals unless user explicitly selects it (default: exact)

---

### 3.5 Transaction UX Requirements
Every transaction must show:
- action name
- affected vault ID (when applicable)
- estimated gas
- confirmation state:
  - submitted
  - pending
  - confirmed
  - failed

Also show:
- “View on BscScan”

---

### 3.6 Failure UX (Do not blame users)
Common failures:
- rejected tx
- insufficient USDT
- insufficient gas
- wrong chain
- allowance too low
- on-chain revert due to bounds

UI must return:
- short reason
- what to do next
- never shame the user

---

### 3.7 Session Safety UX
When wallet disconnects:
- UI must fail safe
- show read-only data if possible
- disable actions

---

## Section 4 — Home Screen (Protocol Overview + First-Run Guidance)

This defines the Home page and first-time user orientation.

### 4.1 Home Screen Primary Goal
Convert confusion into action by answering:
1) What is YieldLoop?
2) What happens if I deposit?
3) What is profit?
4) What are risks?
5) Where do I click next?

---

### 4.2 Required Home Screen Blocks

#### 4.2.1 Hero Block (Plain-English)
Must say (plain English):
- non-custodial vault system
- deposit USDT
- conservative automated strategy
- realized profit only
- claim anytime

CTA buttons:
- “Deposit USDT”
- “View Vaults”
- “Read How Profit Works” (opens disclosure modal)

---

#### 4.2.2 Protocol Truth Panel (Must Always Be Visible)
A boxed panel titled:

**YieldLoop Truth Rules**

Must contain bullet points:
- profit is realized-only
- no guaranteed returns
- no insurance
- no leverage
- system may do nothing for long periods
- safety > activity

This is non-negotiable.

---

#### 4.2.3 Live Protocol Metrics (Real Metrics Only)
Must display:
- total deposits (TVL or total vault principal)
- total realized profit distributed
- total fees paid
- number of active vaults
- system paused state

If something is not on-chain verifiable, label it as:
- “Projected”
- “Estimated”
- “Off-chain indexer”

---

#### 4.2.4 “How it Works” Mini Flow (Clickable)
A simple 5-step diagram:
1) Deposit USDT
2) Strategy Preview
3) Accept / Decline
4) Execute when safe
5) Claim anytime

Each step should open a detail panel.

---

### 4.3 First-Time User Checklist (Guided Onboarding)
For new users, show a checklist:
- Connect wallet
- Confirm BNB Chain
- Confirm USDT token address
- Deposit >= 300 USDT
- Review Strategy Preview
- Accept strategy
- Monitor vault
- Claim profit

---

### 4.4 Supporter / Referral Teasers (Non-Invasive)
Home may include a section:
- Supporter Badge benefits
- Referral overview

But it must not dominate the experience.

**Rule:** investing UX is primary. programs are secondary.

---

### 4.5 “Why trading might be idle” Disclosure
Home must include a panel:
**“Why you might see no activity”**

Explain plainly:
- guardrails reject unsafe/unprofitable trades
- YieldLoop is conservative by design
- fewer trades does not mean broken

---

### 4.6 Docs and Transparency Links
Home must include:
- link to whitepaper
- link to appendix
- link to dev handoff
- list of deployed contracts-

---

## Section 5 — Deposit Flow (Screens + States + Errors)

This section defines the complete deposit funnel.  
It must be deterministic, normie-proof, and not allow silent misconfiguration.

---

### 5.1 Deposit Entry Points (Required)
User can enter the deposit flow from:
- Home CTA: “Deposit USDT”
- Nav: Deposit
- Vaults page: “Create Vault / New Deposit”
- Supporter / Referral screens (secondary CTA only)

**Rule:** Deposit must always route into the same unified flow.

---

### 5.2 Deposit Screen Layout (Normie Default)

**Page Title:** Deposit (Create Vault)

#### 5.2.1 Required Fields (Input Controls)
- **Deposit Asset**
  - Default: USDT
  - If multiple assets supported later: dropdown must show exact token contract addresses
- **Deposit Amount**
  - numeric input
  - Max button (fills wallet available balance)
  - must display:
    - wallet balance
    - minimum deposit requirement
- **Compounding Choice**
  - Slider: 0% → 100%
  - Presets: 0%, 50%, 100%
  - Plain language label:
    - 0% = “Withdraw all rewards”
    - 50% = “Withdraw half / compound half”
    - 100% = “Compound all rewards”
- **Risk Level Selector**
  - Options (per YieldLoop definition):
    - Ultra Low
    - Low
    - Medium
    - High
    - Unrestricted
  - Must display “What changes?” info icon (opens modal)
- **Strategy Style Selector** *(if protocol supports multiple engines)*
  - If only one strategy exists in MVP:
    - show it as “Active Strategy: BTC Profit Vault (default)”
  - If multiple strategies exist:
    - show list of allowed strategies, governed by allowlist + bounds

---

#### 5.2.2 Required Readouts (Non-input)
A summary box must show, in real time:
- Minimum deposit required
- Estimated gas
- Vault creation status (not created yet)
- Deposit fee (if applicable)
- Current UI version + contract version (small text)
- “Profit is realized-only” warning

---

#### 5.2.3 Required CTAs
- Primary:
  - **“Approve USDT”** (Step 1)
  - **“Deposit + Create Vault”** (Step 2)
- Secondary:
  - “Advanced details”
  - “Read Strategy Preview terms”
  - “Cancel”

**Rule:** Deposit cannot happen without approval, and approval must be explicit.

---

### 5.3 Advanced Deposit Panel (Toggle)
When user taps **Advanced**, show:

- Selected config hash/version
- Token allowlist for this risk tier (read-only)
- Venue allowlist (PCS / BiSwap)
- Safety guardrail mode (Conservative / Standard / Aggressive)
- Estimated maximum trade frequency
- Oracle sanity constraints (TWAP/spot checks)

**Rule:** This panel is for transparency only.  
No “custom params” in MVP unless governance explicitly enables it.

---

### 5.4 Deposit Flow State Machine (UI)
UI must implement this as an explicit stepper:

1) **Wallet Connected**
2) **Chain Verified (BNB Chain)**
3) **Approval**
4) **Deposit + Vault Creation**
5) **Vault Created**
6) **Strategy Preview Required**
7) **Acceptance Pending**

Each step must show:
- status icon (idle / in-progress / complete / failed)
- tx receipt link (when applicable)

---

### 5.5 Deposit Success Screen (Required)
After successful deposit, user must land on:

**Screen:** Vault Created — Acceptance Required

Must show:
- Vault ID
- Deposit amount
- Deposit time
- Selected configuration snapshot:
  - risk level
  - compounding %
  - active strategy name
  - venues enabled
- Primary CTA:
  - **“Review Strategy Preview”**
- Secondary CTAs:
  - “Back to Vaults”
  - “Home”

**Rule:** Do not allow user to believe they are earning yet.

---

### 5.6 Deposit Fail States (UI must cover all)

#### 5.6.1 Wallet Not Connected
- disable deposit CTAs
- show connect wallet modal

#### 5.6.2 Wrong Chain
- show “Switch to BNB Chain”
- lock all money actions

#### 5.6.3 Insufficient USDT Balance
- red inline warning
- disable Deposit CTA

#### 5.6.4 Insufficient Gas
- warning: “You need BNB for gas”
- show required minimum gas estimate

#### 5.6.5 Approval Rejected
- show “Approval rejected”
- no blame language
- allow retry

#### 5.6.6 Deposit Tx Failed / Reverted
UI must parse revert reason when available and show:
- “Deposit failed”
- “Reason code: …”
- “Try again” (if safe)
- “Contact support” (if recurring)

#### 5.6.7 Bounds Violation
If user selections violate allowed bounds:
- UI must show:
  - “Your selection is outside allowed bounds”
  - exact field(s) causing violation
  - nearest allowed value suggestions

---

### 5.7 Deposit Receipt + Ledger Requirements
Every deposit must have:
- vault creation tx link
- deposit tx link
- on-screen receipt
- entry in “Vault Activity Log”

---

### 5.8 Deposit Invariants (Non-negotiable)
- Deposit must never silently alter user settings.
- Deposit must never begin execution without acceptance.
- Deposit must create an immutable snapshot record visible to the user.
- Deposit must clearly teach: “profit is not guaranteed and may be idle.”

---

## Section 6 — Strategy Preview Screen (Disclosure Requirements)

This is the most important legal + trust screen in the entire UX.

It must function like:
- a contract disclosure panel
- an acceptance gate
- a “what will happen to my money” truth document

---

### 6.1 Strategy Preview Entry Points
User reaches Strategy Preview from:
- Vault Created success screen
- Vault Dashboard (if still pending acceptance)
- Vaults list item: “Pending Acceptance”

---

### 6.2 Strategy Preview Layout (Required Blocks)

**Screen Title:** Strategy Preview (Required Before Execution)

**Status Banner:**
- “Vault is NOT active until you accept.”
- show time since deposit
- show acceptance deadline (if any)

---

#### 6.2.1 Vault Summary Block
Must include:
- Vault ID
- Deposit asset + amount
- Risk level
- Compounding %
- Strategy version/config hash
- Strategy activation status: `PENDING_ACCEPTANCE`

---

#### 6.2.2 Strategy Description Block (Plain English)
Must include:
- What the strategy does (example):
  - “Trades BTCB within bounded rules to realize profit in USDT”
- Where it trades:
  - PancakeSwap + BiSwap (BNB Chain)
- What profit means:
  - realized USDT after fees + gas
- What it never does:
  - no leverage
  - no borrowing
  - no insurance
  - no guaranteed return

---

#### 6.2.3 Risk Disclosure Block (Non-negotiable)
Must include explicit bullet list:
- You can lose money
- YieldLoop can sit idle for long periods
- Price movements can result in drawdowns
- Fees can reduce profits
- Oracle / venue issues may pause execution
- Contract risk exists (even after audit)

---

#### 6.2.4 “How Profit Is Created” Block
Must contain:
- Profit only exists when realized to stablecoin
- If no safe trade exists, nothing happens
- Guardrails can block trades even if user wants action
- Claims are limited to realized profit (not principal)

---

#### 6.2.5 Fee Summary (User-visible)
Must display:
- performance fee %
- when fees are charged (only upon realized profit)
- where fee goes (split summary)
- warning: discounts may apply for Supporter Badge / referral / etc.

---

#### 6.2.6 Guardrail Overview (User-visible)
Must show:
- a list of guardrails (not the full numeric internals in Normie mode)
Examples:
- Minimum net profit check
- Max drawdown protection
- Oracle sanity check
- Venue mismatch protection
- Max slippage rejection
- Volatility rejection (if configured)
- Emergency pause

Each guardrail item must have:
- “What it protects”
- “What happens when it triggers” (trade blocked, vault pauses, etc.)

---

#### 6.2.7 Confirmation Checkbox Set (Mandatory)
Before enabling Accept, user must tick:

- [ ] “I understand this is not financial advice.”
- [ ] “I understand I can lose money.”
- [ ] “I understand profits are realized-only and may be idle.”
- [ ] “I understand execution begins only after acceptance.”
- [ ] “I approve this strategy to operate under these rules.”

**Rule:** No checkbox → no Accept.

---

### 6.3 Strategy Preview Advanced Panel
Advanced view must show:

- Full strategy configuration snapshot:
  - allowed tokens
  - allowed venues
  - risk-tier bounds
  - max slippage
  - min net profit threshold
  - oracle requirements
  - max trade frequency
- deterministic references:
  - config hash
  - contract version
  - UI version

---

### 6.4 Strategy Preview Required Outputs (On acceptance)
When user accepts, UI must store / display:
- acceptance timestamp
- acceptance tx hash
- config hash accepted
- vault state transition receipt

---

### 6.5 Strategy Preview Hard Rules
- cannot be abridged
- cannot be replaced with “terms link”
- cannot be hidden behind small print
- must be scrollable with a “Read to end” gating option (recommended)
- must be screenshot-friendly (legal defense)

---

## Section 7 — Accept / Decline Gate UX (Mandatory)

This defines the vault activation gate behavior.

---

### 7.1 Accept / Decline Screen Behavior
This can be integrated at bottom of Strategy Preview or separated as its own screen.

Required components:
- “Accept Strategy” button
- “Decline Strategy” button
- “Back” link
- warnings

---

### 7.2 Accept Flow
When user taps **Accept Strategy**:
1) UI verifies:
   - wallet connected
   - correct chain
   - vault is pending acceptance
2) UI opens tx confirmation modal:
   - summary of what acceptance means
   - show config hash + immutable rules
3) User signs tx

After tx confirmation:
- show success banner:
  - “Vault activated”
- new vault state:
  - `ACTIVE` (or `READY_FOR_EXECUTION`)
- direct user to:
  - Vault Dashboard

**Rule:** If acceptance tx fails:
- vault remains pending
- UI must not show “active”

---

### 7.3 Decline Flow (Must Exist and Be Safe)
Decline must allow the user to:
- stop the vault from executing
- withdraw principal safely (subject to protocol design)
- avoid being “stuck”

Decline action must:
- set vault state to `DECLINED`
- require a tx signature
- display receipt

After Decline:
- user sees next step:
  - Withdraw Principal (if allowed)
  - Or “Vault closed”
  - Or “Funds remain idle in vault” if system design requires manual unwind

**Rule:** Decline cannot be a trap.  
It must be a clean exit.

---

### 7.4 Acceptance Invariants
- Accept can only happen once per vault creation.
- Accept binds the vault to the config snapshot.
- User cannot accept a different strategy without creating a new vault (unless governance supports upgrade flows later).
- Acceptance must be irreversible except by closing the vault.

---

### 7.5 Edge Cases
UI must handle:
- User accepted but chain re-org / delayed confirmation:
  - show pending status until final
- User refreshes during acceptance:
  - show state persists correctly
- User declines but execution already occurred (should not happen):
  - UI must show “Incident” banner and point to receipts/logs

---

## Section 8 — Vault Dashboard (Complete Screen Specification)

This is the main operational screen users live inside.

---

### 8.1 Vault Dashboard Entry Points
- Vaults list → click vault
- Deposit success → View Vault
- Notifications → View Vault

---

### 8.2 Vault Dashboard Must Contain 6 Panels (Always)

1) Vault Overview (top)
2) Profit + Claim Panel
3) Vault State + Execution Status Panel
4) Performance Visualization Panel
5) Activity Log Panel
6) Settings Panel (Compounding + Program perks)

---

### 8.3 Vault Overview Panel (Top Panel)
Must show:
- Vault ID
- Vault status badge:
  - Pending Acceptance
  - Active
  - Paused
  - Idle
  - Declined
  - Closing
  - Closed
- Deposit asset + deposit amount
- Risk level
- Strategy name
- Strategy config hash (advanced)
- Created date/time
- Accepted date/time (if accepted)

---

### 8.4 Profit + Claim Panel (Primary CTA Region)
This is the money panel. Must be instantly clear.

Must show 4 balances:
- **Principal**
- **Inventory Exposure** *(optional, advanced label)*
- **Realized Profit**
- **Claimable Profit**

Plus:
- **Claim Button** (primary)
- **Claim History** link

Rules:
- claimable must never exceed realized
- realized must never include principal
- claim button disabled if claimable = 0

---

### 8.5 Vault State + Execution Status Panel
Must show:
- current state label (string)
- “Last execution attempt” timestamp
- “Last successful execution” timestamp
- “Next eligible attempt” (if keeper schedule known)
- “Current guardrail posture” (Safe / Caution / Blocked)

If blocked:
- show last reject reason:
  - code + explanation

---

### 8.6 Performance Visualization Panel
Normie view:
- line chart: “Total Vault Value”
- line chart: “Realized Profit (cumulative)”

Advanced view:
- separate chart of:
  - principal
  - realized profit
  - claimed profit
  - compounded profit

**Rule:** Charts must label what is realized vs projected.

---

### 8.7 Activity Log Panel (Audit Trail)
Must list:
- deposits
- acceptance event
- executed trades (summary level)
- profit realized events
- claims
- guardrail rejections (at least last N)

Each entry must include:
- timestamp
- event type
- short description
- tx hash link

---

### 8.8 Settings Panel (Vault-level controls)
Must allow:
- change compounding % (if allowed mid-cycle; if not allowed: show read-only + tooltip)
- view selected risk level (read-only once accepted)
- display Supporter status (badge + discount)
- display referral code status

If protocol forbids edits mid-cycle:
- show disabled controls with:
  - “Locked until next cycle”
  - “Create new vault for different settings”

---

### 8.9 Guardrail Transparency Drawer (Must Exist)
A “Why idle?” button must open a drawer showing:

- last 10 execution attempts
- for each attempt:
  - timestamp
  - allowed vs blocked
  - reject reason code (if blocked)
  - net profit check result (pass/fail)
  - oracle check (pass/fail)

This prevents FUD and improves trust.

---

### 8.10 Vault Dashboard Invariants
- Must always reflect on-chain truth.
- Must never show “profit” that is not realized.
- Must separate principal and profit at all times.
- Must allow user to find claim button within 1 second.
- Must show exact vault state label.

---

## Section 9 — Claim / Withdraw UX (Full Flow + Receipts)

This section defines claiming rewards (profit) and withdrawing principal (if/when enabled).  
It must be crystal-clear, instant to find, and impossible to misunderstand.

---

### 9.1 Claim Entry Points (Required)
User can initiate Claim from:
- Vault Dashboard (primary CTA)
- Vaults List (quick action if claimable > 0)
- Notifications (“Profit realized → claim available”)

**Rule:** Claim must never be buried.

---

### 9.2 Claim Panel (Vault Dashboard) Requirements
The Claim panel must show:

#### 9.2.1 Balances (must be displayed simultaneously)
- **Claimable Profit** (USDT)
- **Realized Profit** (USDT)
- **Claimed Profit** (USDT)
- **Lifetime Fees Paid** (USDT)

Also show:
- last claim timestamp
- claim count
- average claim size (optional)

---

### 9.3 Claim Flow (Step-by-Step)
When user taps **Claim**:

#### Step 1 — Claim Modal Opens
Modal must show:
- Vault ID
- Claimable Amount
- Destination wallet address
- Reward handling summary:
  - % compounded
  - % withdraw

**If user compounding is enabled (e.g., 50% or 100%), modal must show:**
- “You will receive X USDT now”
- “Y USDT will remain in vault as compounded profit”

---

#### Step 2 — Confirm + Execute Transaction
Buttons:
- “Confirm Claim”
- “Cancel”

On confirm:
- wallet tx prompt
- UI shows tx status

---

#### Step 3 — Claim Results Screen
After tx confirms:
- Success state must display:
  - claimed amount
  - tx hash link
  - updated balances
- Primary CTA:
  - “Back to Vault”
- Secondary:
  - “View Receipt”

---

### 9.4 Claim Receipts (Audit Requirements)
Every claim must generate:
- receipt card in Activity Log
- receipt in Claim History table

Each row includes:
- date/time
- amount claimed
- amount compounded
- fees charged (if any)
- tx hash link

---

### 9.5 Claim Fail States (Must Cover)
UI must explicitly handle:

#### 9.5.1 Claimable = 0
- disable claim button
- tooltip:
  - “No realized profit available to claim”

#### 9.5.2 Vault Not Active
If vault is:
- Pending Acceptance
- Declined
Then:
- Claim disabled
- reason shown

#### 9.5.3 Contract Revert / Failure
Display:
- “Claim failed”
- reason (if available)
- safe retry guidance

#### 9.5.4 Gas Insufficient
Display:
- “Insufficient BNB for gas”
- estimated needed
- how to fix

---

### 9.6 Withdraw Principal UX (If supported)
If protocol supports principal withdrawal:
- it must be separate from Claim
- it must be treated like a “vault close / exit” action

Required features:
- “Withdraw Principal” button
- must display:
  - current principal
  - any lock rules
  - any cooldown
  - any risk warnings (“may require unwind”)

---

### 9.7 Withdraw Principal Flow
When user taps Withdraw Principal:

#### Step 1 — Exit Modal
Modal must show:
- Vault ID
- principal amount
- expected receive amount
- statement:
  - “This closes the vault”
- disclosure:
  - “If funds are in inventory, protocol will unwind first”

Buttons:
- “Request Exit”
- “Cancel”

#### Step 2 — Exit Status Screen
Exit may be instant or staged.

UI must show:
- Exit Status:
  - REQUESTED
  - UNWINDING
  - READY
  - COMPLETED
- “Unwind receipts” list if applicable
- “Withdraw now” button if staged withdrawal is required

---

### 9.8 Claim/Withdraw Invariants
- Claim can never touch principal.
- Withdraw principal cannot “invent profit.”
- All actions must produce receipts.
- Claim must remain available regardless of whether system is actively trading.

---

## Section 10 — Compound Controls UX (Rules, Locks, Boundaries)

Compounding is the “profit routing preference.”  
It must be dead simple for normies and deterministic for devs.

---

### 10.1 Compounding Control Locations
Compounding % must be shown in:
- Deposit flow
- Strategy Preview
- Vault Dashboard settings
- Claim modal

---

### 10.2 Compounding Slider Requirements
The compounding selector must be:
- slider 0% → 100%
- preset buttons 0 / 50 / 100
- plain-language explanation underneath

Text must map exactly:
- **0%:** withdraw all rewards
- **50%:** withdraw half, compound half
- **100%:** compound all rewards

---

### 10.3 Compounding Change Rules (Critical)
Protocol may enforce one of these models:

#### Model A — Locked per cycle
- compounding % chosen at deposit
- locked until cycle end

#### Model B — Editable until claim
- editable anytime
- applied to next realized profit routing

#### Model C — Editable but gated
- editable only at specific checkpoints

**UI must reflect the actual protocol rule truthfully.**
If locked:
- slider disabled
- label: “Locked until end of cycle”
- primary CTA: “Create New Vault with New Settings”

---

### 10.4 Compounding Change Flow (If editable)
When user changes compounding %:
- UI prompts:
  - “This changes how future profit is routed.”
- requires tx signature if stored on-chain
- confirmation receipt required

---

### 10.5 Compounding Display Rules
Compounding should never be shown as:
- a “profit booster”
- a yield multiplier
- a guarantee

It must be shown as:
- routing preference for realized profit

---

### 10.6 Edge Cases
UI must handle:
- compounding = 100% and user expects USDT deposit into wallet
  - show “You will receive 0 USDT; all profits will be reinvested.”
- compounding changes during pending claim
  - must be disallowed or queued

---

### 10.7 Compounding Invariants
- cannot exceed bounds [0..100]
- must be displayed on every profit-related screen
- must be included in receipts:
  - claim receipts
  - profit realized receipts (optional)

---

## Section 11 — Supporter Presale + Badge UX (Genesis Program)

Supporter badge UX must not contaminate investing UX.  
It should feel like:
- a membership / contributor badge
- a discount entitlement layer
- a milestone marker

Not:
- a “pump” feature

---

### 11.1 Supporter/Genesis Goals
The UX must accomplish:
- explain contribution program
- show eligibility rules
- show benefits
- show badge status
- prove discount application transparently

---

### 11.2 Supporter Program Screen (Required)
Nav tab: **Supporter**

Must include:

#### 11.2.1 Program Overview Block
Plain language:
- why it exists (fund build + audit + liquidity)
- limited spots (e.g., first N wallets)
- what user gets (benefits list)

---

#### 11.2.2 Eligibility + Progress Block
Show:
- wallet status: Eligible / Not eligible / Already claimed
- remaining spots
- program end condition

---

#### 11.2.3 Benefits Block (Must be explicit)
Examples:
- lifetime performance fee discount for depositing wallet
- early access perks
- referral eligibility upgrades (if any)
- UI badge

**Critical:** Benefits must show exact application:
- “applies only to this wallet address”
- “transfer rules (if any)”
- “not retroactive unless defined”

---

#### 11.2.4 Purchase / Participate Block
If purchase exists:
- purchase button
- tx confirmation
- receipt

If it’s a “supporter deposit threshold” model:
- show threshold and progress
- show “you qualify after X”

---

### 11.3 Badge Placement Rules
Supporter badge must appear:
- wallet menu
- vault dashboard header
- fee breakdown areas

Badge must never appear as:
- a flashing ad
- “buy now” spam

---

### 11.4 Discount Proof UX
Whenever a fee applies:
- UI must show:
  - base fee
  - discount %
  - net fee
  - reason:
    - Supporter Badge
    - Deposit in YLP (if applicable)
    - Referral
    - Other program

**Rule:** If user gets discount, prove it every time it matters.

---

### 11.5 Transfer Rules UX (If badge transferable)
If badge can transfer:
- UI must explicitly explain:
  - if transfer kills discount on original wallet
  - if discount follows NFT/badge
  - how protocol verifies ownership

If badge cannot transfer:
- UI must state:
  - “Benefits are bound to wallet address.”

---

### 11.6 Supporter Program Invariants
- must not mislead as an investment contract
- must not imply guaranteed return
- must show transparent use of proceeds (optional but recommended)

---

## Section 12 — Referral Program UX (Qualification Timers, Caps, Rewards Ledger)

Referral UX must be:
- simple
- verifiable
- resistant to abuse
- not spammy

---

### 12.1 Referral Program Entry Points
- Nav: Referral
- Vault Dashboard (small referral card)
- Supporter screen (for Genesis users)

---

### 12.2 Referral Screen (Required)
Must include 5 blocks:

1) Your Referral Code / Link
2) Your Referral Stats
3) Reward Rules
4) Referral Ledger
5) Fraud & Abuse Warnings

---

### 12.3 Referral Link Block
Must show:
- referral code
- referral link (copy button)
- QR code (optional)
- “Share” button

Also show:
- “This code is bound to your wallet.”

---

### 12.4 Referral Qualification Rules Block (Critical)
Must clearly state:
- referral reward triggers only if:
  - the referred wallet deposits ≥ minimum
  - remains active for required time (e.g., 30 days)
- rewards may cap:
  - max rewards per month
  - max per wallet lifetime
- rewards paid in:
  - USDT deposit credit
  - or LOOP/YLP (whichever protocol uses)
  - must show exact token and accounting method

---

### 12.5 Referral Stats Block
Must show:
- total referred wallets
- qualified referrals
- pending referrals
- rejected referrals
- total rewards earned
- rewards pending

---

### 12.6 Referral Ledger (Must be verifiable)
Ledger table must include rows for each referral:

Columns:
- referred wallet (short form)
- deposit date
- qualification countdown timer
- qualification status:
  - PENDING
  - QUALIFIED
  - REJECTED
- reward amount
- reward payout date
- tx hash / receipt

---

### 12.7 Pending Qualification Timers (UX must reduce support tickets)
For each pending referral, show:
- “X days remaining to qualify”
- clear reason if not progressing:
  - deposit below threshold
  - vault declined
  - user withdrew early (if applicable)
  - protocol paused (optional)

---

### 12.8 Referral Reward Claiming UX
If rewards are auto-applied:
- show: “Auto credited to principal”
- receipt event

If rewards require claim:
- show “Claim Referral Rewards” CTA
- claim receipt log

---

### 12.9 Anti-Abuse UX (Required Warnings)
Must include:
- “self-referral disallowed”
- “sybil farming disallowed”
- “protocol may withhold rewards if abuse detected”
- “rewards are capped”

**Rule:** The UX must protect the protocol from being bled dry.

---

### 12.10 Referral Invariants
- rewards must be deterministic
- rewards must never be “promised” as profit
- the UI must never imply referral is required
- referral must not block core investing UX

---

## Section 13 — Full Screen Inventory (Complete Routes + Screens + States)

This section is the **master index** of every required screen so the frontend cannot “miss something.”

> If a screen is not in this list, it is not allowed to exist.
> If a screen *is* in this list, it must be built.

---

### 13.1 Global Screens (Always Accessible)

#### 13.1.1 `/` — Home (Protocol Overview)
Required blocks:
- Hero + CTAs
- Truth Rules Panel
- Live Protocol Metrics
- “How it works” mini-flow
- Why Idle disclosure
- Docs / addresses / audit links

States:
- Wallet disconnected
- Wallet connected
- Wrong chain
- Protocol paused banner

---

#### 13.1.2 `/docs` — Documentation Hub
Required:
- Whitepaper link
- Appendix link
- Dev handoff link
- contract addresses list
- version hashes

States:
- external link open failures
- “outdated version” warning (if UI > doc mismatch)

---

#### 13.1.3 `/status` — System Status (HMI Monitor)
Required:
- Protocol paused: yes/no
- Venue health (PCS/BiSwap)
- Oracle status
- Execution budget health (ECW)
- last execution timestamp
- incident banner / last known issue

States:
- All healthy
- Degraded (some guards triggered)
- Paused
- Emergency (hard stop)

---

#### 13.1.4 `/settings` — UI Preferences
Required:
- Normie / Advanced toggle
- Currency display mode
- Notification preferences (in-app)
- “Reset UI” button

---

### 13.2 Wallet / Auth Screens

#### 13.2.1 Global Modal: `Connect Wallet`
Required:
- MetaMask
- Trust Wallet
- WalletConnect

States:
- Connection refused
- Wallet unavailable
- Unsupported wallet

---

#### 13.2.2 Global Modal: `Switch Network`
Required:
- “Switch to BNB Chain”
- explanation of why

States:
- switch failed
- user rejected switch

---

### 13.3 Deposit + Vault Creation Screens

#### 13.3.1 `/deposit` — Deposit / Create Vault
Required:
- deposit amount input
- risk selector
- compounding slider
- approve step
- deposit step
- advanced panel toggle

States:
- Not connected
- Wrong chain
- No USDT
- No gas
- Approval required
- Approval pending
- Deposit pending
- Deposit confirmed
- Deposit reverted

---

#### 13.3.2 `/deposit/success/:vaultId` — Vault Created / Acceptance Required
Required:
- vault ID
- config snapshot
- CTA: review strategy

States:
- vaultId not found
- indexer delay (on-chain exists, UI not synced yet)

---

### 13.4 Strategy Preview + Acceptance Screens

#### 13.4.1 `/vault/:vaultId/preview` — Strategy Preview
Required blocks:
- vault summary
- strategy plain english
- risk disclosure
- profit definition
- fees summary
- guardrails overview
- checkbox confirmation set

States:
- Vault pending acceptance (normal)
- Vault already active (preview becomes read-only)
- Vault declined (read-only)
- Vault closed (read-only)

---

#### 13.4.2 `/vault/:vaultId/accept` — Accept / Decline Gate
Can be merged into preview, but route must exist.

Required:
- Accept CTA
- Decline CTA
- immutable config hash shown

States:
- tx pending
- tx success
- tx fail / revert

---

### 13.5 Vault Screens (Core Experience)

#### 13.5.1 `/vaults` — Vaults List
Required:
- list of vault cards:
  - status badge
  - claimable indicator
  - deposit amount
  - risk level
  - strategy name
- quick actions:
  - View Vault
  - Claim (if claimable > 0)
  - Accept (if pending acceptance)

States:
- no vaults
- indexer stale / retry

---

#### 13.5.2 `/vault/:vaultId` — Vault Dashboard (Primary)
Required panels:
1) Vault Overview
2) Profit + Claim
3) Vault State + Execution Status
4) Performance Visualization
5) Activity Log
6) Settings

States:
- Pending acceptance
- Active
- Idle
- Paused
- Declined
- Closing
- Closed

---

#### 13.5.3 `/vault/:vaultId/activity` — Vault Activity (Expanded)
Required:
- filters (claims / trades / rejects / deposits)
- event list with receipts
- “export CSV” optional (later)

States:
- no events yet
- indexer delay

---

#### 13.5.4 `/vault/:vaultId/guardrails` — Guardrail Transparency Drawer (Full Page)
Required:
- last N execution attempts
- each attempt:
  - allowed/blocked
  - reject reason code
  - net profit check pass/fail
  - oracle check pass/fail

States:
- no attempts yet
- system paused

---

### 13.6 Claim + Exit Screens

#### 13.6.1 Modal: `Claim Profit`
Required:
- claimable amount
- receive vs compound breakdown
- tx confirm + receipt link

States:
- claim blocked (0 claimable)
- tx fail

---

#### 13.6.2 `/vault/:vaultId/claims` — Claim History
Required:
- table of claims
- receipts
- totals

---

#### 13.6.3 Modal: `Exit / Withdraw Principal` *(if supported)*
Required:
- exit request
- unwind status
- withdraw receipt

States:
- exit request pending
- unwind pending
- ready to withdraw
- completed

---

### 13.7 Supporter / Genesis Screens

#### 13.7.1 `/supporter` — Supporter Program
Required:
- eligibility
- spots remaining
- benefits
- discount proof
- badge status

States:
- eligible
- not eligible
- purchased / active
- expired program

---

#### 13.7.2 `/supporter/receipt` — Supporter Receipt
Required:
- proof of participation
- benefit activation proof
- tx receipt

---

### 13.8 Referral Screens

#### 13.8.1 `/referral` — Referral Dashboard
Required:
- referral link + copy
- stats
- rules
- ledger

States:
- eligible / not eligible
- zero referrals
- pending qualification

---

#### 13.8.2 `/referral/ledger` — Referral Ledger (Expanded)
Required:
- full list
- qualification timers
- receipts
- claim reward button (if manual)

---

### 13.9 Error / Edge System Screens (Mandatory)

#### 13.9.1 `/error` — Global Error Page
Required:
- error type
- recovery options
- “Reset UI”
- link to status page

---

#### 13.9.2 `/unsupported` — Unsupported Browser / Wallet
Required:
- supported list
- recommended fix

---

#### 13.9.3 `/incident` — Incident Banner Detail
Required:
- what happened
- impact
- expected user action
- receipts or reference

---

## Section 14 — Full Vault State Machine → UI Behavior Mapping

This section makes the UI deterministic.
Each vault state has:
- allowed actions
- disallowed actions
- required banners
- which CTAs appear

> The UI must not guess.
> The UI must reflect exact vault state labels.

---

### 14.1 Core Vault States (Canonical)

The UI must support at minimum:

1) `PENDING_ACCEPTANCE`
2) `ACTIVE`
3) `IDLE`
4) `PAUSED_GUARDRAIL`
5) `PAUSED_PROTOCOL`
6) `DECLINED`
7) `EXIT_REQUESTED`
8) `UNWINDING`
9) `READY_TO_WITHDRAW`
10) `CLOSED`

If your contracts use different labels, UI must map them deterministically.

---

### 14.2 State-by-State UX Definition

#### 14.2.1 `PENDING_ACCEPTANCE`
Meaning:
- vault exists
- execution is forbidden

Required UI:
- banner: “Execution cannot begin until you accept.”
- primary CTA: **Review Strategy**
- secondary CTA: Accept / Decline

Allowed actions:
- Accept strategy
- Decline strategy
- view details

Disallowed:
- claim (should be zero)
- execution feed claims like “running”

---

#### 14.2.2 `ACTIVE`
Meaning:
- vault accepted
- eligible to trade subject to guardrails

Required UI:
- “Active” badge
- status panel: “Eligible for execution”
- show last attempt timestamp

Allowed:
- claim
- view activity
- adjust compounding (only if permitted)
- request exit (if supported)

Disallowed:
- changing risk tier
- switching strategy (unless upgrade mechanism exists)

---

#### 14.2.3 `IDLE`
Meaning:
- active vault, but currently no safe/profitable execution path

Required UI:
- “Idle (by design)” badge
- explanation: conservative guardrails are blocking trades
- CTA: “Why idle?” → guardrail drawer

Allowed:
- claim
- remain active (do nothing)

Disallowed:
- “force trade”
- “higher risk now” inside same vault

---

#### 14.2.4 `PAUSED_GUARDRAIL`
Meaning:
- vault is temporarily stopped due to safety triggers

Required UI:
- red banner:
  - “Paused for safety.”
  - show trigger reason code
- instructions:
  - “No action required unless you want to exit.”

Allowed:
- claim (if claimable)
- request exit
- view reject feed

Disallowed:
- acceptance changes (already active)
- deposit modifications

---

#### 14.2.5 `PAUSED_PROTOCOL`
Meaning:
- entire protocol paused (admin/governance/emergency)

Required UI:
- global banner across all pages
- in vault:
  - “Protocol paused. No execution will occur.”
- link to System Status / Incident detail

Allowed:
- read-only views
- claims (only if contract allows)
- exit request (if contract allows)

Disallowed:
- deposits
- acceptance
- any action requiring execution

---

#### 14.2.6 `DECLINED`
Meaning:
- user declined strategy
- vault will not execute

Required UI:
- banner:
  - “Declined. This vault will never execute.”
- primary CTA:
  - “Withdraw principal” (if supported)
  - or “Close Vault”

Allowed:
- exit / close

Disallowed:
- accept after decline (unless explicitly supported)

---

#### 14.2.7 `EXIT_REQUESTED`
Meaning:
- user requested withdrawal
- system preparing

Required UI:
- progress indicator
- estimated steps:
  - unwind → ready → withdraw

Allowed:
- view status
- cancel exit (if allowed)

Disallowed:
- new strategy acceptance
- compounding changes

---

#### 14.2.8 `UNWINDING`
Meaning:
- protocol unwinding inventory to return principal

Required UI:
- “Unwinding exposure”
- list unwind tx receipts

Allowed:
- wait
- view receipts

Disallowed:
- claim if claimable not defined during unwind (depends on protocol)

---

#### 14.2.9 `READY_TO_WITHDRAW`
Meaning:
- principal is available for withdrawal

Required UI:
- huge CTA: **Withdraw Now**
- show exact receive amount

Allowed:
- withdraw
- export receipts

---

#### 14.2.10 `CLOSED`
Meaning:
- vault finalized

Required UI:
- “Closed” badge
- readonly history
- final totals:
  - deposited
  - realized profit
  - claimed
  - fees

Allowed:
- view history only

Disallowed:
- all actions

---

### 14.3 UI Action Matrix (Hard Gate Table)

Each vault state must programmatically enable/disable actions:

Actions:
- Deposit more
- Accept
- Decline
- Claim
- Change Compounding
- Request Exit
- Withdraw Principal

**Rule:** Must be computed only from vault state + protocol flags.

---

### 14.4 Required Global Protocol Flags (UI must respect)
In addition to vault state, UI must respect:
- `protocolPaused`
- `depositsEnabled`
- `claimsEnabled`
- `exitEnabled`

UI must display:
- whether restriction is vault-level or system-level

---

## Section 15 — Guardrail Reject Code UX Glossary (Code → Meaning → User Action)

This section prevents 80% of support tickets, panic, and “is this broken?” FUD.

The UI must treat **guardrail rejections as normal operation**, not as failures.

### 15.1 Guardrail Reject UX Standards (Non-negotiable)

#### 15.1.1 Rejects are not errors
A reject reason means:
- the vault attempted execution
- the system blocked it for safety/profit integrity
- funds remain safe
- **no action required**

Therefore:
- Rejects are displayed under **Execution Feed**
- Errors are displayed under **Transaction Failures**
- These are not the same category

---

#### 15.1.2 Every reject reason must have:
UI must show all 3:
1) **Code**
2) **Plain English Explanation**
3) **What you should do**

---

#### 15.1.3 No “mystery rejects”
Forbidden UI:
- “Execution failed”
- “Reverted”
- “Try again later”

Allowed UI:
- “Trade blocked: slippage exceeded safe limit”

---

### 15.2 Reject Code Schema (Developer Contract)

The UI must store/display rejection reasons using a stable enum-like mapping.

**Required fields returned to UI (from indexer or view calls):**
- `timestamp`
- `vaultId`
- `attemptId` *(incrementing counter)*
- `decision` = ALLOWED | BLOCKED
- `rejectCode` *(if blocked)*
- `rejectDetail` *(optional string)*
- `oracleOk` true/false
- `netProfitOk` true/false

---

### 15.3 Canonical Reject Codes (MVP Complete Set)

> This list is intentionally oversized.
> You won’t implement every guardrail in MVP1, but the UI must be able to display all of them cleanly.

---

#### GR-001 — PROTOCOL_PAUSED
**Meaning:** Global pause is active (admin/governance/emergency).
**UI Explanation:** “YieldLoop is paused. No execution can occur right now.”
**User Action:** Do nothing. You can still view vault data. Claims/exits only if enabled.

---

#### GR-002 — VAULT_NOT_ACTIVE
**Meaning:** Vault not eligible (pending acceptance / declined / closed).
**UI Explanation:** “This vault is not active, so no execution can occur.”
**User Action:** Accept strategy (if pending), or exit/close vault.

---

#### GR-003 — STRATEGY_VERSION_NOT_ALLOWED
**Meaning:** Config hash is outdated or no longer allowed.
**UI Explanation:** “This vault’s strategy config is not allowed under current protocol rules.”
**User Action:** Create a new vault with current config (or wait for governance guidance).

---

#### GR-010 — ORACLE_STALE
**Meaning:** Oracle data too old / unsafe.
**UI Explanation:** “Price oracle is stale. Execution is blocked to prevent manipulation.”
**User Action:** Do nothing. Wait.

---

#### GR-011 — ORACLE_DEVIATION_TOO_HIGH
**Meaning:** Spot price deviates too far from oracle/TWAP.
**UI Explanation:** “Price mismatch detected. Trade blocked for safety.”
**User Action:** Do nothing. Wait.

---

#### GR-012 — ORACLE_INVALID
**Meaning:** Oracle returned invalid data.
**UI Explanation:** “Oracle data invalid. Execution blocked.”
**User Action:** Wait. Check Status page.

---

#### GR-020 — VENUE_UNAVAILABLE
**Meaning:** PCS or BiSwap route failed or unavailable.
**UI Explanation:** “Trading venue unavailable or unstable.”
**User Action:** None. System retries later.

---

#### GR-021 — ROUTER_REVERT
**Meaning:** Swap simulation/quote reverted.
**UI Explanation:** “Trade simulation failed. Execution blocked.”
**User Action:** None.

---

#### GR-030 — SLIPPAGE_TOO_HIGH
**Meaning:** Expected slippage exceeds safe bound.
**UI Explanation:** “Slippage too high. Trade would be unsafe.”
**User Action:** None. This is normal during volatility/low liquidity.

---

#### GR-031 — PRICE_IMPACT_TOO_HIGH
**Meaning:** Trade would move market too much.
**UI Explanation:** “Trade size would cause excessive price impact.”
**User Action:** None. This often resolves when liquidity improves.

---

#### GR-032 — LIQUIDITY_TOO_LOW
**Meaning:** LP depth insufficient for safe execution.
**UI Explanation:** “Liquidity too low. Trade blocked.”
**User Action:** None.

---

#### GR-040 — MIN_NET_PROFIT_NOT_MET
**Meaning:** Net profit after fees + gas is below threshold.
**UI Explanation:** “Trade is not profitable enough after costs.”
**User Action:** None. YieldLoop does nothing unless net positive.

---

#### GR-041 — GAS_COST_TOO_HIGH
**Meaning:** Gas cost makes execution unprofitable.
**UI Explanation:** “Gas cost too high. Trade blocked.”
**User Action:** None.

---

#### GR-042 — FEES_EXCEED_PROFIT
**Meaning:** Venue fees would negate profit.
**UI Explanation:** “Fees exceed profit. Trade blocked.”
**User Action:** None.

---

#### GR-050 — VOLATILITY_TOO_HIGH
**Meaning:** Current market volatility exceeds configured max.
**UI Explanation:** “Volatility too high. Execution paused for safety.”
**User Action:** None.

---

#### GR-051 — DRAWDOWN_CAP_RISK
**Meaning:** Trade risks exceeding drawdown limit.
**UI Explanation:** “Drawdown protection triggered. Trade blocked.”
**User Action:** None.

---

#### GR-060 — MAX_TRADES_PER_WINDOW
**Meaning:** Too many trades in time window; throttle active.
**UI Explanation:** “Trade rate limited to reduce risk and costs.”
**User Action:** None.

---

#### GR-061 — COOLDOWN_ACTIVE
**Meaning:** Vault cooling down after previous action.
**UI Explanation:** “Cooldown active. Next attempt later.”
**User Action:** None.

---

#### GR-070 — EXECUTION_BUDGET_LOW
**Meaning:** Not enough gas/execution funds available.
**UI Explanation:** “Execution budget low. Trading paused until replenished.”
**User Action:** None. Check System Status.

---

#### GR-071 — EXECUTION_BUDGET_LOCK
**Meaning:** Budget is reserved for higher priority actions.
**UI Explanation:** “Execution budget reserved. Your vault will retry later.”
**User Action:** None.

---

#### GR-080 — TOKEN_NOT_ALLOWED
**Meaning:** Token outside allowlist for tier/version.
**UI Explanation:** “Token not allowed under current rules.”
**User Action:** None (system-level). Create new vault if needed.

---

#### GR-081 — VENUE_NOT_ALLOWED
**Meaning:** Venue excluded by governance.
**UI Explanation:** “Venue disabled by protocol configuration.”
**User Action:** None.

---

#### GR-090 — RISK_TIER_LOCKED
**Meaning:** Risk tier cannot be changed mid-cycle/vault.
**UI Explanation:** “Risk tier locked. Cannot change in this vault.”
**User Action:** Create a new vault.

---

#### GR-091 — COMPOUNDING_LOCKED
**Meaning:** Compounding % locked until cycle end.
**UI Explanation:** “Compounding locked until cycle end.”
**User Action:** Wait or create new vault.

---

#### GR-100 — EMERGENCY_LOCKDOWN
**Meaning:** Extreme emergency mode (exploit risk).
**UI Explanation:** “Emergency lockdown. Protocol protecting funds.”
**User Action:** Follow incident instructions. No action usually required.

---

### 15.4 Reject Code Display Rules

#### 15.4.1 Primary display format
In execution feed:
- `BLOCKED (GR-040): Minimum net profit not met`
- subtext:
  - “YieldLoop does nothing unless net positive after all costs.”

#### 15.4.2 Severity color bands
- INFO: throttle/cooldown
- WARNING: oracle/volatility
- CRITICAL: emergency/pause

#### 15.4.3 “What should I do?” must be short
Most actions:
- “Do nothing. System will retry automatically.”

Sometimes:
- “Accept strategy.”
- “Create a new vault.”
- “Withdraw principal.”

---

### 15.5 Guardrail Drawer Screen Spec
For `/vault/:vaultId/guardrails`:
- filter dropdown:
  - “All attempts”
  - “Blocked only”
  - “Allowed only”
- table with columns:
  - attemptId
  - time
  - decision
  - reject code
  - explanation
  - receipts

---

## Section 16 — Admin / Operator HMI (Governance Controls + Keeper Panel + Emergency Actions)

This section defines the internal console for operating the protocol.

> This is not a “nice to have.”
> A trading protocol without an HMI is a liability.

### 16.1 Admin HMI Access Rules

#### 16.1.1 Access gating (mandatory)
Admin panel must require:
- admin wallet allowlist
- network = BNB Chain
- explicit “Admin Mode” toggle
- warning banner:
  - “Admin actions affect user funds.”

#### 16.1.2 Read vs Write separation
Admin HMI must have two modes:
- **Read-Only Monitor Mode**
- **Write Mode (requires extra confirmation + signature)**

---

### 16.2 Admin Navigation (Required Tabs)
1) Overview
2) Protocol Flags
3) Config Manager
4) Guardrails
5) Venue Health
6) Oracle Monitor
7) Keeper Console
8) Incident Console
9) Vault Inspector
10) Program Manager (Supporter / Referral)

---

### 16.3 Overview Dashboard (Admin)
Must show:
- protocol status: RUNNING / PAUSED / LOCKDOWN
- active vault count
- total TVL
- total realized profit
- execution attempt rate
- rejection rate
- top reject codes (24h)
- keeper last heartbeat
- oracle freshness
- venue route success %

---

### 16.4 Protocol Flags Panel
Admin must control flags:
- `protocolPaused`
- `depositsEnabled`
- `claimsEnabled`
- `exitEnabled`
- `newVaultsEnabled`
- `keeperEnabled`

Each flag must show:
- current value
- last change timestamp
- changed by address
- tx receipt link

**Rule:** No silent toggles.

---

### 16.5 Config Manager Panel (Strategy Versioning)
This controls:
- current config hash
- allowlist of config hashes
- deprecation of old configs

UI must show:
- config hash list
- risk tier definitions per version
- activation date per config
- rollback ability (if allowed)

---

### 16.6 Guardrails Panel (Numeric Parameters + Bounds)
Must include:

#### 16.6.1 Guardrail groups
- Profit integrity
- Oracle safety
- Slippage/impact
- Volatility/drawdown
- Throttles
- Budget controls
- Emergency

#### 16.6.2 Each guardrail has:
- current value
- allowed range (hard bounds)
- last updated
- reason/comment field (required on change)

**Rule:** Governance cannot set suicidal values.
Hard bounds must be enforced at contract level and displayed here.

---

### 16.7 Venue Health Panel
Show per venue:
- route test status
- failure rate
- quote latency
- last successful swap
- blacklisted pairs/tokens

---

### 16.8 Oracle Monitor Panel
Show:
- oracle sources
- TWAP windows
- deviation thresholds
- stale thresholds
- last update times
- “panic reject” count

---

### 16.9 Keeper Console (Operations HMI)
This is the engine room.

Must show:
- keeper status: online/offline
- keeper wallet + balance
- keeper job queue
- last N keeper actions
- per vault:
  - last attempt
  - result
  - reason

Must support actions:
- `attemptExecute(vaultId)` *(manual retry)*
- `settle(vaultId)` *(if settlement exists)*
- `pauseVault(vaultId)` *(if supported)*
- `resumeVault(vaultId)` *(if supported)*

**Rule:** Manual actions must be logged and visible.

---

### 16.10 Incident Console
When things go wrong:
- admin must be able to publish an incident banner (UI-visible):
  - title
  - what happened
  - impact
  - what users should do
  - timestamp
- link to tx receipts or relevant chain proof

This connects:
- `/incident` screen in user UI
- status banners

---

### 16.11 Vault Inspector (Admin Search Tool)
Admin must be able to search:
- by vaultId
- by wallet address
- by state
- by last action time

Inspect:
- full vault internal state
- config hash
- acceptance record
- claimable balances
- last N rejects
- active inventory exposure (advanced)

---

### 16.12 Program Manager Panel (Supporter + Referral)

#### 16.12.1 Supporter controls
- program active yes/no
- max wallets
- eligibility rule
- benefit rule display
- badge registry

#### 16.12.2 Referral controls
- program active yes/no
- min deposit threshold
- qualification hold time
- cap per wallet per month
- reward type
- anti-abuse toggles

---

### 16.13 Admin HMI Confirmation UX (Absolute requirement)
Every write action must require:
- confirmation modal
- typed confirmation phrase:
  - e.g. “PAUSE_PROTOCOL”
- summary of impact
- signature request

---

### 16.14 Admin Audit Trail (Must Exist)
Admin panel must display:
- full change log
- exportable CSV
- immutable receipts

---

Section 17 — UI Data Model Specification (Fields, Types, Indexer Schema)

This section tells the frontend/dev team exactly what data objects exist, what fields they contain, and what the UI is allowed to display.

Hard rule:
If the UI cannot get a field deterministically (contract call, event log, or indexer), then the UI must either:
	•	label it as Estimated, or
	•	not display it at all

⸻

17.1 Data Sources (Ranked by Truth Level)

Source A — On-chain Contract Reads (Highest trust)
Examples:
	•	getVault(vaultId)
	•	getVaultState(vaultId)
	•	getClaimable(vaultId)
	•	getVaultConfigHash(vaultId)

Rule: If the UI is unsure, contract reads override everything.

⸻

Source B — On-chain Events (Deterministic audit trail)
Examples:
	•	VaultCreated
	•	StrategyAccepted
	•	ExecutionAttempted
	•	ExecutionBlocked
	•	ProfitRealized
	•	Claimed
	•	ExitRequested
	•	VaultClosed

Rule: Events are truth — but indexing can lag.

⸻

Source C — Indexer/Subgraph/Backend Aggregator (Convenience layer)
Examples:
	•	charts
	•	last 30 days realized totals
	•	top reject codes
	•	vault timelines

Rule: If indexer is behind/stale, UI must show:
	•	“Indexing…” or “Syncing…”
	•	and must not fabricate totals

⸻

17.2 Canonical Objects (UI Types)

This is the minimum complete set of objects the UI must support.

17.2.1 Wallet Context
Represents the connected session.

Fields:
	•	connected (boolean)
	•	address (string)
	•	chainId (number)
	•	chainName (string)
	•	provider (string: MetaMask / WalletConnect / TrustWallet / Other)
	•	bnbBalance (raw + formatted)
	•	usdtBalance (raw + formatted)
	•	usdtAllowance (raw + formatted)
	•	lastUpdatedTs (timestamp)

UI rules:
	•	if disconnected: all money actions disabled
	•	if wrong chain: all money actions disabled + Switch Network CTA

⸻

17.2.2 Protocol Flags
Controls global UX gating.

Fields:
	•	protocolPaused
	•	depositsEnabled
	•	claimsEnabled
	•	exitEnabled
	•	keeperEnabled
	•	newVaultsEnabled
	•	incidentActive
	•	incidentId (optional)
	•	updatedBy (optional)
	•	updatedAtTs

UI rules:
	•	protocolPaused triggers global banner everywhere
	•	depositsEnabled false disables Deposit CTA everywhere
	•	claimsEnabled false disables Claim CTA with “Claims paused by protocol”

⸻

17.2.3 Vault Summary
Minimum vault record required to render:
	•	vault cards
	•	vault list
	•	quick actions

Fields:
	•	vaultId
	•	ownerAddress
	•	createdAtTs
	•	acceptedAtTs (optional)
	•	state (canonical string)
	•	stateLabel (human-readable)
	•	depositAsset (USDT)
	•	depositAmountRaw
	•	depositAmountUI
	•	riskTier
	•	strategyName
	•	configHash
	•	contractVersion
	•	uiVersion
	•	principalRaw
	•	realizedProfitRaw
	•	claimableRaw
	•	claimedRaw
	•	compoundingBps (0–10000)
	•	compoundingPctUI (0–100)

⸻

17.2.4 Vault Detail
Full vault dashboard data.

VaultDetail = VaultSummary + the following:

Fields:
	•	lastExecutionAttemptTs (optional)
	•	lastExecutionSuccessTs (optional)
	•	lastReject (RejectEvent optional)
	•	inventoryExposureRaw (optional)
	•	inventoryExposureUI (optional)
	•	feesPaidRaw
	•	feeDiscountBps (optional)
	•	feeDiscountReason:
	•	SUPPORTER
	•	YLP_DEPOSIT
	•	REFERRAL
	•	NONE
	•	exitStatus (optional)

⸻

17.3 Canonical Enums (UI Must Support All)

17.3.1 Vault State
Valid states:
	1.	PENDING_ACCEPTANCE
	2.	ACTIVE
	3.	IDLE
	4.	PAUSED_GUARDRAIL
	5.	PAUSED_PROTOCOL
	6.	DECLINED
	7.	EXIT_REQUESTED
	8.	UNWINDING
	9.	READY_TO_WITHDRAW
	10.	CLOSED

UI rules:
	•	UI must never invent a state label
	•	unknown state → show “UNKNOWN STATE” with warning and link to /status

⸻

17.3.2 Risk Tier
Valid tiers:
	•	ULTRA_LOW
	•	LOW
	•	MEDIUM
	•	HIGH
	•	UNRESTRICTED

UI rules:
	•	risk tier is immutable after acceptance (unless upgrade path exists)
	•	if user requests change, direct to “create new vault”

⸻

17.3.3 Reject Codes
UI must support at least these reject codes:
	•	GR-001 PROTOCOL_PAUSED
	•	GR-002 VAULT_NOT_ACTIVE
	•	GR-003 STRATEGY_VERSION_NOT_ALLOWED
	•	GR-010 ORACLE_STALE
	•	GR-011 ORACLE_DEVIATION_TOO_HIGH
	•	GR-012 ORACLE_INVALID
	•	GR-020 VENUE_UNAVAILABLE
	•	GR-021 ROUTER_REVERT
	•	GR-030 SLIPPAGE_TOO_HIGH
	•	GR-031 PRICE_IMPACT_TOO_HIGH
	•	GR-032 LIQUIDITY_TOO_LOW
	•	GR-040 MIN_NET_PROFIT_NOT_MET
	•	GR-041 GAS_COST_TOO_HIGH
	•	GR-042 FEES_EXCEED_PROFIT
	•	GR-050 VOLATILITY_TOO_HIGH
	•	GR-051 DRAWDOWN_CAP_RISK
	•	GR-060 MAX_TRADES_PER_WINDOW
	•	GR-061 COOLDOWN_ACTIVE
	•	GR-070 EXECUTION_BUDGET_LOW
	•	GR-071 EXECUTION_BUDGET_LOCK
	•	GR-080 TOKEN_NOT_ALLOWED
	•	GR-081 VENUE_NOT_ALLOWED
	•	GR-090 RISK_TIER_LOCKED
	•	GR-091 COMPOUNDING_LOCKED
	•	GR-100 EMERGENCY_LOCKDOWN

UI rules:
	•	unknown GR code → display “UNKNOWN GUARDRAIL CODE” and preserve raw string

⸻

17.4 Event Schema (Indexer Output)

UI needs an indexed event feed per vault and system-wide.

17.4.1 Shared Event Fields
Every event must include:
	•	eventType
	•	vaultId (if applicable)
	•	timestamp
	•	txHash
	•	chainId
	•	blockNumber

Optional:
	•	severity
	•	message
	•	structured fields depending on event

⸻

17.4.2 Event Types (Required)
System events:
	•	ProtocolPaused
	•	ProtocolUnpaused
	•	ConfigUpdated
	•	IncidentPublished

Vault events:
	•	VaultCreated
	•	StrategyAccepted
	•	StrategyDeclined
	•	ExecutionAttempted
	•	ExecutionBlocked (contains rejectCode)
	•	ExecutionSucceeded
	•	ProfitRealized
	•	Claimed
	•	ExitRequested
	•	UnwindStarted
	•	UnwindCompleted
	•	VaultClosed

UI rules:
	•	Activity Log is built entirely from this feed
	•	The Vault Dashboard must render correctly even with ONLY events

⸻

Section 18 — Component Library Specification (Buttons, Banners, Severity, States)

This section prevents inconsistent UI.
It defines standardized components so every state looks intentional and professional.

⸻

18.1 Component Categories (Required)

UI must have these component groups:
	1.	Buttons / CTAs
	2.	Status Badges
	3.	Banners
	4.	Modals
	5.	Drawers
	6.	Tables
	7.	Timeline / Feed
	8.	Charts
	9.	Toast Notifications
	10.	Empty / Loading / Error States

⸻

18.2 Standard Button Types (Do not invent new ones)

18.2.1 Primary CTA
Usage:
	•	Deposit
	•	Accept Strategy
	•	Claim
	•	Withdraw Principal

Rules:
	•	one per screen max
	•	must be disabled with explanation if blocked

⸻

18.2.2 Secondary CTA
Usage:
	•	View Vault
	•	Back
	•	Export receipts
	•	Why idle?

Rules:
	•	cannot initiate money movement

⸻

18.2.3 Danger CTA
Usage:
	•	Decline Strategy
	•	Exit Vault
	•	Emergency Withdraw (if exists)

Rules:
	•	must trigger a confirmation modal
	•	must show irreversible warning

⸻

18.2.4 Utility Button
Usage:
	•	Copy code
	•	View on BscScan
	•	Toggle advanced

⸻

18.3 Badge System (Canonical Labels)

Every vault must display exactly one badge.

Badges:
	•	Pending Acceptance
	•	Active
	•	Idle (by design)
	•	Paused (Guardrail)
	•	Paused (Protocol)
	•	Declined
	•	Exit Requested
	•	Unwinding
	•	Ready to Withdraw
	•	Closed

Rules:
	•	badge must match vault state
	•	badge must be readable on mobile

⸻

18.4 Banner Types (Global system truth)

18.4.1 Global Protocol Pause Banner
Text:
	•	“Protocol paused. Deposits/execution disabled.”

Must include:
	•	link to status
	•	link to incident detail if any

⸻

18.4.2 Vault-Level Pause Banner
Text:
	•	“Vault paused for safety.”
Must include:
	•	reject code
	•	explanation
	•	user action guidance

⸻

18.4.3 Incident Banner
Text:
	•	“Incident active: [title]”
Must include:
	•	impact summary
	•	user action
	•	timestamp

⸻

18.5 Modal Standards (Non-negotiable)

All money movement requires modals.

Required modals:
	•	Approve USDT
	•	Deposit Confirmation
	•	Accept Strategy Confirmation
	•	Decline Strategy Confirmation
	•	Claim Confirmation
	•	Exit/Withdraw Confirmation
	•	Admin Confirmation (separate)

Modal must always show:
	•	Vault ID (if applicable)
	•	expected outcome
	•	tx link after submission
	•	failure state

⸻

18.6 Drawer Standards (Transparency tools)

Drawers used for:
	•	Why Idle
	•	Guardrail feed
	•	Strategy config details

Rules:
	•	drawers cannot hide disclosure
	•	drawers must be deep-linkable (route exists)

⸻

18.7 Table Standards

Must exist for:
	•	Claim history
	•	Activity log
	•	Referral ledger
	•	Admin change log

Table columns must include:
	•	timestamp
	•	description
	•	tx hash link

⸻

18.8 Timeline / Feed Standards

Execution feed must show:
	•	Attempt ID
	•	decision: allowed/blocked
	•	reject reason if blocked
	•	timestamp
	•	receipt

⸻

18.9 Loading / Empty / Error States (Never blank screens)

Required patterns:

Loading:
	•	skeleton cards or spinner + “Syncing vault state…”

Empty:
	•	“No claims yet”
	•	“No execution attempts yet”

Error:
	•	“Unable to sync data”
	•	retry button
	•	link to /status

⸻

18.10 Visual Severity Standard

Every major event must map to severity:

Severity levels:
	•	INFO (normal)
	•	WARNING (risk)
	•	CRITICAL (emergency)

Rules:
	•	rejects like GR-040 are INFO (not failure)
	•	oracle/volatility are WARNING
	•	emergency lockdown is CRITICAL

---

Section 19 — Full Wireframe Pack (Text-Only Layout per Screen)

This section gives the dev team a complete “layout blueprint” for every screen.
No guessing. No missing blocks. No UX holes.

Wireframe Format Rules:
	•	Each screen lists blocks in exact top-to-bottom order.
	•	Each block contains: title, content, CTAs, states.
	•	“Advanced Mode” elements must be explicitly labeled.

⸻

19.1 Screen: Home (/)

Top Bar
	•	Logo (YieldLoop)
	•	Network badge
	•	Wallet connect / wallet dropdown
	•	Notifications icon
	•	Settings icon

Block 1 — Hero
	•	Title: “Non-custodial profit vaults. Realized profit only.”
	•	Subtext: “Deposit USDT. Accept strategy. Execute only when safe.”
	•	CTAs:
	•	Primary: Deposit USDT
	•	Secondary: View Vaults
	•	Utility: Read how profit works

Block 2 — YieldLoop Truth Rules (Always visible)
	•	Bullets:
	•	Profit is realized-only
	•	No guaranteed returns
	•	No insurance
	•	System may be idle for long periods
	•	Guardrails block unsafe trades

Block 3 — Live Metrics
	•	TVL
	•	Active vaults
	•	Total realized profit
	•	Total claimed profit
	•	Protocol state (Running / Paused)

Block 4 — How it Works (5-step clickable)
	1.	Deposit
	2.	Review strategy
	3.	Accept
	4.	Execute when safe
	5.	Claim anytime
Each step opens an info drawer.

Block 5 — Why idle?
	•	Short explanation
	•	CTA: Learn why the vault can idle

Block 6 — Programs (small, non-invasive)
	•	Supporter badge info snippet + link
	•	Referral snippet + link

Footer
	•	Docs links
	•	Contract addresses
	•	Audit status
	•	UI version + contract version
	•	BscScan shortcuts

States:
	•	Wallet disconnected: blocks show, money CTAs route to connect wallet
	•	Wrong chain: show switch network banner and disable money CTAs
	•	Protocol paused: global banner + deposit disabled

⸻

19.2 Screen: Vaults List (/vaults)

Header
	•	Title: “Your Vaults”
	•	CTAs:
	•	Primary: New Deposit
	•	Secondary: Learn how vaults work

Vault Card (repeat per vault)
	•	Vault ID (short format)
	•	Status badge
	•	Deposit amount
	•	Risk tier
	•	Compounding %
	•	Claimable amount (if >0)
	•	Last activity timestamp

CTAs on card:
	•	Primary: View Vault
	•	Secondary:
	•	Accept (if pending acceptance)
	•	Claim (if claimable > 0)
	•	View Activity

Empty State
	•	“No vaults yet.”
	•	CTA: Create your first vault

Indexer stale banner (if needed)
	•	“Syncing vault history…”

⸻

19.3 Screen: Deposit (/deposit)

Header
	•	Title: Create Vault

Block 1 — Deposit Inputs
	•	Deposit asset selector (default USDT)
	•	Amount input + Max
	•	Wallet balance shown
	•	Minimum deposit warning if below min

Block 2 — Risk Tier Selector
	•	Ultra Low / Low / Medium / High / Unrestricted
	•	Info tooltip: “What changes?”

Block 3 — Compounding Slider
	•	Slider 0–100
	•	Presets 0 / 50 / 100
	•	Plain English label for selection

Block 4 — Summary Box
	•	“You are creating a vault”
	•	Selected settings snapshot
	•	Estimated gas
	•	Fee disclosure
	•	Profit definition disclosure

Block 5 — Action Stepper
	•	Step 1: Approve USDT
	•	Step 2: Deposit + Create Vault

Advanced Toggle Drawer
	•	Config hash preview
	•	Allowed venues
	•	Guardrail posture description
	•	Oracle requirements summary

Fail States:
	•	not connected
	•	wrong chain
	•	insufficient USDT
	•	insufficient gas
	•	approval rejected
	•	tx revert

⸻

19.4 Screen: Deposit Success (/deposit/success/:vaultId)

Banner
	•	“Vault created. Acceptance required.”

Vault Summary Card
	•	Vault ID
	•	Deposit amount
	•	Risk tier
	•	Compounding %
	•	Strategy name
	•	Config hash (advanced)

CTAs
	•	Primary: Review Strategy Preview
	•	Secondary: Back to Vaults

⸻

19.5 Screen: Strategy Preview (/vault/:vaultId/preview)

Banner (Critical)
	•	“No execution occurs until you accept.”

Block 1 — Vault Snapshot
	•	Vault ID
	•	Deposit amount
	•	Risk tier
	•	Compounding %
	•	State: PENDING_ACCEPTANCE

Block 2 — Strategy Description
	•	Plain English: what it does, where it trades, what it never does

Block 3 — Profit Definition
	•	Realized-only rule
	•	Claimable vs principal

Block 4 — Risks
	•	List of explicit risk bullets

Block 5 — Fees
	•	Fee %
	•	When fees apply
	•	Discounts (if any)

Block 6 — Guardrails (overview)
	•	Top 8–12 guardrails
	•	Each with: protects, effect

Block 7 — Confirmation Checkboxes (Mandatory)
	•	5 required boxes

Block 8 — Acceptance Actions
	•	Primary: Accept Strategy
	•	Danger: Decline Strategy
	•	Utility: Back to Vault

Advanced Drawer:
	•	full config hash details
	•	numeric bounds tables
	•	oracle constraint details

⸻

19.6 Screen: Vault Dashboard (/vault/:vaultId)

Header
	•	Vault ID + copy
	•	Status badge
	•	Strategy name
	•	Risk tier
	•	Compounding %

Panel 1 — Balances
	•	Principal
	•	Realized profit
	•	Claimable profit
	•	Claimed profit lifetime

CTA:
	•	Primary: Claim (if claimable >0)

Panel 2 — Vault State / Execution
	•	Last attempt
	•	Last success
	•	Current posture: Safe / Blocked / Paused
	•	Last reject reason (if any)

CTA:
	•	Why idle? (opens guardrail drawer)

Panel 3 — Performance
	•	chart: vault value
	•	chart: realized profit

Panel 4 — Activity Log
	•	10 latest events with receipts

CTA:
	•	View full activity

Panel 5 — Settings
	•	Compounding slider or locked display
	•	Exit request button (if supported)
	•	Supporter badge indicator
	•	Referral indicator

⸻

19.7 Screen: Guardrail Feed (/vault/:vaultId/guardrails)

Header
	•	“Execution Attempts”
	•	Filters: All / Blocked / Allowed

Table
	•	Attempt #
	•	Timestamp
	•	Allowed/Blocked
	•	Reject code
	•	Explanation
	•	Receipts

⸻

19.8 Screen: Claim Modal

Header
	•	“Claim Profit”

Body
	•	Claimable amount
	•	Receive amount
	•	Compound amount
	•	Compounding % summary

CTAs
	•	Primary: Confirm Claim
	•	Secondary: Cancel

⸻

19.9 Screen: Supporter (/supporter)

Block 1 — Overview
	•	what it is
	•	why it exists

Block 2 — Eligibility
	•	status
	•	spots remaining

Block 3 — Benefits
	•	fee discount rules
	•	wallet binding rules
	•	proof rules

Block 4 — Badge
	•	active/inactive badge display

Block 5 — Receipts
	•	participation receipt history

⸻

19.10 Screen: Referral (/referral)

Block 1 — Your Code
	•	code
	•	link
	•	copy buttons

Block 2 — Stats
	•	referred
	•	pending
	•	qualified
	•	rejected
	•	rewards earned

Block 3 — Rules
	•	min deposit
	•	hold time
	•	caps
	•	anti-abuse

Block 4 — Ledger
	•	referral rows with timers and receipts

⸻

19.11 Screen: System Status (/status)

Block 1 — Global state
	•	Running/Paused/Lockdown

Block 2 — Modules
	•	Venue health
	•	Oracle health
	•	Keeper health
	•	Execution budget

Block 3 — Reject trends
	•	top reject codes
	•	rejection rate

Block 4 — Incident
	•	banner + instructions

⸻

19.12 Screen: Incident (/incident)
	•	Title
	•	What happened
	•	Impact
	•	What users should do
	•	Proof links
	•	Timestamp

⸻

Section 20 — End-to-End UX Flows (Full Process Flows in Words)

This section defines the end-to-end user flows so the team doesn’t miss edge transitions.

⸻

20.1 Flow A — First-Time User (Happy Path)
	1.	User lands on Home
	2.	User clicks Deposit
	3.	User connects wallet
	4.	User switches to BNB Chain (if needed)
	5.	User selects:
	•	amount
	•	risk tier
	•	compounding %
	6.	User approves USDT
	7.	User deposits and vault is created
	8.	User reviews Strategy Preview
	9.	User checks confirmation boxes
	10.	User accepts strategy
	11.	Vault becomes Active
	12.	Execution attempts occur when safe
	13.	User sees realized profit accumulate
	14.	User claims anytime
	15.	Claim receipt shown + updated balances

Success definition:
	•	user never misunderstands profit vs principal
	•	user can find claim within 1 second
	•	user sees receipts for everything

⸻

20.2 Flow B — User Creates Vault but Does NOT Accept Yet
	1.	Deposit completed
	2.	Vault created in PENDING_ACCEPTANCE
	3.	User navigates away
	4.	Vaults list shows:
	•	Pending Acceptance
	•	“Accept” quick CTA
	5.	User returns later
	6.	Strategy preview shown again
	7.	User accepts

Rules:
	•	No trade attempts occur before acceptance
	•	UI always warns that vault is not active yet

⸻

20.3 Flow C — User Declines Strategy
	1.	Vault created
	2.	Strategy Preview shown
	3.	User taps Decline
	4.	Decline modal confirms:
	•	no execution will ever occur
	5.	Decline tx succeeds
	6.	Vault state becomes DECLINED
	7.	UI routes to:
	•	Withdraw Principal flow (if supported)
	•	or “Close vault instructions”

Rules:
	•	Decline cannot trap funds
	•	Decline must have receipts

⸻

20.4 Flow D — Vault Is Idle for Days/Weeks (Normal)
	1.	Vault is Active
	2.	Execution attempts are blocked repeatedly (GR-040, GR-030, etc.)
	3.	Vault badge becomes “Idle (by design)”
	4.	User sees:
	•	“Idle does not mean broken”
	5.	User opens Why Idle drawer
	6.	UI shows last rejects with explanation
	7.	User does nothing
	8.	Eventually conditions improve and execution succeeds

Rules:
	•	rejects must be presented as safety wins
	•	no “broken” wording

⸻

20.5 Flow E — Vault Paused by Guardrail
	1.	Vault is Active
	2.	Guardrail triggers vault pause
	3.	Vault state becomes PAUSED_GUARDRAIL
	4.	UI shows:
	•	Pause banner
	•	reject code
	•	explanation and user action
	5.	User can:
	•	claim (if allowed)
	•	request exit (if supported)
	•	wait

Rules:
	•	user must not be forced to contact support to understand

⸻

20.6 Flow F — Protocol Paused (Global)
	1.	Admin toggles protocolPaused = true
	2.	UI displays global banner everywhere
	3.	Deposits disabled
	4.	Execution attempts cease
	5.	Users can still view vault data
	6.	Claims/exits depend on flags

Rules:
	•	Pause messaging must be consistent and calm
	•	direct users to /status and /incident

⸻

20.7 Flow G — Claim Profit (Anytime)
	1.	Claim button enabled when claimable > 0
	2.	User clicks Claim
	3.	Claim modal shows receive/compound breakdown
	4.	Claim tx executes
	5.	Activity log updated
	6.	Notification triggered

Rules:
	•	claim cannot touch principal
	•	claim must be receipt-backed

⸻

20.8 Flow H — Referral Qualification
	1.	User shares referral link
	2.	Friend deposits ≥ threshold
	3.	Referral enters PENDING state with countdown timer
	4.	If friend stays through qualification:
	•	state becomes QUALIFIED
	5.	Reward credited (auto or claimable)
	6.	Ledger updates with receipt

Rules:
	•	must show countdown and caps
	•	must show reason for rejection if not qualified

⸻

Section 21 — Dev Acceptance Checklist (Definition of Done Per Screen)

This section is the QA “truth gate.”
A screen is not done unless it meets the checklist.

⸻

21.1 Global App Acceptance Criteria
	•	Wallet connect works (MetaMask + WalletConnect)
	•	BNB Chain gate enforced everywhere
	•	Every money-moving action requires:
	•	modal
	•	signature
	•	receipt
	•	UI never displays unrealized profit as real
	•	Principal and profit never visually merge
	•	All critical pages responsive (mobile-first)
	•	All pages handle indexer lag gracefully
	•	Status page always accessible

⸻

21.2 Home Acceptance Criteria
	•	Truth Rules panel exists and is visible
	•	deposit CTA routes correctly
	•	protocol paused banner works
	•	metrics load or show “syncing”

⸻

21.3 Deposit Acceptance Criteria
	•	approval step works
	•	deposit step works
	•	failure states handled
	•	after deposit success:
	•	vault created state shown
	•	acceptance required shown
	•	user cannot believe vault is active before acceptance

⸻

21.4 Strategy Preview Acceptance Criteria
	•	all disclosure blocks present
	•	fee explanation present
	•	guardrail explanation present
	•	checkbox gate enforced
	•	Accept disabled until all required boxes checked
	•	Decline exists and is functional

⸻

21.5 Vault Dashboard Acceptance Criteria
	•	state badge matches actual vault state
	•	claim button visible immediately
	•	balances displayed separately
	•	execution panel shows last attempt/reject
	•	activity log has receipts
	•	“Why idle?” exists and shows reject codes

⸻

21.6 Claim Acceptance Criteria
	•	claim modal shows exact outcome
	•	claim receipts saved
	•	balances update after claim
	•	claim disabled at zero

⸻

21.7 Referral Acceptance Criteria
	•	referral code copy works
	•	ledger exists
	•	pending countdown exists
	•	qualification states exist
	•	caps clearly stated
	•	anti-abuse warnings exist

⸻

21.8 Supporter Acceptance Criteria
	•	eligibility shown
	•	benefits shown
	•	discount proof shown
	•	badge appears in vault screens where relevant

⸻

21.9 Status + Incident Acceptance Criteria
	•	system status reflects flags
	•	incident banner can display detail page
	•	protocol pause messaging consistent across app

⸻

