pragma solidity ^0.4.17;

/**
 *  A simple contract that stores a number.
 */
contract SimpleStorage {
    // Integer types are automatically initialized with a value of 0 in Solidity.
    uint storedNum;

    /**
     *  Get the currently stored number.
     *  
     *  @return The currently stored number, as a uint.
     */
    function get() constant public returns (uint) {
        return storedNum;
    }

    /**
     *  Sets the currently stored number.
     *  Note: This method works without error and as intended.
     *
     *  @param input The number to be stored.
     */
    function set(uint input) public {
        storedNum = input;
    }

    /**
     *  Sets the currently stored number.
     *  Note: This method produces an "invalid opcode" error on any number other than 0.
     *
     *  @param input The number to be stored.
     */
    function setInvalidOpcode(uint input) public {
        // Require that the stored number can only be 0.
        assert(input == 0);
        storedNum = input;
    }

    /**
     *  Sets the currently stored number.
     *  Note: This method produces an "out of gas" error due to an infinite loop.
     *
     *  @param input The number to be stored.
     */
    function setOutOfGas(uint input) public {
        // Continuously set the stored number until the contract runs out of gas.
        while (true) {
            storedNum = input;
        }
    }
    
    event Odd();   // An odd number has been stored.    
    event Even();  // An even number has been stored.

    /**
     *  Sets the currently stored number.
     *  Note: This method works without error, but emits the wrong event.
     *
     *  @param input The number to be stored.
     */
    function setIncorrectEvent(uint input) public {
        storedNum = input;

        if (input % 2 == 0) {
            // Emit the Odd event for an even number.
            Odd();
        } else {
            // Emit the Even event for an odd number.
            Even();
        }
    }
}