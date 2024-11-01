extends Node

const CONTRACT_ABI := """
[{"inputs":[{"internalType":"string","name":"username","type":"string"},{"internalType":"uint256","name":"score","type":"uint256"}],"name":"uploadScore","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"username","type":"string"}],"name":"getBestScore","outputs":[{"internalType":"bool","name":"exists","type":"bool"},{"internalType":"uint256","name":"bestScore","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getTopScores","outputs":[{"components":[{"internalType":"string","name":"username","type":"string"},{"internalType":"uint256","name":"score","type":"uint256"}],"internalType":"struct HallOfFame.Score[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"}]
"""

const CONTRACT_ADDRESS := "0x811c5976EACB0A81dB447885F76C81172a782484"
const CONTRACT_BYTECODE := "608060405234801561001057600080fd5b50610bd8806100206000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c8063bac2762414610046578063deedc5b814610062578063ee5c4e5d14610093575b600080fd5b610060600480360381019061005b919061084c565b6100b1565b005b61007c6004803603810190610077919061080b565b61014e565b60405161008a929190610a36565b60405180910390f35b61009b6101ae565b6040516100a89190610a14565b60405180910390f35b6000826040516100c191906109fd565b908152602001604051809103902081908060018154018082558091505060019003906000526020600020016000909190919091505560018260405161010691906109fd565b908152602001604051809103902054811115610140578060018360405161012d91906109fd565b9081526020016040518091039020819055505b61014a828261032f565b5050565b600080600060018460405161016391906109fd565b90815260200160405180910390205411156101a1576001808460405161018991906109fd565b908152602001604051809103902054915091506101a9565b600080915091505b915091565b606060006064600280549050106101c65760646101cd565b6002805490505b905060008167ffffffffffffffff811180156101e857600080fd5b5060405190808252806020026020018201604052801561022257816020015b61020f6105ec565b8152602001906001900390816102075790505b50905060005b82811015610326576002818154811061023d57fe5b9060005260206000209060020201604051806040016040529081600082018054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102ef5780601f106102c4576101008083540402835291602001916102ef565b820191906000526020600020905b8154815290600101906020018083116102d257829003601f168201915b5050505050815260200160018201548152505082828151811061030e57fe5b60200260200101819052508080600101915050610228565b50809250505090565b60026040518060400160405280848152602001838152509080600181540180825580915050600190039060005260206000209060020201600090919091909150600082015181600001908051906020019061038b929190610606565b50602082015181600101555050600060016002805490500390505b600081111561059c57600260018203815481106103bf57fe5b906000526020600020906002020160010154600282815481106103de57fe5b90600052602060002090600202016001015411156105895760006002828154811061040557fe5b9060005260206000209060020201604051806040016040529081600082018054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156104b75780601f1061048c576101008083540402835291602001916104b7565b820191906000526020600020905b81548152906001019060200180831161049a57829003601f168201915b505050505081526020016001820154815250509050600260018303815481106104dc57fe5b9060005260206000209060020201600283815481106104f757fe5b90600052602060002090600202016000820181600001908054600181600116156101000203166002900461052c929190610694565b5060018201548160010155905050806002600184038154811061054b57fe5b90600052602060002090600202016000820151816000019080519060200190610575929190610606565b50602082015181600101559050505061058e565b61059c565b8080600190039150506103a6565b50606460028054905011156105e85760028054806105b657fe5b6001900381819060005260206000209060020201600080820160006105db9190610729565b6001820160009055505090555b5050565b604051806040016040528060608152602001600081525090565b828054600181600116156101000203166002900490600052602060002090601f01602090048101928261063c5760008555610683565b82601f1061065557805160ff1916838001178555610683565b82800160010185558215610683579182015b82811115610682578251825591602001919060010190610667565b5b5090506106909190610771565b5090565b828054600181600116156101000203166002900490600052602060002090601f0160209004810192826106ca5760008555610718565b82601f106106db5780548555610718565b8280016001018555821561071857600052602060002091601f016020900482015b828111156107175782548255916001019190600101906106fc565b5b5090506107259190610771565b5090565b50805460018160011615610100020316600290046000825580601f1061074f575061076e565b601f01602090049060005260206000209081019061076d9190610771565b5b50565b5b8082111561078a576000816000905550600101610772565b5090565b60006107a161079c84610a90565b610a5f565b9050828152602081018484840111156107b957600080fd5b6107c4848285610b36565b509392505050565b600082601f8301126107dd57600080fd5b81356107ed84826020860161078e565b91505092915050565b60008135905061080581610b8b565b92915050565b60006020828403121561081d57600080fd5b600082013567ffffffffffffffff81111561083757600080fd5b610843848285016107cc565b91505092915050565b6000806040838503121561085f57600080fd5b600083013567ffffffffffffffff81111561087957600080fd5b610885858286016107cc565b9250506020610896858286016107f6565b9150509250929050565b60006108ac83836109a2565b905092915050565b60006108bf82610ad0565b6108c98185610af3565b9350836020820285016108db85610ac0565b8060005b8581101561091757848403895281516108f885826108a0565b945061090383610ae6565b925060208a019950506001810190506108df565b50829750879550505050505092915050565b61093281610b20565b82525050565b600061094382610adb565b61094d8185610b04565b935061095d818560208601610b45565b61096681610b7a565b840191505092915050565b600061097c82610adb565b6109868185610b15565b9350610996818560208601610b45565b80840191505092915050565b600060408301600083015184820360008601526109bf8282610938565b91505060208301516109d460208601826109df565b508091505092915050565b6109e881610b2c565b82525050565b6109f781610b2c565b82525050565b6000610a098284610971565b915081905092915050565b60006020820190508181036000830152610a2e81846108b4565b905092915050565b6000604082019050610a4b6000830185610929565b610a5860208301846109ee565b9392505050565b6000604051905081810181811067ffffffffffffffff82111715610a8657610a85610b78565b5b8060405250919050565b600067ffffffffffffffff821115610aab57610aaa610b78565b5b601f19601f8301169050602081019050919050565b6000819050602082019050919050565b600081519050919050565b600081519050919050565b6000602082019050919050565b600082825260208201905092915050565b600082825260208201905092915050565b600081905092915050565b60008115159050919050565b6000819050919050565b82818337600083830152505050565b60005b83811015610b63578082015181840152602081019050610b48565b83811115610b72576000848401525b50505050565bfe5b6000601f19601f8301169050919050565b610b9481610b2c565b8114610b9f57600080fd5b5056fea26469706673582212200c993bfd06f1c796df3d1d8dd3a9ac7ce3c58bd1f15b43e3b8d5018d1d49c51764736f6c63430007060033"
const NODE_RPC_URL := "https://snowy-capable-wave.optimism-sepolia.quiknode.pro/360d0830d495913ed76393730e16efb929d0f652"

