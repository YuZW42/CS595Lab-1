// source referenced:lab2, https://noir-lang.org/docs/noir/standard_library/merkle_trees, https://noir-lang.org/docs/how_to/how-to-solidity-verifier
/*
Command used: 
nargo compile
bb write_vk -b ./target/deposit_circuit.json -o ./target --oracle_hash keccak
bb write_solidity_verifier --scheme ultra_honk -k ./target/vk -o ./target/DepositVerifier.sol

Command for the prove: 
nargo execute --prover-name "Prover"
*/


fn main(
    id: Field,                    // Private, based on what the ta described & the homework
    r: Field,                     // Private
    oldPath: [Field; 8],          // Private, 8 --> depth
    oldRoot: pub Field,           // Public
    newRoot: pub Field,           // Public
    commitment: pub Field,        // Public
    index: pub Field              // Public
) {
    // Verify commitment
    let computed_commitment = std::hash::pedersen_hash([id, r]);
    assert(computed_commitment == commitment) ;

    // Define zero (default val based on readme)
    let zero = 0x18d85f3de6dcd78b6ffbf5d8374433a5528d8e3bf2100df0b7bb43a4c59ebd63;

    // Verify old root, merkle root with zero at index
    // deprecated soon but i cant find anything else
    let computed_old_root =  std::merkle::compute_merkle_root(zero, index, oldPath);
    assert(computed_old_root == oldRoot) ;

    // Verify new root, Merkle root with commitment at index
    let computed_new_root = std::merkle::compute_merkle_root(commitment, index, oldPath);
    assert (computed_new_root == newRoot);
}

