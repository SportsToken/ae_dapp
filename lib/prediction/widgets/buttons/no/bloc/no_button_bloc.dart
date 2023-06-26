import 'package:ax_dapp/repositories/subgraph/usecases/get_buy_info_use_case.dart';
import 'package:ax_dapp/service/blockchain_models/apt_buy_info.dart';
import 'package:ax_dapp/service/blockchain_models/apt_sell_info.dart';
import 'package:ax_dapp/service/controller/predictions/event_market_repository.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:shared/shared.dart';

part 'no_button_event.dart';
part 'no_button_state.dart';

class NoButtonBloc extends Bloc<NoButtonEvent, NoButtonState> {
  NoButtonBloc({
    required this.repo,
    required this.eventMarketRepository,
  }) : super(const NoButtonState()) {
    on<NoButtonPressed>(_onNoButtonPressed);
    on<FetchBuyInfoRequested>(_onFetchBuyInfoRequested);
    on<BuyButtonPressed>(_onBuyButtonPressed);
    on<SellButtonPressed>(_onSellButtonPressed);
  }

  final GetBuyInfoUseCase repo;
  final EventMarketRepository eventMarketRepository;

  Future<void> _onNoButtonPressed(
    NoButtonPressed event,
    Emitter<NoButtonState> emit,
  ) async {
    try {
      eventMarketRepository.address1.value = event.shortTokenAddress;
      eventMarketRepository.address2.value =
          '0xd9Fd6e207a2196e1C3FEd919fCFE91482f705909';
      await eventMarketRepository.sell();
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  Future<void> _onFetchBuyInfoRequested(
    FetchBuyInfoRequested event,
    Emitter<NoButtonState> emit,
  ) async {
    final aptAddress = event.shortTokenAddress;
    final response = await repo.fetchAptBuyInfo(aptAddress: aptAddress);
    final isSuccess = response.isLeft();
    if (isSuccess) {
      final pairInfo = response.getLeft().toNullable()!.aptBuyInfo;
      emit(
        state.copyWith(
          aptBuyInfo: AptBuyInfo(
            axPerAptPrice: pairInfo.toPrice,
            minimumReceived: pairInfo.minimumReceived,
            priceImpact: pairInfo.priceImpact,
            receiveAmount: pairInfo.receiveAmount,
            totalFee: pairInfo.totalFee,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          aptBuyInfo: AptBuyInfo.empty,
          status: BlocStatus.error,
        ),
      );
    }
  }

  Future<void> _onBuyButtonPressed(
    BuyButtonPressed event,
    Emitter<NoButtonState> emit,
  ) async {
    try {
      eventMarketRepository.address1.value =
          '0xd9Fd6e207a2196e1C3FEd919fCFE91482f705909';
      eventMarketRepository.address2.value = event.shortTokenAddress;
      eventMarketRepository.amount1.value = 1 * 1e18;
      const contractAddress = '0x4C2295082FC932EDE19EefB1af03c0b6B323610A';
      const amount = 100.0;
      await eventMarketRepository
          .approve(contractAddress, amount)
          .then((value) => eventMarketRepository.buy());
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  Future<void> _onSellButtonPressed(
    SellButtonPressed event,
    Emitter<NoButtonState> emit,
  ) async {
    try {
      eventMarketRepository.address1.value = event.shortTokenAddress;
      eventMarketRepository.address2.value =
          '0xd9Fd6e207a2196e1C3FEd919fCFE91482f705909';
      const contractAddress = '0x4C2295082FC932EDE19EefB1af03c0b6B323610A';
      const amount = 100.0;
      await eventMarketRepository
          .approve(contractAddress, amount)
          .then((value) => eventMarketRepository.sell());
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }
}
