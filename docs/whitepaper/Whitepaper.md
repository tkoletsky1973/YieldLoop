# YieldLoop

## A User-Authorized Execution and Settlement System

**Whitepaper 12_15_25**  
**Version:** 0.1  
**Status:** Initial Design Specification  

YieldLoop is software infrastructure that enables users to authorize predefined actions on their own digital assets and records the outcomes of those actions after execution has completed.

The system is non-custodial, cycle-based, and rule-driven.  
It does not take custody of assets, pool funds, predict outcomes, or provide financial advice.

YieldLoop exists to execute what users explicitly authorize — and to account for what actually happens.


## Table of Contents

1. Introduction and Purpose  
2. What YieldLoop Is  
3. What YieldLoop Is Not  
4. System Overview  
5. User-Owned Vaults and Authorization  
6. Execution Cycles and State Model  
7. Strategy Modules and Execution Rules  
8. Outcome Measurement and Verification  
9. Settlement and Accounting  
10. Fees and Cost Structure  
11. User Controls, Withdrawals, and Reauthorization  
12. Emergency Controls and System Safeguards  
13. Security Model and Auditability  
14. Governance and Administrative Boundaries  
15. Optional Ecosystem Programs  
16. User Interface and User Experience Principles  
17. Risk Disclosure and Assumptions  
18. Limitations and Tradeoffs  
19. Legal and Regulatory Context  
20. Glossary of Terms  

**Appendices**

Appendix A — Fee Schedule and Pricing Policy  
Appendix B — NFT Program Specification  
Appendix C — Referral Program Rules and Safeguards  
Appendix D — Strategy Modules and Capabilities  
Appendix E — Revenue Sources and Financial Model  
Appendix F — System Parameters and Defaults  
Appendix G — Change Control and Versioning


## 1. Introduction and Purpose

YieldLoop is software infrastructure designed to execute user-authorized actions on digital assets and to record the outcomes of those actions after execution has completed.

Many systems present estimates, projections, or continuously updated performance indicators. YieldLoop intentionally does not. It separates decision-making from execution and execution from outcome recording.

The purpose of YieldLoop is to provide a structured, deterministic system that allows users to:
- Define what actions may occur
- Explicitly authorize those actions for a limited period
- Enforce those limits during execution
- Record completed outcomes as factual results

YieldLoop does not attempt to predict results, optimize performance, or influence user decisions. It does not evaluate strategies, recommend configurations, or intervene based on market conditions.

By enforcing clear stages—authorization, execution, settlement, and accounting—YieldLoop is designed to reduce ambiguity and prevent assumptions about outcomes before they are finalized.

This document describes the system’s intended design and operational boundaries. It is written to explain what the system does, what it does not do, and where responsibility remains with the user.


## 2. What YieldLoop Is

YieldLoop is a user-authorized execution and settlement system.

At its core, YieldLoop provides software that allows a user to define a set of permitted actions, authorize those actions for a bounded period of time, and have the system execute only within those bounds. Once execution concludes, the system records the results as completed facts.

YieldLoop operates through user-owned vaults. Each vault is deployed for and controlled by an individual user. Assets are not pooled, commingled, or transferred into protocol custody. The system can act only within the permissions explicitly granted by the user to their vault.

The system is cycle-based. Execution occurs within clearly defined execution cycles that have a beginning, an active execution window, and an end. When a cycle ends, execution stops and settlement begins. No outcomes are recognized until execution has fully concluded.

YieldLoop is rules-driven. Execution behavior is governed by deterministic logic defined in strategy modules and constrained by user authorization. The system enforces those rules but does not alter them during execution.

YieldLoop includes a settlement and accounting layer that records what occurred during an execution cycle. This layer exists to document outcomes, not to forecast future behavior or imply expected results.

In summary, YieldLoop exists to:
- Enforce explicit user authorization
- Execute predefined actions within fixed boundaries
- Stop execution at the end of each cycle
- Record completed outcomes as factual records

  
## 3. What YieldLoop Is Not

YieldLoop is not an investment product, financial instrument, or managed account.

It does not accept deposits, pool user funds, or exercise discretionary control over assets. All assets remain in user-owned vaults, and the system acts only within the permissions explicitly granted by the user.

YieldLoop is not an advisor, broker, or asset manager. It does not recommend strategies, suggest configurations, assess suitability, or provide guidance on expected outcomes. Decisions regarding participation, configuration, and reauthorization are made solely by the user.

YieldLoop is not a yield generator or optimizer. It does not advertise returns, projected APYs, or performance targets. It does not smooth results, subsidize outcomes, or compensate for losses.

YieldLoop is not a forecasting, analytics, or monitoring platform. It does not provide real-time performance indicators, predictive metrics, or signals during active execution cycles.

YieldLoop is not a custodial service, bank, payment system, or deposit substitute. It does not guarantee liquidity, redemption, or capital preservation.

In short, YieldLoop does not promise outcomes, manage risk on behalf of users, or replace user judgment. It executes what is authorized and records what occurred—nothing more.


## 4. System Overview

YieldLoop is organized around a simple, repeatable system flow that separates user decision-making from execution and separates execution from outcome recording.

The system operates through four distinct stages:

1. **Authorization**  
   The user defines execution parameters, selects permitted strategy modules, and grants explicit, time-bounded permission for execution. No actions occur without authorization.

2. **Execution**  
   During an active execution cycle, the system performs only the actions permitted by the user and only within the defined constraints. Execution is deterministic and rule-based.

3. **Settlement**  
   Once the execution window closes, all execution stops. The system finalizes activity, accounts for execution-related costs, and prepares results for recording.

4. **Accounting**  
   After settlement, outcomes are recorded as completed facts. Accounting reflects what occurred during the cycle and does not imply future performance or expectations.

Each stage is discrete and enforced by system rules. Stages do not overlap and cannot be bypassed or reordered.

YieldLoop does not adapt its behavior based on market conditions, prior outcomes, or user performance. Its role is limited to enforcing authorization, executing predefined logic, and recording finalized results.

This structure is intended to make system behavior predictable, auditable, and resistant to misinterpretation.


## 5. User-Owned Vaults and Authorization

YieldLoop operates through user-owned vaults. A vault is a smart contract instance deployed for and controlled by an individual user. The vault holds the user’s assets and defines the scope of what actions may be performed.

The user retains ownership and control of the vault at all times. YieldLoop does not pool assets, does not take custody, and does not acquire independent authority over vault contents.

Authorization is the mechanism by which a user grants limited permission for the system to act on their vault. Authorization is explicit, parameter-specific, and time-bounded. The system cannot act outside the permissions granted by the user.

