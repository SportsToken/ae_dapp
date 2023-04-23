

var PrizePoolFactory = ( function () {
    function PrizePoolFactory() {
        if (window.ethereum != null){
            this._web3 = new Web3(window.ethereum);
            //https://rpc.sx.technology/ 
        } else 
        {
            this._web3 = new Web3('https://rpc.sx.technology');
        }
        
    }

    // This function creates a pool contract, and then https://github.com/Riiz0/AX_PrizePool/blob/main/Prizepool.sol#L16
    PrizePoolFactory.prototype.createLeague = async function(_axToken, _entryFeeAmount, _leagueStartTime, _leagueEndTime) {  
        let prizePoolAddress;
        const accounts = await this._web3.eth.getAccounts(); 
        const response = [
            {
                "inputs": [
                    {
                        "internalType": "address",
                        "name": "winner",
                        "type": "address"
                    }
                ],
                "name": "distributePrize",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "inputs": [],
                "name": "joinLeague",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "inputs": [
                    {
                        "internalType": "address",
                        "name": "_axToken",
                        "type": "address"
                    },
                    {
                        "internalType": "uint256",
                        "name": "_entryFeeAmount",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "_leagueStartTime",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "_leagueEndTime",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "nonpayable",
                "type": "constructor"
            },
            {
                "inputs": [],
                "name": "withdrawBeforeLeagueStarts",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "inputs": [],
                "name": "admin",
                "outputs": [
                    {
                        "internalType": "address",
                        "name": "",
                        "type": "address"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [],
                "name": "approveAmount",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [],
                "name": "axToken",
                "outputs": [
                    {
                        "internalType": "contract IERC20",
                        "name": "",
                        "type": "address"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [],
                "name": "entryFeeAmount",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [],
                "name": "leagueEndTime",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [],
                "name": "leagueStartTime",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [],
                "name": "myBalance",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [
                    {
                        "internalType": "address",
                        "name": "",
                        "type": "address"
                    }
                ],
                "name": "stakedAmounts",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            }
        ];
        const PrizePoolContract = new this._web3.eth.Contract(response);
        // These arguments can be found here: 
        await (PrizePoolContract.deploy({
            data: '60806040523480156200001157600080fd5b50604051620014fd380380620014fd833981810160405281019062000037919062000191565b836000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555033600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550670de0b6b3a764000083620000ce919062000232565b6002819055508160038190555080600481905550505050506200027d565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006200011e82620000f1565b9050919050565b620001308162000111565b81146200013c57600080fd5b50565b600081519050620001508162000125565b92915050565b6000819050919050565b6200016b8162000156565b81146200017757600080fd5b50565b6000815190506200018b8162000160565b92915050565b60008060008060808587031215620001ae57620001ad620000ec565b5b6000620001be878288016200013f565b9450506020620001d1878288016200017a565b9350506040620001e4878288016200017a565b9250506060620001f7878288016200017a565b91505092959194509250565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b60006200023f8262000156565b91506200024c8362000156565b92508282026200025c8162000156565b9150828204841483151762000276576200027562000203565b5b5092915050565b611270806200028d6000396000f3fe608060405234801561001057600080fd5b50600436106100a95760003560e01c8063c4e5feb611610071578063c4e5feb614610140578063c9116b691461015e578063c99fea941461017c578063ce70108714610186578063f851a440146101a4578063fceb0f3b146101c2576100a9565b8063100500dc146100ae57806310c1c103146100cc5780631d518c5e146100fc578063223943aa1461011a5780639d43dc4614610136575b600080fd5b6100b66101e0565b6040516100c39190610aac565b60405180910390f35b6100e660048036038101906100e19190610b2a565b6101e6565b6040516100f39190610aac565b60405180910390f35b6101046101fe565b6040516101119190610aac565b60405180910390f35b610134600480360381019061012f9190610b2a565b610204565b005b61013e61052b565b005b610148610722565b6040516101559190610aac565b60405180910390f35b610166610728565b6040516101739190610aac565b60405180910390f35b61018461072e565b005b61018e610a43565b60405161019b9190610bb6565b60405180910390f35b6101ac610a67565b6040516101b99190610be0565b60405180910390f35b6101ca610a8d565b6040516101d79190610aac565b60405180910390f35b60045481565b60076020528060005260406000206000915090505481565b60035481565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614610294576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161028b90610c58565b60405180910390fd5b6004544210156102d9576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016102d090610cc4565b60405180910390fd5b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166370a08231306040518263ffffffff1660e01b81526004016103359190610be0565b602060405180830381865afa158015610352573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906103769190610d10565b90506000600760008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020549050600081116103ff576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016103f690610d89565b60405180910390fd5b80821015610442576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161043990610e1b565b60405180910390fd5b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663a9059cbb85846040518363ffffffff1660e01b81526004016104a0929190610e3b565b6020604051808303816000875af11580156104bf573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906104e39190610e9c565b905080610525576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161051c90610f3b565b60405180910390fd5b50505050565b600354421061056f576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161056690610fa7565b60405180910390fd5b6000600760003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020549050600081116105f6576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016105ed90611013565b60405180910390fd5b6000600760003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000208190555060008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663a9059cbb33846040518363ffffffff1660e01b8152600401610699929190610e3b565b6020604051808303816000875af11580156106b8573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906106dc9190610e9c565b90508061071e576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016107159061107f565b60405180910390fd5b5050565b60025481565b60065481565b600454421115610773576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161076a906110eb565b60405180910390fd5b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663dd62ed3e33306040518363ffffffff1660e01b81526004016107d192919061110b565b602060405180830381865afa1580156107ee573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906108129190610d10565b90508060058190555060008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166370a08231336040518263ffffffff1660e01b81526004016108749190610be0565b602060405180830381865afa158015610891573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906108b59190610d10565b600681905550600254811015610900576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016108f790611180565b60405180910390fd5b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166323b872dd33306002546040518463ffffffff1660e01b8152600401610962939291906111a0565b6020604051808303816000875af1158015610981573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906109a59190610e9c565b9050806109e7576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016109de9061107f565b60405180910390fd5b600254600760003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000828254610a389190611206565b925050819055505050565b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b60055481565b6000819050919050565b610aa681610a93565b82525050565b6000602082019050610ac16000830184610a9d565b92915050565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000610af782610acc565b9050919050565b610b0781610aec565b8114610b1257600080fd5b50565b600081359050610b2481610afe565b92915050565b600060208284031215610b4057610b3f610ac7565b5b6000610b4e84828501610b15565b91505092915050565b6000819050919050565b6000610b7c610b77610b7284610acc565b610b57565b610acc565b9050919050565b6000610b8e82610b61565b9050919050565b6000610ba082610b83565b9050919050565b610bb081610b95565b82525050565b6000602082019050610bcb6000830184610ba7565b92915050565b610bda81610aec565b82525050565b6000602082019050610bf56000830184610bd1565b92915050565b600082825260208201905092915050565b7f4f6e6c792061646d696e2063616e2064697374726962757465207072697a6500600082015250565b6000610c42601f83610bfb565b9150610c4d82610c0c565b602082019050919050565b60006020820190508181036000830152610c7181610c35565b9050919050565b7f4c656167756520686173206e6f7420656e646564207965740000000000000000600082015250565b6000610cae601883610bfb565b9150610cb982610c78565b602082019050919050565b60006020820190508181036000830152610cdd81610ca1565b9050919050565b610ced81610a93565b8114610cf857600080fd5b50565b600081519050610d0a81610ce4565b92915050565b600060208284031215610d2657610d25610ac7565b5b6000610d3484828501610cfb565b91505092915050565b7f57696e6e657220686173206e6f207374616b656420616d6f756e740000000000600082015250565b6000610d73601b83610bfb565b9150610d7e82610d3d565b602082019050919050565b60006020820190508181036000830152610da281610d66565b9050919050565b7f4e6f7420656e6f75676820415820746f6b656e7320746f20646973747269627560008201527f7465000000000000000000000000000000000000000000000000000000000000602082015250565b6000610e05602283610bfb565b9150610e1082610da9565b604082019050919050565b60006020820190508181036000830152610e3481610df8565b9050919050565b6000604082019050610e506000830185610bd1565b610e5d6020830184610a9d565b9392505050565b60008115159050919050565b610e7981610e64565b8114610e8457600080fd5b50565b600081519050610e9681610e70565b92915050565b600060208284031215610eb257610eb1610ac7565b5b6000610ec084828501610e87565b91505092915050565b7f4661696c656420746f207472616e7366657220415820746f6b656e7320746f2060008201527f77696e6e65720000000000000000000000000000000000000000000000000000602082015250565b6000610f25602683610bfb565b9150610f3082610ec9565b604082019050919050565b60006020820190508181036000830152610f5481610f18565b9050919050565b7f477261636520706572696f642068617320656e64656400000000000000000000600082015250565b6000610f91601683610bfb565b9150610f9c82610f5b565b602082019050919050565b60006020820190508181036000830152610fc081610f84565b9050919050565b7f4e6f207374616b656420616d6f756e7420746f20776974686472617700000000600082015250565b6000610ffd601c83610bfb565b915061100882610fc7565b602082019050919050565b6000602082019050818103600083015261102c81610ff0565b9050919050565b7f4661696c656420746f207472616e7366657220415820746f6b656e7300000000600082015250565b6000611069601c83610bfb565b915061107482611033565b602082019050919050565b600060208201905081810360008301526110988161105c565b9050919050565b7f4c65616775652068617320616c726561647920656e6465640000000000000000600082015250565b60006110d5601883610bfb565b91506110e08261109f565b602082019050919050565b60006020820190508181036000830152611104816110c8565b9050919050565b60006040820190506111206000830185610bd1565b61112d6020830184610bd1565b9392505050565b7f496e73756666696369656e7420415820746f6b656e20616c6c6f77616e636500600082015250565b600061116a601f83610bfb565b915061117582611134565b602082019050919050565b600060208201905081810360008301526111998161115d565b9050919050565b60006060820190506111b56000830186610bd1565b6111c26020830185610bd1565b6111cf6040830184610a9d565b949350505050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b600061121182610a93565b915061121c83610a93565b9250828201905080821115611234576112336111d7565b5b9291505056fea2646970667358221220d62b73e3f87a8f86c16af1e4cad6821ea789e6d8c8cd424bb80e8a3533c0817564736f6c63430008120033',
            arguments: [_axToken, _entryFeeAmount, _leagueStartTime, _leagueEndTime]
        })
        .send({
            from: accounts[0],
            gas: 20000000
        })
        .on('receipt', function(receipt){
            console.log(receipt.contractAddress)
        }).then(function(newContractInstance) {
            prizePoolAddress = newContractInstance.options.address
        }));
        
        console.log(prizePoolAddress);
        return prizePoolAddress;
    }
    return PrizePoolFactory;
})();