# uzhethereum-pow

Instructions for running a mining node on UZH Ethereum Proof-of-Work network.

You don't need to clone the repository in order to use it. On Linux you can just download the main script `uzhethereum.sh` and run it in the following way:
```
mkdir uzhethereum
cd uzhethereum
wget "https://raw.githubusercontent.com/matijapiskorec/uzhethereum-pow/refs/heads/main/uzhethereum.sh"
chmod +x uzhethereum.sh
./uzhethereum.sh
./uzhethereum.sh download linux64 
./uzhethereum.sh init 
./uzhethereum.sh run 
```

This will start the synchronization process. You can also run the mining along with the node by providing your Ethereum address (for example, from Metamask) as an `ETHERBASE` argument:
```
./uzhethereum.sh run ETHERBASE 
```

Then you can watch the blockchain download progress in a separate terminal:
```
watch du -h --max-depth 1
```

If the node is running you can attach to its console:
```
./geth --datadir blockhain attach http://localhost:8545
```

And then issue commands to interact with the node::
```
admin.peers
eth.syncing
eth.blockNumber
eth.hashrate
eth.coinbase
web3.fromWei(eth.getBalance(eth.coinbase), "ether")
eth.getHeaderByNumber(eth.blockNumber)
```

