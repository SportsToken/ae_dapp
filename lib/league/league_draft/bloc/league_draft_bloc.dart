import 'dart:async';

import 'package:ax_dapp/league/repository/league_repository.dart';
import 'package:ax_dapp/scout/models/athlete_scout_model.dart';
import 'package:ax_dapp/service/controller/usecases/get_max_token_input_use_case.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tokens_repository/tokens_repository.dart';

part 'league_draft_event.dart';
part 'league_draft_state.dart';

class LeagueDraftBloc extends Bloc<LeagueDraftEvent, LeagueDraftState> {
  LeagueDraftBloc({
    required LeagueRepository leagueRepository,
    required GetTotalTokenBalanceUseCase getTotalTokenBalanceUseCase,
  })  : _leagueRepository = leagueRepository,
        _getTotalTokenBalanceUseCase = getTotalTokenBalanceUseCase,
        super(const LeagueDraftState()) {
    on<FetchAptsOwnedEvent>(_onFetchAptsOwnedEvent);
    on<AddAptToTeam>(_onAddAptToTeam);
    on<RemoveAptFromTeam>(_onRemoveAptFromTeam);
    on<ConfirmTeam>(_onConfirmTeam);
    on<GetAthletes>(_onGetAthletes);
  }

  final LeagueRepository _leagueRepository;
  final GetTotalTokenBalanceUseCase _getTotalTokenBalanceUseCase;

  Future<void> _onFetchAptsOwnedEvent(
    FetchAptsOwnedEvent event,
    Emitter<LeagueDraftState> emit,
  ) async {
    final athletes = event.athletes;
    debugPrint('$athletes');
    try {
      emit(state.copyWith(status: BlocStatus.loading));
      // final ownedApts = await _getTotalTokenBalanceUseCase.getOwnedApts();
      // debugPrint('$ownedApts');
      emit(state.copyWith(ownedApts: athletes, status: BlocStatus.success));
    } catch (_) {
      emit(
        state.copyWith(
          ownedApts: [],
          status: BlocStatus.error,
        ),
      );
    }
  }

  void _onAddAptToTeam(
    AddAptToTeam event,
    Emitter<LeagueDraftState> emit,
  ) {}

  void _onRemoveAptFromTeam(
    RemoveAptFromTeam event,
    Emitter<LeagueDraftState> emit,
  ) {}

  Future<void> _onConfirmTeam(
    ConfirmTeam event,
    Emitter<LeagueDraftState> emit,
  ) async {}

  void _onGetAthletes(
    GetAthletes event,
    Emitter<LeagueDraftState> emit,
  ) {
    final athletes = event.athletes;
    emit(state.copyWith(athletes: athletes));
  }
}
