# FILE: HANDOFF_APPENDIX_NFTS_AND_REFERRALS.md

# YieldLoop — Peripheral Systems Appendix  
## NFTs, Referrals, Governance Hooks  
**Version:** v1.0  
**Status:** Implementation-Binding  
**Audience:** Smart Contract Engineers, Backend Engineers  
**Parent Document:** YIELDLOOP_ENGINEERING_HANDOFF.md  
**Author:** Todd Koletsky  
**Date:** 2025-12-18  

---

## Purpose

This appendix defines **all non-core peripheral systems** in YieldLoop:

- NFTs
- Fee discounts
- Referrals
- Governance participation hooks
- Bounty eligibility hooks

These systems are **explicitly isolated** from execution, accounting, and settlement logic.

If this appendix were removed entirely, the YieldLoop execution engine **must continue to function correctly**.

---

## Core Rule (Non-Negotiable)

> **Peripheral systems may only modify platform fee distribution *after settlement*.  
They may never influence execution, accounting, profit calculation, or LOOP minting.**

If a change affects execution behavior, it is invalid.

---

## 1. NFT SYSTEM

### 1.1 NFT Roles (Authoritative)

YieldLoop supports exactly two NFT roles in v1:

| NFT Type | Purpose |
|--------|--------|
| Supporter NFT | Fee discount + access |
| Governor NFT | Higher discount + advisory role |

NFTs are **utility and coordination tools only**.

---

## 1.2 NFT Capabilities (Allowed)

NFT ownership MAY:

- Apply a **platform fee discount**
- Unlock UI visibility
- Gate governance discussion access
- Enable bounty eligibility

NFT ownership MAY NOT:

- Change execution behavior
- Affect strategies
- Affect settlement math
- Mint LOOP
- Trigger execution
- Unlock withdrawals
- Accelerate cycles
- Create financial claims

---

## 1.3 Supporter NFT Specification

**Minting**
- Public mint
- BNB-denominated price
- Initial price: $300 USD equivalent
- Price adjustable prospectively by governance
- Unlimited supply

**Discount**
- 5% discount on platform fee
- Applies only:
  - If profit > 0
  - At settlement
  - To platform fee only

**Transferability**
- Freely transferable
- Discount follows wallet holding NFT at settlement time

---

## 1.4 Governor NFT Specification

**Minting**
- Admin mint only (multisig)
- No default public sale
- Supply limited by policy, not hard cap

**Discount**
- 10% platform fee discount
- Overrides Supporter NFT discount if both present

**Transferability**
- Non-transferable by default
- Transfer allowed only via multisig approval
- Unauthorized transfer must revert

**Revocation**
- Revocable and burnable by multisig
- Revocation reasons include inactivity or abuse

**Authority**
- Advisory only
- No execution rights
- No settlement rights
- No treasury control

---

## 1.5 Discount Resolution Logic (Authoritative)

Discounts are resolved **once per cycle per vault**, during settlement.

**Order of precedence:**
1. Governor NFT → 10%
2. Supporter NFT → 5%
3. No NFT → 0%

**Rules**
- Discount applies only to platform fee
- Discount cannot exceed 100%
- Discount cannot reduce fee below zero
- Discount does not stack

---

## 2. REFERRAL SYSTEM (POST-LAUNCH)

### 2.1 Purpose

The referral system rewards **successful, profit-generating user introductions** without:

- Emissions
- Volume incentives
- Ponzi mechanics
- Infinite accrual

---

## 2.2 Eligibility Rules

A user becomes eligible to refer others only after:

- Completing a deposit
- Completing at least one full execution cycle

Referral codes are issued **only after eligibility is met**.

---

## 2.3 Qualified Referral Definition

A referral is considered qualified only if:

- The referred user deposits funds
- The referred user completes a cycle
- The referred user produces **positive net profit**

No profit = no referral credit.

---

## 2.4 Referral Credit Mechanics

**Credit Amount**
- 5% of the **platform fee**
- Never sourced from user profit
- Never sourced from system deposit

**Cycle Limit**
- Applies to the referred user’s **first six (6) positive cycles**
- After six positive cycles, referral expires permanently

---

## 2.5 Settlement Timing (Critical)

Referral credits are calculated:

- After settlement
- After platform fee is finalized
- After NFT discounts are applied

**Processing order:**

SettlementEngine
↓
Platform Fee Calculated
↓
NFT Discount Applied
↓
Referral Credit Calculated (5% of fee)

If any step fails → referral credit = 0.

---

## 2.6 Referral Credit Form

Referral credits may be issued as:

- LOOP
- Platform credit
- Other governance-approved form

Form must be:
- Explicitly defined
- Non-inflationary
- Logged on-chain or in auditable records

---

## 2.7 Anti-Abuse Rules

The system MUST prevent:

- Self-referrals
- Circular referrals
- Multi-wallet abuse
- Artificial account chaining

Admins may revoke referral eligibility for abuse.

Revocation:
- Applies prospectively only
- Does not affect settled credits

---

## 3. GOVERNANCE & BOUNTY HOOKS (NON-BINDING)

### 3.1 Governance Participation

NFTs may grant access to:
- Advisory votes
- Discussion forums
- Proposal reviews

Governance outputs are:
- Non-binding
- Informational only
- Logged but not enforceable

---

### 3.2 Bounty Eligibility

Governor NFTs may be eligible for bounties:

- Funded from marketing allocation
- Approved via multisig
- One-time, task-specific
- No recurring payments

Bounties:
- Are not compensation
- Are not profit-sharing
- Do not create employment or agency

---

## 4. On-Chain vs Off-Chain Responsibility

| Function | On-Chain | Off-Chain |
|------|--------|---------|
| NFT ownership | ✅ | |
| Discount resolution | ✅ | |
| Referral tracking | | ✅ |
| Referral payout authorization | ✅ | |
| Governance discussion | | ✅ |
| Bounty coordination | | ✅ |

No off-chain system may alter on-chain results.

---

## 5. Failure Behavior

If any peripheral system fails:
- Execution continues
- Settlement proceeds
- Core accounting is unaffected
- Peripheral benefits are skipped

Failure must never block settlement.

---

## 6. Explicit Non-Permissions

Peripheral systems must NEVER:

- Affect strategy execution
- Affect vault locking
- Affect profit calculation
- Affect LOOP mint authorization
- Affect cycle timing
- Affect withdrawal permissions

Violation of this rule is a critical bug.

---

## 7. Final Implementation Rule

> **Peripheral systems are allowed to observe, not influence.  
They reward reality — they do not create it.**

If this boundary is unclear in code, it is implemented incorrectly.

---
