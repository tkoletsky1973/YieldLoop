# YieldLoop NFT Admin Panel — Functional Specification

This document defines **exactly what the NFT Admin Panel must do**, who can access it, and how it interacts with on-chain contracts.

This panel is **team-only**, wallet-gated, and is a **critical control surface**.  
Nothing here should be guesswork for a developer.

---

## 1) Purpose of the Admin Panel

The Admin Panel exists to allow the YieldLoop team (via multisig / admin wallets) to:

- Control NFT minting and distribution
- Bestow and revoke Governor roles
- Enforce restricted Governor transfers
- Configure mint pricing and treasury routing
- Configure protocol-fee discounts
- Manage metadata and safety controls
- Monitor NFT-related activity

The Admin Panel **does not**:
- Expose public minting (except Supporter via the public dApp)
- Grant governance authority
- Automate bounties or payouts

---

## 2) Access Control

### 2.1 Wallet-based gating
- Admin access is granted based on wallet address
- Wallet must hold appropriate on-chain admin roles
- UI must block and hide admin actions from non-admin wallets

### 2.2 Role model (recommended)
- `DEFAULT_ADMIN_ROLE` — multisig (ultimate authority)
- `MINTER_ROLE` — minting actions
- `PAUSER_ROLE` — pause/unpause
- `URI_ROLE` — metadata updates

The Admin Panel must **check roles on-chain**, not rely on a static allowlist.

---

## 3) Required Screens and Capabilities

### 3.1 Dashboard (Landing)

**Purpose**
- High-level visibility into NFT system state

**Must display**
- Total Supporter NFTs minted
- Total Governor NFTs minted
- Current Supporter mint price (BNB)
- Current discount values (Supporter % / Governor %)
- Minting status (enabled/paused)
- Treasury multisig address

**Optional**
- Recent admin actions
- Recent mint events

---

### 3.2 Mint Supporter NFTs

**Purpose**
- Admin distribution for marketing, partnerships, community rewards

**Features**
- Mint to a single wallet
- Batch mint via CSV upload (wallet address + quantity)
- Quantity input
- Confirmation modal before execution

**On-chain action**
- Calls `mintAdmin(address to, uint256 qty)`

**UI safeguards**
- Validate wallet address
- Prevent zero-quantity mints
- Require explicit confirmation

---

### 3.3 Mint Governor NFTs (Bestowal)

**Purpose**
- Bestow Governor advisory roles

**Features**
- Mint to a single wallet
- Batch mint (optional)
- Input field for **reason** (free text, logged for record-keeping)

**Rules**
- Enforce one Governor per wallet (surface error if already exists)
- Governor minting is admin-only

**On-chain action**
- Calls `mintAdmin(address to, uint256 qty, string reason)`

---

### 3.4 Revoke Governor NFT

**Purpose**
- Remove Governor role and burn NFT

**Features**
- Input Governor tokenId or wallet address
- Display current holder and metadata
- Confirmation modal with warning language

**On-chain action**
- Calls `revoke(uint256 tokenId)`

**Rules**
- Revocation is irreversible
- UI must clearly warn before execution

---

### 3.5 Authorize Governor Transfer

**Purpose**
- Allow an exception transfer of a Governor NFT

**Features**
- Input tokenId
- Input approved recipient address
- Display current owner
- Confirmation modal explaining this is a one-time authorization

**On-chain action**
- Calls `authorizeTransfer(uint256 tokenId, address approvedRecipient)`

**Rules**
- Authorization applies to one transfer only
- Authorization is cleared after transfer
- Unauthorized transfers must revert

---

### 3.6 Pricing and Treasury Configuration

**Purpose**
- Control Supporter mint economics

**Features**
- Set Supporter mint price (BNB)
- Update treasury multisig address
- Display current values

**On-chain actions**
- `setMintPrice(uint256 newPriceWei)`
- `setTreasury(address newTreasury)`

**Rules**
- Changes apply prospectively only
- UI must validate non-zero addresses

---

### 3.7 Discount Policy Configuration

**Purpose**
- Manage protocol-fee discounts

**Features**
- Set Supporter discount (bps)
- Set Governor discount (bps)
- Toggle discounts enabled/disabled (optional emergency)

**On-chain actions**
- `setDiscounts(uint16 supporterBps, uint16 governorBps)`
- `setDiscountsEnabled(bool enabled)` (if implemented)

**Rules**
- Discount changes do not retroactively affect past settlements
- UI should display warnings explaining impact

---

### 3.8 Metadata Management

**Purpose**
- Update NFT metadata hosting

**Features**
- Set baseURI for Supporter NFT
- Set baseURI for Governor NFT

**On-chain action**
- `setBaseURI(string newBaseURI)`

**Rules**
- UI should warn that metadata changes affect all tokens
- Optional: irreversible “freeze metadata” if implemented later

---

### 3.9 Safety Controls

**Purpose**
- Emergency control over minting

**Features**
- Pause/unpause Supporter mint
- Pause/unpause Governor mint (if applicable)

**On-chain actions**
- `pause()`
- `unpause()`

**Rules**
- Pause affects minting only
- Transfers follow contract rules regardless of pause state (unless explicitly coded otherwise)

---

### 3.10 Events and Reporting

**Purpose**
- Visibility and auditability

**Features**
- Display recent events:
  - Supporter minted (public/admin)
  - Governor minted
  - Governor revoked
  - Transfer authorized
  - Pricing updated
  - Discounts updated
- Optional CSV export of holder lists

**Implementation**
- Read directly from chain or via lightweight indexer

---

## 4) UI/UX Expectations

- Clear warnings for destructive actions
- Explicit confirmation for admin actions
- Dark-mode friendly (to match YieldLoop branding)
- Responsive layout (desktop-first)

---

## 5) Security Expectations

- Admin panel must never store private keys
- All transactions must require wallet confirmation
- Multisig should control all high-privilege roles
- UI should clearly show which wallet is connected

---

## 6) Out of Scope (Admin Panel)

- Automated bounty distribution
- DAO voting
- User account management
- Identity/KYC systems

---

## 7) Next File

Proceed to: `docs/nft/NFT_MINT_DAPP.md`
