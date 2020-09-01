pragma solidity ^0.5.9;

import "./BridgePublicAPI.sol";

contract wikiName is BridgePublicAPI {
    
    event LogWikiName(string _name);
    
    string public name;
    
    constructor() public {
        send_query();
    }
    function send_query() public {
        bridge_query("URL", 'html(https://wikipedia.org/).//*[contains(@class, 'central-textlogo__image')]/text()');
    }
    function __callback(bytes32 _myid, string memory _result) public {
        require(msg.sender == oracle_cbAddress());
        name = _result;
        emit LogWikiName(_result);
    }
}