Authorization defines:
- Which strategy modules may be used
- Which assets may be involved
- The duration of the execution cycle
- Any limits or constraints selected by the user

Once authorization is granted, the system may execute only within those bounds and only for the duration of the authorized execution cycle.

Authorization does not transfer ownership of assets and does not grant discretionary control to the system. Authorization expires at the end of each execution cycle and must be renewed explicitly by the user to continue execution.


## 6. Execution Cycles and State Model

YieldLoop executes actions within clearly defined execution cycles. An execution cycle is a bounded period during which authorized actions may occur and outside of which no execution takes place.

Each execution cycle progresses through a fixed sequence of system states:

1. **Inactive**  
   No authorization exists. The vault is idle and no execution may occur.

2. **Configured**  
   The user has defined execution parameters but has not authorized execution. No actions are performed in this state.

3. **Active Execution**  
   The user has authorized execution. During this state, the system may perform only the actions permitted by the authorization and only within defined constraints.

4. **Settlement**  
   The execution window has closed. All execution activity has stopped. The system accounts for completed actions and execution-related costs.

5. **Post-Cycle**  
   Settlement is complete. The user regains full control of the vault and may withdraw assets, modify configuration, reauthorize execution, or leave the vault inactive.

State transitions are enforced by system rules and cannot be bypassed or reordered. Users cannot modify parameters or withdraw assets during active execution or settlement.

This state model is designed to prevent partial execution, mid-cycle intervention, or ambiguous outcomes.


## 7. Strategy Modules and Execution Rules

YieldLoop performs actions through discrete strategy modules. A strategy module is a predefined, deterministic set of rules that specifies how authorized actions may be executed within a user-owned vault.

Strategy modules do not adapt, learn, or modify behavior during execution. Given the same authorization parameters and on-chain conditions, a module will behave consistently.

Users explicitly select which strategy modules may be used during authorization. The system cannot invoke any module that has not been permitted by the user.

Each strategy module defines:
- The types of actions it may perform
- The assets it may interact with
- Any external protocols or contracts it may call
- Execution limits, frequency constraints, or stop conditions

Execution rules are enforced by the system. A module cannot exceed user-defined limits or operate outside authorized parameters.

Strategy modules do not assess market conditions, predict outcomes, or evaluate risk. They execute predefined logic only.

If a module encounters a condition that violates its rules or exceeds authorization bounds, execution halts for that module. The system does not substitute alternative actions or override constraints.

Strategy modules are designed to be inspectable and auditable. Their logic is defined in advance and does not change mid-cycle.


## 8. Outcome Measurement and Verification

YieldLoop measures outcomes only after an execution cycle has fully completed. No outcomes are calculated, displayed, or implied during an active execution cycle.

Outcome measurement compares the recorded state of a user-owned vault at the start of an execution cycle with the recorded state at the end of that cycle. Only assets held within the vault are considered. External market conditions, unrealized positions, or hypothetical valuations are excluded.

Verification is the process of confirming that:
- Execution occurred only within authorized parameters
- All execution-related actions have concluded
- All execution-related costs have been accounted for

Outcome measurement records differences between the starting and ending vault states as completed facts. It does not label outcomes as successful or unsuccessful and does not imply expected future results.

If the ending vault state does not exceed the starting state after accounting for execution-related costs, the outcome is recorded as having no positive result. No adjustments, smoothing, or offsets are applied across cycles.

Verification relies on on-chain data and deterministic rules. Estimates, projections, or forward-looking assumptions are not used.

This approach ensures that recorded outcomes reflect completed execution only and are resistant to reinterpretation or manipulation.


## 9. Settlement and Accounting

Settlement begins immediately after an execution cycle ends and outcome measurement is complete. During settlement, no further execution actions are permitted.

Settlement finalizes execution activity by:
- Confirming that all authorized actions have concluded
- Accounting for execution-related costs, including network and protocol fees
- Establishing the final state of the user-owned vault for the cycle

Settlement is deterministic and rule-based. It does not involve discretionary judgment, adjustment, or optimization of outcomes.

Accounting is the process of recording settlement results as finalized, historical records. These records describe what occurred during the execution cycle and do not represent forecasts, entitlements, or expectations of future performance.

Accounting records may include:
- The starting and ending vault states
- References to execution actions performed
- Execution-related costs incurred
- The net change between start and end states

Once finalized, accounting records are immutable. They are intended to be auditable and verifiable using on-chain data.

Settlement and accounting do not trigger automatic reinvestment, reauthorization, or asset movement. Any subsequent actions require explicit user input after the cycle has concluded.


## 10. Fees and Cost Structure

YieldLoop applies protocol fees only in connection with completed execution cycles and only after settlement and accounting have concluded.

No fees are charged for:
- Creating or configuring a vault
- Authorizing or declining execution
- Depositing or withdrawing assets
- Viewing system state or historical records

Protocol fees apply **only** when an execution cycle results in a net positive outcome, as determined through finalized accounting.

### Fee Basis

The protocol fee is calculated as a percentage of the net positive outcome for a given execution cycle, after all execution-related costs have been accounted for. Execution-related costs include network fees and any third-party protocol fees incurred as a direct result of executing authorized actions.

If an execution cycle does not produce a net positive outcome, **no protocol fee is charged** for that cycle.

### Fee Determinism

Fee calculation is deterministic and based solely on finalized accounting records. The system does not estimate, reserve, or pre-collect fees prior to settlement, and it does not modify execution behavior to influence fee generation.

### Fee Rate and Scaling

The applicable fee rate is defined by the current fee schedule in effect at the time an execution cycle begins. Fee schedules, including scaling mechanisms and minimum or maximum rates, are defined separately in Appendix A.

Any changes to fee rates or schedules apply prospectively only and do not affect previously completed execution cycles.

### Transparency

Fee logic, calculation methods, and applicable rates are intended to be inspectable and auditable. Users are able to review how fees were calculated for each completed cycle using recorded accounting data.

Fees exist to support the ongoing operation, maintenance, security, and development of the system. They do not represent compensation for investment advice, asset management, or guaranteed performance.


## 11. User Controls, Withdrawals, and Reauthorization

User control is foundational to the YieldLoop system. At all times, users determine whether execution may occur, under what conditions, and for how long.

Withdrawals and configuration changes are governed by the execution cycle state. During an active execution cycle or settlement phase, withdrawals and parameter changes are not permitted. This restriction exists to prevent partial execution, inconsistent accounting, and ambiguous outcomes.

Once settlement is complete and the system enters the post-cycle state, the user regains full control of the vault. In this state, the user may:
- Withdraw assets in part or in full
- Modify execution parameters
- Select different strategy modules
- Reauthorize execution for a subsequent cycle
- Leave the vault inactive

