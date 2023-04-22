part of 'league_game_bloc.dart';

abstract class LeagueGameEvent extends Equatable {
  const LeagueGameEvent();

  @override
  List<Object?> get props => [];
}

class WatchAppDataChangesStarted extends LeagueGameEvent {
  const WatchAppDataChangesStarted();
}

class FetchScoutInfoRequested extends LeagueGameEvent {}

class EditTeamsEvent extends LeagueGameEvent {
  const EditTeamsEvent({
    required this.rosters,
    required this.sports,
    required this.teamSize,
  });

  final String rosters;
  final String sports;
  final String teamSize;

  @override
  List<Object?> get props => [rosters, sports, teamSize];
}

class ClaimPrizeEvent extends LeagueGameEvent {}

class CalculateAppreciationEvent extends LeagueGameEvent {
  const CalculateAppreciationEvent({
    required this.leagueTeams,
    required this.athletes,
  });

  final List<LeagueTeam> leagueTeams;
  final List<AthleteScoutModel> athletes;

  @override
  List<Object?> get props => [
        leagueTeams,
        athletes,
      ];
}

class JoinLeagueEvent extends LeagueGameEvent {
  const JoinLeagueEvent({
    required this.leagueID,
    required this.entryFee,
    required this.isPrivate,
  });

  final String leagueID;
  final String entryFee;
  final String isPrivate;

  @override
  List<Object?> get props => [leagueID, entryFee, isPrivate];
}

class LeaveLeagueEvent extends LeagueGameEvent {
  const LeaveLeagueEvent({
    required this.leagueID,
    required this.userWalletID,
  });
  final String leagueID;
  final String userWalletID;

  @override
  List<Object?> get props => [
        leagueID,
        userWalletID,
      ];
}

class CalculateRemainingDays extends LeagueGameEvent {}

class EditLeagueEvent extends LeagueGameEvent {
  const EditLeagueEvent({
    required this.leagueID,
    required this.name,
    required this.adminWallet,
    required this.dateStart,
    required this.dateEnd,
    required this.teamSize,
    required this.maxTeams,
    required this.entryFee,
    required this.isPrivate,
    required this.isLocked,
    required this.sports,
    required this.prizePoolAddress,
  });

  final String leagueID;
  final String name;
  final String adminWallet;
  final String dateStart;
  final String dateEnd;
  final int teamSize;
  final int maxTeams;
  final int entryFee;
  final bool isPrivate;
  final bool isLocked;

  final List<SupportedSport> sports;
  final String prizePoolAddress;

  @override
  List<Object?> get props => [
        leagueID,
        name,
        adminWallet,
        dateStart,
        dateEnd,
        teamSize,
        maxTeams,
        entryFee,
        isPrivate,
        isLocked,
        sports,
        prizePoolAddress,
      ];
}

class FetchLeagueTeamsEvent extends LeagueGameEvent {
  const FetchLeagueTeamsEvent({required this.leagueID});

  final String leagueID;

  @override
  List<Object?> get props => [leagueID];
}

class ProcessLeagueWinnerEvent extends LeagueGameEvent {
  const ProcessLeagueWinnerEvent({
    required this.leagueID,
    required this.leagueTeams,
    required this.athletes,
  });

  final List<LeagueTeam> leagueTeams;
  final String leagueID;
  final List<AthleteScoutModel> athletes;

  @override
  List<Object?> get props => [
        leagueID,
        leagueTeams,
        athletes,
      ];
}
