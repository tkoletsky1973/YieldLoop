# YieldLoop NFT Program Overview (BNB Chain)

This folder documents the complete YieldLoop NFT program: what it is, what users can do, what admins can do, and what developers must build.

If you are a developer starting work, read this file first, then `NFT_DEV_BRIEF.md`, then Appendix B and Appendix H.

---

## 1) What the NFT program is

YieldLoop has two utility/role NFTs:

- **Supporter NFT** (public, purchasable)
- **Governor NFT** (team-bestowed advisory role)

These NFTs exist to provide:
- Operational **protocol-fee discounts**
- Access control / role signaling (UI + Discord gating)
- A structured advisory/governance-support group (Governor)

These NFTs do **not** provide:
- Ownership, equity, or revenue share
- Profit rights or “yield”
- Guarantees of performance or appreciation
- Execution priority or strategy changes

---

## 2) Network and treasury basics

- Chain: **BNB Chain**
- Supporter mint proceeds: routed to **team/dev multisig** (address TBD at deployment)
- Refunds: **none**
- Contracts: **immutable** (no proxy upgrades)

---

## 3) NFT tiers (user-facing summary)

### Supporter NFT
- Price: **$300** (implemented as a configurable BNB mint price)
- Supply: unlimited
- Minting: public mint, always open
- Transfers: freely transferable (standard ERC-721)
- Discount: **5% protocol-fee discount**
- Access: Supporter Discord channel
- Admin minting: allowed for promotions/partnerships/community distribution
- Artwork: YieldLoop logo + “SUPPORTER” in **silver**

### Governor NFT
- Minting: **team-only** (bestowed), not sold by default
- Supply: unlimited team-only minting, but **one per wallet/person**
- Transfers: non-transferable by default; transfer only via explicit multisig authorization
- Revocation: admin can revoke/burn
- Discount: **10% protocol-fee discount**
- Access: Governor Discord channel
- Role: advisory/think tank/support (no ownership, no oversight yet)
- Artwork: YieldLoop logo + “GOVERNOR” in **gold**

---

## 4) Discounts (how they work)

Discounts apply only to the **protocol fee** and are enforced **on-chain** at settlement via `DiscountRegistry`.

- If wallet holds Governor NFT → 10% discount applies
- Else if wallet holds Supporter NFT → 5% discount applies
- Else → no discount
- Governor overrides Supporter
- Discounts do not affect DEX fees, slippage, gas, losses, routing, or strategy outcomes

---

## 5) Governor Think Tank Bounties (Advisory Sessions, Not Yield)

Governor NFTs may be invited to participate in discrete, purpose-defined advisory or “think tank” sessions convened by the YieldLoop team.

These sessions are operational and advisory in nature and do not constitute governance authority, ownership rights, employment, or compensated services.

---

### Structure of Think Tank Sessions

Each think tank session is defined **in advance** and includes:

- A specific purpose or topic
- A fixed date and duration
- A **maximum number of available seats**
- A **predefined bounty pool** assigned before participation begins

Participation is invite-based or application-based at the team’s discretion. Governors are not required or expected to participate in any session.

---

### Bounty Assignment and Distribution

- Each session has a **fixed bounty pool** established prior to the meeting
- The bounty pool is sourced from a configurable **0.5%–1.0% of the total marketing budget**
- The marketing budget itself is funded from the platform’s existing profit split

At the conclusion of the session:
- The bounty pool is split **equally** among:
  - Verified attendees
  - Participants who complete the required advisory participation (e.g., attendance and confirmed vote or input)

Distributions are:
- Manual and discretionary in v1
- Executed via team multisig
- Paid in LOOP or another designated token

---

### Cool-Down and Participation Limits

To ensure broad participation and prevent concentration:

- Any Governor who **receives a bounty payment for a think tank session** becomes **ineligible for the immediately subsequent session**
- This cool-down applies regardless of topic or session size
- Governors who do not receive a bounty (e.g., did not attend or did not participate fully) are not subject to the cool-down

The purpose of this rule is to:
- Rotate advisory participation
- Encourage diverse perspectives
- Prevent recurring or implied compensation relationships

---

### Important Constraints

Think tank bounties:

- Are **not automatic**
- Are **not guaranteed**
- Do **not accrue**
- Do **not represent compensation for services**
- Do **not create employment, contractor, or fiduciary relationships**
- Do **not constitute yield, income, or profit sharing**

Failure to attend or participate carries no penalty, and participation in one session does not confer priority or entitlement for future sessions.

These sessions exist solely to support structured advisory input and are treated as a bounded, discretionary operational expense.

---

## 6) What must be built (high level)

### On-chain contracts
- `YieldLoopSupporterNFT.sol`
- `YieldLoopGovernorNFT.sol`
- `DiscountRegistry.sol`

### Web apps
- Public mint dApp (Supporter purchase/mint)
- Admin panel (mint/award/revoke/authorize transfer/configure discounts/metadata/price)

### Off-chain integrations (optional but expected)
- Discord token-gating (Supporter channel + Governor channel)
- Event indexing for admin dashboard views

---

## 7) Where the formal spec lives

- Appendix B: `docs/appendices/APPENDIX_B_NFT_PROGRAM.md`
- Appendix H: `docs/appendices/APPENDIX_H_GOVERNANCE_ADVISORY.md`

This `docs/nft/` folder is developer-oriented. Appendices are canonical for policy language.

---

## 8) Next file to read

Proceed to: `docs/nft/NFT_DEV_BRIEF.md`
