# FILE: HANDOFF_APPENDIX_SETTLEMENT_PSEUDOCODE.md

# YieldLoop — Settlement & Accounting Pseudocode  
**Version:** v1.0  
**Status:** Implementation-Binding  
**Audience:** Smart Contract Engineers, Auditors  
**Parent Document:** YIELDLOOP_ENGINEERING_HANDOFF.md  
**Author:** Todd Koletsky  
**Date:** 2025-12-18  

---

## Purpose

This appendix defines the **authoritative settlement logic** for YieldLoop.

Settlement is the **only place** where:
- Profit is recognized
- Fees are applied
- LOOP may be minted
- Referral credits may be created

If settlement is wrong, the entire system is wrong.

This document exists so:
- No developer “fills in gaps”
- No auditor has to infer intent
- No ambiguity exists about ordering or failure behavior

---

## Core Settlement Principles (Non-Negotiable)

1. Settlement runs **once per cycle per vault**
2. Settlement is **atomic**
3. Settlement is **deterministic**
4. Settlement either completes fully or **reverts**
5. If anything is unclear → **profit = 0**

---

## Settlement Preconditions

Settlement may be called **only if all are true**:

- Cycle state == `Settling`
- Vault state == `Settling`
- Settlement has not yet occurred
- Emergency halt may be active or inactive (does not matter)

If any precondition fails → revert.

---

## Canonical Settlement Order (Authoritative)

Settlement must follow this order **exactly**:

1. Snapshot ending balances  
2. Compute raw profit  
3. Apply zero-profit rule  
4. Calculate platform fee  
5. Apply NFT discount  
6. Route platform fee  
7. Calculate referral credit  
8. Mint LOOP (if applicable)  
9. Finalize records  
10. Unlock vault  

No step may be reordered.

---

## Pseudocode (Authoritative)

```text
function settle(vault):

  assert caller == CycleController
  assert vault.state == Settling
  assert vault.lastCycle.settled == false

  // --- STEP 1: SNAPSHOT END BALANCE ---
  endBalance = vault.getBalance()
  startBalance = vault.lastCycle.startBalance
  gasCost = vault.lastCycle.gasCost
  protocolCost = vault.lastCycle.protocolCost

  // --- STEP 2: COMPUTE NET PROFIT ---
  netProfit = endBalance
            - startBalance
            - gasCost
            - protocolCost

  // --- STEP 3: ZERO-PROFIT RULE ---
  if netProfit <= 0:
      recordOutcome(
          vault,
          profit = 0,
          fee = 0,
          loopMinted = 0
      )

      vault.lastCycle.settled = true
      vault.unlockAfterCycle()
      return

  // --- STEP 4: CALCULATE PLATFORM FEE ---
  baseFee = netProfit * PLATFORM_FEE_RATE

  // --- STEP 5: APPLY NFT DISCOUNT ---
  discountRate = resolveNFTDiscount(vault.owner)
  discountedFee = baseFee * (1 - discountRate)

  // Guardrail
  if discountedFee < 0:
      discountedFee = 0

  // --- STEP 6: ROUTE PLATFORM FEE ---
  FeeRouter.routeFee(
      user = vault.owner,
      feeAmount = discountedFee
  )

  // --- STEP 7: REFERRAL CREDIT ---
  referrer = ReferralRegistry.getReferrer(vault.owner)

  if referrer exists AND
     ReferralRegistry.isEligible(vault.owner):

      referralCredit = discountedFee * 0.05
      FeeRouter.routeReferral(referrer, referralCredit)

  // --- STEP 8: MINT LOOP ---
  retainedSurplus = netProfit - discountedFee

  if retainedSurplus > 0:
      LOOPToken.mint(
          to = vault.owner,
          amount = retainedSurplus
      )

  // --- STEP 9: FINALIZE RECORD ---
  recordOutcome(
      vault,
      profit = netProfit,
      fee = discountedFee,
      loopMinted = retainedSurplus
  )

  vault.lastCycle.settled = true

  // --- STEP 10: UNLOCK VAULT ---
  vault.unlockAfterCycle()

Zero-Profit Behavior (Explicit)

If netProfit <= 0:
	•	No platform fee
	•	No LOOP mint
	•	No referral credit
	•	No retries
	•	No compensation
	•	Cycle closes flat

This is a successful and valid outcome.

⸻

Failure Semantics

If any of the following occur during settlement:
	•	Math overflow / underflow
	•	External call revert (FeeRouter, LOOPToken)
	•	Missing dependency
	•	Inconsistent state

Then:
	•	Settlement reverts
	•	Vault remains locked
	•	No partial outcomes are recorded
	•	Operator intervention required (via governance or upgrade)

Partial settlement is forbidden.

⸻

Idempotency Rules

Settlement must be:
	•	Callable exactly once
	•	Protected against re-entry
	•	Protected against replay

Any second call must revert.

⸻

Discount Resolution (Reference)

function resolveNFTDiscount(user):
  if GovernorNFT.isGovernor(user):
      return 0.10
  if SupporterNFT.balanceOf(user) > 0:
      return 0.05
  return 0.00

No stacking.
Governor overrides Supporter.

Referral Eligibility (Reference)

function isEligible(user):
  return
    referralCyclesCompleted[user] < 6
    AND userHasPositiveCycle(user)

No positive cycle → no referral credit.

Accounting Records (Minimum)

Settlement must emit events or records for:
	•	Cycle ID
	•	Vault address
	•	Start balance
	•	End balance
	•	Net profit
	•	Platform fee
	•	Discount applied
	•	LOOP minted
	•	Timestamp

Records must be immutable.

⸻

Explicit Non-Permissions

Settlement must NEVER:
	•	Assume future profit
	•	Retry execution
	•	Smooth losses
	•	Carry forward negative balances
	•	Mint LOOP pre-fee
	•	Touch user principal
	•	Be called manually by admins

⸻

Audit Statement

If settlement cannot be reasoned about from this file alone, the implementation is incorrect.

This file is intended to be read line-by-line by auditors.

⸻

Final Rule

Settlement is the truth boundary.

Everything before it is execution.
Everything after it is history.

There are no exceptions.
