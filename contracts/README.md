# YieldLoop Smart Contracts

This folder contains the on-chain contracts for the YieldLoop platform.

All contracts in this directory must follow the specifications defined in the YieldLoop whitepaper and appendices. Where conflicts exist, **appendices take precedence over UI assumptions**.

---

## 1) Network and Deployment Model

- **Target chain:** BNB Chain
- **Deployment model:** Immutable contracts (no proxy upgrade pattern)
- **Admin model:** Multisig-controlled roles
- **Refunds:** None
- **KYC:** None

Contracts must be written defensively and assume hostile inputs.

---

## 2) Contract Groups

### 2.1 NFT Program Contracts

These contracts implement the utility NFT system described in **Appendix B** and **Appendix H**.

**Location**
```text
contracts/nft/

Contracts
	•	YieldLoopSupporterNFT.sol
	•	YieldLoopGovernorNFT.sol
	•	DiscountRegistry.sol

These contracts are responsible for:
	•	Public minting of Supporter NFTs
	•	Team-bestowed minting of Governor NFTs
	•	Restricted transfers and revocation of Governor NFTs
	•	On-chain determination of protocol-fee discounts

Authoritative specification:
	•	docs/appendices/APPENDIX_B_NFT_PROGRAM.md
	•	docs/appendices/APPENDIX_H_GOVERNANCE_ADVISORY.md
	•	docs/nft/

⸻

2.2 Core Protocol Contracts (Future)

Core YieldLoop execution contracts will live here once implementation begins.

These contracts are expected to:
	•	Accept deposits
	•	Execute strategies
	•	Measure realized profit or loss
	•	Apply protocol fees
	•	Query DiscountRegistry at settlement
	•	Record verified surplus

They are not part of the NFT system and should remain decoupled.

⸻

3) Design Rules (Non-Negotiable)

All contracts in this repo must adhere to the following rules:
	•	No reliance on frontend logic for enforcement
	•	All critical rules enforced on-chain
	•	No hidden state or implicit permissions
	•	Explicit role-based access control
	•	Events emitted for all privileged actions
	•	No assumptions about benevolent users or admins

⸻

4) Access Control and Roles

Contracts must use role-based access control (OpenZeppelin recommended).

Typical roles include:
	•	DEFAULT_ADMIN_ROLE — multisig (ultimate authority)
	•	MINTER_ROLE — minting authority
	•	PAUSER_ROLE — emergency controls
	•	URI_ROLE — metadata management

No externally owned account (EOA) should retain permanent unilateral control once multisig is configured.

⸻

5) Discount Enforcement Rule

Discounts:
	•	Apply only to protocol fees
	•	Are determined on-chain
	•	Are queried via DiscountRegistry
	•	Are applied at settlement time

Execution contracts must never assume discount values or infer them off-chain.

⸻

6) Testing Expectations

Every contract must have tests covering:
	•	Happy paths
	•	Failure paths
	•	Unauthorized access attempts
	•	Boundary conditions
	•	Event emissions

At minimum, NFT contracts must test:
	•	Public mint
	•	Admin mint
	•	Transfer restrictions
	•	Revocation
	•	Discount precedence

⸻

7) Security Expectations
	•	Use OpenZeppelin libraries where appropriate
	•	Avoid unnecessary complexity
	•	Prefer explicit logic over clever abstractions
	•	Treat all external calls as hostile
	•	Emit events for all admin actions

⸻

8) Documentation Expectations

Each contract file must include:
	•	A header comment stating purpose
	•	Reference to the governing appendix
	•	A clear description of privileged roles
	•	Notes on any configurable parameters

Example header snippet:
/**
 * @title YieldLoopSupporterNFT
 * @notice Public utility NFT for YieldLoop supporters
 * @dev See Appendix B — NFT Program
 */

9) What Does NOT Belong Here
	•	Frontend code
	•	Wallet private keys
	•	Hardcoded admin EOAs
	•	Business logic that belongs in off-chain services
	•	DAO governance code (unless explicitly approved)

⸻

10) Read This Before Coding

Developers should read, in order:
	1.	Root README.md
	2.	Whitepaper (docs/whitepaper/)
	3.	Appendix B — NFT Program
	4.	Appendix H — Governance & Advisory
	5.	docs/nft/NFT_DEV_BRIEF.md

Only then should implementation begin.

⸻

Clarity beats cleverness. Security beats speed.
