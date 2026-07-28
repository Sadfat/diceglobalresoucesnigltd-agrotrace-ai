# AgroTrace AI Agent 🌾🔗

**An autonomous blockchain-based system for traceability and verification of agricultural products on the Somnia Network.**

Built for the Somnia Hackathon by **Dice Global Resources Nig Ltd**.

---

## 📖 Overview

AgroTrace AI Agent combines AI-driven verification with on-chain traceability to track agricultural products — from farm to market — on the Somnia blockchain. It aims to reduce fraud, improve trust in supply chains, and give smallholder farmers verifiable proof of origin and quality for their produce.

## ✨ Features

- **On-chain product registration** — each batch of produce is logged with an immutable record (origin, date, handler).
- **Traceability chain** — every transfer/checkpoint (farm → processor → distributor → market) is recorded on-chain.
- **AI verification agent** — flags anomalies or inconsistent supply chain data before it's committed.
- **Public verification** — anyone can look up a product's history via its unique on-chain ID.
- **Built on Somnia Network** — leverages Somnia's fast, low-cost infrastructure for real-time agri-data transactions.

## 🏗️ Architecture

```
contracts/
  AgroTraceAgent.sol      → Core smart contract (registration + traceability logic)
scripts/
  deploy.js               → Deployment script (Hardhat)
hardhat.config.js         → Network + compiler config
```

## 🔧 Tech Stack

- **Solidity** — smart contract logic
- **Hardhat** — development, testing, deployment
- **Somnia Network** — target blockchain
- **Node.js** — tooling runtime

## 🚀 How to Run

1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/diceglobal-agrotrace-ai.git
   cd diceglobal-agrotrace-ai
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Compile the contract:
   ```bash
   npx hardhat compile
   ```
4. Configure your Somnia network RPC + private key in `hardhat.config.js` (use a `.env` file — never commit real keys).
5. Deploy:
   ```bash
   npx hardhat run scripts/deploy.js --network somnia
   ```

## 👥 Team

**Dice Global Resources Nig Ltd**
- Abubakar Jibrin Gunda (Sadiq) — Project Lead / Founder

*(Add other team members here)*

## 📄 License

MIT License

## 🙏 Acknowledgments

Built for the Somnia Network Hackathon.