Reauthorization is never automatic. Each execution cycle requires an explicit user decision to proceed. If the user does not reauthorize execution, no further actions occur.

Changes made by the user apply only to future execution cycles. Completed cycles and settled accounting records are not modified or reversed.

YieldLoop does not impose penalties for choosing not to reauthorize execution or for withdrawing assets after settlement. Availability of withdrawals may be affected by external network or protocol conditions, but the system does not intentionally delay or restrict post-settlement access.


## 12. Emergency Controls and System Safeguards

YieldLoop includes limited emergency controls intended solely to preserve system integrity and prevent unintended behavior when normal execution cannot safely continue.

Emergency controls may be triggered in predefined conditions such as:
- Discovery of a critical smart contract vulnerability
- Failure or exploit of a dependent external protocol
- Conditions that prevent reliable settlement or accounting

Emergency actions are defensive only. When triggered, they may pause the initiation of new execution cycles or halt execution within an active cycle. Emergency controls do not modify strategy logic, reallocate assets, or complete execution after a halt.

Emergency intervention does not transfer custody of assets. User-owned vaults remain under user control, and assets are not seized, redirected, or pooled as a result of emergency action.

If an active execution cycle is halted, the system proceeds to settlement using the recorded vault state at the time execution stopped. No discretionary adjustments are applied.

All emergency actions are logged and intended to be transparent. Emergency controls do not eliminate execution risk and do not guarantee protection against loss.


## 13. Security Model and Auditability

YieldLoop is implemented as on-chain software and inherits the security properties and risks of the underlying blockchain networks on which it operates.

The security model is based on minimizing trust and limiting authority. The system is designed so that execution can occur only through user-owned vaults and only within the bounds of explicit user authorization. The protocol does not possess general authority to move assets outside those bounds.

Core smart contract logic is deterministic and intended to be inspectable. The behavior of authorization, execution, settlement, accounting, and fee calculation can be independently verified using on-chain data and published code.

Auditability refers to the ability to confirm that:
- Execution occurred only during authorized execution cycles
- Strategy modules operated within defined rules and limits
- Settlement and accounting accurately reflect completed execution activity
- Fees were calculated and applied according to published logic

Security testing, formal reviews, or third-party audits may be conducted prior to deployment or during operation. Such reviews are intended to reduce risk but do not eliminate the possibility of defects, vulnerabilities, or unintended behavior.

YieldLoop may interact with external protocols, contracts, or infrastructure during execution. Vulnerabilities, failures, or exploits in those external dependencies may affect execution outcomes even if YieldLoop’s own code behaves as intended.

No security model can eliminate all risk. Users should assume exposure to smart contract risk, execution risk, and infrastructure risk when authorizing actions within the system.


## 14. Governance and Administrative Boundaries

YieldLoop separates system execution from system administration. Governance and administrative functions exist only to maintain system operability, security, and long-term sustainability. They do not exist to influence execution outcomes or user decisions.

Administrative authority is limited to narrowly scoped actions such as:
- Deploying updated versions of system contracts
- Enabling or disabling strategy modules for future cycles
- Managing system-level parameters that apply prospectively
- Triggering or releasing emergency controls as defined in Section 12

Administrative authority does not include discretionary control over user-owned vaults, the ability to move user assets, or the ability to modify execution outcomes.

Governance refers to structured processes through which certain administrative decisions may be proposed, reviewed, and approved. Governance processes do not operate in real time and do not intervene in active execution cycles.

Neither administrators nor governance participants may:
- Alter or reverse settled accounting records
- Override user authorization
- Grant preferential execution, pricing, or access
- Modify vault balances or execution results

Changes made through governance or administration apply only to future execution cycles. Completed cycles and settled outcomes remain unchanged.

Participation in governance does not convey ownership rights, revenue rights, or claims on protocol fees. Governance roles are procedural and supervisory in nature and do not constitute financial participation.

The presence of governance and administrative functions does not reduce system risk or create assurances regarding performance, availability, or outcomes.


## 15. Optional Ecosystem Programs

YieldLoop may support optional ecosystem programs that exist alongside the core execution and settlement system. These programs are not required to access or use the core system and do not alter how execution, settlement, or accounting operates.

Ecosystem programs are intended to support development, testing, coordination, education, and community participation. Examples may include testing initiatives, advisory groups, referral coordination, or non-financial participation programs.

Participation in ecosystem programs is voluntary. Users may fully use the core YieldLoop system without engaging in any ecosystem program.

Ecosystem programs do not provide:
- Ownership interests
- Equity or governance rights over protocol execution
- Profit-sharing or revenue entitlements
- Preferential execution treatment
- Guaranteed fee reductions beyond those explicitly defined as operational pricing adjustments

Any benefits associated with ecosystem programs are operational in nature and are defined separately from the core protocol specification. Such benefits do not affect execution logic, outcome measurement, or settlement behavior.

Details of ecosystem programs, including eligibility, participation criteria, and available benefits, may change over time and are documented separately in applicable appendices.

Ecosystem programs are structurally and functionally separate from the core YieldLoop execution and settlement system.


## 16. User Interface and User Experience Principles

The YieldLoop user interface is designed to accurately reflect system behavior and to prevent misinterpretation of execution status, outcomes, or risk.

The interface prioritizes clarity and correctness over persuasion or engagement metrics. It does not display projected returns, estimated performance, rankings, or recommendations.

User actions that authorize execution are explicit and intentional. Prior to authorization, users are shown the selected parameters, constraints, applicable fees, and known limitations. Authorization requires affirmative confirmation.

During an active execution cycle or settlement phase, the interface clearly indicates that withdrawals and configuration changes are unavailable. The interface does not suggest or imply that intervention is possible during these states.

Outcome information is displayed only after settlement and accounting are complete. Results are presented as historical records derived from finalized data and are not framed as indicators of future performance.

Optional ecosystem programs are visually and functionally separated from core execution controls. Participation in such programs is not required and is not presented as necessary for system use.

User interface design choices are intended to reduce confusion, discourage overinterpretation, and align user expectations with actual system behavior.


## 17. Risk Disclosure and Assumptions

Use of YieldLoop involves risk. The system executes user-authorized actions on digital assets and records outcomes after execution has completed. Outcomes may vary and may include partial or total loss of assets.

Risks include, but are not limited to:
- Smart contract risk, including bugs, vulnerabilities, or unintended behavior
- Execution risk arising from market conditions, liquidity constraints, or timing
- Infrastructure risk related to blockchain networks, validators, or dependent services
- Dependency risk associated with third-party protocols or contracts used during execution

