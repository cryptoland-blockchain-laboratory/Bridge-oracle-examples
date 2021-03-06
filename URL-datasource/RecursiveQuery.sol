pragma solidity ^0.5.9;

import "./BridgePublicAPI.sol";

contract BTCprice is BridgePublicAPI {
    
    function send_query(uint256 delay_time) public {
        bridge_query(delay_time, "URL", "json(https://www.therocktrading.com/api/ticker/BTCEUR).result.0.last");
    }
    
    string public res;
    
    event btcPrice(string _price);
    
    function __callback(bytes32 _myid, string memory _result) public {
        require(msg.sender == oracle_cbAddress());
        res = _result;
        emit btcPrice(_result);
        send_query(60);
    }
}