#!/bin/bash
set -e # The script will stop running immediately if any line of command encounters an error.

CIRCUIT_NAME="AliceCompliance"
PTAU_FILE="build/pot12_final.ptau" 

echo "Step 1: Compiling Circuit..."
circom circuits/${CIRCUIT_NAME}.circom --r1cs --wasm --sym -o build -l .

echo "Step 2: Setup (Groth16)..."
snarkjs groth16 setup build/${CIRCUIT_NAME}.r1cs ${PTAU_FILE} build/${CIRCUIT_NAME}_0000.zkey

echo "Step 3: Contribute to randomness..."
# The corrected zkey contribute syntax
snarkjs zkey contribute build/${CIRCUIT_NAME}_0000.zkey build/${CIRCUIT_NAME}_final.zkey --name="Alice" -v -e="random_entropy_123"

echo "Step 4: Export verification key..."
snarkjs zkey export verificationkey build/${CIRCUIT_NAME}_final.zkey build/verification_key.json

echo "Step 5: Generate Witness..."
node build/${CIRCUIT_NAME}_js/generate_witness.js build/${CIRCUIT_NAME}_js/${CIRCUIT_NAME}.wasm input.json build/witness.wtns

echo "Step 6: Generate proof..."
snarkjs groth16 prove build/${CIRCUIT_NAME}_final.zkey build/witness.wtns build/proof.json build/public.json

echo "Step 7: Verify proof..."
snarkjs groth16 verify build/verification_key.json build/public.json build/proof.json

echo "--------------------------------------"
echo "✅ A true success! All ZK files are ready."