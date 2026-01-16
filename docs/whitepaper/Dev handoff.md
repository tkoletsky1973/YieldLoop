# DEV_HANDOFF.md — MVP Contract Scope + Build Order (YieldLoop v1)

This document is the **handoff blueprint** for developers building YieldLoop MVP.

It defines:
- exact MVP scope (what to build now vs later)
- contract inventory
- build order
- required deliverables
- acceptance criteria

If you build what’s in this document, YieldLoop MVP is complete.

---

## 1) MVP Definition (What “done” means)

YieldLoop MVP is considered complete when:

- users can deposit **>= 300 USDT**
- they must pass a **Strategy Accept / Decline** checkpoint before trading begins
- trading runs continuously (keeper-driven execution)
- trading is restricted to:
  - BTCB
  - Binance-Peg SOL
  - Binance-Peg XRP
- venues restricted to:
  - PancakeSwap
  - BiSwap
- profit is defined strictly:
  - **realized net USDT profit only**
- performance fee:
  - 20% standard (USDT reward mode)
  - 17.5% if user chooses LOOP reward mode
  - supporter discount stacks with others but bounded
- user rewards stored as:
  - claimable any time, not auto-withdrawn
- supporter presale:
  - 300 USDT deposit
  - first 5000 wallets
  - NFT badge minted
  - supporter discount eligibility
- referral program:
  - supporter holders can refer
  - qualification: 180 days + activity
  - payout: 25 LOOP each side
  - payout source: minted OR marketing/partnership budget routing (configurable)

---

## 2) Locked Business Rules (Non-Negotiable)

### 2.1 SupporterBadge NFT
- BEP-721
- transferable ✅

### 2.2 Discount Warmup Rules
- discount is inactive until badge held continuously **30 days**
- discount resets on transfer
- only 1 badge counts per wallet

### 2.3 Referral Eligibility
Referrer must:
- hold badge
- hold continuously 30 days (warmup)
- not blacklisted

Referred must:
- deposit >= 300 USDT
- accept strategy
- remain ACTIVE **180 consecutive days**
- meet activity requirement:
  - at least **10 successful executions** OR **$10 total fees paid**

Referral payout:
- 25 LOOP referrer
- 25 LOOP referred
- credited into ClaimLedger as claimable LOOP

Caps:
- max 5 payouts per referrer per month
- max 100 lifetime payouts per referrer
- global monthly budget cap (governance-controlled), default $7,500 eq.

---

## 3) Locked Guardrail Defaults (Conservative_v1)

ConfigRegistry must store `Conservative_v1` bounds:

- oracle staleness: 10 minutes
- max venue deviation: 0.60% (60 bps)
- max oracle deviation: 0.75% (75 bps)
- max slippage cap: 0.80% (80 bps)
- keeper minOut target: 0.50% (50 bps)
- min route liquidity: $750,000
- max peg deviation: 1.25% (125 bps)
- peg warning: 0.80% (80 bps)
- peg auto pause: 2.50% (250 bps)
- max exec cost per trade: $1.25
- profit-to-cost minimum: 3.0x
- cooldown: 120 seconds
- max trades/hour: 10
- max exposure per asset: 45%
- min exposure per asset: 20%
- drawdown pause: 8.0%
- resume threshold: 4.0%
- min net profit per execution: $0.65 (or $1.00 in elevated gas mode)

---

## 4) MVP Contract Inventory (What to build NOW)

### 4.1 Core Vault System (MVP)
1) **VaultFactory / VaultManager**
2) **UserVault** (recommended: 1 vault contract per deposit OR mapping-based single contract)
3) **ConfigRegistry**
4) **GuardrailEngine**
5) **ExecutionRouter**
6) **OracleAdapter** (TWAP/price sanity)
7) **FeeRouter**
8) **ClaimLedger**

### 4.2 LOOP + Token Modules (MVP)
9) **LOOP Token (BEP-20)**
10) **LoopMinter** (bounded mint authority)

