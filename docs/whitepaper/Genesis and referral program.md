# Genesis Program + Referral Program (Final Spec)
**Applies to:** YieldLoop v0.7.2+  
**Purpose:** bootstrap protocol funding + reserve strength + early community flywheel (without referral farming abuse)

---

## 1) Global Protocol Rules (Baseline)

### 1.1 Chain / Scope
- Chain: BNB Chain (BSC)
- Deposit asset: USDT only
- Pair: BTCB/USDT only
- Venues: PancakeSwap + BiSwap only

### 1.2 Minimum Deposit (Updated)
- **Minimum YieldLoop deposit: 250 USDT**
- Rationale:
  - spam resistance
  - referral sanity
  - improves economic quality of the user base

---

## 2) Genesis Program (First 2,500 Wallets)

### 2.1 Eligibility
- Genesis is limited to the **first 2,500 unique wallets** that complete the Genesis deposit.
- Wallet must be an **EOA** (Externally Owned Account). Contracts are disallowed unless explicitly allowlisted.
- Each wallet may participate only once.

### 2.2 Genesis Deposit Amount
- **Genesis deposit: 300 USDT**

### 2.3 Genesis Deposit Allocation Split (3-way)
Each 300 USDT Genesis deposit is split:

1) **Dev Allocation:** 100 USDT  
2) **Reserve Seeding:** 100 USDT  
3) **Genesis LOOP Allocation:** 100 USDT (issued at fixed internal Genesis issuance price)

---

### 3.1 Genesis Issuance Basis (Accounting Reference Only)
- Genesis LOOP issuance uses an **internal accounting reference unit** for initial allocation.
- This reference unit is NOT:
  - a market price
  - a peg
  - a promise of redemption value
  - a guarantee of exchange rate

**Genesis issuance basis (accounting only):**
- 100 USDT Genesis LOOP allocation → **100 LOOP base issuance**

> NOTE: “Base issuance” is a Genesis allocation reference for mint accounting and vesting schedules only.
> LOOP market value (if any secondary market exists) is independent of this reference.

### 3.2 Genesis Bonus (One-Time)
- Genesis wallets receive a one-time issuance bonus:
  - **Genesis Bonus = +2.5% LOOP**
- Example:
  - 100 LOOP base issuance → **102.5 LOOP minted**

### 3.3 Vesting Schedule (Updated to 180 Days)
- Genesis LOOP is vested:
  - **180 days linear vesting** starting from launch day
- Vesting model:
  - each day unlocks 1/180 of total Genesis LOOP
  - unvested LOOP is non-transferable / non-claimable

### 3.4 Genesis LOOP Supply Cap
- Genesis LOOP minting is capped by Genesis wallet limit:
  - Max participants: 2,500 wallets
- Total Genesis LOOP max (approx):
  - 2,500 * 102.5 LOOP = **256,250 LOOP** max issuance from Genesis (including bonus)

---

## 4) Dev Allocation Usage (Includes Operational Seeding)

### 4.1 Dev Allocation Purpose
Dev Allocation is protocol funding used for:
- smart contract development
- audit
- legal
- infrastructure/hosting
- operations

### 4.2 Required Operational Seed Buckets (Recommended Defaults)
From total Genesis Dev Allocation pool, allocate (admin configurable within hard bounds):

- **ECW Seed (Execution Cost Wallet): 15%**
  - funds BNB gas buffer used for keeper execution
  - non-speculative: cap BNB holdings, replenish only as needed

- **Referral + Marketing Rewards Seed: 15%**
  - funds referral credits paid in USDT
  - held in MarketingRewardsVault

- **Core Dev / Audit / Legal / Infra: 70%**

> Note: Percentages above are recommended defaults. Governance/admin may adjust within predefined min/max bounds.

---

## 5) Genesis Fee Tier (Permanent Wallet-Based Discount)

### 5.1 Discount Benefit
Genesis wallets receive:
- **Genesis Fee Tier = 1.0% fee discount**
- Discount applies to:
  - protocol fees only (performance/withdrawal/mint-redeem fee components as defined)