YieldLoop does not provide insurance, guarantees, or loss protection mechanisms. The system does not intervene to prevent losses or preserve asset value.

Users are responsible for understanding the actions they authorize, the constraints they select, and the potential consequences of execution. YieldLoop assumes users act on their own behalf and with awareness of the risks involved.

No assumptions are made regarding profitability, suitability, or appropriateness of participation. Prior outcomes do not predict future results.


## 18. Limitations and Tradeoffs

YieldLoop is intentionally designed with constraints that prioritize determinism, auditability, and clarity over flexibility, speed, or continuous control.

Execution occurs in discrete cycles. Users cannot intervene during active execution or settlement phases. This reduces ambiguity and improves auditability but limits responsiveness to rapid changes.

The system does not provide real-time analytics, forecasts, or adaptive behavior. Users must wait until settlement to observe outcomes. This avoids misinterpretation but reduces immediacy.

Strategy modules execute predefined logic and do not adapt to market conditions or optimize results dynamically. This improves predictability but may result in missed opportunities or unfavorable timing.

Optional ecosystem programs are deliberately separated from core execution. This reduces complexity and regulatory exposure but may limit incentive structures or engagement features found in other systems.

These limitations are intentional tradeoffs chosen to align system behavior with explicit authorization, clear boundaries, and factual outcome recording.


## 19. Legal and Regulatory Context

YieldLoop is described and designed as software infrastructure that enables users to authorize actions on their own digital assets and records outcomes after execution has completed.

The system is not presented as a financial product, investment service, custodial platform, or advisory offering. It does not accept deposits, pool funds, provide recommendations, or exercise discretionary control over user assets.

Regulatory treatment of software systems interacting with digital assets varies by jurisdiction and may evolve over time. This document does not attempt to classify YieldLoop under any specific regulatory regime or assert exemption from applicable laws.

Users are solely responsible for determining whether their use of the system complies with the laws, regulations, and tax obligations applicable to them. YieldLoop does not assess user eligibility, suitability, or compliance unless required by law.

Nothing in this document constitutes legal, tax, or regulatory advice. The descriptions provided reflect intended system behavior and design boundaries, not legal conclusions or assurances.


## 20. Glossary of Terms

**Accounting**  
The process of recording finalized settlement results as factual, historical records. Accounting reflects completed execution only and does not include estimates, projections, or expectations of future outcomes.

**Administrative Authority**  
Limited system-level permissions granted to maintain, update, or secure the protocol. Administrative authority does not include discretionary control over user assets, execution outcomes, or accounting records.

**Authorization**  
A user’s explicit, parameter-specific, and time-bounded permission allowing the system to perform predefined actions on a user-owned vault.

**Cycle State**  
A defined operational phase of an execution cycle, including Inactive, Configured, Active Execution, Settlement, and Post-Cycle states.

**Deterministic Execution**  
Execution behavior that is fully defined by code, authorization parameters, and on-chain conditions, producing consistent behavior given the same inputs.

**Emergency Controls**  
Predefined defensive mechanisms that pause or halt execution when system integrity is at risk. Emergency controls do not reallocate assets, alter outcomes, or complete execution after interruption.

**Execution**  
The act of performing authorized actions on a user-owned vault during an active execution cycle.

**Execution Cycle**  
A bounded operational period during which authorized actions may occur, followed by settlement and accounting.

**Execution-Related Costs**  
Network fees, gas costs, and third-party protocol fees incurred directly as a result of executing authorized actions.

**Fee Rate**  
The percentage applied to a net positive outcome after settlement to calculate the protocol fee.

**Governance**  
Structured processes used to review and approve certain administrative actions that apply prospectively. Governance does not intervene in active execution cycles or modify settled outcomes.

**Net Positive Outcome**  
A condition in which the ending state of a user-owned vault exceeds its starting state after all execution-related costs have been accounted for.

**Non-Custodial**  
A system design in which user assets remain under the control of user-owned smart contracts and are never held, pooled, or controlled by the protocol.

**Optional Ecosystem Programs**  
Non-essential programs that exist alongside the core system, such as NFT initiatives or referral coordination, which do not affect execution, settlement, or accounting logic.

**Outcome Measurement**  
The comparison of a vault’s starting and ending state after an execution cycle has completed. Outcome measurement is retrospective and factual.

**Post-Cycle State**  
The system state following settlement and accounting in which the user regains full control of the vault and may withdraw assets or reauthorize execution.

**Protocol Fee**  
A fee applied to a net positive outcome after settlement, calculated according to the active fee schedule.

**Settlement**  
The process of finalizing execution activity, accounting for execution-related costs, and establishing the final vault state for an execution cycle.

**Strategy Module**  
A predefined, deterministic set of rules specifying how authorized actions may be executed within a user-owned vault.

**System Safeguards**  
Controls and constraints designed to prevent unintended behavior, including state enforcement, authorization limits, and emergency controls.

**User Interface (UI)**  
The software layer through which users view system state, configure parameters, and authorize execution. The UI reflects system behavior but does not alter execution logic.

**User-Owned Vault**  
A smart contract instance deployed for and controlled by a single user that holds the user’s assets and enforces authorization boundaries.

**Withdrawal**  
The transfer of assets out of a user-owned vault after settlement and entry into the post-cycle state.

**YieldLoop System**  
The combination of smart contracts, execution logic, settlement processes, and accounting mechanisms described in this document.


# Appendix A — Fee Schedule and Pricing Policy (Operational, Non-Binding)

This appendix defines the **complete operational fee model** for the YieldLoop system.

This appendix is **descriptive, not contractual**. All values, thresholds, and allocation percentages described herein may be modified through documented administrative or governance processes and apply prospectively only. This appendix does not alter the core execution, settlement, or accounting logic of the system.

---

## A.1 Purpose

This appendix exists to clearly and exhaustively describe:

- How protocol fees are calculated  
- When protocol fees apply  
- How the protocol fee rate scales as system usage increases  
- The minimum and maximum fee boundaries  
- How collected protocol fees are allocated internally  

The intent is transparency without embedding rigid commercial terms into the core system specification.

---

## A.2 Source of Protocol Revenue

YieldLoop generates revenue **exclusively through protocol fees** applied to completed execution cycles that result in a net positive outcome.

The system does **not** generate revenue through:
- Custody or pooling of user assets  
- Interest, lending, or borrowing  
- Market making or spread capture  
- Sale of user data or performance data  
- Preferential execution, prioritization, or access  

Optional ecosystem programs (including NFTs or referral coordination) may provide development or operational funding, but they are **not protocol revenue derived from execution activity**.

