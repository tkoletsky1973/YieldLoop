# YieldLoop Documentation — How to Use This Folder

This directory contains the **authoritative design, engineering, and audit documentation** for the YieldLoop platform.

These documents are not marketing materials.  
They are intended for **developers, auditors, reviewers, and serious technical collaborators**.

If you are looking for a high-level explanation of what YieldLoop is, start with the Whitepaper.  
If you are building or auditing the system, start with the Engineering Handoff.

---

## Canonical Reading Order (Important)

Different audiences should read these documents in **different orders**.

### 🔹 For Developers (Primary Audience)

Read **in this exact order**:

1. **`handoff_doc.md`**  
   → The authoritative engineering handoff  
   → Defines system intent, constraints, and non-negotiables  

2. **`HANDOFF_APPENDIX_CONTRACT_INTERFACES.md`**  
   → What contracts exist  
   → What each contract is allowed to do  
   → Required interfaces and storage  

3. **`HANDOFF_APPENDIX_SETTLEMENT_PSEUDOCODE.md`**  
   → The core truth engine  
   → How profit, fees, LOOP minting, and zero-profit cycles work  

4. **`HANDOFF_SEQUENCE_DIAGRAMS.md`**  
   → Exact execution and settlement flows  
   → What happens, when, and in what order  

5. **`HANDOFF_APPENDIX_NFTS_AND_REFERRALS.md`**  
   → Peripheral systems  
   → What NFTs and referrals can and *cannot* influence  

6. **`HANDOFF_MVP_TASK_BREAKDOWN.md`**  
   → Build order  
   → Scope boundaries  
   → What “done” means for MVP  

7. **`HANDOFF_AUDIT_CHECKLIST.md`**  
   → Final self-check before calling something complete  

If a behavior is not allowed by these documents, **do not implement it** without clarification.

---

### 🔹 For Auditors / Reviewers

Read in this order:

1. `handoff_doc.md`  
2. `HANDOFF_APPENDIX_SETTLEMENT_PSEUDOCODE.md`  
3. `HANDOFF_AUDIT_CHECKLIST.md`  
4. `HANDOFF_SEQUENCE_DIAGRAMS.md`  
5. `HANDOFF_APPENDIX_CONTRACT_INTERFACES.md`  

The system is considered correct only if:
- Every outcome can be traced through settlement pseudocode
- Every authority boundary is enforced
- Zero-profit cycles are handled cleanly

---

### 🔹 For Conceptual / Product Understanding

Start here:

- **`Whitepaper (long).md`**

The whitepaper explains:
- Why YieldLoop exists
- What problem it solves
- How it differs from traditional DeFi
- The philosophical and regulatory posture

**Important:**  
The whitepaper explains *intent*.  
The handoff documents explain *implementation*.  
If there is ever ambiguity, the **handoff documents control behavior**.

---

## File Descriptions (What Each Document Is)

### `handoff_doc.md`
The **master engineering handoff**.  
Defines:
- Core philosophy
- System boundaries
- Non-negotiable constraints
- What YieldLoop is *not*

This is the “north star” for all implementation decisions.

---

### `HANDOFF_APPENDIX_CONTRACT_INTERFACES.md`
Defines:
- All core contracts
- Their responsibilities
- Their interfaces
- Authority boundaries

This prevents:
- Overlapping permissions
- Hidden coupling
- “We’ll just add a function” mistakes

---

### `HANDOFF_APPENDIX_SETTLEMENT_PSEUDOCODE.md`
Defines:
- The only place profit is recognized
- Fee calculation order
- NFT discount application
- Referral credit timing
- LOOP minting rules

If this logic is wrong, the system is wrong.

---

### `HANDOFF_SEQUENCE_DIAGRAMS.md`
Defines:
- Exact call order
- State transitions
- Failure paths
- Emergency halt behavior

These are **behavioral contracts**, not illustrations.

---

### `HANDOFF_APPENDIX_NFTS_AND_REFERRALS.md`
Defines:
- NFT roles and discounts
- Referral eligibility and limits
- Explicit non-permissions

NFTs and referrals are **settlement-time modifiers only**.

---

### `HANDOFF_MVP_TASK_BREAKDOWN.md`
Defines:
- What is included in MVP v1
- Build order
- Explicit out-of-scope items

If it’s not listed here, it is not part of MVP.

---

### `HANDOFF_AUDIT_CHECKLIST.md`
Defines:
- What must be true for the system to pass audit
- What constitutes failure
- What auditors should verify line-by-line

This is the final gate before deployment.

---

### `Whitepaper (long).md`
Defines:
- Vision
- Motivation
- User-facing explanation
- Regulatory posture
- Design philosophy

This document should **never be used alone** to build the system.

---

## One Rule That Applies Everywhere

> **If an outcome cannot be explained deterministically from these documents, it must not exist in the system.**

YieldLoop is designed to:
- Execute
- Settle
- Tell the truth
- Survive flat or losing markets

Anything else is secondary.

---

## Questions or Clarifications

If you are implementing this system and encounter a decision that requires:
- Guessing intent
- Optimizing outcomes
- Adding convenience that blurs finality

Stop and ask.

YieldLoop only works if the boundaries are respected.

---
