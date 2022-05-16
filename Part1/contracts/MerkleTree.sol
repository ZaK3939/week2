//SPDX-License-Identifier: Unlicense
// Ref https://github.com/appliedzkp/incrementalquintree/blob/master/contracts/MultiIncrementalQuinTree.sol
pragma solidity ^0.8.0;

import { PoseidonT3 } from "./Poseidon.sol"; //an existing library to perform Poseidon hash on solidity
import "./verifier.sol"; //inherits with the MerkleTreeInclusionProof verifier contract



contract MerkleTree is Verifier {
    uint256[] public hashes; // the Merkle tree in flattened array form
    uint256 public index = 0; // the current index of the first unfilled leaf
    uint256 public root; // the current Merkle root
    // The zero value per level
    mapping (uint256 => uint256) internal zeros;
    // The number of leaves per node
    uint8 internal constant LEAVES_PER_NODE = 2;
    uint8 treeLevels;
    // The number of inserted leaves
    uint256 internal nextLeafIndex = 0;
    uint256 internal currentTreeNum;
    // Allows you to compute the path to the element (but it's not the path to
    // the elements). Caching these values is essential to efficient appends.
    mapping (uint256 => mapping (uint256 => uint256)) internal filledSubtrees;
     // The filled subtrees for a blank tree.
    mapping (uint256 => mapping (uint256 => uint256)) internal originalFilledSubtrees;
    constructor() {
        // [assignment] initialize a Merkle tree of 8 with blank leaves
        treeLevels = 3;
        uint256 currentZero = 0;
        hashes = new uint256[](15);
        // hash3 requires a uint256[] memory input, so we have to use temp
        uint256[LEAVES_PER_NODE] memory temp;

        for (uint8 i = 0; i < treeLevels; i++) {
            for (uint8 j = 0; j < LEAVES_PER_NODE; j ++) {
                //filledSubtrees[i][j] = currentZero;
                originalFilledSubtrees[i][j] = currentZero;
                temp[j] = currentZero;
            }

            zeros[i] = currentZero;
            currentZero = hash3(temp);
        }

        root = currentZero;
    }

    function insertLeaf(uint256 hashedLeaf) public returns (uint256) {
        // [assignment] insert a hashed leaf into the Merkle tree
        // If the current tree overflows, create a new one
        if (nextLeafIndex >= uint256(LEAVES_PER_NODE) ** uint256(treeLevels)) {
            nextLeafIndex = 0;
            currentTreeNum ++;
            for (uint8 i = 0; i < treeLevels; i++) {
                for (uint8 j = 0; j < LEAVES_PER_NODE; j ++) {
                    filledSubtrees[i][j] = originalFilledSubtrees[i][j];
                }
            }
        }

        uint256 currentIndex = nextLeafIndex;

        uint256 currentLevelHash = hashedLeaf;

        // hash3 requires a uint256[] memory input, so we have to use temp
        uint256[LEAVES_PER_NODE] memory temp;

        // The leaf's relative position within its node
        uint256 m = currentIndex % LEAVES_PER_NODE;

        for (uint8 i = 0; i < treeLevels; i++) {
            // If the leaf is at relative index 0, zero out the level in
            // filledSubtrees
            if (m == 0) {
                for (uint8 j = 1; j < LEAVES_PER_NODE; j ++) {
                    filledSubtrees[i][j] = zeros[i];
                }
            }

            // Set the leaf in filledSubtrees
            filledSubtrees[i][m] = currentLevelHash;

            // Hash the level
            for (uint8 j = 0; j < LEAVES_PER_NODE; j ++) {
                temp[j] = filledSubtrees[i][j];
            }
            currentLevelHash = hash3(temp);

            currentIndex /= LEAVES_PER_NODE;
            m = currentIndex % LEAVES_PER_NODE;
        }

        root = currentLevelHash;

        //rootHistory[currentTreeNum][currentLevelHash] = true;

        nextLeafIndex += 1;

        return currentIndex;
    }

    function verify(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[1] memory input
        ) public view returns (bool) {

        // [assignment] verify an inclusion proof and check that the proof root matches current root
        return verifyProof(a, b, c, input);
    }
    function hash3(uint256[2] memory array) public pure returns (uint256) {
        return PoseidonT3.poseidon(array);
    }
}
