## Part1,Q1
SHA256 <MiMC ≈ Poseidon < Pedersen

- Gas cost
POSEIDON ≈ MiMC < Pedersen < SHA256 (efficient)

Ultimately, whether the gas tradeoff is worth it depends on one’s use case. For instance, for an application that requires a tree that supports between 1 - 2 million leaves, a a binary Merkle tree that uses Poseidon is favourable, as it requires at least 767k gas per insertion, rather than 969k gas per insertion for a MiMC binary Merkle tree, or 1129k gas per insertion for a Poseidon quinary Merkle tree.
[Reference]
<https://ethresear.ch/t/gas-and-circuit-constraint-benchmarks-of-binary-and-quinary-incremental-merkle-trees-using-the-poseidon-hash-function/7446>

- Capacity (clarification: capacity meaning the number of inputs it can take in circomlib templates)
Poseidon < Pedersen < MiMC < SHA-256 (ideal)
[Reference]
<https://ethresear.ch/t/gas-and-circuit-constraint-benchmarks-of-binary-and-quinary-incremental-merkle-trees-using-the-poseidon-hash-function/7446>

- Proof generation efficiency
SHA-256 ≈ MiMC < Poseidon < Pedersen (ideal)
[Reference]
<https://medium.com/aztec-protocol/plonk-benchmarks-2-5x-faster-than-groth16-on-mimc-9e1009f96dfe>
<https://graz.pure.elsevier.com/en/publications/poseidon-a-new-hash-function-for-zero-knowledge-proof-systems>

- Proof size
Poseidon < Pedersen < MiMC < SHA256 (ideal)
[Reference]
<https://medium.com/aztec-protocol/plonk-benchmarks-2-5x-faster-than-groth16-on-mimc-9e1009f96dfe>
<https://crypto.stackexchange.com/questions/76929/minimizing-exchanges-for-zk-proof-of-a-message-with-given-sha-256>
<https://github.com/clearmatics/zeth/issues/4>

## Part2,Q1

- arbitrary amounts
The great novelty compared to traditional Tornado Cash pools is that deposited amounts are no longer predefined.
<https://docs.tornado.cash/tornado-cash-nova/fund-and-withdraw-on-nova>

- shielded transfers
One of the specificity of Tornado Cash Nova is the introduction of shielded transfers. It allows shielded transactions of deposited tokens while staying within the pool.
So far, to transfer the custody of deposited funds, tokens needed to be withdrawn first. With Nova, you will be able to transfer a chosen amount of your shielded balance (not necessarily all of it) to another address without needing to withdraw them from the pool.
<https://docs.tornado.cash/tornado-cash-nova/shielded-transfers-on-nova>

- L2(Gnosis Chain)

## Part2,Q2
To eliminate gas fees and ensure anonymity of transactions by paying reward to re-layers.
Going through your wallet for this gas fee can compromise the anonymity of the transaction if used ETH are linkable to your identity.
<https://docs.tornado.cash/tornado-cash-nova/more-anonymity-tips>


## Part3,Q1
Semaphore is a zero-knowledge gadget which allows Ethereum users to prove their membership of a set which they had previously joined without revealing their original identity.
The system can notify users of the approval of any string of characters so that once they have registered, they cannot register again.
This gadget comprises of smart contracts and zero-knowledge components which work in tandem. The Semaphore smart contract handles state, permissions, and proof verification onchain.
Expected to be used for applications such as mixing, anonymous login, anonymous DAO, anonymous voting, news reporting, etc.

## Part3,Q2
Double signing protection is explained here.
<https://medium.com/coinmonks/to-mixers-and-beyond-presenting-semaphore-a-privacy-gadget-built-on-ethereum-4c8b00857c9b>
(i) anonymously prove that their identity is in the set of registered identities, and at the same time:
(ii) Publicly store an arbitrary string in the contract, if and only if that string is unique to the user and the contract’s current external nullifier
If someone try to send another signal, but the contract rejects it because he/she has previously signaled to external nullifier

## Part3,Q3
1. Mao (card game)
<https://en.wikipedia.org/wiki/Mao_(card_game>)

2. Insider trading Detection
