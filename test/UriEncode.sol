// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {UriEncode} from "../src/UriEncode.sol";

contract TestUriEncode is Test {
    function setUp() public {}

    function testEncode() public {
        assertEq(
            UriEncode.uriEncode("encode me +.-/balj^%"),
            "encode%20me%20%2b.-%2fbalj%5e%25"
        );
    }

    function testBlank() public {
        assertEq(UriEncode.uriEncode(""), "");
    }

    function testNouns() public {
        string memory nounsStr = unicode"/⌐◨-◨/";
        assertEq(
            UriEncode.uriEncode(nounsStr),
            "%2f%e2%8c%90%e2%97%a8-%e2%97%a8%2f"
        );
    }

    function testEveryEncodeChar() public {
        assertEq(
            UriEncode.uriEncode("       .   "),
            "%20%20%20%20%20%20%20.%20%20%20"
        );
    }

    function testNoEncodeAnyChar() public {
        assertEq(
            UriEncode.uriEncode(
                "ABCDEFHIJKLMNOPQRSTUVWXYZabcdefhijklmnopqrstuvwxyz0123456789"
            ),
            "ABCDEFHIJKLMNOPQRSTUVWXYZabcdefhijklmnopqrstuvwxyz0123456789"
        );
    }

    function testStringDoesNotCrash(string memory input) public {
        string memory solidityResult = UriEncode.uriEncode(input);
    }
}