# 上传用户成绩，对应智能合约中的 uploadScore 函数
func upload_score(username, score, prikey):
	await get_tree().create_timer(2.0).timeout
	# create a new instance of the ABIHelper class and unmarshal the ABI JSON string into it
	#var h = ABIHelper.new()
	#var res = h.unmarshal_from_json(CONTRACT_ABI)
	#if !res:
		#print("unmarshal_from_json failed!")
		#return
#
	#var params = [
		#username,
		#score
	#]
	#var packed = h.pack("uploadScore", params)
#
	## get Optimism instance and set rpc url
	#var op = Optimism.new()
	#op.set_rpc_url(NODE_RPC_URL)
	## set private key for sign tx
	#var secp256k1 = op.get_secp256k1_wrapper()
	#assert(secp256k1.set_secret_key(prikey), "set_secret_key failed!")
	#var block_number = BigInt.new()
	#block_number.from_string("0")
#
	#var ethaccount_manager = EthAccountManager.new()
	#var ethaccount = ethaccount_manager.from_private_key(prikey.hex_decode())
	#var address = "0x" + ethaccount.get_address().hex_encode()
#
	#var get_nonce = op.nonce_at(address, block_number)
	#print("get_nonce: ", get_nonce)
#
	## create a legacyTx
	#var legacyTx = LegacyTx.new()
	#legacyTx.set_nonce(get_nonce)
	## todo: write a function to get gas price & gas limit
	#var gas_price = op.suggest_gas_price()
	#legacyTx.set_gas_price(gas_price)
	#legacyTx.set_gas_limit(828516)
	#var value = BigInt.new()
	#value.from_string("0")
	#legacyTx.set_value(value)
	#legacyTx.set_data(packed)
