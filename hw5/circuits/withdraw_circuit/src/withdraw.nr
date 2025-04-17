fn main(
    r: Field,                     // Private
    index: Field,                 // Private
    path: [Field; 8],             // Private 8 -> depth
    root: pub Field,              // Public
    id: pub Field,                // Public, also the nullifier
) {
    // Compute commitment
    let commitment = std::hash::pedersen_hash([id, r]);
    // Verify inclusion, merkle root with commitment given index
    let computed_root = std::merkle::compute_merkle_root(commitment, index, path);
    assert(computed_root == root);
}