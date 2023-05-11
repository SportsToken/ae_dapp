import 'package:ax_dapp/predict/models/prediction_model.dart';
import 'package:ax_dapp/service/controller/predictions/event_market_repository.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:equatable/equatable.dart';
import 'package:ethereum_api/emp_api.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';
import 'package:tokens_repository/tokens_repository.dart';
import 'package:use_cases/stream_app_data_changes_use_case.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'prediction_page_event.dart';
part 'prediction_page_state.dart';

class PredictionPageBloc
    extends Bloc<PredictionPageEvent, PredictionPageState> {
  PredictionPageBloc({
    required WalletRepository walletRepository,
    required TokensRepository tokensRepository,
    required EventMarketRepository eventMarketRepository,
    required StreamAppDataChangesUseCase streamAppDataChangesUseCase,
  })  : _walletRepository = walletRepository,
        _tokensRepository = tokensRepository,
        eventMarketRepository = eventMarketRepository,
        _streamAppDataChangesUseCase = streamAppDataChangesUseCase,
        super(const PredictionPageState()) {
    on<WatchAppDataChangesStarted>(_onWatchAppDataChangesStarted);
    on<PredictionPageLoaded>(_onPredictionPageLoaded);
    on<LoadingPredictionPage>(_onLoadingPredictionPage);
  }

  final WalletRepository _walletRepository;
  final TokensRepository _tokensRepository;
  final EventMarketRepository eventMarketRepository;
  final StreamAppDataChangesUseCase _streamAppDataChangesUseCase;

  Future<void> _onWatchAppDataChangesStarted(
    WatchAppDataChangesStarted _,
    Emitter<PredictionPageState> emit,
  ) async {
    await emit.onEach<AppData>(
      _streamAppDataChangesUseCase.appDataChanges,
      onData: (appData) {
        emit(
          state.copyWith(
            status: BlocStatus.loading,
            predictionAddress: kNullAddress,
          ),
        );

        final appConfig = appData.appConfig;

        // Keeps the event contract client values current
        eventMarketRepository
          ..aptFactory = appConfig.reactiveAptFactoryClient.value
          ..aptRouter = appConfig.reactiveAptRouterClient.value
          ..marketAddress.value = state.predictionModel.address
          ..eventBasedPredictionMarket =
              appConfig.reactiveEventMarketsClient.value;
      },
    );
  }

  Future<void> _onMintPredictionTokens(
    MintPredictionTokens event,
    Emitter<PredictionPageState> emit,
  ) async {
    await eventMarketRepository.mint();
    emit(state.copyWith(status: BlocStatus.success));
  }

  Future<void> _onRedeemPredictionTokens(
    RedeemPredictionTokens event,
    Emitter<PredictionPageState> emit,
  ) async {
    await eventMarketRepository.redeem();
    emit(state.copyWith(status: BlocStatus.success));
  }

  Future<void> _onLoadingPredictionPage(
    LoadingPredictionPage event,
    Emitter<PredictionPageState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    emit(state.copyWith(status: BlocStatus.success));
  }

  Future<void> _onPredictionPageLoaded(
    PredictionPageLoaded event,
    Emitter<PredictionPageState> emit,
  ) async {
    final predictionAddress = event.predictionModel.address;
    final currentPrediction = event.predictionModel;
    eventMarketRepository.eventMarketAddress = predictionAddress;
    emit(
      state.copyWith(
        status: BlocStatus.success,
        predictionModel: currentPrediction,
      ),
    );
  }
}


//        // Sets the event market to currently selected prediction question
        // eventMarketRepository.marketAddress.value =
        //     state.predictionModel.address;
        // eventMarketRepository.address1.value =
        //     state.predictionModel.yesTokenAddress;