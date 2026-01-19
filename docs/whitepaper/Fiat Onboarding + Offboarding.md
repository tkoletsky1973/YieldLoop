# YieldLoop Whitepaper Addendum — Fiat Onboarding + Offboarding (“Normie Rail”)

## Title Block

**Document Title:** YieldLoop Whitepaper Addendum — Fiat Onboarding + Offboarding (“Normie Rail”)  
**Project:** YieldLoop  
**Author:** Todd Koletsky  
**Version:** 0.8.1  
**Date:** January 19, 2026  
**Document Type:** Whitepaper Addendum  
**Status:** Draft / Integration-Ready  
**Chain:** BNB Chain (BSC)  
**DEX Venues:** PancakeSwap (PCS), BiSwap  
**Scope:** On-ramp, Off-ramp, Fiat UX, Compliance Notes, Failure Handling  

---

## Change Summary (What This Addendum Fixes)

The YieldLoop v0.8.0 whitepaper defines the system logic (vault model, strategy proposal, acceptance gate, cycle rules, settlement logic).  
However, it does **not fully specify how normal users fund and withdraw** without DeFi expertise.

This addendum defines:

1. A frictionless fiat on-ramp path (**bank/card → USDT/BNB → deposit**)
2. A frictionless fiat off-ramp path (**withdraw → USDT → bank payout**)
3. Embedded ramp architecture and UX language so the experience is “normal” for non-DeFi users
4. Compliance reality: KYC/AML handled by regulated ramp providers
5. Failure handling and fallback logic for ramp edge cases

This addendum is **non-invasive**: it does not alter strategy logic, vault architecture, token logic, or cycle mechanics. It only adds product-real fiat rails.

---

## Table of Contents

1. Purpose and Design Goal  
2. Definitions  
3. User Types + UX Modes  
4. Onboarding Architecture (Fiat On-Ramp)  
5. Offboarding Architecture (Fiat Off-Ramp)  
6. Core UX Requirements (Normie-Grade)  
7. Failure States + Fallback Logic  
8. Compliance / KYC Handling  
9. Whitepaper Integration Notes (Required Inserts)  

---

# 1. Purpose and Design Goal

YieldLoop must support two parallel user experiences:

- **DeFi-native experience:** user already has wallet + BNB gas + USDT
- **Normie experience:** user has only a bank account / debit card

The normie experience must be:

- as simple as a mainstream fintech app
- no bridges
- no token contract addresses
- no “go buy gas” confusion

YieldLoop must offer equal or better usability than a DeFi-native workflow by embedding the necessary fiat rails directly into the dApp.

---

# 2. Definitions

**Fiat On-Ramp:** Regulated service allowing users to purchase crypto using debit card, bank transfer, or supported payment rails.

**Fiat Off-Ramp:** Regulated service allowing users to sell crypto and receive fiat payout to a bank account or card.

**Embedded Ramp:** Widget/API integrated inside the YieldLoop dApp so users do not need to leave the app.

**Ramp Provider:** Third-party infrastructure provider such as **Transak**, **MoonPay**, **Ramp Network** (final selection TBD).

**Gas Funding:** Purchase of a small amount of BNB used to cover transaction costs on BNB Chain.

---

# 3. User Types + UX Modes

YieldLoop supports two UI modes:

## 3.1 Normie Mode (Default)

Normie Mode assumes:

- the user does not understand wallets, chains, gas, swaps, or bridges
- the user expects a simple “fund / withdraw” experience similar to fintech apps

Normie Mode requirements:

- hide chain vocabulary by default
- use normal product language:
  - “Fund Account”
  - “Withdraw to Bank”
  - “Deposit”
  - “Claim”
- auto-handle BNB gas top-ups and USDT purchasing

## 3.2 Advanced Mode (Optional Toggle)

Advanced Mode assumes:

- the user understands chain mechanics
- the user wants full control and visibility

Advanced Mode may expose:

- balances per token
- gas estimates
- swap routing venue (PCS vs BiSwap)
- contract addresses, txn hashes, block explorer links

---

# 4. Onboarding Architecture (Fiat On-Ramp)

## 4.1 Design Principle: “Fund Account” not “Buy Crypto”

YieldLoop must NOT position onboarding as “crypto buying” for normies.

User framing must be:

> “You are funding your YieldLoop account.”

This reduces confusion and increases conversion.

## 4.2 Primary Goal: USDT-First Deposit UX

For normies, YieldLoop should default to:

- fund with **USDT** (recommended)
- acquire **BNB only as gas utility** (minimal amount)

BNB is not treated as the “investment asset” in normie mode, it is treated as a network requirement.

## 4.3 Embedded Ramp Requirement

The YieldLoop dApp must integrate one or more embedded fiat on-ramp providers so the user can:

1. Buy **BNB** for gas (automatically recommended amount)
2. Buy **USDT on BNB Chain**
3. Confirm wallet receipt
4. Continue deposit flow

Ramp integrations are implemented using provider widget/API.

### Recommended Provider Stack

- **Primary provider (default):** Transak (on-ramp + off-ramp)
- **Secondary provider (fallback):** MoonPay or Ramp Network