### 4.3 Programs (MVP)
11) **SupporterPresale**
12) **SupporterBadge (BEP-721)**
13) **ReferralRegistry**
14) **BlacklistRegistry** (or embed inside ReferralRegistry)

### 4.4 Emergency (MVP)
15) **EmergencyPauseModule**
16) **TimelockController**
17) **AdminMultisig**

---

## 5) Upgrade Policy (Best Practice for Trust)

This is locked in for MVP.

### 5.1 Immutable (Do Not Upgrade)
- UserVault (holds user principal & inventory)
- SupporterPresale (after deployed)
- SupporterBadge
- LOOP Token (optional upgradeable is fine, but prefer immutable for trust)

### 5.2 Upgradeable (Timelocked Only)
- ConfigRegistry
- GuardrailEngine
- FeeRouter
- ReferralRegistry
- ExecutionRouter
- OracleAdapter

### 5.3 Required Upgrade Discipline
- upgrades must go through timelock
- emergency pause is immediate
- no admin can withdraw principal ever

---

## 6) Build Order (Implementation Sequence)

### Phase 1 — Infrastructure First
1) Deploy LOOP Token
2) Deploy LoopMinter (bounded caps)
3) Deploy ConfigRegistry (allowlists + Conservative_v1)
4) Deploy OracleAdapter
5) Deploy ExecutionRouter
6) Deploy GuardrailEngine

### Phase 2 — Vault Mechanics
7) Deploy ClaimLedger
8) Deploy FeeRouter (fee splits + discount cap/floor)
9) Deploy VaultFactory/VaultManager
10) Implement UserVault

### Phase 3 — Programs
11) Deploy SupporterBadge
12) Deploy SupporterPresale
13) Deploy ReferralRegistry + blacklist rules

### Phase 4 — Safety + Ops
14) Deploy EmergencyPauseModule
15) Deploy TimelockController
16) Set multisig permissions

---

## 7) Required Events (Minimum)

Events must enable full UI indexing and auditing.

### Vault Events
- VaultCreated
- StrategyPreviewed
- StrategyAccepted
- StrategyDeclined
- ExecutionAttempted
- ExecutionRejected (with reason code)
- ExecutionCompleted (netProfitUSDT, feeUSDT)
- ProfitSplitApplied (claimUSDT, compoundUSDT)
- Claimed (asset, amount)
- ExitRequested
- VaultPaused / VaultUnpaused

### Program Events
- SupporterDeposit
- BadgeMinted
- BadgeTransferred
- ReferralRegistered (referrer, referred)
- ReferralQualified
- ReferralRewardCredited
- ReferralRewardClaimed
- WalletBlacklisted / Unblacklisted

---

## 8) Developer Deliverables Checklist

The dev must deliver:

### Smart Contracts
- full contract suite above
- full test coverage for invariants
- deployment scripts
- config initialization scripts

### Documentation
- README.md
- deployment config doc
- param doc (Conservative_v1)
- incident controls doc

### Frontend (Minimum)
- deposit flow
- accept/decline screen
- vault dashboard
- claim screen
- supporter presale screen
- referral screen

---

## 9) Acceptance Criteria (Pass/Fail)

MVP is **FAIL** if:
- trading can occur before acceptance
- fee is charged when profit is 0
- claim touches principal
- referral can be farmed instantly
- badge transfer instantly grants discount
- admin can withdraw principal
- guardrails can be bypassed

MVP is **PASS** only if:
- all invariants in Appendix G hold
- guardrails enforce Conservative_v1 parameters
- UI displays guardrails at accept checkpoint
- events allow complete indexing
- claims work at all times unless chain failure

---

## 10) Notes to Developer (Operational Reality)

YieldLoop is designed to:
- reject most trades
- idle during danger
- trade only when conditions are safe and profitable

A “high execution frequency” system is NOT acceptable for MVP.
Safety > activity.

Build it conservative.
Make it boring.
That’s how it survives.
