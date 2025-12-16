# 5. Product and System Description

YieldLoop is implemented as a modular, on-chain software system designed to execute user-authorized actions on digital assets and to record outcomes after execution has completed.

This section describes the system at a functional level for business, operational, and regulatory clarity. Detailed technical specifications, execution rules, and state models are defined in the YieldLoop whitepaper and govern system behavior.

---

## 5.1 System Architecture Overview

The YieldLoop system consists of the following core components:

- **User-Owned Vaults**  
  Smart contract instances deployed for and controlled by individual users. Vaults hold user assets and enforce authorization boundaries. Assets are not pooled or commingled.

- **Authorization Layer**  
  Mechanisms through which users define execution parameters and grant time-bounded permission for execution. Authorization is explicit, parameter-specific, and expires at the end of each execution cycle.

- **Execution Engine**  
  Deterministic logic that performs authorized actions during active execution cycles. The execution engine cannot exceed user-defined limits and cannot adapt behavior mid-cycle.

- **Settlement Layer**  
  Processes that finalize execution activity after a cycle ends, account for execution-related costs, and establish final vault state.

- **Accounting Layer**  
  Immutable records of completed execution cycles, including starting and ending vault states and net changes. Accounting reflects completed facts only.

- **Administrative and Safeguard Controls**  
  Limited system-level controls used to manage upgrades, supported components, and emergency halts. These controls apply prospectively and do not alter settled outcomes.

Each component is intentionally constrained to prevent discretionary behavior, ambiguous authority, or hidden dependencies.

---

## 5.2 User Flow and Authorization Model

A typical user interaction with YieldLoop follows a fixed sequence:

1. **Vault Deployment or Configuration**  
   The user deploys or configures a user-owned vault and deposits assets under their control.

2. **Parameter Selection**  
   The user selects permitted strategy modules, assets, limits, and execution cycle duration.

3. **Explicit Authorization**  
   The user grants time-bounded authorization for execution. No execution occurs prior to this step.

4. **Active Execution Cycle**  
   The system executes authorized actions deterministically within defined constraints.

5. **Settlement and Accounting**  
   Execution stops at the end of the cycle. Settlement and accounting finalize outcomes.

6. **Post-Cycle Control**  
   The user regains full control, may withdraw assets, modify parameters, or reauthorize execution for a subsequent cycle.

At no point does YieldLoop assume custody, discretion, or unilateral authority over user assets.

---

## 5.3 What the System Explicitly Does Not Do

YieldLoop is defined as much by its exclusions as by its capabilities. The system explicitly does not:

- Take custody of user assets
- Pool or commingle funds
- Provide investment advice or recommendations
- Predict, project, or optimize outcomes
- Display real-time performance metrics during execution
- Intervene, adapt, or substitute actions mid-cycle
- Guarantee execution success, profitability, or capital preservation
- Automatically reauthorize execution or compound outcomes

These exclusions are architectural, not cosmetic. They are enforced by system design to preserve clarity, auditability, and legal defensibility.
