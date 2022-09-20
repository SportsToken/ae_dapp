import 'dart:async';
import 'dart:math';

import 'package:ax_dapp/app/config/app_config.dart';
import 'package:ax_dapp/athlete/models/market_price_record.dart';
import 'package:ax_dapp/repositories/mlb_repo.dart';
import 'package:ax_dapp/repositories/nfl_repo.dart';
import 'package:ax_dapp/scout/models/models.dart';
import 'package:ax_dapp/scout/usecases/get_scout_athletes_data_use_case.dart';
import 'package:ax_dapp/service/athlete_models/athlete_price_record.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:ax_dapp/util/chart/extensions/graph_data.dart';
import 'package:intl/intl.dart';
import 'package:shared/shared.dart';
import 'package:tokens_repository/tokens_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'athlete_page_event.dart';
part 'athlete_page_state.dart';

class AthletePageBloc extends Bloc<AthletePageEvent, AthletePageState> {
  AthletePageBloc({
    required WalletRepository walletRepository,
    required TokensRepository tokensRepository,
    required this.mlbRepo,
    required this.nflRepo,
    required this.athlete,
    required this.athleteUseCase,
  })  : _walletRepository = walletRepository,
        _tokensRepository = tokensRepository,
        super(
          // setting the apt corresponding to the default aptType which is long
          AthletePageState(
            longApt: tokensRepository.currentAptPair(athlete.id).longApt,
          ),
        ) {
    on<WatchAptPairStarted>(_onWatchAptPairStarted);
    on<AptTypeSelectionChanged>(_onAptTypeSelectionChanged);
    on<GetPlayerStatsRequested>(_onGetPlayerStatsRequested);
    on<OnGraphRefresh>(_mapGraphRefreshEventToState);
    on<AddTokenToWalletRequested>(_onAddTokenToWalletRequested);

    add(WatchAptPairStarted(athlete.id));
    add(GetPlayerStatsRequested(athlete.id));
  }

  final AthleteScoutModel athlete;

  final WalletRepository _walletRepository;
  final TokensRepository _tokensRepository;
  final MLBRepo mlbRepo;
  final NFLRepo nflRepo;
  final GetScoutAthletesDataUseCase athleteUseCase;

  Future<void> _onWatchAptPairStarted(
    WatchAptPairStarted event,
    Emitter<AthletePageState> emit,
  ) async {
    await emit.forEach<AptPair>(
      _tokensRepository.aptPairChanges(event.athleteId),
      onData: (aptPair) =>
          state.copyWith(longApt: aptPair.longApt, shortApt: aptPair.shortApt),
    );
  }

  void _onAptTypeSelectionChanged(
    AptTypeSelectionChanged event,
    Emitter<AthletePageState> emit,
  ) {
    emit(state.copyWith(aptTypeSelection: event.aptType));
  }

  Future<void> _onGetPlayerStatsRequested(
    GetPlayerStatsRequested event,
    Emitter<AthletePageState> emit,
  ) async {
    final playerId = event.playerId;
    emit(state.copyWith(status: BlocStatus.loading));
    switch (athlete.sport) {
      case SupportedSport.all:
        break;

      case SupportedSport.NFL:
        try {
          final priceRecord = await nflRepo.getPlayerPriceHistory(
            playerId,
          );
          final recordLength = priceRecord.priceHistory.length;
          if (recordLength > 0) {
            final startDate = priceRecord.priceHistory[0].timestamp;
            final marketRecords = await athleteUseCase.getMarketPriceHistory(
              nflRepo,
              playerId,
              startDate,
            );
            updatePriceGraphData(priceRecord, marketRecords, emit);
          }
        } catch (_) {
          emit(state.copyWith(status: BlocStatus.error));
        }
        break;

      case SupportedSport.MLB:
        try {
          final priceRecord = await mlbRepo.getPlayerPriceHistory(
            playerId,
          );
          final recordLength = priceRecord.priceHistory.length;
          if (recordLength > 0) {
            final startDate = priceRecord.priceHistory[0].timestamp;
            final marketRecords = await athleteUseCase.getMarketPriceHistory(
              nflRepo,
              playerId,
              startDate,
            );
            updatePriceGraphData(priceRecord, marketRecords, emit);
          }
        } catch (_) {
          emit(state.copyWith(status: BlocStatus.error));
        }
        break;
      case SupportedSport.NBA:
        break;
    }
  }

  void updatePriceGraphData(
    AthletePriceRecord priceRecord,
    MarketPriceRecord marketRecord,
    Emitter<AthletePageState> emit,
  ) {
    var longIndex = 0, shortIndex = 0;
    final longHistory = marketRecord.longRecord.priceHistory;
    final shortHistory = marketRecord.shortRecord.priceHistory;

    final graphStats = priceRecord.priceHistory.map(
      (record) {
        final bookDate = DateFormat('yyy-MM-dd').parse(record.timestamp);
        if (longHistory.isNotEmpty) {
          final nextIndex = min(longIndex + 1, longHistory.length - 1);
          final nextDateStr = longHistory[nextIndex].timestamp;
          final nextDate = DateFormat('yyy-MM-dd').parse(nextDateStr);
          if (bookDate.isAfter(nextDate)) {
            longIndex = nextIndex;
          }
        }

        if (shortHistory.isNotEmpty) {
          final nextIndex = min(shortIndex + 1, shortHistory.length - 1);
          final nextDateStr = shortHistory[nextIndex].timestamp;
          final nextDate = DateFormat('yyy-MM-dd').parse(nextDateStr);
          if (bookDate.isAfter(nextDate)) {
            shortIndex = nextIndex;
          }
        }

        return GraphData(
          DateFormat('yyy-MM-dd').parse(record.timestamp),
          record.price * kCollateralizationMultiplier,
          longHistory[longIndex].price,
          shortHistory[shortIndex].price,
        );
      },
    ).toList();
    final seenDates = <DateTime>{};
    final distinctPoints =
        graphStats.where((element) => seenDates.add(element.date)).toList();
    emit(
      state.copyWith(
        stats: distinctPoints,
        status: BlocStatus.success,
      ),
    );
  }

  void _mapGraphRefreshEventToState(
    OnGraphRefresh event,
    Emitter<AthletePageState> emit,
  ) {}

  Future<void> _onAddTokenToWalletRequested(
    AddTokenToWalletRequested event,
    Emitter<AthletePageState> emit,
  ) async {
    if (_walletRepository.currentWallet.isDisconnected) {
      emit(state.copyWith(failure: DisconnectedWalletFailure()));
      emit(state.copyWith(failure: Failure.none));
      return;
    }
    try {
      await _walletRepository.addToken(
        tokenAddress: state.selectedAptAddress,
        tokenImageUrl: state.aptTypeSelection.url,
      );
    } on WalletFailure {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }
}