---

## A.3 Fee Applicability Conditions

A protocol fee is applied **only if all of the following conditions are met**:

1. An execution cycle has fully completed  
2. Settlement and accounting are finalized  
3. The ending vault state exceeds the starting vault state **after all execution-related costs**  

If **any** condition is not met, **no protocol fee is charged** for that execution cycle.

Protocol fees are **never** applied to:
- Deposits  
- Withdrawals  
- Principal  
- Unrealized activity  
- Configuration, authorization, or viewing actions  

---

## A.4 Fee Basis and Calculation

The protocol fee is calculated as a percentage of the **net positive outcome** for an execution cycle.

**Net Positive Outcome** is defined as the difference between:
- The recorded vault state at the end of settlement, and  
- The recorded vault state at the beginning of the execution cycle,  
after all execution-related costs have been deducted.

Execution-related costs include:
- Network fees (e.g., gas)  
- Third-party protocol fees incurred directly by authorized execution  

Fee calculation is deterministic and based solely on finalized accounting records.

---

## A.5 Base Fee Rate

At system launch, the protocol fee rate is:

**20% of net positive outcome**

This rate reflects early-stage operational, infrastructure, and security costs.

---

## A.6 Scaling Fee Reduction Model

As system usage increases and operational efficiency improves, the protocol fee rate decreases automatically based on the total value of assets locked in active execution cycles.

### A.6.1 Definition: Total Deposits Locked

“Total Deposits Locked” refers to the aggregate USD-equivalent value of user assets **actively authorized for execution** during execution cycles.

It explicitly excludes:
- Idle balances not authorized for execution  
- Withdrawn assets  
- Assets held outside user-owned vaults  

---

### A.6.2 Fee Reduction Rule

- For every **$1,000,000 USD-equivalent** increase in Total Deposits Locked  
- The protocol fee rate decreases by **0.5 percentage points**

Fee reductions apply globally and automatically once the corresponding threshold is reached.

---

### A.6.3 Fee Floor and Lock

- The protocol fee rate **will not decrease below 10%**  
- Once the 10% rate is reached, the fee rate is **locked**  
- Any reduction below this level requires an explicit administrative or governance decision  

---

### A.6.4 Illustrative Fee Ladder

| Total Deposits Locked | Protocol Fee Rate |
|----------------------|------------------|
| $0 – $1,000,000      | 20.0% |
| $2,000,000           | 19.0% |
| $4,000,000           | 18.0% |
| $6,000,000           | 17.0% |
| $8,000,000           | 16.0% |
| $10,000,000          | 15.0% |
| $12,000,000          | 14.0% |
| $14,000,000          | 13.0% |
| $16,000,000          | 12.0% |
| $18,000,000          | 11.0% |
| $20,000,000+         | 10.0% (locked) |

Values are illustrative and rounded for clarity.

---

## A.7 Fee Collection Timing

Protocol fees are:
- Calculated **only after settlement is complete**
- Applied **only to finalized accounting results**

The system does not:
- Pre-collect or reserve fees  
- Escrow fees during execution  
- Modify execution behavior to optimize fee generation  

---

## A.8 Fee Allocation (Illustrative)

Collected protocol fees are allocated internally to support system operation and sustainability.

An illustrative allocation model is:

- **40%** — Core development, maintenance, and upgrades  
- **20%** — Security, audits, and infrastructure  
- **15%** — Operations and administration  
- **15%** — Ecosystem support and community programs  
- **10%** — Reserves and long-term sustainability  

Allocation percentages may be adjusted over time through documented processes and apply prospectively only.

---

## A.9 Change Management

Fee rates, thresholds, reduction mechanics, and allocation structures may be updated through administrative or governance processes.

All changes:
- Apply only to future execution cycles  
- Are disclosed prior to taking effect  
- Do not retroactively affect completed cycles  

---

## A.10 Non-Reliance and Clarification

Nothing in this appendix should be interpreted as:
- A promise of future pricing  
- A guarantee of fee stability  
- An inducement to participate  
- A representation of profitability or cost efficiency  

Participation decisions should be based on system behavior and risk tolerance, not fee assumptions.


# Appendix B — NFT Program Specification (Operational, Non-Binding)

This appendix describes the NFT programs associated with the YieldLoop ecosystem.

This appendix is descriptive, not contractual. NFT availability, pricing, benefits, and eligibility criteria may be modified through documented administrative or governance processes and apply prospectively only. NFT programs are optional and exist outside the core execution, settlement, and accounting system.

---

## B.1 Purpose

The NFT programs exist to:
- Support development and ongoing operations
- Coordinate testing, feedback, and community participation
- Provide limited, non-financial participation benefits
- Offer defined operational fee discounts as a pricing adjustment

NFTs are not required to access or use the YieldLoop system.

---

## B.2 General Restrictions and Clarifications

NFTs issued or awarded by YieldLoop do not represent:
- Equity or ownership interests
- Profit-sharing or revenue rights
- Claims on protocol assets
- Guarantees of performance or outcomes
- Rights to influence execution, settlement, or accounting

NFTs are not marketed or represented as investments or income-generating assets.

---

## B.3 NFT Categories

### B.3.1 Supporter NFT

**Availability**  
- Available on an ongoing basis  
- Not supply-limited  
- May be issued continuously or in multiple batches at the discretion of the system operator  

**Illustrative Price**  
- USD $300 equivalent

**Illustrative Benefits**
- Five percent (5%) discount on applicable protocol fees, applied after settlement  
- Access to designated community communication channels  
- Eligibility for early testing, previews, and structured feedback programs  

**Limitations**
- No governance authority  
- No influence over execution behavior or strategy selection  
- No yield enhancement, priority access, or performance benefit  

The Supporter NFT is designed for broad participation and does not derive value from scarcity.

---

### B.3.2 Benefactor NFT

**Availability**  
- Awarded, not sold  
- Issued selectively at the discretion of the system operator  

**Eligibility Examples**
- Advisors  
- Active contributors  
- Community leaders or outreach participants  

**Illustrative Benefits**
- Ten percent (10%) discount on applicable protocol fees, applied after settlement  
- Access to designated advisory, governance, or think-tank channels  
- Eligibility to participate in structured review or planning sessions  

**Compensation Clarification**
- Any compensation for time or services is defined separately  
- Compensation is not performance-based  
- Compensation is not tied to protocol revenue, execution outcomes, or deposits  

---

## B.4 Fee Discounts and Interaction With Appendix A

NFT-based fee discounts:
- Apply only to protocol fees defined in Appendix A  
- Reduce the fee rate applied after settlement  
- Do not alter execution logic, settlement rules, or accounting  

