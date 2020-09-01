pragma solidity ^0.5.9;

import "./BridgePublicAPI.sol";

contract priceFeed is BridgePublicAPI {
    
    event price(uint256 _amount);
    
    string public BTCUSD;

    function send_query(string memory arg) public {
        bridge_query("URL", "json(https://api.pro.coinbase.com/products/BTC-USD/ticker).price");
    }
    function __callback(bytes32 _myid, string memory _result) public {
        require(msg.sender == oracle_cbAddress());
        BTCUSD = _result;
        uint256 res =  parseInt(_result, 0);
        emit price(res);
    }
}