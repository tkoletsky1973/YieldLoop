# YieldLoop — Architecture Overview

This document provides a **system-level overview** of YieldLoop: what components exist, how they interact, and where authority and responsibility live.

It is intentionally high-level and implementation-agnostic. Detailed logic lives in the whitepaper and appendices.

---

## 1) System Goals

YieldLoop is designed to:
- Measure **real, verifiable surplus**
- Avoid projected or synthetic yield
- Enforce rules deterministically on-chain
- Maintain clear administrative accountability
- Separate execution, policy, and presentation layers

---

## 2) High-Level Components

YieldLoop consists of five major layers:

1. **User Interface Layer**
2. **Policy & Access Layer**
3. **Execution & Accounting Layer**
4. **Administrative Control Layer**
5. **Off-Chain Services (Optional)**

Each layer has a narrow, well-defined responsibility.

---

## 3) User Interface Layer

### Components
- YieldLoop user dashboard (future)
- Supporter NFT public mint dApp
- NFT admin panel (team-only)

### Responsibilities
- Wallet connection
- Network validation (BNB Chain)
- User input and confirmations
- Display of state (balances, NFTs, discounts)

### Non-Responsibilities
- No private key custody
- No decision-making authority
- No accounting or settlement logic

All user-facing applications are **read-only with respect to system rules** and submit transactions to on-chain contracts.

---

## 4) Policy & Access Layer

### Key Contracts
- `DiscountRegistry`
- NFT contracts (`YieldLoopSupporterNFT`, `YieldLoopGovernorNFT`)

### Responsibilities
- Determine protocol-fee discounts
- Identify user roles (Supporter / Governor)
- Enforce role-based rules
- Centralize configurable policy values

### Key Design Choice
Policy is **separated** from execution so:
- Discounts can be adjusted prospectively
- NFT logic does not contaminate trading logic
- The core protocol remains simpler and auditable

---

## 5) Execution & Accounting Layer

### Components
- YieldLoop core protocol contracts (to be implemented)

### Responsibilities
- Accept deposits
- Execute strategies
- Track realized profit or loss
- Apply protocol fees
- Query `DiscountRegistry` at settlement
- Record verified surplus

### Key Principle
Execution contracts **do not trust UIs** and **do not infer discounts**.  
They always compute fees and discounts on-chain.

---

## 6) Administrative Control Layer

### Control Mechanism
- Multisig wallet

### Controlled Actions
- Minting and revocation of Governor NFTs
- Authorization of Governor transfers
- Configuration of mint price and treasury
- Adjustment of discount values
- Pause/unpause of minting
- Future protocol configuration changes

### Design Intent
Administrative authority is:
- Explicit
- Traceable on-chain
- Limited to necessary controls
- Centralized initially for safety

There is no implicit or hidden governance.

---

## 7) Governance vs Advisory Separation

- **Advisory:** Governor NFTs, discussion, feedback, support
- **Governance:** Multisig-controlled actions

No NFT holder has binding authority at launch.

This separation is intentional and documented in Appendix H.

---

## 8) Off-Chain Services (Optional)

These services improve UX but are not required for correctness:

- Event indexers (for dashboards)
- Discord role gating
- Analytics dashboards
- Notifications

Failure of off-chain services must **not** affect core protocol behavior.

---

## 9) Data Flow Summary

1. User interacts with UI
2. UI submits transaction to contract
3. Contract enforces rules
4. At settlement:
   - Core protocol queries `DiscountRegistry`
   - Protocol fee is calculated and adjusted
   - Verified result is recorded
5. UI reflects on-chain state

---

## 10) Security and Trust Boundaries

- Users trust **on-chain contracts**, not UIs
- UIs trust **wallet providers**
- Admin actions are gated by multisig
- Advisory roles have no execution authority

This minimizes trust assumptions.

---

## 11) Extensibility

Future additions may include:
- Additional policy registries
- New NFT tiers
- Formal governance modules
- Cross-chain execution layers

Such changes require new deployments or explicit disclosures.  
No future functionality is implied.

---

## 12) Where to Go Next

- Whitepaper: `docs/whitepaper/`
- NFT Program: `docs/appendices/APPENDIX_B_NFT_PROGRAM.md`
- Governance: `docs/appendices/APPENDIX_H_GOVERNANCE_ADVISORY.md`
- NFT Dev Docs: `docs/nft/`

---

**Architecture favors clarity over cleverness.**
