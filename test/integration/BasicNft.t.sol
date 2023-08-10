// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {BasicNft} from "src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployBasicNft;
    BasicNft public basicNft;

    address public user = makeAddr("user");
    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function test_NameIsCorrect() public {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        // 1st way
        assertEq(expectedName, actualName);
        // 2nd way to compare two strings
        assertEq(keccak256(abi.encodePacked(expectedName)), keccak256(abi.encodePacked(actualName)));
    }

    function test_CanMintAndHaveABlanace() public {
        vm.prank(user);
        basicNft.mintNft(PUG);

        assertEq(basicNft.balanceOf(user), 1);
        assertEq(PUG, basicNft.tokenURI(0));
    }
}