#
	#var chain_id = BigInt.new()
	#chain_id.from_string("11155420")
	#legacyTx.set_chain_id(chain_id)
	#legacyTx.set_to_address(CONTRACT_ADDRESS)
#
	## sign tx
	#var sign_result = legacyTx.sign_tx(secp256k1)
	#assert(sign_result == 0, "sign tx failed!")
#
	### marshal binary
	#var send_tx_data = legacyTx.signedtx_marshal_binary()
#
	#var rpc_result = op.send_transaction(send_tx_data)
	## example rpc_result:  { "success": true, "errmsg": "", "txhash": "0xe3b18398db6371a47c1795f4a09ab412ddeceaa29ffda3d5dbae514a99e6caed" }
	#if rpc_result["success"] == false:
		#print("rpc reqeust failed! errmsg: ", rpc_result["errmsg"])
		#return
	#var tx_hash = rpc_result["txhash"]
	#print("tx_hash: ", tx_hash)
	#return tx_hash
	return ""

# 上传用户成绩，对应智能合约中的 uploadScore 函数
# 第二种实现方式，使用 signed_transaction 函数。更加简洁。
func upload_score2(username, score, prikey):
	## create a new instance of the ABIHelper class and unmarshal the ABI JSON string into it
	#var h = ABIHelper.new()
	#var res = h.unmarshal_from_json(CONTRACT_ABI)
	#if !res:
		#print("unmarshal_from_json failed!")
		#return
#
	#var params = [
		#username,
		#score
	#]
	#var packed = h.pack("uploadScore", params)
#
	## get Optimism instance and set rpc url
	#var op = Optimism.new()
	#op.set_rpc_url(NODE_RPC_URL)
	#var ethaccount_manager = EthAccountManager.new()
	#var ethaccount = ethaccount_manager.from_private_key(prikey.hex_decode())
	#op.set_eth_account(ethaccount)
	#var transaction = {
		#"to": CONTRACT_ADDRESS,
		#"data": packed,
	#}
	#var signed_tx_data = op.signed_transaction(transaction)
	#var rpc_result = op.send_transaction(signed_tx_data)
	#print("rpc_result: ", rpc_result)
	## example rpc_result:  { "success": true, "errmsg": "", "txhash": "0xe3b18398db6371a47c1795f4a09ab412ddeceaa29ffda3d5dbae514a99e6caed" }
	#if rpc_result["success"] == false:
		#print("rpc reqeust failed! errmsg: ", rpc_result["errmsg"])
		#return
	#var tx_hash = rpc_result["txhash"]
	#print("tx_hash: ", tx_hash)
	#return tx_hash
	return ""


# 获取用户最高分数，对应智能合约中的 getBestScore 函数
func get_best_score(username):
	## create a new instance of the ABIHelper class and unmarshal the ABI JSON string into it
	#var h = ABIHelper.new()
	#var res = h.unmarshal_from_json(CONTRACT_ABI)
	#if !res:
		#print("unmarshal_from_json failed!")
		#return []
#
	#var packed = h.pack("getBestScore", [username])
