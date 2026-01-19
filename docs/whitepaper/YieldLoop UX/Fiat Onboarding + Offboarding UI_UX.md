# YieldLoop UI/HMI Specification Add-On — Fiat Onboarding + Offboarding (Normie Rail)

## Title Block

**Document Title:** YieldLoop UI/HMI Add-On — Fiat Onboarding + Offboarding (Normie Rail)  
**Project:** YieldLoop  
**Author:** Todd Koletsky  
**Version:** 0.8.1-UI  
**Date:** January 19, 2026  
**Document Type:** UI/HMI Addendum  
**Status:** Draft / Dev-Ready  
**Chain:** BNB Chain (BSC)  
**Scope:** Fund Account, Gas Top-Up, Buy USDT, Withdraw to Bank, Failure States  

---

## Table of Contents

1. UX Principles (Normie-Grade)  
2. Global UI Components Required  
3. Page: Fund Account (Normie Mode)  
4. Page: Buy BNB (Gas Top-Up)  
5. Page: Buy USDT (Primary Funding Asset)  
6. Page: Convert BNB → USDT (One-Tap Swap Helper)  
7. Page: Withdraw to Bank  
8. Page: Withdraw as USDT (Manual Offboard Fallback)  
9. Modals, Alerts, and Failure States  
10. Event Tracking + Metrics (Required)

---

# 1. UX Principles (Normie-Grade)

YieldLoop must feel like:

- a fintech app
- a savings / investing app
- a “fund account / withdraw” product

YieldLoop must NOT feel like:

- a crypto swap tool
- a DeFi dashboard
- a bridge/gas/explorer experience

## 1.1 Language Rules

### Allowed words (normie-safe)
- Fund Account
- Withdraw to Bank
- Cash Balance
- Network Fee (not “gas” by default)
- Confirm
- Continue
- Security Check
- Processing
- Provider

### Avoid by default
- gas
- bridge
- liquidity
- router
- slippage
- DEX
- chain
- BEP-20

(Advanced Mode can expose those.)

## 1.2 Minimum Steps Rule

Normie onboarding must be:

- 3–5 steps end-to-end
- embedded inside YieldLoop
- no “go to another website and come back” (unless ramp provider hard-requires redirect)

---

# 2. Global UI Components Required

## 2.1 Navigation

- Home/Dashboard
- Fund Account
- Deposit
- Claim
- Withdraw
- Settings
- Help/Support

## 2.2 Global Balance Strip (Top Bar)

Always visible:

- **Cash Balance (USDT)**
- **Network Fee Balance (BNB)**

Advanced toggle shows:
- wallet address
- token breakdown
- chain/network name

## 2.3 Assistance Widget (Normie Support)

Persistent help CTA:
- “Need help?”
- opens Knowledge/FAQ + live chat (if enabled)

Support content must include:
- “What is USDT?”
- “Why do I need BNB?”
- “How to withdraw to bank?”
- “Funds safety / non-custodial explanation”

---

# 3. Page: Fund Account (Normie Mode)

## 3.1 Page Purpose
Allow normie to fund their YieldLoop wallet with:

- BNB (for network fees)
- USDT (for deposit)

WITHOUT requiring external exchange.

## 3.2 Entry Points
- Primary CTA on Dashboard: **Fund Account**
- If user attempts Deposit with insufficient USDT/BNB:
  - redirect to Fund Account with intent

## 3.3 UI Layout

### Header
**Fund Your YieldLoop Account**

Subtitle:
> Add funds using your card or bank transfer.  
> You’ll receive USDT for investing and a small amount of BNB for network fees.

### Funding Tiles (2 cards)
#### Card A (Recommended)
✅ **Buy USDT (Recommended)**  
- “Best for deposits”
- “Stable value”
- CTA: **Buy USDT**

#### Card B
**Buy BNB (Network Fees)**  
- “Needed to run transactions”
- CTA: **Buy BNB**

