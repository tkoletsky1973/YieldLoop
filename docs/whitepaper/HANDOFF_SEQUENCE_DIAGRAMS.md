# FILE: HANDOFF_SEQUENCE_DIAGRAMS.md

# YieldLoop — Authoritative Sequence Diagrams  
**Version:** v1.0  
**Status:** Implementation-Binding  
**Audience:** Full-Stack Developers, Smart Contract Engineers, Auditors  
**Parent Document:** YIELDLOOP_ENGINEERING_HANDOFF.md  
**Author:** Todd Koletsky  
**Date:** 2025-12-18  

---

## Purpose

This document defines the **exact call and state sequences** for all critical YieldLoop flows.

These are not illustrative diagrams.  
They are **behavioral contracts**.

If the implementation deviates from these sequences, the system is incorrect.

---

## Global Rule

> **No component may act outside the active system state.  
No sequence may skip a step.  
No sequence may be reordered.**

---

## 1. User Vault Creation
 
User
↓ connect wallet
VaultFactory
↓ createVault(user)
UserVault
↓ owner = user
↓ state = Inactive

**Rules**
- One vault per user (policy)
- No funds move
- No execution possible

---

## 2. Deposit (Queued Funds)

User
↓ deposit(amount)
UserVault
↓ state == Inactive OR PostCycle
↓ funds credited
↓ marked as queued

**Rules**
- Deposits during Active are queued
- Deposits do not trigger execution
- No settlement impact

---

## 3. Cycle Configuration (Pre-Lock)

User
↓ select strategies
↓ define parameters
↓ set post-cycle preferences
UserVault
↓ state = Configured

**Rules**
- All parameters mutable
- No execution
- No locks yet

---

## 4. Cycle Authorization & Lock

User
↓ authorizeCycle()
UserVault
↓ parameters locked
CycleController
↓ registerVault(vault)
↓ state transition pending

**Rules**
- Authorization is explicit
- No partial authorization
- Cannot auto-start

---

## 5. Cycle Start (Global)

CycleController
↓ startCycle()
UserVault(s)
↓ state = Active
↓ snapshotStart()

**Rules**
- All eligible vaults start simultaneously
- Deposits after cutoff excluded
- Parameters immutable

---

## 6. Strategy Execution (During Active)

CycleController
↓ authorize execution window
StrategyRegistry
↓ validate enabled strategies
Strategy
↓ execute(vault)
UserVault
↓ assets moved per strategy

**Failure Path**

Strategy
↓ revert OR halt
CycleController
↓ stop execution
↓ transition to Settling

**Rules**
- No retries
- No substitution
- Other strategies may continue if isolated

---

## 7. Cycle End (Time or Halt)

CycleController
↓ endCycle()
UserVault
↓ state = Settling

**Rules**
- No execution allowed past this point
- Vault locked
- No user action possible

---

## 8. Settlement (Critical Path)


CycleController
↓ settle(vault)
SettlementEngine
↓ snapshotEnd()
↓ compute profit
↓ apply zero-profit rule
↓ apply fees & discounts
↓ route fees
↓ mint LOOP (if applicable)
↓ finalize records
UserVault
↓ unlockAfterCycle()
↓ state = PostCycle

**Rules**
- Atomic
- Deterministic
- Runs once
- Revert on failure

---

## 9. Post-Cycle User Actions

User
↓ view results
↓ withdraw funds (optional)
↓ withdraw LOOP (optional)
↓ reconfigure for next cycle
UserVault
↓ state = Inactive OR Configured

**Rules**
- Full user control restored
- No retroactive changes
- Results immutable

---

## 10. Zero-Profit Cycle

SettlementEngine
↓ netProfit <= 0
↓ record zero outcome
↓ no fees
↓ no LOOP
UserVault
↓ unlockAfterCycle()

**Rules**
- Zero is success
- No compensation
- No smoothing

---

## 11. NFT Discount Resolution (Settlement-Time Only)

SettlementEngine
↓ resolveNFTDiscount(user)
GovernorNFT? → yes → 10%
SupporterNFT? → yes → 5%
else → 0%

**Rules**
- Read-only
- One-time per cycle
- No stacking

---

## 12. Referral Credit Sequence

SettlementEngine
↓ discountedFee finalized
FeeRouter
↓ check referral eligibility
ReferralRegistry
↓ return referrer
FeeRouter
↓ allocate referral credit

**Rules**
- Only after profit
- Only after discount
- Only first 6 positive cycles

---

## 13. Emergency Halt Sequence

Multisig
↓ haltSystem()
CycleController
↓ stop execution
UserVault(s)
↓ state = Settling
SettlementEngine
↓ settle current state

**Rules**
- No parameter changes
- No execution resume
- Truth preserved

---

## 14. System-Owned Capital Participation

SystemVault
↓ deposit system LOOP
CycleController
↓ treat like user vault
SettlementEngine
↓ system vault can profit or lose

**Rules**
- No special privilege
- No subsidy
- No withdrawal

---

## 15. Explicit Forbidden Sequences

The following sequences must never exist:

- Execution → fee routing → settlement
- Settlement → execution retry
- Mid-cycle withdrawal
- Admin-triggered trade
- LOOP mint before fee
- Referral credit without profit

If observed, this is a **critical bug**.

---

## Final Statement

> **If you can’t trace an outcome through one of these sequences, it doesn’t exist.**

YieldLoop is defined by order, not intention.

---
