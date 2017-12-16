//1. Enter solidity version here

pragma solidity ^0.4.19;

//2. Create contract here
contract ZombieFactory {
    //3. Start here

    //The uint data type is an unsigned integer, meaning its value must be non-negative. There's also an int data type for signed integers
    //This will be stored permanently in the blockchain
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    //Structs allow you to create more complicated data types that have multiple properties
    struct Zombie {
        string name;
        uint dna;
    }

    //Remember that state variables are stored permanently in the blockchain?
    //So creating a dynamic array of structs like this can be useful for storing structured data in your contract, kind of like a database
    //You can declare an array as public, and Solidity will automatically create a getter method for it
    Zombie[] public zombies;

    //It's convention (but not required) to start function parameter variable names with an underscore (_) in order to differentiate them from global variables
    function _createZombie(string _name, uint _dna) private {
        // create a New Zombie:
        /*Zombie satoshi = Zombie("Satoshi", 172);*/

        // Add that zombie to the Array:
        /*zombies.push(satoshi);*/

        //We can also combine these together and do them in one line of code to keep things clean:
        /*zombies.push(Zombie("Satoshi", 172));*/
        zombies.push(Zombie(_name, _dna));
    }

    //Ethereum has the hash function keccak256 built in, which is a version of SHA3.
    //A hash function basically maps an input string into a random 256-bit hexidecimal number. A slight change in the string will cause a large change in the hash
    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));

        return rand % dnaModulus;
    }

    //We're going to create a public function that takes an input, the zombie's name, and uses the name to create a zombie with random DNA
    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);

        _createZombie(_name, randDna);
    }
}
