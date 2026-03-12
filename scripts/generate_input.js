// scripts/generate_input.js
const fs = require('fs');
const { ethers } = require('ethers');
const { buildPoseidon } = require("circomlibjs");
const path = require('path');

async function generate() {
    const r_hex = process.argv[2]; 
    const p_hex = process.argv[3];
    const aliceSecretID = process.argv[4] || "88888888";

    if (!r_hex || !p_hex) {
        console.error("❌ Missing arguments! Usage: node generate_input.js <r_hex> <p_hex> <aliceSecretID>");
        process.exit(1);
    }

    // Initialising Poseidon
    const poseidonLib = await buildPoseidon();

    // ✅ Calculate Poseidon hash
    // Note: The result of Poseidon is Uint8Array,needs converte to decimal string using F.toString.
    const hash = poseidonLib([BigInt(aliceSecretID)]);
    const alicePublicID = poseidonLib.F.toString(hash);

    // Calculate the transaction anchor hash (Keccak)
    const transferHashHex = ethers.solidityPackedKeccak256(["string"], [p_hex]);
    const transferHash = BigInt(transferHashHex).toString();

    const r_nonce = BigInt("0x" + r_hex.replace('0x', '')).toString();

    const input = {
        "aliceSecretID": aliceSecretID,
        "r_nonce": r_nonce, 
        "alicePublicID": alicePublicID,
        "transferHash": transferHash
    };

    const outputPath = path.join(__dirname, '../input.json');
    fs.writeFileSync(outputPath, JSON.stringify(input, null, 2));
    
    console.log("✨ Input generated with real-time data!");
    console.log("File saved to:", outputPath);
    console.log("r_nonce (first 10 digits):", r_nonce.slice(0, 10) + "...");
}

generate().catch(console.error);