Discounts:
- Apply prospectively only  
- Do not reduce the protocol fee below the minimum floor defined in Appendix A  
- Are not transferable unless explicitly specified  

NFT ownership does not affect:
- Execution priority  
- Strategy module availability  
- Withdrawal timing  
- Outcome measurement  

---

## B.5 Use of NFT Proceeds

Funds raised through NFT sales may be used for:
- Development and maintenance  
- Infrastructure and hosting  
- Security reviews and audits  
- Community and ecosystem operations  

NFT holders do not obtain rights to direct fund allocation unless explicitly defined through governance processes.

---

## B.6 Change Management

NFT programs may be:
- Modified  
- Paused  
- Replaced  
- Discontinued  

All changes:
- Apply prospectively only  
- Do not affect completed execution cycles  
- Are disclosed prior to taking effect  

---

## B.7 Non-Reliance Statement

Nothing in this appendix should be interpreted as:
- A promise of future benefits or pricing  
- A guarantee of continued availability  
- An inducement to use the core system  
- A representation of economic value  

Participation in NFT programs is optional and independent of YieldLoop system usage.


# Appendix C — Referral Program Rules and Safeguards (Operational, Non-Binding)

This appendix describes the referral coordination programs associated with the YieldLoop ecosystem.

This appendix is descriptive, not contractual. Referral eligibility, thresholds, benefits, and enforcement mechanisms may be modified through documented administrative or governance processes and apply prospectively only. Referral programs are optional and exist outside the core execution, settlement, and accounting system.

---

## C.1 Purpose

Referral programs exist to:
- Encourage organic user adoption
- Reward outreach and community participation
- Support early-stage growth without altering core system behavior

Referral programs do not affect execution logic, settlement rules, accounting outcomes, or strategy behavior.

---

## C.2 General Restrictions and Clarifications

Referral participation does not provide:
- Ownership interests
- Equity
- Profit-sharing rights in the protocol
- Ongoing revenue entitlements
- Influence over execution or governance

Referral benefits are **operational incentives**, not financial products.

---

## C.3 Eligibility Requirements

To qualify as a referral:
- The referred participant must be a real, unique human user
- Community participation and verification requirements must be met
- Automated, duplicate, or fraudulent activity invalidates referral credit

The system operator may verify eligibility and revoke benefits in cases of abuse.

---

## C.4 Referral Tiers

### C.4.1 Tier 1 — Pre-Launch Community Referral

**Requirement**
- Refer **20 unique, verifiable human participants** to designated community channels

**Limit**
- First **ten (10)** participants to reach the threshold

**Benefit**
- Whitelisting to receive **one (1) Supporter NFT** upon program launch

---

### C.4.2 Tier 2 — Pre-Launch Community Leadership Referral

**Requirement**
- Refer **100 unique, verifiable human participants**

**Limit**
- First **three (3)** participants to reach the threshold

**Benefit**
- Whitelisting to receive **one (1) Benefactor NFT**

---

### C.4.3 Tier 3 — Post-Launch User Referral Program

**Availability**
- Begins **after public system launch**
- Available to users **after completing their first deposit and execution cycle**

**Referral Code Issuance**
- After a user completes their first deposit, they receive a unique referral code
- Referral codes may be shared voluntarily

**Qualified Referral**
A referral is considered qualified when:
- A referred user completes their first deposit
- The referred user completes execution cycles that result in net positive outcomes

**Referral Benefit**
- The referrer receives a **credit equal to five percent (5%) of the protocol fees generated by the referred user’s net positive outcomes**
- This benefit applies only to the referred user’s **first six (6) execution cycles that result in net positive outcomes**

**Clarifications**
- Credits are derived **solely from protocol fees**, not from user principal
- Credits do not reduce the referred user’s net outcome
- Credits do not apply if an execution cycle produces no positive outcome
- Credits are capped by the six-cycle limit and do not recur beyond that point

---

## C.5 Non-Financial Nature of Referral Credits

Referral credits:
- Are not ownership interests
- Are not revenue shares
- Do not entitle the referrer to ongoing payments
- Do not depend on referral deposit size beyond protocol fee generation
- Do not guarantee any amount or frequency of benefit

Credits are applied only after settlement and finalized accounting.

---

## C.6 Anti-Abuse and Enforcement

The system operator may:
- Reject or revoke referral credits for fraud, manipulation, or abuse
- Invalidate self-referrals or circular referral schemes
- Suspend referral program access for violations

All determinations are final.

---

## C.7 Prohibited Representations

Participants may not describe the referral program as:
- An income opportunity
- A commission-based system
- A yield or profit-sharing arrangement
- An investment or compensation plan

Violations may result in disqualification.

---

## C.8 Change Management

The referral program may be modified, paused, or discontinued.

All changes:
- Apply prospectively only
- Do not affect settled execution cycles
- Are disclosed prior to taking effect

---

## C.9 Non-Reliance Statement

Nothing in this appendix should be interpreted as:
- A promise of future benefits
- A guarantee of eligibility or earnings
- A financial inducement
- A representation of economic value

Participation is voluntary and independent of core YieldLoop system usage.


# Appendix D — Basic Strategy Bots and Execution Programs (Operational, Non-Binding)

This appendix describes the initial, basic strategy programs (“bots”) that YieldLoop may execute within user-owned vaults when explicitly authorized.

This appendix is descriptive, not contractual. Strategy availability, parameters, supported assets, and supported protocols may change through documented administrative or governance processes and apply prospectively only. All strategies operate within the core execution, settlement, and accounting framework defined in the main document.

---

## D.1 Purpose

The purpose of this appendix is to plainly describe:
- What strategies the system runs
- What assets and protocols may be used
- What each strategy does and does not do
- How execution is bounded to prevent confusion or overreach

These strategies are not recommendations, not advice, and do not imply expected outcomes.

---

## D.2 Strategy Set (Initial)

YieldLoop’s initial strategy set is intentionally limited to simple, auditable programs:

1. **Spot Trading Bot (Major Coins)**
2. **Spot Trading Bot (PAXG)**
3. **LP / Yield Farming Bot (via approved vault platforms)**
4. **Stablecoin Yield Bot (non-staking yield sources)**

Each strategy is optional and must be explicitly enabled by the user.

---

## D.3 Strategy 1 — Spot Trading Bot (Major Coins)

### D.3.1 Purpose
Execute simple buy/sell spot trades on approved venues for selected major assets such as:
- BTC
- ETH
- SOL
- Additional assets may be added later via governance/administration

