// ignore_for_file: implementation_imports, avoid_web_libraries_in_flutter, invalid_use_of_internal_member

import 'package:ax_dapp/service/Controller/createWallet/abstractWallet.dart';
import 'package:bip39/bip39.dart'
    as bip39; // Basics of BIP39 https://coldbit.com/bip-39-basics-from-randomness-to-mnemonic-words/
import './createWallet/createWallet.dart'
    if (dart.library.io) './createWallet/mobile.dart'
    if (dart.library.js) './createWallet/web.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';
import 'package:get/get.dart';

//Comment this for Android
const EMPTY_WALLET_ID = "0x0000000000000000000000000000000000000000";

class Controller extends GetxController {
  /// VARIABLES
  var seedHex = "".obs;
  var credentials;
  var mnemonic = "".obs;
  late DappWallet web3;
  var networkID = 0.obs;
  bool activeChain = false;
  static String latestTx = "";
  bool walletConnected = false;
  var gas = EtherAmount.zero().obs;
  var gasString = "0".obs;
  static const MAINNET_CHAIN_ID = 137;
  static const TESTNET_CHAIN_ID = 80001;
  int activeChainId = TESTNET_CHAIN_ID;
  static const supportedChains = {
    137: "https://polygon-rpc.com",
    80001: "https://matic-mumbai.chainstacklabs.com"
  };
  String mainRPCUrl = "https://polygon-rpc.com";
  String testRPCUrl = "https://matic-mumbai.chainstacklabs.com/";
  var client = Web3Client("https://polygon-rpc.com", Client()).obs;
  var publicAddress = EthereumAddress.fromHex(EMPTY_WALLET_ID).obs;

  set axTokenAddress(EthereumAddress tokenAddress) {
    axTokenAddress = EthereumAddress.fromHex("${tokenAddress.hex}");
  }

  Controller() {
    initState();
  }

  void initState() async {
    //Setting up Client & Credentials for connecting to dApp from a client
    web3 = newWallet();
  }

  Future<int> connect() async {
    //Connect and setup credentials
    await web3.connect().then((value) {
      print("Connecting Wallet... ${web3.publicAddress}");
      this.publicAddress.value = web3.publicAddress;
    });

    try {
      networkID.value = web3.networkID;
      print(networkID.value);
    } catch (e) {
      throw ("NetworkId value is breaking $e");
    }

    try {
      client.value = web3.client;
    } catch (e) {
      throw ("Client value is breaking: $e");
    }

    try {
      credentials = web3.credentials;
    } catch (e) {
      throw ("credentials are breaking $e");
    }

    if (web3.networkID != null) {
      this.walletConnected = true;
    }

    return 1;
  }
  //Comment this for Android
  // Connect the dapp to metamask and update relevant values

  // Connect the client + set credentials

  void getCurrentGas() async {
    var rawGasPrice = await client.value.getGasPrice();
    var gasPriceinGwei =
        rawGasPrice.getValueInUnit(EtherUnit.gwei).toStringAsFixed(2);

    gasString.value = "$gasPriceinGwei";
    print('Getting latest gas... $gasString');
    update();
  }

  void updateTxString(String tx) {
    print("latest txString: $tx");
    latestTx = tx;
  }

  void changeAddress() async {}

  void disconnect() async {
    walletConnected = false;
    client.value.dispose();

    // client.value.getChainId();
    update();
  }

  static void viewTx() async {
    Uri urlString = Uri.parse('');
    latestTx == ""
        ? urlString = Uri.parse('https://polygonscan.com')
        : urlString = Uri.parse('https://polygonscan.com/tx/$latestTx');
    await launchUrl(urlString);
  }

  void generateMnemonic() async {
    web3.createNewMnemonic();
    // String generatedString = web3.seedHex;
    this.mnemonic.value = web3.mnemonic;
    this.seedHex.value = web3.seedHex;
  }

  bool isValidMnemonic(String theMnemonic) {
    bool YesOrNo = bip39.validateMnemonic(theMnemonic);
    return YesOrNo;
  }
}
