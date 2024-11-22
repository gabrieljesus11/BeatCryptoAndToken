// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract BeatCoin is ERC20 {
    constructor()
        ERC20("BeatCoin", "BEAT")
    {
        _mint(msg.sender, 100 * 10 ** uint256(10));
    }

    function mint(address _to, uint qty) external {
        _mint(_to, qty);
    }
}
