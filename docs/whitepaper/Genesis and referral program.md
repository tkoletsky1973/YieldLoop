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

### 5.2 Transferability (No Manual Admin, But Anti-Flip Protected)
The discount benefit MUST NOT require manual admin approval to transfer.

Recommended implementation:
- Mint a **GenesisBadge NFT**
- Discount applies to the current NFT holder wallet
- NFT is transferable by the user

**Anti-abuse rule (mandatory):**
- GenesisBadge benefits use a **warm-up activation delay**
- After receiving the NFT (mint or transfer), the wallet must hold it for **30 days** before:
  - Genesis Fee Tier discount activates
  - referral eligibility activates (if tied to badge)

This:
- keeps transferability (no admin discretion)
- prevents instant discount flipping / resale farming
- blocks referral-code resale markets
- makes Genesis “early users” real participants, not badge speculators

---

## 6) Referral Program (Genesis Contributors Only)

### 6.1 Eligibility
- Genesis participants receive a GenesisBadge NFT.
- Only wallets with an **active GenesisBadge** may earn referral rewards.
- Active GenesisBadge = NFT held past the warm-up activation delay.

### 6.2 Referral Reward (1 / 1 Credit)
If a referred wallet qualifies:
- **Referrer Reward:** +1 USDT credited to vault principal
- **Referred User Reward:** +1 USDT credited to vault principal

This is funded from MarketingRewardsVault (see Section 7).

### 6.3 Qualification Trigger (One-Time, Wallet-Level)
A referred wallet qualifies for a referral reward only once, and only on its first qualifying deposit.

Qualification rules:
- Qualification is evaluated at settlement time after the referred wallet has remained active for 30 days.
- The referred wallet must have made at least one deposit meeting:
  - minimum deposit: 250 USDT
  - deposit remains active for 30 days
- Qualification can only occur once per referred wallet address, lifetime.

**Important implementation rule:**
- Only the first qualifying deposit is eligible.
- Additional deposits, later deposits, new vaults, or repeated participation by the same wallet MUST NOT create additional referral rewards.

### 6.4 Referral Binding (First Referrer Wins, Locked at First Deposit)
- A referred wallet may only be associated with one referrer.
- The referral code binding is recorded permanently at the time of the referred wallet’s first deposit.
- If a referred wallet deposits without a referral code, no referral can be attached later.
- Referral code changes after first deposit are not permitted.

This prevents referral hijacking, disputes, or “retroactive referral claims.”

---

### 6.4.1 Referral Reward Uniqueness Constraint (Dev Requirement)
The contract MUST maintain a permanent record:
- hasQualifiedReferralReward[referredWallet] = true after first reward payout

Once true:
- the referred wallet is permanently ineligible for future referral rewards.

---

### 6.5 Reward Source Isolation (Never Principal, Never Reserve)
Referral rewards MUST be paid only from:
- MarketingRewardsVault (a pre-funded marketing budget wallet)

Referral rewards MUST NOT be paid from:
- user principal deposits
- the protocol reserve / redemption backing
- trading PnL that has not cleared settlement rules

If MarketingRewardsVault is empty or paused:
- referral rewards pause automatically
- no IOUs are created
- no negative balances are recorded

---

## 7. Fraud & Abuse Prevention (Flag → Freeze → Review → Revoke)

### 7.1 Basic Requirements
- Genesis eligibility and referral rewards are EOA-only (no smart contract wallets).
- The system may use automated heuristics to detect Sybil/farming behavior (e.g., repeated funding source patterns, rapid wallet clusters, identical timing/gas funding behaviors).

### 7.2 Enforcement Scope (Rewards-Only)
Enforcement actions related to Genesis/referrals MUST apply only to:
- Genesis discounts
- referral reward eligibility
- referral reward payouts

Enforcement MUST NOT:
- seize user principal
- impact vault accounting
- impact settlement rules or user claim mechanics

### 7.3 Flag and Freeze
If suspicious behavior is detected, the system may:
- flag a wallet (or wallet cluster)
- freeze Genesis/referral benefits temporarily

During freeze:
- referral payouts are withheld (not paid)
- no debt/IOUs are created
- eligibility remains pending until resolved

### 7.4 Resolution Outcomes
After review (automated and/or governance/admin process), the outcome is one of:
A) Clear:
- unfreeze benefits and continue normally

B) Confirmed abuse / sanction / exploit linkage:
- permanently revoke Genesis/referral benefits for the wallet(s)
- permanently block referral payouts to/from those wallet(s)

### 7.5 Transparent Logging (Recommended)
All freeze/revoke actions SHOULD emit an on-chain event:
- wallet address
- action type (freeze/unfreeze/revoke)
- reason code (Sybil, sanctions, exploit linkage, etc.)
  
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
