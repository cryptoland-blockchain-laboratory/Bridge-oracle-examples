pragma solidity ^0.5.9;

import "./BridgePublicAPI.sol";

contract TRXprice is BridgePublicAPI {
    
    event result(string _result);
    
    mapping (bytes32 => bool) public pendingQueries;
    
    
    bytes32 public BTCid;
    bytes32 public TRXid;

    function send_query1() public {
        BTCid = bridge_query("URL", "json(https://api.pro.coinbase.com/products/BTC-USD/ticker).price");
        pendingQueries[BTCid] = true;
    }
    
    function send_query2() public {
        TRXid = bridge_query("URL", "json(https://api.kraken.com/0/public/Ticker?pair=TRXUSD).result.TRXUSD.a.0");
        pendingQueries[TRXid] = true;
    }

    function __callback(bytes32 _myid, string memory _result) public {
        require(msg.sender == oracle_cbAddress());
        if(_myid == BTCid) {
            require(pendingQueries[BTCid] == true);
            emit result(_result);
            delete pendingQueries[BTCid];
        } else if (_myid == TRXid) {
            require(pendingQueries[TRXid] == true);
            emit result("hello world");
            delete pendingQueries[TRXid];
        }
    }
}