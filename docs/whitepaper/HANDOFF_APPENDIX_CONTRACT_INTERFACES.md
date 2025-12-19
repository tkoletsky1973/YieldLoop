# FILE: HANDOFF_APPENDIX_CONTRACT_INTERFACES.md

# YieldLoop — Core Contract Interfaces & Storage  
**Version:** v1.0  
**Status:** Implementation-Binding  
**Audience:** Smart Contract Engineers, Auditors  
**Parent Document:** YIELDLOOP_ENGINEERING_HANDOFF.md  
**Author:** Todd Koletsky  
**Date:** 2025-12-18  

---

## Purpose

This appendix defines the **minimum required smart contract interfaces, responsibilities, and storage models** for YieldLoop v1.

This document exists to eliminate:
- Interface ambiguity
- Authority confusion
- Hidden coupling
- “We’ll decide later” behavior

If a function or permission is not defined here, it must **not** be implemented without explicit review.

---

## 1. Contract Map (Authoritative)

YieldLoop v1 consists of the following on-chain contracts:

VaultFactory
└── UserVault (1 per user)

CycleController (global)
SettlementEngine
StrategyRegistry
IStrategy (multiple implementations)

FeeRouter
SystemVault

LOOPToken

NFTSupporter
NFTGovernor

ReferralRegistry (minimal)

Each contract has a **single responsibility**.

---

## 2. VaultFactory

### Responsibility
- Deploy new UserVaults
- Enforce one-vault-per-user (policy-defined)

### Required Interface
```solidity
interface IVaultFactory {
    function createVault(address owner) external returns (address);
    function getVault(address owner) external view returns (address);
}

Rules
	•	VaultFactory does not hold funds
	•	VaultFactory does not control execution
	•	Vault ownership is immutable after creation

⸻

3. UserVault

Responsibility
	•	Hold user assets
	•	Enforce state-based permissions
	•	Expose balances to settlement

Vault State

enum VaultState {
    Inactive,
    Configured,
    Active,
    Settling,
    PostCycle
}

Required Storage

struct CycleSnapshot {
    uint256 startBalance;
    uint256 endBalance;
    uint256 gasCost;
    uint256 protocolCost;
    bool settled;
}

address public owner;
VaultState public state;
CycleSnapshot public lastCycle;

Required Interface

interface IUserVault {
    function deposit(uint256 amount) external;
    function withdraw(uint256 amount) external;

    function lockForCycle() external;
    function unlockAfterCycle() external;

    function snapshotStart() external;
    function snapshotEnd() external;

    function getBalance() external view returns (uint256);
    function getState() external view returns (VaultState);
}

Hard Rules
	•	Withdrawals revert in Active and Settling
	•	Only CycleController may lock/unlock
	•	Vault cannot initiate execution
	•	Vault cannot mint LOOP

⸻

4. CycleController (Global Authority)

Responsibility
	•	Define cycle timing
	•	Transition vault states
	•	Authorize execution
	•	Trigger settlement
	•	Enforce emergency halt

Required Storage

uint256 public cycleStart;
uint256 public cycleEnd;
bool public emergencyHalt;

Required Interface

interface ICycleController {
    function startCycle() external;
    function endCycle() external;

    function registerVault(address vault) external;

    function haltSystem() external;
    function resumeSystem() external;

    function isActive() external view returns (bool);
}

Rules
	•	Only multisig may halt/resume
	•	Active cycles cannot be extended
	•	Halt forces settlement path
	•	No vault skips allowed

⸻

5. StrategyRegistry

Responsibility
	•	Maintain whitelist of executable strategies
	•	Enable / disable strategies prospectively

Required Interface

interface IStrategyRegistry {
    function enableStrategy(address strategy) external;
    function disableStrategy(address strategy) external;
    function isEnabled(address strategy) external view returns (bool);
}

Rules
	•	Only multisig may modify registry
	•	Disabling does not affect active cycles
	•	Registry does not execute strategies

⸻

6. Strategy Interface (IStrategy)

Responsibility
	•	Deterministic execution only
	•	No decision-making
	•	No settlement awareness

Required Interface

interface IStrategy {
    function execute(address vault) external;
    function halt(address vault) external;
    function validateParams(bytes calldata params)
        external
        pure
        returns (bool);
}

Hard Constraints
	•	Must revert on invalid state
	•	Must halt cleanly on failure
	•	Must not call settlement
	•	Must not access other vaults

⸻

7. SettlementEngine

Responsibility
	•	Perform one-time end-of-cycle accounting
	•	Authorize LOOP minting
	•	Route fees

Required Interface

interface ISettlementEngine {
    function settle(address vault) external;
}

Settlement Requirements
	•	Callable only by CycleController
	•	Callable once per cycle per vault
	•	Atomic or revert
	•	Deterministic math only

⸻

8. FeeRouter

Responsibility
	•	Split platform fees
	•	Apply NFT discounts
	•	Route referral credits
	•	Allocate system deposit

Required Interface

interface IFeeRouter {
    function routeFee(
        address user,
        uint256 feeAmount
    ) external;
}

Rules
	•	FeeRouter never touches principal
	•	Discounts resolved internally
	•	Referral credit calculated post-discount
	•	Must not revert settlement unless misconfigured

⸻

9. LOOPToken

Responsibility
	•	Represent verified retained surplus
	•	Mint only from settlement

Required Interface

interface ILOOPToken {
    function mint(address to, uint256 amount) external;
}

Hard Rules
	•	Only SettlementEngine may mint
	•	No burn in v1
	•	No emissions
	•	No admin mint

⸻

10. SystemVault

Responsibility
	•	Hold system-owned LOOP and assets
	•	Participate in cycles
	•	Never withdraw

Required Interface

interface ISystemVault {
    function deposit(uint256 amount) external;
    function getBalance() external view returns (uint256);
}

Rules
	•	Cannot withdraw
	•	Cannot bypass cycle rules
	•	Can lose money

⸻

11. NFT Contracts

Supporter NFT

interface ISupporterNFT {
    function balanceOf(address user) external view returns (uint256);
}

Governor NFT

interface IGovernorNFT {
    function isGovernor(address user) external view returns (bool);
}

NFT contracts:
	•	Do not call core contracts
	•	Are queried only during settlement

⸻

12. Referral Registry (Minimal)

Responsibility
	•	Track referral relationships
	•	Enforce cycle limits

Required Interface

interface IReferralRegistry {
    function getReferrer(address user) external view returns (address);
    function recordReferral(address referrer, address referee) external;
}

Rules
	•	Referral credit logic lives in FeeRouter
	•	Registry does not issue funds
	•	Registry does not affect execution

13. Authority Summary

Action              Authority
Vault lock/unlock   CycleController
Strategy enable     Multisig
Settlement          SettlementEngine
LOOP mint           SettlementEngine
Emergency halt      Multisig
NFT mint/revoke     Multisig
Referral payout     FeeRouter

No authority overlap is allowed.

14. Final Engineering Rule

If two contracts can change the same outcome, the design is wrong.

Every outcome must have one source of truth.


