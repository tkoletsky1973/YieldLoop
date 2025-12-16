# YieldLoop

**YieldLoop is a proof-driven DeFi execution platform focused on verified surplus, explicit authorization, and conservative system design.**

YieldLoop rejects projected APYs, inflationary rewards, and narrative-based performance.  
Instead, it operates in fixed execution cycles where only **verifiable, realized profit** counts.

If profit cannot be verified **after fees, slippage, gas, and execution costs**, it is treated as **zero**.

The goal is not to promise upside — it is to **prove reality**.

---

## Start Here (Project Overview)

YieldLoop is designed as a **non-custodial, cycle-based execution system** that prioritizes:

- Explicit user authorization
- Deterministic execution
- Post-execution accounting
- Conservative financial posture
- Long-term regulatory durability

The repository contains the **full technical, economic, and governance specification** for the platform.

---

## What Problem YieldLoop Solves

Most DeFi yield systems rely on:
- Estimated or projected APYs
- Emissions or incentives that mask losses
- Continuous dashboards that imply outcomes
- Opaque or discretionary execution logic

These practices make it difficult for users, auditors, or regulators to distinguish **real surplus** from accounting artifacts.

YieldLoop replaces assumption with **verification**.

---

## Core Design Principles

- **Proof over projection**  
  Only realized, post-cost surplus is recognized.

- **Cycle-based execution**  
  Results are measured at the end of each execution cycle.  
  Outcomes are binary: **profit** or **no profit**.

- **No synthetic yield**  
  No emissions, no inflation, no smoothing.

- **Deterministic behavior**  
  No discretionary intervention during execution.

- **Conservative controls**  
  Safety, clarity, and auditability take priority over speed or hype.

---

## Platform Economics (High-Level)

- Fees are charged **only on verified net profit**
- No fees on:
  - Deposits
  - Idle capital
  - Losing cycles
- Platform fees **decrease as AUM grows**
- Fees compress deterministically and lock at a defined minimum

This structure aligns incentives, reduces conflicts, and avoids implied performance signaling.

---

## NFT Program (Utility Only)

YieldLoop includes an **optional, two-tier utility NFT system**.

### Supporter NFT
- Public mint (target price: $300 USD equivalent)
- Unlimited supply
- Transferable
- **5% protocol-fee discount**
- Optional Supporter community access

### Governor NFT
- Team-bestowed advisory role
- One per wallet/person
- Non-transferable by default
- Revocable
- **10% protocol-fee discount**
- Advisory and support participation only  
  *(no governance authority, no ownership rights)*

NFTs are **utility and role tokens only**.  
They do **not** represent ownership, equity, profit share, or guaranteed returns.

**Authoritative documentation:**
- `docs/appendices/APPENDIX_B_NFT_PROGRAM.md`
- `docs/appendices/APPENDIX_H_GOVERNANCE_ADVISORY.md`
- `docs/nft/`

---

## Governance and Control

YieldLoop is **not a DAO at launch**.

- Final decision authority resides with the YieldLoop team
- Treasury and privileged actions are controlled by multisig
- Advisory input is welcomed but **non-binding**

This structure is intentional to preserve accountability, safety, and regulatory clarity.

---

## Current Status

- ✅ Core platform architecture defined
- ✅ Economic and fee model specified
- ✅ NFT program fully documented
- ✅ Governance and advisory framework defined
- ⏳ Smart contracts not yet deployed
- ⏳ Frontend applications not yet built
- ⏳ Independent security audit pending

YieldLoop is currently in the **pre-MVP / specification-complete phase**, preparing for implementation.

---

## Repository Structure

```text
docs/
  whitepaper/        → Core whitepaper and system narrative
  appendices/        → Formal program appendices (NFTs, governance, financials)
  nft/               → Developer-oriented NFT documentation

contracts/           → Smart contracts (to be implemented)
apps/                → Frontend applications (mint dApp, admin panel)
