
👸 Hera's Ledger 

Privacy-preserving payment infrastructure for financial sovereignty.

Hera’s Ledger is a functional proof-of-concept (PoC) designed to provide unlinkable transactions while maintaining a necessary layer of zero-knowledge compliance. Built with EIP-5564 (Dual-Key Stealth Addresses) and ZK-SNARKs, it addresses the critical need for financial privacy for vulnerable groups, specifically focusing on women’s financial autonomy.

🚀 Overview 

In a transparent public ledger, transaction histories are visible to everyone, which can lead to surveillance or domestic financial control. Hera’s Ledger solves this by combining:
Unlinkable Receivership (DKSA): Using EIP-5564 to ensure that a sender can generate a unique, one-time address for a recipient that only the recipient can scan and spend from.
Privacy-Preserving Compliance (ZKP): Utilizing ZK-SNARKs to prove that a transaction participant is "authorized" (e.g., verified by a support network or NGO) without revealing their real-world identity or wallet address on-chain.

🛠️ Technical Stack 
### **Phase 1: Functional Demo (Current)**
* **Cryptography:** * **EIP-5564:** Implementation of Dual-Key Stealth Address (DKSA) for unlinkable transactions.
    * **ZKP:** Circom & SnarkJS (Groth16) for privacy-preserving identity/membership proofs.
* **Logic:** Node.js (Scanning, spending, and witness generation logic).
* 
### **Phase 2: On-chain Integration (Milestone 2)**
* **Smart Contracts (Solidity):** * **EIP-5564 Announcer:** Deploying the registry for stealth meta-tags.
    * **On-chain Verifier:** Transitioning the Groth16 verification logic into Solidity smart contracts for decentralized settlement.
      
🏗️ Core Features 
Stealth Key Generation: Support for generating scanning and spending keys.
Automated Scanning: Efficiently scans the blockchain for incoming stealth transactions without revealing the user's master public key.
ZK-Compliance Layer: Generates a witness and proof that the sender belongs to a verified "Allowlist" using a zero-knowledge circuit.
One-click Spend: Logic for deriving the private key for a stealth address to sign and broadcast transactions.


📋 Roadmap
[x] Functional Node.js Demo for DKSA (EIP-5564)
[x] Basic ZK-Circuit for Identity Verification
[ ] Merkle Tree Integration for On-chain Member Verification (In Progress)
[ ] L2 Deployment (Arbitrum/Optimism)
[ ] Front-end UI for Non-Technical Users
[ ] Smart Contracts On-chain verifier 

🤝 Social Impact 
As a female-led project, Hera’s Ledger is built as a Public Good. We believe that privacy is a human right. Our goal is to provide tools that protect those in vulnerable economic situations, ensuring that financial aid and personal savings remain private and secure.


🛠 Installation & Setup 
To run the Hera’s Ledger ZK-proof generation locally, follow these steps:
1. Clone and Install Dependencies
***
git clone https://github.com/WenjingLondon/Heras-Ledger.git 
cd Heras-Ledger 
npm install
***
2. Prepare the Build Environment Since the build artifacts and large cryptographic files are excluded from this repository for efficiency, you must set up the local directory structure:
Create the build folder:
***
mkdir build 
* Powers of Tau (PTAU): The script expects a pot12_final.ptau file located in the build/ directory. You can download it from the Hermez trusted setup or provide your own.
* Place the file here: build/pot12_final.ptau
***
3. Generate the ZK Proof Once the environment is prepared, run the automated shell script to compile the circuit, generate the witness, and verify the proof:
***
chmod +x build_proof.sh 
./build_proof.sh
***
4. Run the Local Server To interact with the demo via the web interface:
***
node server.js 
Then open your browser at http://localhost:5000.
***

📜 License 
This project is licensed under the MIT License—feel free to use, modify, and build upon this work to foster a more private and equitable Web3.