### Provider Selector
Displayed under tiles:

- “Payment Provider”
- dropdown:
  - Transak (default)
  - MoonPay (fallback)
  - Ramp Network (fallback)

Rules:
- If provider availability is geo-limited:
  - hide unavailable provider or gray it out with explanation

### Footer Disclaimer (Plain English)
> YieldLoop does not custody your funds. Purchases are made directly to your wallet through regulated payment partners.  
> Identity verification may be required.

## 3.4 Success Criteria
- user completes purchase
- balances auto-refresh (no manual refresh)
- next CTA appears:
  - if USDT >= minDeposit → show **Continue to Deposit**
  - if USDT insufficient → suggest buy more

---

# 4. Page: Buy BNB (Gas Top-Up)

## 4.1 Purpose
Get user enough BNB to avoid stuck transactions.

## 4.2 Entry Points
- from Fund Account
- from system auto-detection modal:
  - “Insufficient Network Fee Balance”

## 4.3 UI Layout

### Header
**Add Network Fee Balance**

### Auto-Recommend Amount (Critical)
System must compute:
- minBNBNeeded for:
  - approval
  - swap (optional)
  - deposit
  - claim
  - withdraw

UI shows recommended:
- “Recommended: 0.015 BNB (~$X)”

Buttons:
- **Buy Recommended Amount**
- Custom Amount (advanced accordion)

### Embedded Widget
- provider widget embedded
- prefilled chain = BNB Chain
- token = BNB
- destination = connected wallet address

## 4.4 Post Purchase
Auto-redirect:

- if user came from Deposit:
  - return to Deposit page
- else:
  - return to Fund Account page

---

# 5. Page: Buy USDT (Primary Funding Asset)

## 5.1 Purpose
Buy USDT directly to wallet to enable deposit.

## 5.2 UI Layout

### Header
**Add Cash Balance (USDT)**

### Amount Input
- slider + text input
- minimum default:
  - “Recommended minimum: $25”
  - (or platform-configured minDeposit)

### Payment Method
Allow provider-driven selection:
- Debit/Credit
- Bank transfer
- Apple Pay (if supported by provider)

### Embedded Widget Configuration
- chain = BNB Chain
- asset = USDT
- destination = connected wallet

### Plain English Summary
> You are buying USDT to use inside YieldLoop.  
> USDT is a digital dollar used for deposits and withdrawals.

### CTA
**Continue Purchase**

---

# 6. Page: Convert BNB → USDT (One-Tap Swap Helper)

## 6.1 Purpose
When user purchased BNB but needs USDT to deposit.

This page is only required if:
- user has insufficient USDT
- user has enough BNB to swap

## 6.2 Trigger
Auto-suggestion banner:

> You have BNB but not enough USDT to deposit.  
> Convert BNB to USDT in one tap.

CTA: **Convert Now**

## 6.3 UI Layout

### Header
**Convert BNB to USDT**

### Swap Preview Panel
Show:
- input: BNB amount
- output: estimated USDT
- fee estimate
- time estimate

Normie explanation:
> This converts BNB into USDT so you can deposit.

### Buttons
- **Convert Recommended Amount**
- Custom Amount

### Advanced Accordion (Optional)
- show DEX routing (PCS vs BiSwap)
- show slippage
- show transaction hash + explorer link

## 6.4 Safety Rules
- refuse swap if:
  - BNB after swap < safetyGasReserve
- always reserve:
  - “Keep at least 0.01 BNB for network fees”

---

# 7. Page: Withdraw to Bank (Normie Offboarding)

## 7.1 Purpose
Allow user to offboard funds to fiat without DeFi knowledge.

## 7.2 Entry Points
- Dashboard: **Withdraw**
- Claim page completion:
  - “Withdraw to Bank”

## 7.3 UI Layout

### Header
**Withdraw to Bank**

