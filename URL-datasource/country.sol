pragma solidity ^0.5.9;

import "./BridgePublicAPI.sol";

contract country is BridgePublicAPI {
    
    event countryLog(string _amount);
    
    string public countryName;

    constructor() public {
        countryName = "US";
    }
    function send_query() public {
        bridge_query("URL", "xml(https://samples.openweathermap.org/data/2.5/weather?q=London&mode=xml&appid=439d4b804bc8187953eb36d2a8c26a02).current.city.country");
    }
    function __callback(bytes32 _myid, string memory _result) public {
        require(msg.sender == oracle_cbAddress());
        countryName = _result;
        emit countryLog(_result);
    }
}