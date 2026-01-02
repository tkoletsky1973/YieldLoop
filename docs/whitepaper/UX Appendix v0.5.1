# Appendix UX — Application Architecture & Interaction Constraints

**Document Purpose**  
This appendix defines the **frontend UX architecture** for YieldLoop and its **hard constraints**, ensuring that the user interface:

- does not imply guarantees, continuity, or yield
- does not contradict protocol behavior
- does not introduce discretionary control
- does not misrepresent execution, settlement, or redemption

This appendix is **authoritative for frontend implementation**.

If a UX element contradicts this appendix, it is incorrect.

---

## UX-0. Core UX Invariants (Non-Negotiable)

The YieldLoop frontend MUST enforce the following invariants:

1. **No live profit indicators**
2. **No rolling PnL**
3. **No APY, projections, or expectations**
4. **No implied execution continuity**
5. **No mid-cycle control surfaces**
6. **No visual smoothing of outcomes**
7. **No cross-vault aggregation by default**
8. **No redemption guarantees**
9. **No execution guarantees**
10. **No override or emergency UI**

The frontend MUST reflect **protocol truth**, not user comfort.

---

## UX-1. Global Application Structure

### Primary Navigation Sections

The application MUST expose the following top-level sections:

1. Overview  
2. Vaults  
3. Cycles  
4. Execution  
5. Settlement  
6. LOOP  
7. Governance / Supporter  
8. Documentation  
9. Settings  

Each section corresponds directly to a whitepaper section and MAY NOT merge responsibilities.

---

## UX-2. Overview Screen Requirements

### Purpose
Provide **situational awareness** only.  
No performance implication.

### Required Components

#### UX-2.1 Global Cycle Status

Current Cycle: 
Status: {Not Started | Executing | Settled}
Time Remaining: 

No profit data displayed.

---

#### UX-2.2 User Participation Summary

Vaults Authorized This Cycle: 
Withdrawals: {Enabled | Locked}

---

#### UX-2.3 Last Settled Cycle Summary

Cycle: 
Verified Net Profit: {YES | NO}
User Outcome: {Gain | Flat | Loss}
Inventory Carried: {YES | NO}
LOOP Minted: 

Binary accounting state MUST be shown before user outcome.

---

## UX-3. Vaults Interface

### UX-3.1 Vault Isolation

Each vault MUST be rendered independently.  
The UI MUST NOT pool or aggregate vault balances by default.

---

### UX-3.2 Vault States

Vaults MUST reflect one of the following states:

- Idle
- Configured
- Authorized
- Executing
- Settled

State transitions are **one-directional per cycle**.

---

### UX-3.3 Vault Detail Tabs (Required)

Each vault detail view MUST include:

1. Status  
2. Configuration  
3. Execution  
4. Inventory  
5. Settlement History  
6. Execution Cost Wallet (ECW)  

---

### UX-3.4 Status Tab

Must display:

Vault State: 
Cycle: 
Withdrawals: {Enabled | Disabled}

If withdrawals are disabled, UI MUST display:

> Funds are locked until settlement.

---

### UX-3.5 Configuration Tab

- Read-only during Authorized or Executing states
- Must display:
  - strategy engines
  - parameters
  - allocations
  - profit handling mode
  - ECW funding

Must include authorization timestamp.

---

## UX-4. Configuration Flow (Pre-Cycle Only)

### UX-4.1 Strategy Selection

- Strategy cards ONLY
- No sliders implying optimization
- Must include disclaimers:
  - execution may not occur
  - profit is not guaranteed

---

### UX-4.2 Parameter Entry

- Hard bounds only
- No estimated returns
- No expected outcomes

---

### UX-4.3 Profit Handling Selection

Must present exactly:

- Compound All
- Split 50 / 50
- Withdraw All Profits

Each option MUST explicitly state:

> Applied only at settlement and only if verified profit exists.

---

### UX-4.4 Execution Cost Wallet (ECW)

ECW MUST be visually separated from principal.

Display:

ECW Balance: 
Minimum Required: 

Low-balance warnings MUST NOT imply execution continuation.

---

### UX-4.5 Authorization Screen (Critical)

Authorization requires explicit acknowledgments:

- Funds are locked
- Execution may not occur
- Profit is not guaranteed
- Settlement is final

Button label MUST be:

Authorize Next Cycle

No alternative wording permitted.

---

## UX-5. Execution View

### UX-5.1 Execution Display Rules

- NO charts
- NO live profit indicators
- NO green/red performance visuals

Execution MUST be rendered as an **event log**:

— Strategy evaluation
 — Execution skipped
 — Trade executed
 — Trade closed

 Neutral language only.

---

## UX-6. Inventory Interface

### UX-6.1 Inventory Definition

Inventory MUST have a dedicated tab.

Inventory MUST display:

- asset
- origin cycle
- open/closed status
- NO market value
- NO PnL

Banner text REQUIRED:

> Inventory is unrealized and excluded from profit recognition.

---

## UX-7. Settlement Interface

### UX-7.1 Settlement Presentation

Settlement MUST be rendered as a **final event**.

Required fields:

Cycle: 
Verified Net Profit: {YES | NO}
VNP Amount: <amount or 0>
Platform Fee: <amount or 0>
User Outcome: {Gain | Flat | Loss}
Inventory Remaining: {YES | NO}
LOOP Minted:

Settlement screens MUST NOT allow user action.

---

## UX-8. LOOP Interface

### UX-8.1 LOOP Dashboard

Must display:

LOOP Balance: 
Accounting Parity: 1 LOOP = 1 USDT
Redeemable Now: 
Queued: 

Banner REQUIRED:

> LOOP is an accounting receipt of retained surplus. Redemption is capacity-limited.

---

### UX-8.2 Redemption Screen

Redemption MUST be explicit and frictioned.

Display:

Requested: 
Status: {Available | Queued | Paused}
Queue Epoch: 

NO countdown timers.  
NO redemption promises.

---

## UX-9. Governance & Supporter Interface

### UX-9.1 Supporter Contributions

Supporter contributions MUST be clearly separated from vaults.

Display:

Supporter Contribution: 
Purpose: Platform sustainability

Required disclaimer:

> Not execution capital.  
> Not redeemable.  
> No profit participation.

---

## UX-10. Copy and Language Rules

### Forbidden Terms

The frontend MUST NOT use:

- APY
- Earn
- Passive income
- Guaranteed
- Yield (outside technical context)
- Growth (without explicit qualification)

---

### Required Language Patterns

Use:
- “may”
- “if verified”
- “at settlement”
- “not guaranteed”
- “may remain idle”

---

## UX-11. Failure and Edge States (First-Class)

The frontend MUST explicitly support and display:

- no execution cycles
- ECW exhaustion
- inventory carryover
- zero-profit cycles
- loss cycles
- redemption pauses

Each state MUST include:
- explanation
- no apology
- no remediation promise

---

## UX-12. Enforcement Clause

If a frontend element:

- implies profit
- implies execution certainty
- allows mid-cycle interaction
- masks inactivity or loss

It is **non-compliant with YieldLoop**.

This appendix overrides convenience, aesthetics, and marketing pressure.
