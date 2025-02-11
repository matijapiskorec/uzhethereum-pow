#!/bin/bash

if [ -z "$1" ]
then
    echo "Running UZH Ethereum PoW node"
    echo "Usage instructions:"
    echo "    ./uzhethereum.sh download linux64 - download Linux 64 version of geth"
    echo "    ./uzhethereum.sh download mac - download Mac OS version of geth"
    echo "    ./uzhethereum.sh init - initialize geth for the UZH Ethereum PoW network"
    echo "    ./uzhethereum.sh run - run UZH Ethereum PoW node"
    echo "    ./uzhethereum.sh run ETHERBASE - run UZH Ethereum PoW node that mines on the ETHERBASE address"
else
	case "$1" in
        download)
            if [ -z "$2" ]
            then
                echo "Provide your operating system as second argument - linux64, mac!"
            else
                case "$2" in
                    linux64)
                        echo "Downloading Go Ethereum client for Linux 64 bit..."
                        sleep 2;
                        wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.10.15-8be800ff.tar.gz;
                        tar xvzf geth-linux-amd64-1.10.15-8be800ff.tar.gz geth-linux-amd64-1.10.15-8be800ff/geth --strip-components 1;
                        ;;
                    mac)
                        echo "Downloading Go Ethereum client for Mac OS..."
                        sleep 2;
                        wget https://gethstore.blob.core.windows.net/builds/geth-darwin-amd64-1.10.15-8be800ff.tar.gz;
                        tar xvzf geth-darwin-amd64-1.10.15-8be800ff.tar.gz --strip-components 1;
                        ;;
                esac
                echo "Downloading template genesis file for initializing UZH Ethereum PoW network..."
                sleep 2;
                curl -O https://raw.githubusercontent.com/matijapiskorec/uzhethereum-pow/refs/heads/main/uzheth.json;
                echo "Downloading static node file for the UZH Ethereum PoW network..."
                sleep 2;
                wget https://raw.githubusercontent.com/matijapiskorec/uzhethereum-pow/refs/heads/main/static-nodes.json;
            fi
			;;
		init)
            echo "Initializing UZH Ethereum PoW node..."
            sleep 2;
            ./geth --datadir blockchain init uzheth.json;
            cp static-nodes.json blockchain/geth/.;
			;;
        run)
            if [ -z "$2" ]
            then
                echo "Running UZH Ethereum PoW node...";
                sleep 2;
                ./geth --datadir blockchain --http --http.port 8545 --http.corsdomain "*" --http.vhosts "*" --http.api miner,eth,admin,net,web3 --networkid 702 --syncmode "full" --http.addr 0.0.0.0;
            else
                echo "Running UZH Ethereum PoW node and miner using $2 as an Etherbase argument...";
                sleep 2;
                ./geth --datadir blockchain --http --http.port 8545 --http.corsdomain "*" --http.vhosts "*" --http.api miner,eth,admin,net,web3 --networkid 702 --syncmode "full" --http.addr 0.0.0.0 --mine --miner.threads=1 --miner.etherbase="$2";
            fi
			;;
	esac
fi
