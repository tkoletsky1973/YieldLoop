# YieldLoop NFT Program — Developer Build Brief (BNB Chain)

This document defines **exactly what must be built** for the YieldLoop NFT program.  
It is authoritative for implementation details and should be followed alongside Appendix B and Appendix H.

---

## 1) Scope of work

You are building a **two-tier utility NFT system** on **BNB Chain**, consisting of:

1. **Smart contracts**
   - Supporter NFT (public mint)
   - Governor NFT (team-bestowed, restricted)
   - DiscountRegistry (on-chain discount policy)

2. **Web applications**
   - Public mint dApp (Supporter NFT)
   - Admin panel (team-only controls)

3. **Optional integrations**
   - Discord role gating
   - Event indexing for admin dashboards

The system is **not** a DAO, **not** yield-generating, and **not** an investment product.

---

## 2) NFT tier requirements (hard rules)

### 2.1 Supporter NFT

**Purpose**
- Paid utility membership NFT

**Rules**
- Mint price: **$300 target**
  - Implemented as a configurable BNB-denominated price
  - Admin may update price prospectively
- Supply: unlimited
- Minting:
  - Public mint always enabled
  - Unlimited per wallet
  - Admin mint allowed for promos/partnerships
- Transfers:
  - Fully transferable (standard ERC-721)
- Discount:
  - **5% protocol-fee discount**
- Access:
  - Supporter Discord channel
- Refunds:
  - None

**Artwork**
- YieldLoop logo
- Text: “SUPPORTER” in silver

---

### 2.2 Governor NFT

**Purpose**
- Advisory / governance-support role token

**Rules**
- Minting:
  - Team-only (admin mint)
  - Not sold publicly by default
- Supply:
  - Unlimited admin minting
  - **One per wallet/person**
- Transfers:
  - Non-transferable by default
  - Transfer only allowed via explicit multisig authorization
- Revocation:
  - Admin can revoke and burn
- Discount:
  - **10% protocol-fee discount**
- Access:
  - Governor Discord channel
- Role:
  - Advisory only
  - No ownership
  - No binding governance authority

**Artwork**
- YieldLoop logo
- Text: “GOVERNOR” in gold

---

## 3) Governor support bounty (_toggleable, non-automated_)

- Paid in **LOOP**
- Only for active Governors
- Funded from **0.5%–1.0% of the total marketing budget**
- Marketing budget comes from the platform’s existing profit split
- Manual, discretionary multisig distribution
- Not guaranteed, not automatic, not yield

No on-chain bounty logic is required in v1.

---

## 4) Smart contract architecture

All contracts are **immutable** (no proxy pattern).

### 4.1 Contracts to implement

| Contract | Purpose |
|-------|--------|
| `YieldLoopSupporterNFT` | Public mint utility NFT |
| `YieldLoopGovernorNFT` | Restricted, revocable advisory NFT |
| `DiscountRegistry` | On-chain discount determination |

---

## 5) Supporter NFT contract (`YieldLoopSupporterNFT.sol`)

### Required standards
- ERC-721
- OpenZeppelin AccessControl
- Pausable

### State
- `address treasuryMultisig`
- `uint256 mintPriceWei`
- `bool mintEnabled`

### Functions
- `mintPublic(uint256 qty)` — payable, public
- `mintAdmin(address to, uint256 qty)` — admin
- `setMintPrice(uint256 newPriceWei)` — admin
- `setTreasury(address newTreasury)` — admin
- `setMintEnabled(bool enabled)` — admin
- `setBaseURI(string newBaseURI)` — admin
- `pause()` / `unpause()` — admin

### Funds handling
- All mint proceeds forwarded to `treasuryMultisig`
- No refund logic

---

## 6) Governor NFT contract (`YieldLoopGovernorNFT.sol`)

### Required standards
- ERC-721
- AccessControl
- Pausable

### State
- `mapping(uint256 => address) authorizedRecipient`
- `mapping(address => bool) hasGovernor`

### Functions
- `mintAdmin(address to, uint256 qty, string reason)` — admin
  - Must enforce `hasGovernor[to] == false`
- `authorizeTransfer(uint256 tokenId, address approvedRecipient)` — admin
- `revoke(uint256 tokenId)` — admin
- `setBaseURI(string newBaseURI)` — admin
- `pause()` / `unpause()` — admin

### Transfer logic
- Allow mint (`from == address(0)`)
- Allow burn (`to == address(0)`)
- Otherwise:
  - Require `to == authorizedRecipient[tokenId]`
  - Clear authorization after transfer
- Unauthorized transfers must revert

---

## 7) DiscountRegistry (`DiscountRegistry.sol`)

### Purpose
Provide deterministic on-chain protocol-fee discounts.

### State
- `address supporterNft`
- `address governorNft`
- `uint16 supporterDiscountBps` (default: 500)
- `uint16 governorDiscountBps` (default: 1000)
- `bool discountsEnabled` (optional)

### View
- `getDiscountBps(address user) returns (uint16)`

### Rules
- If discounts disabled → return 0
- If Governor holder → return governorDiscountBps
- Else if Supporter holder → return supporterDiscountBps
- Else → 0

### Admin
- `setDiscounts(uint16 supporterBps, uint16 governorBps)`
- `setNftAddresses(address supporter, address governor)`
- `setDiscountsEnabled(bool enabled)`

---

## 8) Public mint dApp (Supporter)

### Required features
- Wallet connect (MetaMask + WalletConnect)
- BNB Chain detection + network switch
- Mint quantity selector
- Mint transaction flow with status
- “My NFTs” view:
  - Detect Supporter/Governor ownership
  - Display active discount status
- Disclosures:
  - Utility-only NFT
  - No refunds
  - Discounts apply to protocol fees only

### Pages
- Landing / explanation
- Mint Supporter
- My NFTs
- Disclosures

Governor mint UI should not be exposed.

---

## 9) Admin panel dApp

### Access control
- Wallet-based gating
- Admin role required for all actions

### Required actions
- Mint Supporter NFTs (single + batch)
- Mint Governor NFTs (single + batch with reason)
- Revoke Governor NFT
- Authorize Governor transfer
- Set Supporter mint price
- Set treasury multisig
- Set discount bps
- Enable/disable discounts (optional)
- Set baseURIs
- Pause/unpause minting

### Visibility
- Mint totals
- Recent admin actions/events
- Optional export of holder lists

---

## 10) Out of scope (v1)

- DAO voting
- Automated bounty distribution
- NFT staking
- Yield mechanics
- KYC
- Oracle-based USD pricing

---

## 11) Definition of done

- Supporter mint works end-to-end on BNB testnet
- Admin panel performs all privileged actions
- Governor transfer blocked unless authorized
- Governor revoke works correctly
- DiscountRegistry returns correct values
- Contracts verified on explorer
- Documentation updated

---

## 12) Next file

Proceed to: `docs/nft/NFT_ADMIN_PANEL.md`
