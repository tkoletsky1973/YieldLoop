# 9. Legal and Regulatory Considerations

YieldLoop is designed and operated as software infrastructure that enables users to authorize execution actions on their own digital assets and records outcomes after execution has completed.

This section describes the project’s legal and regulatory posture, design intent, and known areas of uncertainty. It does not assert regulatory conclusions or exemptions and is not intended as legal advice.

---

## 9.1 Design Intent and Compliance Posture

YieldLoop is intentionally designed to operate outside the scope of regulated financial activities such as custody, brokerage, discretionary asset management, investment advisory services, pooled investment vehicles, and securities issuance.

This design intent is reflected in the following architectural and operational characteristics:

- The system does not take custody of user assets
- Assets are not pooled or commingled
- All execution requires explicit, time-bounded user authorization
- Execution behavior is deterministic and rule-based
- The system does not provide recommendations, projections, or suitability assessments
- Outcomes are recorded only after execution has fully concluded
- Fees are applied only after settlement and only on net positive outcomes

These characteristics are enforced by system design rather than policy or disclosure alone.

---

## 9.2 Jurisdictional Uncertainty

Regulatory treatment of digital asset software varies by jurisdiction and continues to evolve. YieldLoop does not attempt to classify itself under any specific regulatory regime and does not represent that it is exempt from applicable laws.

Users are solely responsible for determining whether their use of the system complies with local laws, regulations, and tax obligations. YieldLoop does not assess user eligibility or suitability unless required by law.

Future regulatory developments may impose requirements or restrictions that affect system operation, availability, or supported features. Any required changes would apply prospectively and be documented prior to implementation.

---

## 9.3 Risk Avoidance by Architecture

YieldLoop’s primary regulatory risk mitigation strategy is architectural restraint.

Rather than relying on disclaimers or interpretive arguments, the system avoids regulated activity by design. Features commonly associated with regulatory risk are deliberately excluded, including:

- Custodial asset handling
- Discretionary execution
- Performance marketing or projections
- Guaranteed outcomes or capital protection
- Automatic reinvestment or compounding
- Incentive structures tied to deposits or execution volume

This approach is intended to reduce regulatory ambiguity and enforcement risk by aligning system behavior with explicit user authorization and factual outcome recording.

YieldLoop does not seek regulatory visibility or precedent-setting status. Compliance is achieved through conservative design choices and operational discipline rather than engagement-driven interpretation.
