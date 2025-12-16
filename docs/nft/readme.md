# YieldLoop NFT Program — Documentation Index

This folder contains the **complete, authoritative documentation** for the YieldLoop NFT program.

These documents define:
- What the YieldLoop NFTs are (and are not)
- How they function on-chain
- What developers must build
- What administrators can control
- How users interact with the system

The NFT program is **utility-focused**, **non-investment**, and **not a DAO**.

---

## Purpose of the NFT Program

YieldLoop NFTs exist to provide:
- **Protocol-fee discounts**
- **Role-based access** (UI and Discord gating)
- A structured **advisory and think-tank framework** (Governor role)

They do **not** provide:
- Ownership, equity, or revenue share
- Yield, profit, or appreciation guarantees
- Governance authority or treasury control
- Execution priority or strategy influence

All NFTs are designed to be **utility-only**.

---

## NFT Types

### Supporter NFT
- Publicly mintable utility NFT
- Provides a **5% protocol-fee discount**
- Freely transferable
- Unlimited supply
- Intended for users who want long-term fee reductions and access

### Governor NFT
- Bestowed by the team (not publicly sold by default)
- Represents an **advisory / think-tank role**
- Provides a **10% protocol-fee discount**
- Non-transferable by default
- May be revoked at any time
- Carries **no governance or ownership authority**

---

## How to Use This Documentation

### 👷 Developers
If you are building the NFT system, read the files in this order:

1. **NFT Program Overview**
   - High-level explanation of the NFT system and roles  
   - Located in: `NFT_OVERVIEW.md`

2. **NFT Developer Build Brief**
   - Hard technical rules and implementation requirements  
   - Located in: `NFT_DEV_BRIEF.md`

3. **NFT Admin Panel Specification**
   - Defines all team/admin controls and safety requirements  
   - Located in: `NFT_ADMIN_PANEL.md`

4. **Supporter NFT Mint dApp Specification**
   - Public-facing mint application requirements  
   - Located in: `NFT_MINT_DAPP.md`

Appendices:
- **Appendix B** — Formal NFT policy language  
- **Appendix H** — Governance and advisory framework  

Appendices are **canonical for policy and legal framing**.

---

### 👥 Users and Community Members
If you are a user or community member:
- NFTs are **optional**
- NFTs provide **utility benefits only**
- NFTs are **not investments**

A plain-language user guide is available separately:
- `NFT_USER_GUIDE.md`

---

## Key Design Principles

- **Safety first**: No automated payouts, no yield promises
- **Clarity over hype**: Explicit disclosures and constraints
- **Centralized execution**: Advisory input without loss of control
- **Upgradeable process, immutable contracts**
- **Regulatory awareness**: Avoidance of implied financial rights

---

## Contract and Network Details

- Chain: **BNB Chain**
- Standards: ERC-721 (OpenZeppelin)
- Contracts are **immutable**
- Treasury and privileged roles are controlled by multisig
- Discounts are enforced **on-chain** via `DiscountRegistry`

---

## Status

- This documentation reflects **v1 launch intent**
- Some features are explicitly marked “out of scope” for v1
- Future expansion is possible but **not implied**

---

## Questions or Changes

All changes to the NFT program must:
- Be documented here
- Preserve utility-only intent
- Avoid creating implied ownership, yield, or governance rights

**This README is an index and orientation guide.**  
Individual documents are authoritative for their respective scopes.

---