Two provider options are recommended to reduce:

- regional coverage gaps
- KYC failure exits
- payment method exclusions
- provider downtime

## 4.4 One-Tap Gas Funding (Auto-Detection)

YieldLoop must detect:

- wallet BNB balance
- estimated required gas for:
  - approval
  - swap (if needed)
  - deposit transaction
  - claim/withdraw transactions

If user BNB balance is insufficient:

- display a one-click step: **“You need ~$X BNB for network fees.”**
- provide button: **“Buy BNB”**
- auto-return to deposit state once complete

## 4.5 Minimal Cognitive Steps

The normie onboarding flow should not exceed:

- 3–5 total steps
- no external site redirects
- no requirement for the user to understand token addresses or chain selection

---

# 5. Offboarding Architecture (Fiat Off-Ramp)

## 5.1 Design Principle: “Withdraw to Bank” not “Sell Crypto”

Normie phrasing must be:

> “Withdraw to Bank”

Not:

- offramp
- sell token
- send to exchange

YieldLoop must present this like a normal payout system.

## 5.2 Off-Ramp User Flow

When the user chooses to exit to fiat:

1. user selects amount in USDT (or converts rewards to USDT)
2. user clicks **Withdraw to Bank**
3. embedded off-ramp widget opens
4. provider performs:
   - identity checks (if required)
   - payout destination selection (bank/card)
   - rate quote (fees included)
5. provider generates deposit request:
   - required amount
   - target address
   - transaction memo or identifier (if applicable)
6. user confirms transfer from wallet
7. provider delivers fiat payout to user

## 5.3 Stablecoin Preference

Off-ramp should prioritize:

- **USDT → fiat**

This reduces volatility and prevents confusion, and aligns with normie expectation of a “cash balance.”

## 5.4 “Frictionless Redemption” Requirement

YieldLoop UX must ensure:

- the user does not need to open a centralized exchange
- the user does not need to “bridge out”
- the user does not need to understand chain mechanics

If off-ramp fails, fallback options must be presented clearly (see Section 7).

---

# 6. Core UX Requirements (Normie-Grade)

YieldLoop must support normies with:

## 6.1 Always Show a Simple Balance View

- “Cash Balance (USDT)”
- “Gas Balance (BNB)”

No other token exposure unless Advanced Mode is toggled.

## 6.2 One-Click Conversion Assistance

If user funded with BNB:

- provide one-tap conversion:
  - “Convert to USDT”
- prefill recommended conversion amount
- disclose estimated swap fee / slippage

## 6.3 User Trust Requirements

Always display:

- expected fees
- estimated time
- whether identity verification may be required
- provider name and support link

---

# 7. Failure States + Fallback Logic

Fiat rails will fail sometimes. YieldLoop must treat failure as normal.

## 7.1 On-Ramp Failures (Funding)

Failure conditions include:

- payment declined
- KYC failed or not supported
- provider downtime
- unsupported region/state

Fallback options:

1. switch provider (Transak → MoonPay/Ramp)
2. show “manual funding” instructions:
   - send USDT (BEP-20) to wallet
   - minimum recommended gas amount

## 7.2 Off-Ramp Failures (Cash Out)

Failure conditions include:

- provider cannot payout in user region
- KYC failed
- bank transfer rails unavailable
- provider downtime

Fallback options:

1. switch provider
2. offer “withdraw USDT” option:
   - user can self-offramp via external exchange
3. provide stable fallback explanation:
   - “Your funds remain in your wallet. YieldLoop does not custody funds.”

---

# 8. Compliance / KYC Handling

## 8.1 KYC/AML Reality

Fiat ramps require regulatory compliance.

YieldLoop policy:

- YieldLoop does not custody fiat
- YieldLoop does not collect identity documents
- KYC/AML is performed by the ramp provider

Normie UX phrasing should be plain and non-alarmist:

> “Identity verification may be required to comply with payment regulations.”

## 8.2 Non-Custodial Guarantee

Even with fiat rails, YieldLoop must remain non-custodial:

- user controls the wallet
- user signs all transactions
- user approves all strategy execution
- user can exit at end-of-cycle rules as defined in the core whitepaper

---

# 9. Whitepaper Integration Notes (Required Inserts)

To integrate this addendum properly, the core whitepaper must include minimal inserts.

## 9.1 Insert 1: Onboarding Section

Add 1 paragraph:

> Users may fund deposits using embedded fiat on-ramp providers integrated into the YieldLoop dApp (e.g., Transak/MoonPay/Ramp). Normie users can purchase BNB for gas and USDT for deposit without leaving the application.

## 9.2 Insert 2: Withdrawals / Redemption Section

Add 1 paragraph:

> Users may withdraw to fiat using embedded off-ramp providers integrated into the dApp. This enables users to claim USDT and receive fiat payout to their bank account or card through regulated payment partners.

## 9.3 Insert 3: UX Summary

Add 1 sentence in the UI/UX summary:

> YieldLoop supports a normie-first onboarding experience designed to be equivalent to mainstream fintech apps while maintaining non-custodial user control.

---

## End of Document
