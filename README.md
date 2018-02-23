truffle-debug-example
=====================
As of version 4, Truffle has a built in debugger for stepping through the code that executes during a transaction. This project contains examples of different errors that will require the use of the debugger to locate and fix.

Assumptions:
------------
1. Familiarity with [Truffle Framework](http://truffleframework.com/)
1. Truffle 4.0 or newer has been installed
1. This repository has been cloned

Usage:
------
> Open a terminal and navigate to where this project is cloned.
> 
> For the following commands, interact directly with the terminal:
>
> `...\truffle-debug-example>`

1. Truffle will easily compile and build the contracts in the /contracts/ directory using this command.

    Input:
    ```
     truffle compile
    ```

    Output:
    ```
    Compiling .\contracts\Migrations.sol...
    Compiling .\contracts\Store.sol...
    Writing artifacts to .\build\contracts
    ```

1. Truffle has a built-in development blockchain that can be used to locally test contracts. Initialize the local blockhain and launch the Truffle development interactive shell with this command.  
*Note: The Accounts and Private Keys will vary. (Never use any of this on the mainnet!)*
    
    Input:
    ```
    truffle develop
    ```

    Output:
    ```
    Truffle Develop started at http://localhost:9545/

    Accounts:
    (0) 0x627306090abab3a6e1400e9345bc60c78a8bef57
    (1) 0xf17f52151ebef6c7334fad080c5704d77216b732
    (2) 0xc5fdf4076b8f3a5357c5e395ab970b5b54098fef
    (3) 0x821aea9a577a9b44299b9c15c88cf3087f3b5544
    (4) 0x0d1d4e623d10f9fba5db95830f7d3839406c6af2
    (5) 0x2932b7a2355d6fecc4b5c0b6bd44cc31df247a2e
    (6) 0x2191ef87e392377ec08e7c08eb105ef5448eced5
    (7) 0x0f4f2ac550a1b4e2280d04c21cea7ebd822934b5
    (8) 0x6330a553fc93768f612722bb8c2ec78ac90b3bbc
    (9) 0x5aeda56215b167893e80b4fe645ba6d5bab767de

    Private Keys:
    (0) c87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3
    (1) ae6ae8e5ccbfb04590405997ee2d52d2b330726137b875053c36d94e974d162f
    (2) 0dbbe8e4ae425a6d2687f1a7e3ba17bc98c673636790f1b8ad91193c05875ef1
    (3) c88b703fb08cbea894b6aeff5a544fb92e78a18e19814cd85da83b71f772aa6c
    (4) 388c684f0ba1ef5017716adb5d21a053ea8e90277d0868337519f97bede61418
    (5) 659cbb0e2411a44db63778987b1e22153c086a95eb6b18bdf89de078917abc63
    (6) 82d052c865f5763aad42add438569276c00d3d88a2d062d36b2bae914d58b8c8
    (7) aa3680d5d48a8283413f7a108367c7299ca73f553735860a87b08f39395618b7
    (8) 0f62d96d6675f32685bbdb8ac13cda7c23436f63efbb9d07700d8669ff12b7c4
    (9) 8d5366123cb560bb606379f90a0bfd4769eecc0557f1b362dcae9012b548b1e5

    Mnemonic: candy maple cake sugar pudding cream honey rich smooth crumble sweet treat
    ```

> For the following commands, interact with the Truffle development shell:
> 
> `truffle(develop)>`

1. This command will have Truffle deploy the peviously compiled contracts to the local development blockchain.  
*Note: The hashes will vary. (Never use any of this on the mainnet!)*

    Input:
    ```
    migrate
    ```

    Output:
    ```
    Using network 'develop'.

    Running migration: 1_initial_migration.js
    Deploying Migrations...
    ... 0x8da0651940a879216370aa7a6348116bad08b629509723d62f032909d824f45b
    Migrations: 0x8cdaf0cd259887258bc13a92c0a6da92698644c0
    Saving successful migration to network...
    ... 0xd7bc86d31bee32fa3988f1c1eabce403a1b5d570340a3a9cdba53a472ee8c956
    Saving artifacts...
    Running migration: 2_deploy_contracts.js
    Deploying SimpleStorage...
    ... 0x66a503636d4e9ae10deee41f772247a6b9a20547d201f64e6fb2b7fbb23e0972
    SimpleStorage: 0x345ca3e014aaf5dca488057592ee47305d9b3e10
    Saving successful migration to network...
    ... 0xf36163615f41ef7ed8f4a8f192149a0bf633fe1a2398ce001bf44c43dc7bdda0
    Saving artifacts...
    ```

1. This command looks for the SimpleStorage contract on the local blockchain and calls the `get()` function that is defined inside. The output is returned and converted to a number. Notice that the value returned is `0` (even though it is not initialized in the contract code) since Solidity automatically initializes integer types with a value of zero.  
*Note: The `get()` function will be used multiple times throughout the remainder of this example.*

    Input:
    ```javascript
    SimpleStorage.deployed().then((instance)=>{return instance.get.call();}).then((value)=>{return value.toNumber()});
    ```

    Output:
    ```javascript
    0
    ```

1. This command calls the `set()` function with a value of `4`. The `set()` function is the 'clean' function that will work without error and as intended. Since there was no error, the output shows information regarding the transaction.  
*Note: Notice the transaction hash, returned both as `tx` and `transactionHash`. When debugging issues in the following sections, the hashes for those transactions will be required.*

    Input:
    ```javascript
    SimpleStorage.deployed().then((instance)=>{return instance.set(4);});
    ```

    Output:
    ```javascript
    { tx: '0x8a7d3343dd2aaa0438157faae678ca57cc6485825bb4ed2ebefe90609dd268ce',
      receipt:
        { transactionHash: '0x8a7d3343dd2aaa0438157faae678ca57cc6485825bb4ed2ebefe90609dd268ce',
          transactionIndex: 0,
          blockHash: '0x5df42b1779e76c70836112f0026a722ab687bca75de27ac11b460fb29882e0db',
          blockNumber: 5,
          gasUsed: 41664,
          cumulativeGasUsed: 41664,
          contractAddress: null,
          logs: [],
          status: 1 },
        logs: [] }
    ```

1. Call the `get()` function again and notice that the value returned is now `4`.

    Input:
    ```javascript
    SimpleStorage.deployed().then((instance)=>{return instance.get.call();}).then((value)=>{return value.toNumber()});
    ```

    Output:
    ```javascript
    4
    ```

1. These steps have first shown how to compile, build, and deploy this project to a local development blockchain that is built-in to the Truffle framework. Then the `get()` command was called to show that the number stored on the blockchain has been initialized to `0`. Next, the `set()` command was called with a value of `4`. Finally, the `get` command was again called to show that the number stored on the blockchain was correctly changed to `4`.

1. The following sections will explain how to step through problematic code using Truffle's transaction debugger.

Debugging Issues:
-----------------

> To assist debugging, attach to the Truffle development logging output:
>
> 1. Open a second terminal alongside the Truffle development shell
> 1. Navigate to where this project is cloned
> 1. Input: `truffle develop --log`
> 1. Output: `Connected to existing Truffle Develop session at http://localhost:9545/`
> 1. This terminal will now receive Truffle development logging output

> For the following commands, continue to interact with the Truffle development shell:
> 
> `truffle(develop)>`

### Issue 1: Invalid Opcode

1. This command calls the `setInvalidOpcode()` function with a value of `0`. The `setInvalidOpcode()` function throws an error on any value other than `0`. Since the function is called with a value of `0`, there was no error, and the output shows information regarding the transaction.  

    Input:
    ```javascript
    SimpleStorage.deployed().then((instance)=>{return instance.setInvalidOpcode(0);});
    ```

    Output:
    ```
    { tx: '0x8e2e8dcb787c45f43a772e25b697f2d9b72731faf1a878be9c1969d59e3c7512',
      receipt:
        { transactionHash: '0x8e2e8dcb787c45f43a772e25b697f2d9b72731faf1a878be9c1969d59e3c7512',
          transactionIndex: 0,
          blockHash: '0x8012074814f3c5f55ee03d22f4215c26aea080a2b3b0740e145292d4029f6232',
          blockNumber: 6,
          gasUsed: 13326,
          cumulativeGasUsed: 13326,
          contractAddress: null,
          logs: [],
          status: 1 },
        logs: [] }
    ```

1. Call the `get()` function again and notice that the value returned is now `0`.

    Input:
    ```javascript
    SimpleStorage.deployed().then((instance)=>{return instance.get.call();}).then((value)=>{return value.toNumber()});
    ```

    Output:
    ```javascript
    0
    ```

1. Call the `setInvalidOpcode()` function once again, but now with a value of `4`. Since the function is called with a value other than `0`, the output shows information regarding the error that was encountered.  
*Note: Notice that the error output does not contain the transaction hash needed for debugging the issue, hence why the debugger logs are needed.*

    Input:
    ```javascript
    SimpleStorage.deployed().then((instance)=>{return instance.setInvalidOpcode(4);});
    ```

    Output:
    ```
    Error: VM Exception while processing transaction: invalid opcode
    at XMLHttpRequest._onHttpResponseEnd (...\npm\node_modules\truffle\build\webpack:\~\xhr2\lib\xhr2.js:509:1)
    at XMLHttpRequest._setReadyState (...\npm\node_modules\truffle\build\webpack:\~\xhr2\lib\xhr2.js:354:1)
    at XMLHttpRequestEventTarget.dispatchEvent (...\npm\node_modules\truffle\build\webpack:\~\xhr2\lib\xhr2.js:64:1)
    at XMLHttpRequest.request.onreadystatechange (...\npm\node_modules\truffle\build\webpack:\~\web3\lib\web3\httpprovider.js:128:1)
    at ...\npm\node_modules\truffle\build\webpack:\~\truffle-provider\wrapper.js:134:1
    at ...\npm\node_modules\truffle\build\webpack:\~\web3\lib\web3\requestmanager.js:86:1
    at Object.InvalidResponse (...\npm\node_modules\truffle\build\webpack:\~\web3\lib\web3\errors.js:38:1)
    ```