### D.3.2 What It Does
- Buys and sells approved assets under predefined rules
- Uses only spot transactions (no leverage, no borrowing, no derivatives)
- Executes within the user’s authorized limits on:
  - Assets
  - Order size
  - Frequency
  - Max slippage

### D.3.3 What It Does Not Do
- No margin trading
- No leverage
- No perpetuals or options
- No shorting
- No discretionary “human trader” intervention mid-cycle

### D.3.4 Halt Conditions (Illustrative)
Execution halts if:
- Slippage exceeds authorized limits
- Liquidity conditions fail predefined checks
- External protocol/venue is unavailable
- Execution errors occur

---

## D.4 Strategy 2 — Spot Trading Bot (PAXG)

### D.4.1 Purpose
Execute simple spot trading of PAXG (or other approved tokenized commodity assets) under predefined rules.

### D.4.2 What It Does
- Buys and sells PAXG spot under user-authorized constraints
- Uses only approved venues and approved pairs

### D.4.3 What It Does Not Do
- No commodity claims or redemption promises
- No custody or guarantee of backing
- No leverage or derivatives

PAXG exposure includes issuer and token-specific risks that are external to YieldLoop.

---

## D.5 Strategy 3 — LP / Yield Farming Bot (Approved Vault Platforms)

### D.5.1 Purpose
Deploy user-authorized assets into approved liquidity or vault platforms (e.g., a “Krystal-like” vault system or other approved systems) to participate in protocol-defined yield mechanisms.

### D.5.2 What It Does
- Deposits into approved vaults/pools using predefined logic
- Withdraws from vaults/pools as authorized
- May claim and reinvest rewards only if explicitly authorized

### D.5.3 What It Does Not Do
- No guarantee of yield
- No guarantee of principal preservation
- No attempts to “rescue” positions or override protocol mechanics
- No forced compounding unless explicitly enabled

### D.5.4 Key Risks (Explicit)
- Impermanent loss (for LP positions)
- Smart contract and platform risk
- Liquidity risk
- Reward/token volatility
These risks are external and cannot be eliminated by YieldLoop.

---

## D.6 Strategy 4 — Stablecoin Yield Bot (Non-Staking Yield Sources)

### D.6.1 Purpose
Deploy stablecoins into approved yield sources that may include:
- Lending markets
- Vaults
- Stablecoin pools
- Other protocol-defined yield mechanisms

This is described as “yield” because stablecoins generally do not have true chain-native staking.

### D.6.2 What It Does
- Deposits stablecoins into approved venues under predefined rules
- Withdraws as authorized
- May claim/reinvest protocol rewards only if enabled

### D.6.3 What It Does Not Do
- No guarantee of peg stability
- No guarantee of yield
- No protection against depegs, hacks, insolvency, or protocol failure

---

## D.7 Supported Assets and Expansion

The initial supported asset set is intentionally narrow for auditability.

Adding new assets, pairs, or venues requires:
- Documentation of the change
- A published update process
- Prospective-only application

YieldLoop does not imply that any future asset will be added, or that additions improve outcomes.

---

## D.8 Execution Boundaries (Applies to All Strategies)

All strategies:
- Operate only during authorized execution cycles
- Use only user-authorized assets and limits
- Record outcomes only after settlement
- Halt rather than “improvise” when constraints fail

The system does not:
- Provide investment advice
- Guarantee profitability
- Guarantee capital preservation
- Guarantee execution success

---

## D.9 Non-Reliance Statement

Nothing in this appendix should be interpreted as:
- A recommendation to use any strategy
- A promise of profits or yield
- A guarantee of results
- A representation that the strategies are safe or suitable

These strategies are execution programs that operate only under user authorization and remain subject to market risk and protocol risk.


# Appendix E — Revenue Sources and Financial Model (Operational, Non-Binding)

This appendix explains **how YieldLoop is funded and sustained**, where revenue comes from, and how money flows through the system.

This appendix is descriptive, not contractual. Revenue sources, allocations, and operational assumptions may change through documented administrative or governance processes and apply prospectively only. Nothing in this appendix alters core execution, settlement, or accounting logic.

---

## E.1 Purpose

The purpose of this appendix is to clearly answer three questions that reviewers, users, and regulators always ask:

1. How does the system make money?
2. What does it *not* make money from?
3. How are funds used to keep the system operating?

This appendix exists to eliminate ambiguity and prevent assumptions about hidden incentives or undisclosed monetization.

---

## E.2 Primary Revenue Source — Protocol Fees

The **sole recurring revenue source** of the YieldLoop system is the protocol fee described in Appendix A.

Protocol fees:
- Are applied only after completed execution cycles
- Apply only to net positive outcomes
- Are calculated deterministically after settlement
- Are never charged on deposits, withdrawals, or principal

YieldLoop does not generate revenue from:
- Holding or custody of assets
- Interest spread or lending margins
- Market making
- Front-running or execution priority
- Selling access to strategies
- Selling user or execution data

---

## E.3 Secondary Funding Sources (Non-Execution)

In addition to protocol fees, YieldLoop may receive **non-recurring or supplemental funding** from sources that are operationally separate from execution activity, including:

### E.3.1 NFT Program Funding
- Proceeds from optional NFT programs (Appendix B)
- Used for development, audits, infrastructure, and operations
- Not tied to execution outcomes
- Not recurring protocol revenue

### E.3.2 Community and Ecosystem Support
- Voluntary contributions
- Grants or sponsorships
- Ecosystem partnerships

These sources do not affect execution behavior, settlement outcomes, or accounting.

---

## E.4 Separation of Revenue and Execution

A core design principle of YieldLoop is **separation between execution and revenue**.

Specifically:
- Execution logic does not change based on revenue considerations
- Strategies do not attempt to maximize fees
- The system does not prefer actions that generate higher fees
- Fee calculation occurs only after execution is complete

This separation exists to prevent conflicts of interest and to keep execution behavior deterministic.

---

## E.5 Cost Structure (Illustrative)

Operating costs may include:
- Software development and maintenance
- Infrastructure and hosting
- Security reviews and audits
- Operations, administration, and compliance
- Community and ecosystem support

Costs are covered by protocol fees and supplemental funding where applicable.

---

## E.6 Sustainability Model

YieldLoop is designed to be sustainable at scale by:
- Reducing fee rates as total deposits locked increase (Appendix A)
- Maintaining a minimum fee floor
- Avoiding capital-intensive guarantees or subsidies
- Limiting operational complexity

There is no requirement for continuous growth, token emissions, or external subsidies to maintain system operation.

---

## E.7 No Profit Expectation or Reliance

Nothing in this appendix should be interpreted as:
- A representation of profitability
- A promise of revenue growth
- An inducement to participate
- A guarantee of system longevity