- Discount does NOT apply to:
  - principal accounting
  - reserve redemption rate limits
  - circuit breakers / safety rules

### 5.2 Transferability (Remove “by request” centralization)
The discount benefit MUST NOT require manual admin approval to transfer.

Recommended implementation:
- Mint a **GenesisBadge NFT**
- Discount applies to the current NFT holder wallet
- NFT is transferable by the user

This:
- removes discretionary centralization optics
- prevents “email Todd to transfer”
- makes the benefit portable and clean

---

## 6) Referral Program (Genesis Contributors Only)

### 6.1 Eligibility
- Only Genesis wallets receive referral codes and may earn referral rewards.

### 6.2 Referral Reward (1 / 1 Credit)
If a referred wallet qualifies:
- **Referrer Reward:** +1 USDT credited to vault principal
- **Referred User Reward:** +1 USDT credited to vault principal

This is funded from MarketingRewardsVault (see Section 7).

### 6.3 Referral Qualification Rules (Anti-Farm)
A referral qualifies ONLY if the referred wallet:

1) deposits **≥ 250 USDT**
2) remains continuously active in the protocol for **30 days**
3) completes the settlement checkpoint / cycle continuation without early exit or exploit flags

This prevents:
- deposit/withdraw farming
- bot loops
- wash activity

### 6.4 Referral Rules (One Referrer Only)
- First referral code used by a wallet becomes permanent (“first referrer wins”)
- Each referred wallet can only qualify once
- A wallet cannot refer itself
- Referral loop patterns are disallowed:
  - A→B and B→A
  - circular chains flagged by rules engine

---

## 7) MarketingRewardsVault (Funding + Limits)

### 7.1 Funding Source
MarketingRewardsVault is funded by:
- Genesis Dev Allocation seed bucket (initial)
- ongoing marketing budget allocations (later)

### 7.2 No Debt Rule
- If MarketingRewardsVault is empty or below threshold:
  - referral rewards automatically pause
- No IOUs, no protocol debt, no negative balances.

### 7.3 Protocol-Wide Rate Limit (Recommended)
Add a protocol-level limit:
- **Max referral payouts per month (global): configurable**
- Example launch defaults:
  - 5,000 USDT / month initially
  - scalable upward by admin/governance as community grows

This prevents runaway budget burn.

---

## 8) Per-Wallet Referral Reward Caps

### 8.1 Monthly Cap (Confirmed)
- **Max referral rewards per wallet per month: 25 USDT**
- Equivalent:
  - 25 qualified referrals/month maximum per referrer wallet

### 8.2 Additional Recommended Safety Cap (Optional)
- Maximum lifetime referral rewards per wallet: configurable
- Example:
  - 250 USDT lifetime maximum per wallet

This is optional but recommended for long-term containment.

---

## 9) Genesis Anti-Sybil + Abuse Controls (Minimum Requirements)

### 9.1 EOA Only
- Genesis participation: EOA-only
- Referral participation: EOA-only (recommended)

### 9.2 Transaction/Pattern Filters
Protocol SHOULD flag and optionally restrict:
- repeated deposits from wallets funded by same wallet in short windows
- contract-based farming behaviors
- high-frequency referral bursts

### 9.3 Sanctions / Abuse Revocation
Genesis and Referral benefits may be revoked only for:
- OFAC/sanctions requirement
- proven exploit behavior
- fraud / abuse patterns (rule-triggered)

Revocation must be rule-based and logged.

---

## 10) Messaging / Compliance Notes (Website + Docs)

All UI/marketing language must avoid:
- guaranteed returns
- fixed APR
- “risk-free”
- “only goes up”
- “profit assured”

Allowed language:
- simulation
- example outcomes
- reserve-backed mechanics
- rate-limited redemption design
- realized profit only
- no fake yield / no emissions yield

---

## End: Genesis + Referral Spec
