/*
 *      ##########################################
 *      ##########################################
 *      ###                                    ###
 *      ###          &#119823;&#119845;&#119834;&#119858; &amp; &#119830;&#119842;&#119847; &#119812;&#119853;&#119841;&#119838;&#119851;          ###
 *      ###                 at                 ###
 *      ###          &#119812;&#119827;&#119815;&#119812;&#119825;&#119808;&#119813;&#119813;&#119819;&#119812;.&#119810;&#119822;&#119820;          ###
 *      ###                                    ###
 *      ##########################################
 *      ##########################################
 *
 *      Welcome to the temporary &#119812;&#119853;&#119841;&#119838;&#119851;&#119834;&#119839;&#119839;&#119845;&#119838; &#119811;&#119842;&#119852;&#119835;&#119854;&#119851;&#119852;&#119834;&#119845; &#119810;&#119848;&#119847;&#119853;&#119851;&#119834;&#119836;&#119853;. 
 *      It&#39;s currently a place-holder whose only functionality is 
 *      forward-compatability with the soon-to-be-deployed actual 
 *      contract. 
 *
 *      Its job is to accrue funds generated by &#119812;&#119853;&#119841;&#119838;&#119851;&#119834;&#119839;&#119839;&#119845;&#119838; to pay out 
 *      as &#119837;&#119842;&#119855;&#119842;&#119837;&#119838;&#119847;&#119837;&#119852; to the &#119819;&#119822;&#119827; token holders. But that&#39;s only the 
 *      start. &#119819;&#119822;&#119827; token holders will form a &#119811;&#119808;&#119822; who own and run 
 *      &#119812;&#119853;&#119841;&#119838;&#119851;&#119834;&#119839;&#119839;&#119845;&#119838;, and will be able to vote of the future of the 
 *      platform via this very contract! They&#39;ll also get to say where 
 *      &#119812;&#119853;&#119841;&#119825;&#119838;&#119845;&#119842;&#119838;&#119839; - Etheraffle&#39;s charitable arm - funds go to as well. 
 *      All whilst earning a &#119837;&#119842;&#119855;&#119842;&#119837;&#119838;&#119847;&#119837; from ticket sales of &#119812;&#119853;&#119841;&#119838;&#119851;&#119834;&#119839;&#119839;&#119845;&#119838;! 
 *
 *
 *                     &#119812;&#119857;&#119836;&#119842;&#119853;&#119842;&#119847;&#119840; &#119853;&#119842;&#119846;&#119838;&#119852; - &#119852;&#119853;&#119834;&#119858; &#119853;&#119854;&#119847;&#119838;&#119837;!
 *
 *
 *      Learn more and take part at &#119841;&#119853;&#119853;&#119849;&#119852;://&#119838;&#119853;&#119841;&#119838;&#119851;&#119834;&#119839;&#119839;&#119845;&#119838;.&#119836;&#119848;&#119846;/&#119842;&#119836;&#119848;
 *      Or if you want to chat to us you have loads of options:
 *      On &#119827;&#119838;&#119845;&#119838;&#119840;&#119851;&#119834;&#119846; @ &#119841;&#119853;&#119853;&#119849;&#119852;://&#119853;.&#119846;&#119838;/&#119838;&#119853;&#119841;&#119838;&#119851;&#119834;&#119839;&#119839;&#119845;&#119838;
 *      Or on &#119827;&#119856;&#119842;&#119853;&#119853;&#119838;&#119851; @ &#119841;&#119853;&#119853;&#119849;&#119852;://&#119853;&#119856;&#119842;&#119853;&#119853;&#119838;&#119851;.&#119836;&#119848;&#119846;/&#119838;&#119853;&#119841;&#119838;&#119851;&#119834;&#119839;&#119839;&#119845;&#119838;
 *      Or on &#119825;&#119838;&#119837;&#119837;&#119842;&#119853; @ &#119841;&#119853;&#119853;&#119849;&#119852;://&#119838;&#119853;&#119841;&#119838;&#119851;&#119834;&#119839;&#119839;&#119845;&#119838;.&#119851;&#119838;&#119837;&#119837;&#119842;&#119853;.&#119836;&#119848;&#119846;
 *
 */
pragma solidity^0.4.21;

contract ReceiverInterface {
    function receiveEther() external payable {}
}

contract EtheraffleDisbursal {

    bool    upgraded;
    address etheraffle;
    /**
     * @dev  Modifier to prepend to functions rendering them
     *       only callable by the Etheraffle multisig address.
     */
    modifier onlyEtheraffle() {
        require(msg.sender == etheraffle);
        _;
    }
    event LogEtherReceived(address fromWhere, uint howMuch, uint atTime);
    event LogUpgrade(address toWhere, uint amountTransferred, uint atTime);
    /**
     * @dev   Constructor - sets the etheraffle var to the Etheraffle
     *        managerial multisig account.
     *
     * @param _etheraffle   The Etheraffle multisig account
     */
    function EtheraffleDisbursal(address _etheraffle) {
        etheraffle = _etheraffle;
    }
    /**
     * @dev   Upgrade function transferring all this contract&#39;s ether
     *        via the standard receive ether function in the proposed
     *        new disbursal contract.
     *
     * @param _addr    The new disbursal contract address.
     */
    function upgrade(address _addr) onlyEtheraffle external {
        upgraded = true;
        emit LogUpgrade(_addr, this.balance, now);
        ReceiverInterface(_addr).receiveEther.value(this.balance)();
    }
    /**
     * @dev   Standard receive ether function, forward-compatible
     *        with proposed future disbursal contract.
     */
    function receiveEther() payable external {
        emit LogEtherReceived(msg.sender, msg.value, now);
    }
    /**
     * @dev   Set the Etheraffle multisig contract address, in case of future
     *        upgrades. Only callable by the current Etheraffle address.
     *
     * @param _newAddr   New address of Etheraffle multisig contract.
     */
    function setEtheraffle(address _newAddr) onlyEtheraffle external {
        etheraffle = _newAddr;
    }
    /**
     * @dev   selfDestruct - used here to delete this placeholder contract
     *        and forward any funds sent to it on to the final disbursal
     *        contract once it is fully developed. Only callable by the
     *        Etheraffle multisig.
     *
     * @param _addr   The destination address for any ether herein.
     */
    function selfDestruct(address _addr) onlyEtheraffle {
        require(upgraded);
        selfdestruct(_addr);
    }
    /**
     * @dev   Fallback function that accepts ether and announces its
     *        arrival via an event.
     */
    function () payable external {
    }
}