#
	#var op = Optimism.new()
	#op.set_rpc_url(NODE_RPC_URL)
	#var call_msg = {
		#"from": "0x0000000000000000000000000000000000000000",
		#"to": CONTRACT_ADDRESS,
		#"input": "0x" + packed.hex_encode(),
	#}
	#var rpc_resp = op.call_contract(call_msg, "")
	#print("gd: origin rpc_result: ", rpc_resp)
	#print("gd: rpc_result: ", rpc_resp["response_body"])
#
	#var call_result = JSON.parse_string(rpc_resp["response_body"])
#
	## create a new instance of the ABIHelper class and unmarshal the ABI JSON string into it
	#var call_ret = call_result["result"]
	#call_ret = call_ret.substr(2, call_ret.length() - 2)
	#print("getBestScore. gd call ret: ", call_ret)
	#print("========= unpack to dictionary ==============\n")
	#var result = []
	#var err = h.unpack_into_array("getBestScore", call_ret.hex_decode(), result)
	#if err != OK:
		#assert(false, "unpack_into_dictionary failed!")
	#print("call result: ", result)
	## exmaple result: [false, "0"]
	#return result
	return 9990

# 获取前100名的分数，对应智能合约中的 getTopScores 函数
func get_top_scores():
	## create a new instance of the ABIHelper class and unmarshal the ABI JSON string into it
	#var h = ABIHelper.new()
	#var res = h.unmarshal_from_json(CONTRACT_ABI)
	#if !res:
		#print("unmarshal_from_json failed!")
		#return []
#
	#var packed = h.pack("getTopScores", [])
#
	#var op = Optimism.new()
	#op.set_rpc_url(NODE_RPC_URL)
	#var call_msg = {
		#"from": "0x0000000000000000000000000000000000000000",
		#"to": CONTRACT_ADDRESS,
		#"input": "0x" + packed.hex_encode(),
	#}
	#var rpc_resp = op.call_contract(call_msg, "")
	#print("gd: origin rpc_result: ", rpc_resp)
	#print("gd: rpc_result: ", rpc_resp["response_body"])
#
	#var call_result = JSON.parse_string(rpc_resp["response_body"])
#
	## create a new instance of the ABIHelper class and unmarshal the ABI JSON string into it
	#var call_ret = call_result["result"]
	#call_ret = call_ret.substr(2, call_ret.length() - 2)
	#print("getBestScore. gd call ret: ", call_ret)
	#print("========= unpack to dictionary ==============\n")
	#var result = []
	#var err = h.unpack_into_array("getTopScores", call_ret.hex_decode(), result)
	#if err != OK:
		#assert(false, "unpack_into_dictionary failed!")
	#print("call result: ", result)
	## exmaple result: [[["zfer", "420"], ["cooper", "100"]]]
	#return result
	return [Record.new("zfer", 420, 1), Record.new("cooper", 100, 2)]


class Record:
	var name: String = ""
	var score: int = 0
	var index: int = 0

	func _init(name, score, index=0):
		self.name = name
		self.score = score
		self.index = index


func check_username_available(username):
	"""
	检查用户名是否已经被占用，用于进行唯一的全局排名
	"""
	# TODO change this
	return randi_range(0, 10) < 5
		

func sync_leaderboard():
	"""
	从链上同步战绩，只返回前100名
	"""
	# TODO change this to get record_list from chain
	
	# -------------------------------------------
	var alphabet = "qwertyuiopasdfghjklzxcvbnm".split()
	print(alphabet)
	var record_list = []
	for i in range(100):
		var name = ""
		for ii in range(randi_range(5, 10)):
			name += alphabet[randi_range(0, 25)]
		var score = randi_range(10, 100) * 10
		print(name)
		record_list.append(Record.new(name, score))
	record_list.append(Record.new(Vars.username, Vars.highest_score))
	# -------------------------------------------
	
	record_list.sort_custom(func(a, b): return a.score > b.score)
	record_list = record_list.slice(0, 100)
	for i in range(len(record_list)):
		record_list[i].index = i + 1
	return record_list
	
	
func update_user_score(username, score):
	"""
	将用户的最高分数同步到链上 
	"""
	pass

	
	
