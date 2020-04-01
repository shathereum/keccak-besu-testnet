## Besu Keccak256 Proof-of-Work Testnet

Whiteblock and the ETC Cooperative have teamed up to create a proof of concept
of Keccak256 for Proof-of-Work using the Hyperledger Besu Ethereum client. A 
live testnet is currently hosted and maintained by Whiteblock. Read on to learn 
how to connect to the testnet or start your own!

### Clone this Repository

    git clone https://github.com/whiteblock/keccak-besu-testnet.git
    cd keccak-besu-testnet
 
### Connect to the Whiteblock Testnet using a Docker Container

To connect to the testnet without mining:

    make connect-testnet

To connect to the testnet as a miner:

    make connect-testnet-as-miner

### Create Your Own Testnet

A docker-compose.yaml file is provided to start your own testnet. First, make
a copy of `keccak256genesis.json` and name it `new-testnet-genesis.json`.
*Change the chainID to a different number* and then run:

    make start-testnet

The provided `docker-compose.yaml` will use the private keys in this repository
(see key_notes.md). If your testnet has a reachable IP, join your new testnet 
from a remote node by running the following command with `{TESTNET_IP}` in the
bootnode URL replaced with your testnet's IP. Remove `--miner-enabled` to turn 
off mining.

    docker run --rm -it -p 30303:30303 \
        -v ${PWD}:/opt/besu/config:Z gcr.io/whiteblock/besu:keccak256 \
        --genesis-file=/opt/besu/config/new-testnet-genesis.json \
        --miner-enabled \
        --miner-coinbase=0xb32bbe0883f8062497acc738ebb2f71e656db135  \
        --p2p-host=0.0.0.0 \
        --p2p-port=30303 \
        --rpc-http-api=ADMIN,ETH,NET,WEB3,CLIQUE,IBFT,PERM,DEBUG,MINER,EEA,PRIV,PLUGINS \
        --data-path=/tmp/dataDir  \
        --bootnodes=enode://2eea5409afa0ef7a211d17fbfec4dfc09db9b37600ce953e62b6b38db151c12a902f56501b58c3b980506a0e1a56cb5675365c99f228fa092382bce7d1e4d154@{TESTNET_IP}:30303 \
        --logging=TRACE  \
        --rpc-http-enabled  \
        --rpc-http-host=0.0.0.0  \
        --host-whitelist='*'  

### Connect to the Whiteblock Testnet by Building Besu from Source

To begin, consult with the Hyperledger Besu documentation and wiki pages to
install dependencies and build the official Besu client from source. Then,
build and run the modified client with Keccak256 mining. 

    git clone https://github.com/whiteblock/besu.git
    cd besu/
    git checkout develop
    # Make a copy of the keccak256genesis.json file in this repository over to
    # the top level of the modified besu repository. Then, in the besu/ directory
    ./gradlew installDist
    ./build/install/besu/bin/besu --genesis-file=keccak256genesis.json \
        --p2p-host=0.0.0.0 \
        --p2p-port=30303 \
        --data-path=/tmp/tmpDataDir --logging=TRACE \
        --bootnodes=enode://7b377874e6639232f7967fe47df79dc653a24f13e117a0ea9f005e031183e974615ae5546d5818e593249713d730a4aa84438204378397f3d5f438ee268faa81@34.70.120.1:30303 \
        --rpc-http-enabled \
        --rpc-http-host=0.0.0.0 \
        --host-whitelist='*'