### Amount Selection
- input in USDT
- “Max” button
- show:
  - available USDT balance
  - pending cycle restrictions (if any)

### Provider Selection
Same provider dropdown as Fund Account:
- Transak (default)
- MoonPay
- Ramp Network

### Embedded Off-Ramp Widget
The widget handles:
- KYC/AML
- bank/card selection
- payout estimate
- quote

### Flow Stages (visual timeline)
1. Confirm Amount
2. Verify Identity (if required)
3. Send USDT
4. Receive Bank Payout

### CTA
**Continue to Bank Withdrawal**

## 7.4 Critical UX Rule: No Fear Language
Avoid:
- “sell crypto”
- “off-ramp”
- “liquidate”
- “token sale”

Use:
- “withdraw”
- “payout”
- “cash out”

## 7.5 Status Updates
After initiating:
- show processing screen:
  - “Your withdrawal is processing.”
  - “You will receive confirmation from the payment provider.”
- provide:
  - provider receipt ID
  - transaction hash

---

# 8. Page: Withdraw as USDT (Manual Offboard Fallback)

## 8.1 Purpose
Provide fallback if provider fails, user refuses KYC, or provider doesn’t support region.

## 8.2 Trigger
If provider returns error:
- show fallback route

## 8.3 UI Layout

### Header
**Withdraw as USDT**

> You can withdraw USDT to another wallet or exchange account.

### Required Fields
- destination address input
- network fixed: BNB Chain
- amount input

### Safety Warnings
- “Only send to a BNB Chain USDT address”
- “Sending to wrong network may result in permanent loss”

### CTA
**Send USDT**

---

# 9. Modals, Alerts, and Failure States

## 9.1 Modal: Insufficient Network Fee Balance
Trigger:
- user tries to deposit/claim/withdraw and BNB is insufficient

Copy:
**You need a small network fee balance**
> To complete this action, you need about ~$X in BNB for network fees.

Buttons:
- **Buy BNB Now**
- “I’ll do this later”

## 9.2 Modal: Provider Not Available
Trigger:
- provider geo blocked, down, or unsupported

Copy:
**This provider isn’t available**
> Choose another payment provider or withdraw as USDT.

Buttons:
- switch provider
- withdraw USDT fallback

## 9.3 Modal: Purchase Completed (Success)
Copy:
**Funds Received**
> Your purchase has arrived in your wallet.

Buttons:
- **Continue to Deposit**
- “Back to Dashboard”

## 9.4 Alert: KYC Required
Copy:
**Identity verification required**
> Payment providers may require identity checks to comply with financial regulations.

Buttons:
- Continue
- Choose another provider
- Use USDT manual route

---

# 10. Event Tracking + Metrics (Required)

YieldLoop must track these events (non-sensitive):

## 10.1 Onboarding Funnel
- VIEW_FUND_ACCOUNT
- CLICK_BUY_USDT
- CLICK_BUY_BNB
- RAMP_PROVIDER_SELECTED
- RAMP_WIDGET_OPENED
- RAMP_PURCHASE_SUCCESS
- RAMP_PURCHASE_FAILED

## 10.2 Deposit Funnel
- CLICK_CONTINUE_TO_DEPOSIT_AFTER_FUNDING
- DEPOSIT_BLOCKED_INSUFFICIENT_USDT
- DEPOSIT_BLOCKED_INSUFFICIENT_BNB

## 10.3 Offboarding Funnel
- VIEW_WITHDRAW_TO_BANK
- RAMP_OFFRAMP_WIDGET_OPENED
- RAMP_OFFRAMP_SUCCESS
- RAMP_OFFRAMP_FAILED
- FALLBACK_WITHDRAW_USDT_USED

## 10.4 Core Success Metrics
- fund completion %
- deposit completion %
- withdraw completion %
- provider-specific failure rate
- average time-to-fund
- average time-to-withdraw

---

## End of Document
