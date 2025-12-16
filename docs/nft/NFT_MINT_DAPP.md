# YieldLoop Supporter NFT — Public Mint dApp Specification

This document defines the **public-facing mint application** used to purchase and mint the **Supporter NFT** on BNB Chain.

This dApp is intentionally simple, transparent, and utility-focused.

---

## 1) Purpose

The Supporter Mint dApp exists to:
- Allow users to purchase/mint the Supporter NFT
- Clearly explain what the NFT does and does not do
- Show users their NFT holdings and discount status
- Route mint proceeds to the team/dev multisig

This dApp does **not**:
- Mint Governor NFTs
- Provide financial advice
- Promise yield, profit, or appreciation

---

## 2) Supported Network and Wallets

- Chain: **BNB Chain**
- Wallets:
  - MetaMask
  - WalletConnect-compatible wallets

The dApp must:
- Detect the active network
- Prompt users to switch to BNB Chain if connected elsewhere
- Block minting on unsupported networks

---

## 3) Required Pages

### 3.1 Landing / Explanation Page

**Purpose**
- Educate users before minting

**Must include**
- Plain-language explanation of:
  - What YieldLoop is
  - What the Supporter NFT is
  - What benefits it provides
  - What it does not provide
- Key facts:
  - Unlimited supply
  - $300 target price
  - 5% protocol-fee discount
  - Transferable NFT
  - No refunds
- Clear link to:
  - Whitepaper
  - Appendix B (NFT Program)
  - Disclosures page

---

### 3.2 Mint Page

**Purpose**
- Execute Supporter NFT mint

**Features**
- Wallet connect button
- Network guard (BNB Chain)
- Quantity selector
- Display:
  - Mint price per NFT (BNB)
  - Estimated total cost
- Mint button
- Transaction status:
  - Pending
  - Confirmed
  - Failed (with error message)

**On-chain action**
- Calls `mintPublic(uint256 qty)` on `YieldLoopSupporterNFT`

---

### 3.3 My NFTs Page

**Purpose**
- Show users what they own and what it means

**Features**
- Display:
  - Supporter NFT count
  - Governor NFT status (if any)
- Display discount status:
  - “Active protocol-fee discount: 5%”
  - “Active protocol-fee discount: 10% (Governor)”
  - “No active discount”
- Optional:
  - Token images and metadata
  - Links to blockchain explorer

**Implementation**
- Query NFT contracts directly
- Query `DiscountRegistry.getDiscountBps(wallet)`

---

### 3.4 Disclosures Page

**Purpose**
- Set expectations clearly

**Must include**
- Utility-only NFT disclosure
- No refunds
- Discounts apply to protocol fees only
- No effect on strategy execution or returns
- NFTs are not investments

---

## 4) UX Requirements

- Clear call-to-action
- Minimal steps to mint
- Explicit warnings before transaction
- Mobile-friendly layout
- Dark theme consistent with YieldLoop branding

---

## 5) Error Handling

The dApp must handle:
- Wallet not connected
- Wrong network
- User rejects transaction
- Insufficient funds
- Contract revert (surface readable error)

Errors must be user-readable, not raw RPC messages.

---

## 6) Security Considerations

- No private keys stored
- No backend custody
- All transactions signed by user wallet
- Contract addresses must be hardcoded per network (no user override)

---

## 7) Out of Scope

- Governor minting
- Secondary marketplace integration
- Bounty management
- DAO governance
- User accounts beyond wallet connection

---

## 8) Completion Criteria

The mint dApp is considered complete when:
- Users can mint Supporter NFTs on BNB testnet
- NFT appears in wallet after mint
- “My NFTs” page reflects correct discount status
- Disclosures are visible and clear
- All transactions route funds to multisig

---

**End of NFT Mint dApp Specification**
