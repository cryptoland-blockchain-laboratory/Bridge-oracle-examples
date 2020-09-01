pragma solidity ^0.5.9;

import "./BridgePublicAPI.sol";

contract TRXprice is BridgePublicAPI {
    
    event price(string TRXprice);
    
    constructor() public {
        send_query("json(https://api.kraken.com/0/public/Ticker?pair=TRXUSD).result.TRXUSD.a.0");
    }
    
    string public TRXUSD;
    
    mapping (bytes32 => bool) public pendingQueries;
    
    function send_query(string memory arg) public {
        bytes32 queryId = bridge_query("URL", arg);
        pendingQueries[queryId] = true;
    }

    function __callback(bytes32 _myid, string memory _result) public {
        require(msg.sender == oracle_cbAddress());
        require(pendingQueries[_myid] == true);
        TRXUSD = _result;
        emit price(TRXUSD);
        delete pendingQueries[_myid];
    }
}