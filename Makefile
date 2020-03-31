local-docker-bootnode:
	@echo "Starting a local bootnodew without mining"
	docker run --rm -it -p 30303:30303 \
		-v ${PWD}:/opt/besu/config:Z gcr.io/whiteblock/besu:keccak256 \
	  	--genesis-file=config/keccak256genesis.json \
		--p2p-host=0.0.0.0 \
		--p2p-port=30303 \
		--rpc-http-api=ADMIN,ETH,NET,WEB3,CLIQUE,IBFT,PERM,DEBUG,MINER,EEA,PRIV,PLUGINS \
		--data-path=/tmp/dataDir  \
		--node-private-key-file=config/bootnode.key \
		--logging=TRACE  \
		--rpc-http-enabled  \
		--rpc-http-host=0.0.0.0  \
		--host-whitelist='*'
.PHONY: local-docker-bootnode

local-docker-bootnode-miner:
	@echo "Starting a local mining bootnode"
	@echo ""
	docker run --rm -it -p 30303:30303 \
		-v ${PWD}:/opt/besu/config:Z gcr.io/whiteblock/besu:keccak256 \
	  	--genesis-file=config/keccak256genesis.json \
	  	--miner-enabled \
		--miner-coinbase=0xb32bbe0883f8062497acc738ebb2f71e656db135  \
		--p2p-host=0.0.0.0 \
		--p2p-port=30303 \
		--rpc-http-api=ADMIN,ETH,NET,WEB3,CLIQUE,IBFT,PERM,DEBUG,MINER,EEA,PRIV,PLUGINS \
		--data-path=/tmp/dataDir  \
		--node-private-key-file=config/bootnode.key \
		--logging=TRACE  \
		--rpc-http-enabled  \
		--rpc-http-host=0.0.0.0  \
		--host-whitelist='*' 
.PHONY: local-docker-bootnode-miner

connect-testnet:
	@echo "Connecting to Whiteblock Keccak256 testnet at bootnode URL:"
	@echo "7b377874e6639232f7967fe47df79dc653a24f13e117a0ea9f005e031183e974615ae5546d5818e593249713d730a4aa84438204378397f3d5f438ee268faa81@34.70.120.1:30303"
	@echo ""
	docker run --rm -it -p 30303:30303 \
		-v ${PWD}:/opt/besu/config:Z gcr.io/whiteblock/besu:keccak256 \
	  	--genesis-file=/opt/besu/config/keccak256genesis.json \
		--p2p-host=0.0.0.0 \
		--p2p-port=30303 \
		--rpc-http-api=ADMIN,ETH,NET,WEB3,CLIQUE,IBFT,PERM,DEBUG,MINER,EEA,PRIV,PLUGINS \
		--data-path=/tmp/dataDir  \
		--node-private-key-file=/opt/besu/config/bootnode.key \
		--bootnodes=enode://7b377874e6639232f7967fe47df79dc653a24f13e117a0ea9f005e031183e974615ae5546d5818e593249713d730a4aa84438204378397f3d5f438ee268faa81@34.70.120.1:30303 \
		--logging=TRACE  \
		--rpc-http-enabled  \
		--rpc-http-host=0.0.0.0  \
		--host-whitelist='*' 
.PHONY: connect-testnet

connect-testnet-miner:
	@echo "Connecting to Whiteblock Keccak256 testnet at bootnode URL:"
	@echo "7b377874e6639232f7967fe47df79dc653a24f13e117a0ea9f005e031183e974615ae5546d5818e593249713d730a4aa84438204378397f3d5f438ee268faa81@34.70.120.1:30303"
	@echo ""
	docker run --rm -it -p 30303:30303 \
		-v ${PWD}:/opt/besu/config:Z gcr.io/whiteblock/besu:keccak256 \
	  	--genesis-file=/opt/besu/config/keccak256genesis.json \
	  	--miner-enabled \
		--miner-coinbase=0xb32bbe0883f8062497acc738ebb2f71e656db135  \
		--p2p-host=0.0.0.0 \
		--p2p-port=30303 \
		--rpc-http-api=ADMIN,ETH,NET,WEB3,CLIQUE,IBFT,PERM,DEBUG,MINER,EEA,PRIV,PLUGINS \
		--data-path=/tmp/dataDir  \
		--node-private-key-file=/opt/besu/config/bootnode.key \
		--bootnodes=enode://7b377874e6639232f7967fe47df79dc653a24f13e117a0ea9f005e031183e974615ae5546d5818e593249713d730a4aa84438204378397f3d5f438ee268faa81@34.70.120.1:30303 \
		--logging=TRACE  \
		--rpc-http-enabled  \
		--rpc-http-host=0.0.0.0  \
		--host-whitelist='*' 

start-testnet:
	@echo "Starting testnet..."
	@echo ""
	docker-compose up
.PHONY: start-testnet

clean: 
	docker-compose down
.PHONY: clean
