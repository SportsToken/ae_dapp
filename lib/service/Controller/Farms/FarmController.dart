import 'dart:typed_data';
import 'package:ax_dapp/pages/farm/models/FarmModel.dart';
import 'package:ax_dapp/util/UserInputNorm.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart' as Web3Dart;
import 'package:ax_dapp/contracts/Pool.g.dart';
import 'package:ax_dapp/service/Controller/Controller.dart';
import 'package:ax_dapp/contracts/ERC20.g.dart';

class FarmController {
  // decalaration of member varibles
  late Pool contract;

  Controller controller = Get.find();
  String? athlete;
  String strName = "";
  String strAddress = "";
  String strStakeTokenAddress = "";
  String strRewardTokenAddress = "";
  String strStakingModule = "";
  double dAPR = 0.0;
  double dTVL = 0.0;
  double dStakeTokenPrice = 0.0;
  double dRewardTokenPrice = 0.0;

  RxDouble dStaked = 0.0.obs;
  RxDouble dRewards = 0.0.obs;
  RxString strStakedSymbol = "".obs;
  RxString strRewardSymbol = "".obs;
  RxString strStakedAlias = "".obs;

  RxDouble dUnStakeBalance = 0.0.obs;
  RxDouble dStakeBalance = 0.0.obs;

  late Web3Dart.Web3Client rpcClient;

  // contructor with poolInfo from api
  FarmController(FarmModel farm) {
    this.strAddress = farm.strAddress;
    this.strName = farm.strName;
    this.dAPR = farm.dAPR;
    this.dTVL = farm.dTVL;
    this.dStaked = RxDouble(farm.dStaked);
    this.dRewards = RxDouble(farm.dRewards);
    this.dStakeTokenPrice = farm.dStakeTokenPrice;
    this.dRewardTokenPrice = farm.dRewardTokenPrice;
    this.strStakeTokenAddress = farm.strStakeTokenAddress;
    this.strRewardTokenAddress = farm.strRewardTokenAddress;
    this.strStakingModule = farm.strStakingModule;

    this.strStakedSymbol = RxString(farm.strStakedSymbol);
    this.strRewardSymbol = RxString(farm.strRewardSymbol);
    this.strStakedAlias = RxString(farm.strStakedAlias);

    Web3Dart.EthereumAddress address =
        Web3Dart.EthereumAddress.fromHex(this.strAddress);
    String rpcUrl = controller.mainRPCUrl;
    if (Controller.supportedChains.containsKey(controller.networkID.value))
      rpcUrl = Controller.supportedChains[controller.networkID.value]!;
    rpcClient = Web3Dart.Web3Client(rpcUrl, Client());
    this.contract = new Pool(address: address, client: rpcClient);
  }

  // constructor from another farm
  FarmController.fromFarm(FarmController farm) {
    this.strAddress = farm.strAddress;
    this.strName = farm.strName;
    this.dAPR = farm.dAPR;
    this.dTVL = farm.dTVL;
    this.dStaked = farm.dStaked;
    this.dRewards = farm.dRewards;
    this.dStakeTokenPrice = farm.dStakeTokenPrice;
    this.dRewardTokenPrice = farm.dRewardTokenPrice;
    this.strStakeTokenAddress = farm.strStakeTokenAddress;
    this.strRewardTokenAddress = farm.strRewardTokenAddress;
    this.strStakingModule = farm.strStakingModule;
    this.strStakedSymbol = farm.strStakedSymbol;
    this.strRewardSymbol = farm.strRewardSymbol;
    this.strStakedAlias = farm.strStakedAlias;
    this.rpcClient = farm.rpcClient;
    this.contract = farm.contract;

    String account = controller.publicAddress.value.hex;
    // account = "0x22b3e4b38fb2f260302787b18b1401747eacf8d4";
    this.updateStakedBalance(account);
  }

  /// This function is used to stake tokens on a specific farm
  /// and also update the txHash string on conroller
  ///
  /// @return {void}
  Future<void> stake() async {
    Uint8List stakingData = Uint8List.fromList([]);
    Uint8List rewardData = Uint8List.fromList([]);

    BigInt stakeAmount = normalizeInput(this.dStakeBalance.value);
    String txHash = await this.contract.stake(
        stakeAmount, stakingData, rewardData,
        credentials: controller.credentials);
    controller.updateTxString(txHash);
  }

  /// This function is used to unstake tokens on a specific farm
  /// and also update the txHash string on conroller
  ///
  /// @param {double} this is the decimal amount to unstake
  ///
  /// @return {void}
  Future<void> unstake() async {
    Uint8List stakingData = Uint8List.fromList([]);
    Uint8List rewardData = Uint8List.fromList([]);

    BigInt unstakeAmount = normalizeInput(this.dUnStakeBalance.value);
    String txHash = await this.contract.unstake(
        unstakeAmount, stakingData, rewardData,
        credentials: controller.credentials);
    controller.updateTxString(txHash);
  }

  /// This function is used to stake tokens on a specific farm
  /// and also update the txHash string on conroller
  ///
  /// @return {void}
  Future<void> claim() async {
    Uint8List stakingData = Uint8List.fromList([]);
    Uint8List rewardData = Uint8List.fromList([]);

    String txHash = await this.contract.claim(
        BigInt.from(100), stakingData, rewardData,
        credentials: controller.credentials);
    controller.updateTxString(txHash);
  }

  /// This function is used to get balance of staked farm
  ///
  /// @param {String} the address of the account
  /// @return {void}
  Future<void> updateStakedBalance(String strAccount) async {
    Web3Dart.EthereumAddress ethAccount =
        Web3Dart.EthereumAddress.fromHex(strAccount);
    List<BigInt> balances = await this.contract.stakingBalances(ethAccount);
    Web3Dart.EtherAmount stakedWeiBalance =
        Web3Dart.EtherAmount.inWei(balances[0]);
    double stakedEtherBalance =
        stakedWeiBalance.getValueInUnit(Web3Dart.EtherUnit.ether);
    this.dStaked.value = stakedEtherBalance;
  }

  /// This function is used to approve the reward token
  ///
  /// @return {void}
  Future<void> approve() async {
    Web3Dart.EthereumAddress routerAddress =
        Web3Dart.EthereumAddress.fromHex(this.strStakingModule);
    Web3Dart.EthereumAddress tokenAddress =
        Web3Dart.EthereumAddress.fromHex(this.strStakeTokenAddress);
    ERC20 rewardToken = ERC20(address: tokenAddress, client: rpcClient);
    BigInt approveAmount = normalizeInput(this.dStakeBalance.value);
    String txHash = await rewardToken.approve(routerAddress, approveAmount,
        credentials: controller.credentials);
    controller.updateTxString(txHash);
  }
}
