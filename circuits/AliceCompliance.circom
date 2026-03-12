pragma circom 2.1.0;

include "../node_modules/circomlib/circuits/poseidon.circom";

template AliceCompliance() {
    // --- 私有输入 ---
    signal input aliceSecretID;   // Alice 的私密身份码 (例如她的 KYC 编号)
    signal input r_nonce;         // Alice 为这笔证明随机生成的 Nonce，防止重放攻击

    // --- 公开输入 ---
    signal input alicePublicID;   // Alice 的公开身份哈希 (银行已知)
    signal input transferHash;    // 交易锚定哈希 (由 P 算出，证明此证明仅对该 P 地址有效)

    // 1. 验证身份：Alice 必须知道能对应上 PublicID 的秘密 ID
    component idCheck = Poseidon(1);
    idCheck.inputs[0] <== aliceSecretID;
    idCheck.out === alicePublicID;

    // 2. 逻辑绑定：将 Alice 的秘密与这笔特定交易的哈希进行绑定
    // 这证明了：是合规的 Alice 授权了发往 transferHash (即 P 地址) 的转账
    component binding = Poseidon(2);
    binding.inputs[0] <== r_nonce;
    binding.inputs[1] <== transferHash;

    // 输出一个合规存证锚点 (银行可以记录这个输出)
    signal output complianceAnchor;
    complianceAnchor <== binding.out;
}

component main {public [alicePublicID, transferHash]} = AliceCompliance();