Revenue exists solely to support operation and maintenance of the system.

---

## E.8 Change Management

Revenue sources, allocation practices, and funding mechanisms may change through documented administrative or governance processes.

All changes:
- Apply prospectively only
- Do not affect settled execution cycles
- Are disclosed prior to taking effect


# Appendix F — System Parameters, Defaults, and Configuration Boundaries (Operational, Non-Binding)

This appendix defines the **system parameters**, default settings, and configuration boundaries that govern how YieldLoop operates in practice.

This appendix is descriptive, not contractual. Parameters, defaults, limits, and configuration options may be modified through documented administrative or governance processes and apply prospectively only. This appendix does not alter core execution, settlement, or accounting logic.

---

## F.1 Purpose

The purpose of this appendix is to:
- Make all adjustable system elements explicit
- Prevent hidden defaults or undocumented behavior
- Clarify which values are user-controlled versus system-controlled
- Reduce ambiguity for auditors, regulators, and technical reviewers

---

## F.2 User-Configurable Parameters

Users may configure parameters **only at authorization time**, prior to execution.

Illustrative user-configurable parameters include:
- Assets approved for execution
- Strategy categories enabled
- Maximum allocation per strategy
- Transaction size limits
- Execution frequency limits
- Slippage tolerance
- Whether compounding or reinvestment is permitted
- Whether rewards may be claimed or left idle

Users cannot modify parameters mid-cycle.

---

## F.3 System Defaults

If a user does not explicitly configure certain parameters, system defaults may apply.

Defaults are:
- Conservative
- Documented
- Applied uniformly
- Subject to change prospectively only

Illustrative defaults may include:
- Conservative slippage limits
- Limited execution frequency
- Partial capital deployment
- Disabled compounding unless enabled

Defaults do not imply recommendations or suitability.

---

## F.4 Hard System Limits (Non-Overridable)

Certain limits exist to protect system integrity and auditability.

Examples include:
- No leverage
- No borrowing
- No derivatives
- No short positions
- No mid-cycle parameter changes
- No discretionary human intervention during execution

These limits cannot be overridden by users or administrators.

---

## F.5 Administrative Parameters

Administrative parameters apply **system-wide** and prospectively only.

Examples may include:
- Supported assets list
- Supported protocols and venues
- Fee schedules and thresholds
- Emergency control triggers
- Maximum exposure per protocol

Administrative changes:
- Do not affect active cycles
- Are documented prior to activation
- Do not modify settled outcomes

---

## F.6 Failure and Boundary Handling

If a parameter conflict, invalid configuration, or boundary violation is detected:
- Execution does not begin, or
- Execution halts safely
- The system proceeds to settlement if applicable

The system does not attempt to auto-correct or override invalid configurations.

---

## F.7 Transparency and Disclosure

All active parameters and defaults are:
- Exposed via the user interface
- Inspectable via on-chain or published records
- Versioned where applicable

Users are responsible for reviewing parameters prior to authorization.

---

## F.8 Non-Reliance Statement

Nothing in this appendix should be interpreted as:
- A recommendation of default settings
- A guarantee of safety
- A representation of optimal configuration
- A substitute for user judgment

System parameters define boundaries, not outcomes.


# Appendix G — Disclosures, Assumptions, and Known Risks (Operational, Non-Binding)

This appendix consolidates **explicit disclosures, operating assumptions, and known risks** associated with the YieldLoop system.

This appendix is descriptive, not contractual. It exists to surface known limitations and risks so that system behavior is not misunderstood or overstated. Nothing in this appendix alters execution, settlement, accounting, or authorization logic.

---

## G.1 Purpose

The purpose of this appendix is to:
- Eliminate ambiguity around risk
- Prevent implied guarantees or assurances
- Clearly state what the system assumes and what it does not control
- Address common failure modes and external dependencies

This appendix is written to be read independently by reviewers, regulators, auditors, and users.

---

## G.2 Core Operating Assumptions

YieldLoop operates under the following assumptions:

- Blockchain networks will continue to function as designed
- Smart contracts execute deterministically but may contain defects
- External protocols and venues behave according to their published rules
- Market liquidity may vary or disappear
- Users understand and accept non-custodial execution risk

If any assumption fails, execution outcomes may be adversely affected.

---

## G.3 Market and Execution Risks

Risks inherent to execution include:
- Price volatility and rapid market movement
- Slippage exceeding expected thresholds
- Partial execution or aborted transactions
- Thin liquidity or market closure
- Failed arbitrage sequences

YieldLoop does not intervene to prevent losses resulting from market behavior.

---

## G.4 Protocol and Smart Contract Risks

Risks include:
- Bugs or vulnerabilities in YieldLoop contracts
- Bugs or vulnerabilities in third-party protocols
- Unexpected interactions between contracts
- Upgrades or changes to external protocols
- Exploits, hacks, or insolvency of third-party platforms

No audits or reviews eliminate these risks entirely.

---

## G.5 Stablecoin and Asset-Specific Risks

Stablecoins may:
- Lose or deviate from their intended peg
- Be frozen or blacklisted by issuers
- Experience liquidity shortages

Tokenized assets (e.g., PAXG) involve:
- Issuer risk
- Custodial risk
- Regulatory action risk
- Redemption limitations

These risks are external and not controlled by YieldLoop.

---

## G.6 Infrastructure and Dependency Risks

YieldLoop depends on:
- Blockchain validators and network uptime
- RPC providers and node infrastructure
- Oracles or pricing sources where applicable
- Wallet software and user key management

Failures in any dependency may delay or prevent execution or settlement.

---

## G.7 User Responsibility and Control

Users are responsible for:
- Understanding authorization parameters
- Managing private keys and wallets
- Reviewing execution constraints
- Accepting execution outcomes

YieldLoop does not assess user suitability, experience, or financial capacity.

---

## G.8 No Guarantees or Insurance

YieldLoop provides:
- No insurance
- No capital protection
- No loss recovery mechanisms
- No guarantees of execution success or profitability

Users should assume total loss is possible.

---

## G.9 Legal and Regulatory Uncertainty

Laws and regulations governing digital assets and automated execution systems may change.

Possible risks include:
- New regulatory requirements
- Restrictions on protocol interaction
- Asset freezes or sanctions
- Changes in tax treatment

YieldLoop does not monitor or enforce compliance on behalf of users unless required by law.

---

## G.10 Non-Reliance Statement

Nothing in this appendix or elsewhere in this document should be interpreted as:
- Financial, legal, or tax advice
- An inducement to participate
- A guarantee of outcomes
- A representation of system safety or suitability

Use of the system is voluntary and at the user’s sole risk.


