# FILE: HANDOFF_MVP_TASK_BREAKDOWN.md

# YieldLoop — MVP Implementation Task Breakdown  
**Version:** v1.0  
**Status:** Build-Order Authoritative  
**Audience:** Full-Stack Developers, Smart Contract Engineers, Project Managers  
**Parent Document:** YIELDLOOP_ENGINEERING_HANDOFF.md  
**Author:** Todd Koletsky  
**Date:** 2025-12-18  

---

## Purpose

This document defines the **exact MVP build scope**, broken into **concrete, actionable tasks**.

It is designed to:
- Prevent scope creep
- Enable accurate estimates
- Enforce correct build order
- Make “done” unambiguous

If a task is not listed here, it is **not part of MVP v1**.

---

## MVP Definition (Non-Negotiable)

MVP v1 is complete when:

- A real user can complete a full cycle
- Settlement produces a final, auditable result
- Zero-profit cycles close cleanly
- LOOP mints only from verified surplus
- NFTs and referrals apply only at settlement
- Admins cannot touch outcomes
- The system survives failure without lying

Nothing else is required.

---

## PHASE 0 — Project Setup (Required)

### 0.1 Repository & Tooling
- [ ] Initialize monorepo (contracts / frontend / docs)
- [ ] Configure Solidity toolchain (Foundry or Hardhat)
- [ ] Linting + formatting
- [ ] CI pipeline (compile + test only)

**Exit Criteria:** Clean compile, empty test suite passes.

---

## PHASE 1 — Core Contracts (Critical Path)

### 1.1 VaultFactory
- [ ] Implement VaultFactory
- [ ] Enforce one-vault-per-user
- [ ] Emit vault creation events

### 1.2 UserVault
- [ ] Implement vault state machine
- [ ] Deposit / withdraw logic
- [ ] Lock / unlock logic
- [ ] Start / end balance snapshot
- [ ] Enforce withdrawal restrictions

**Exit Criteria:**  
Vault correctly blocks actions by state.

---

## PHASE 2 — Cycle Controller

### 2.1 Cycle Timing
- [ ] Implement cycle start/end timestamps
- [ ] Enforce fixed cycle duration
- [ ] Enforce deposit cutoffs

### 2.2 State Transitions
- [ ] Register vaults for cycle
- [ ] Transition vault states
- [ ] Emergency halt logic

**Exit Criteria:**  
Cycle transitions are deterministic and irreversible.

---

## PHASE 3 — Strategy Framework (Minimal)

### 3.1 Strategy Registry
- [ ] Enable/disable strategies
- [ ] Multisig-controlled access

### 3.2 IStrategy Base
- [ ] Implement interface
- [ ] Halt semantics
- [ ] Parameter validation

### 3.3 Initial Strategy (1 Required)
- [ ] Simple spot trade OR dummy no-op strategy
- [ ] Deterministic behavior
- [ ] Failure handling

**Exit Criteria:**  
A strategy can execute and halt correctly.

---

## PHASE 4 — Settlement & Accounting (Core Truth Engine)

### 4.1 Settlement Engine
- [ ] Implement settlement function
- [ ] Enforce single-run
- [ ] Zero-profit rule
- [ ] Deterministic math
- [ ] Event emission

### 4.2 Fee Router
- [ ] Platform fee calculation
- [ ] Fee split routing
- [ ] Discount resolution
- [ ] Referral hook (stub if needed)

### 4.3 LOOP Token
- [ ] Mint-only token
- [ ] Settlement-only mint permission
- [ ] No burn / no emissions

**Exit Criteria:**  
Settlement produces final, immutable outcomes.

---

## PHASE 5 — Peripheral Systems (Isolated)

### 5.1 NFTs
- [ ] Supporter NFT contract
- [ ] Governor NFT contract
- [ ] Discount lookup logic
- [ ] Transfer / revocation rules

### 5.2 Referral Registry
- [ ] Referral relationship tracking
- [ ] Cycle count tracking
- [ ] Eligibility enforcement

**Exit Criteria:**  
NFTs and referrals modify fees only.

---

## PHASE 6 — System Deposit

### 6.1 System Vault
- [ ] Non-withdrawable vault
- [ ] Participation in cycles
- [ ] No special permissions

**Exit Criteria:**  
System capital behaves like user capital.

---

## PHASE 7 — Frontend (Minimal, Honest)

### 7.1 User UI
- [ ] Wallet connect
- [ ] Vault overview
- [ ] Deposit / withdraw
- [ ] Cycle configuration
- [ ] Authorization screen
- [ ] Active cycle status
- [ ] Post-cycle results

### 7.2 Mandatory UX Safeguards
- [ ] Risk disclosures
- [ ] Lock warnings
- [ ] No projections
- [ ] No live P&L

**Exit Criteria:**  
User cannot misunderstand risk or control.

---

## PHASE 8 — Admin & Multisig

### 8.1 Admin Controls
- [ ] Multisig setup
- [ ] Strategy enable/disable
- [ ] Emergency halt
- [ ] NFT mint/revoke

**Exit Criteria:**  
Admins can pause but not interfere.

---

## PHASE 9 — Testing & Hardening

### 9.1 Unit Tests
- [ ] Vault state enforcement
- [ ] Settlement math
- [ ] Zero-profit cycles
- [ ] Discount precedence
- [ ] Referral caps

### 9.2 Failure Injection
- [ ] Strategy failure mid-cycle
- [ ] Settlement revert
- [ ] Emergency halt during execution

**Exit Criteria:**  
System fails closed and tells the truth.

---

## Explicitly Out of Scope for MVP

The following are **not allowed** in v1:

- AI or optimization logic
- Dynamic strategy selection
- Cross-chain execution
- Leverage or borrowing
- DAO control
- Emissions or rewards
- Performance charts
- APY calculations

---

## Final Acceptance Criteria

MVP v1 is accepted when:

- At least one full cycle completes
- Zero-profit cycle completes cleanly
- Positive cycle mints LOOP correctly
- Fees and discounts apply correctly
- Admins cannot change outcomes
- Auditors can trace outcomes end-to-end

If all are true, MVP is complete.

---

## Final Instruction

> **Do not optimize.  
Do not improve.  
Do not extrapolate.  
Build exactly this.**

YieldLoop survives by being correct, not clever.

---
