---

## Appendix A — Supporter Pass (Paid Membership Program)

This appendix describes the YieldLoop **Supporter Pass**, a paid membership program designed to support platform development, community engagement, and long-term sustainability.

The Supporter Pass is **not an investment**, **not a financial product**, and **not a tokenized yield mechanism**.  
It is a one-time paid membership with defined utility and access benefits.

---

### A.1 Purpose of the Supporter Pass

The Supporter Pass exists to:

- Fund early-stage platform development and operations
- Create a committed community of aligned participants
- Provide a simple, transparent membership tier
- Enable community-driven contributions via bounties and advisory input

Funds collected from Supporter Pass purchases are treated as **platform income** and are not segregated as user deposits.

---

### A.2 Supporter Pass Terms

- **Price:** USD $300 (or equivalent stable asset)
- **Purchase Type:** One-time payment
- **Refunds:** None
- **Transferability:** Non-transferable
- **Withdrawal:** Not applicable
- **Expiration:** Lifetime of the YieldLoop platform, subject to upgrades or migrations

“Lifetime” refers to the operational lifetime of YieldLoop and its successor contracts or deployments.

---

### A.3 Benefits of the Supporter Pass

Supporter Pass holders receive the following benefits:

#### Platform Fee Discount
- **Lifetime 5% absolute discount** on platform performance fees
- Example:  
  - Standard platform fee: 20%  
  - Supporter Pass fee: **19%**

The discount is enforced at settlement and applied deterministically by the system.

#### Private Community Access
- Access to a **private Supporter Discord channel**
- Early visibility into platform updates, discussions, and roadmap items

#### Participation Eligibility
Supporter Pass holders may be considered for:
- bounty participation
- advisory input
- governance or configuration feedback (if and when enabled)

Eligibility does not guarantee selection, compensation, or influence.

---

### A.4 Bounty Pool and Community Incentives

A portion of the **Marketing & Partnerships allocation** may be used to create a **Bounty Pool**.

The Bounty Pool may be used to:
- solve technical or strategic problems
- reward meaningful contributions
- incentivize research, tooling, documentation, or outreach
- support community-driven problem solving

Key properties:
- bounties are discretionary and task-specific
- participation is invite-based or selection-based
- rewards are not guaranteed
- payouts may be manual and off-chain or on-chain, depending on context

The Bounty Pool does not affect:
- execution behavior
- LOOP minting or burning
- user vaults
- system backing or floor mechanics

---

### A.5 Technical Implementation (High-Level)

The Supporter Pass is implemented via a simple on-chain membership contract.

Typical flow:
1. User connects a wallet
2. User purchases the Supporter Pass via a smart contract
3. Contract records the wallet as a Supporter
4. Platform fee discounts are applied automatically at settlement
5. Off-chain services (e.g., Discord) verify Supporter status via wallet signature

The Supporter Pass contract:
- does not custody user vault funds
- does not interact with execution logic
- does not affect deposits or withdrawals
- does not mint or burn LOOP
- does not represent an investment position

---

### A.6 Explicit Non-Features

The Supporter Pass does **not**:

- represent ownership in YieldLoop
- confer equity, profit rights, or revenue share
- guarantee profit, yield, or returns
- provide priority execution or preferential risk treatment
- grant unilateral governance control
- function as a financial instrument

Purchasing a Supporter Pass does not create any expectation of financial return.

---

### A.7 Accounting and Disclosure

- Supporter Pass proceeds are recognized as **platform income**
- Funds may be used for development, marketing, operations, or reserves
- Supporter Pass purchases are independent of YieldLoop vault usage
- A user may purchase a Supporter Pass without ever depositing capital into YieldLoop

---

### A.8 Final Clarification

The Supporter Pass is a **paid membership**, not a financial product.

It exists to:
- support platform development
- reward aligned participation
- reduce long-term platform fees for supporters

Nothing more.

---
