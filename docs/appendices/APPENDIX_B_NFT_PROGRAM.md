# Appendix B — YieldLoop NFT Program

## B.1 Purpose and Scope

YieldLoop includes an optional NFT program designed to provide **utility, access, and operational benefits** to participants. The NFT program consists of two tiers:

- **Supporter NFT**
- **Governor NFT**

These NFTs are **not investments**, do not represent equity, ownership, revenue share, profit rights, or guaranteed returns, and do not alter trading execution, strategy selection, or market exposure.

All benefits are operational and may be modified **prospectively**.

---

## B.2 Network and Deployment

- **Blockchain:** BNB Chain  
- **Contracts:** Deployed as **immutable contracts** (no proxy upgrade pattern)  
- **Treasury:** All mint proceeds are routed to a **team/development multisig wallet** (address established prior to deployment)  
- **Refunds:** No refunds under any circumstances  

---

## B.3 NFT Tiers Overview

### B.3.1 Supporter NFT

**Description**  
The Supporter NFT is a paid utility membership NFT intended for supporters of the YieldLoop platform.

**Price**  
- Target price: **$300**
- Implemented as a configurable BNB-denominated mint price
- Price updates apply only to future mints

**Supply**  
- Unlimited

**Minting**
- Public mint via the YieldLoop mint dApp
- Minting is always open by default
- No per-wallet limit
- Admin minting allowed for promotions, marketing, partnerships, or community distribution

**Transferability**
- Freely transferable (standard ERC-721 behavior)

**Utility**
- **5% protocol-fee discount**
- Access to a Supporter-only Discord channel and related platform visibility features

**Visual**
- YieldLoop logo
- “SUPPORTER” text in silver

---

### B.3.2 Governor NFT

**Description**  
The Governor NFT represents a high-trust **advisory and governance-support role** within the YieldLoop ecosystem.

**Minting**
- Team-only mint (bestowed)
- Not sold publicly by default

**Supply**
- Unlimited team minting
- **One per wallet/person**

**Transferability**
- Non-transferable by default
- Transfers allowed only if explicitly authorized by the team multisig for a specific token and recipient

**Revocation**
- Governor NFTs may be revoked and burned by administrative action

**Utility**
- **10% protocol-fee discount**
- Access to a Governor-only Discord channel
- Participation in advisory, think-tank, and support discussions

**Authority**
- No ownership
- No binding governance power
- No treasury control

**Visual**
- YieldLoop logo
- “GOVERNOR” text in gold

---

## B.4 Mint Proceeds and Treasury

All NFT mint proceeds are routed directly to the YieldLoop team/development multisig wallet.

Proceeds may be used for:
- Development
- Audits
- Infrastructure
- Maintenance
- Platform operations

No refunds are provided.

---

## B.5 Protocol-Fee Discounts

### B.5.1 Scope of Discounts

NFT-based discounts apply **only** to the YieldLoop **protocol fee**.

Discounts do not apply to:
- DEX fees
- Slippage
- Gas costs
- Market losses
- Strategy performance

NFT ownership does not affect trade routing, execution priority, or outcomes.

---

### B.5.2 Discount Values

- Supporter NFT: **5% protocol-fee discount**
- Governor NFT: **10% protocol-fee discount**

If a wallet qualifies for both, the **Governor discount overrides** the Supporter discount.

---

### B.5.3 Enforcement

Discounts are enforced **on-chain at settlement** via a dedicated policy contract (`DiscountRegistry`).

Discount values are configurable **prospectively** and do not retroactively affect completed cycles.

---

## B.6 Governor Support Bounty Program

Governors who actively participate in advisory, onboarding, education, partnerships, or other platform-support activities may be eligible for **discretionary support bounties**.

### B.6.1 Funding Source

The Governor support bounty pool is funded **exclusively from the marketing budget**.

- **0.5%–1.0% of the total marketing budget** is allocated to the Governor support pool
- The marketing budget itself is funded from the platform’s existing protocol profit split
- No additional token issuance or emissions are created

---

### B.6.2 Asset and Distribution

- Bounties are paid in **LOOP**
- Distribution is **manual and discretionary**
- Executed by the team multisig
- Timing and amounts vary based on contribution and available budget

---

### B.6.3 No Entitlement

Governor bounties:
- Are not automatic
- Are not guaranteed
- Do not constitute yield, profit share, wages, or compensation

Eligibility is determined by the YieldLoop team based on observed participation.

---

## B.7 Transfer Rules

Supporter NFTs follow standard ERC-721 transfer behavior and may be freely transferred. Any associated benefits follow the wallet that currently holds the NFT.

Governor NFTs are non-transferable by default. A Governor NFT may only be transferred if the team multisig explicitly authorizes a specific transfer. Unauthorized transfers must revert. Governor NFTs may be revoked and burned by administrative action.

---

## B.8 Smart Contract Architecture (Summary)

The NFT program consists of three primary contracts:

- `YieldLoopSupporterNFT` — public mint, transferable utility NFT
- `YieldLoopGovernorNFT` — restricted, revocable advisory NFT
- `DiscountRegistry` — on-chain discount determination

All contracts use role-based access control and are administered by a multisig.

---

## B.9 Applications

The NFT program includes:

- A **public mint dApp** for Supporter NFTs
- A **team-only admin panel** for minting, revocation, transfer authorization, pricing, metadata, and discount configuration

Governor NFTs are not publicly mintable via the dApp.

---

## B.10 Disclosures

YieldLoop NFTs are utility-based role tokens. They do not provide ownership, equity, revenue rights, guaranteed returns, or influence over strategy execution. Discounts apply only to protocol fees and are configurable prospectively. No refunds are provided.

---

## B.11 Future Changes

Future versions of the platform may modify NFT utilities, governance structures, or discount mechanisms through new deployments or policies. No future rights or benefits are implied by current NFT ownership.

---

**End of Appendix B**
