import 'package:json_annotation/json_annotation.dart';

part 'MLBAthlete.g.dart';

@JsonSerializable()
class MLBAthlete {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "team")
  final String team;
  @JsonKey(name: "position")
  final String position;
  @JsonKey(name: "started")
  final double started;
  @JsonKey(name: "games")
  final double games;
  @JsonKey(name: "atBats")
  final double atBats;
  @JsonKey(name: "runs")
  final double runs;
  @JsonKey(name: "singles")
  final double singles;
  @JsonKey(name: "triples")
  final double triples;
  @JsonKey(name: "homeRuns")
  final double homeRuns;
  @JsonKey(name: "inningsPlayed")
  final double inningsPlayed;
  @JsonKey(name: "battingAverage")
  final double battingAverage;
  @JsonKey(name: "outs")
  final double outs;
  @JsonKey(name: "walks")
  final double walks;
  @JsonKey(name: "errors")
  final double errors;
  @JsonKey(name: "saves")
  final double saves;
  @JsonKey(name: "strikeOuts")
  final double strikeOuts;
  @JsonKey(name: "stolenBases")
  final double stolenBases;
  @JsonKey(name: "plateAppearances")
  final double plateAppearances;
  @JsonKey(name: "weightedOnBasePercentage")
  final double weightedOnBasePercentage;
  @JsonKey(name: "price")
  final double price;
  @JsonKey(name: "timeStamp")
  final String timeStamp;

  const MLBAthlete({
    required this.id,
    required this.name,
    required this.team,
    required this.position,
    required this.started,
    required this.games,
    required this.atBats,
    required this.runs,
    required this.singles,
    required this.triples,
    required this.homeRuns,
    required this.inningsPlayed,
    required this.battingAverage,
    required this.outs,
    required this.walks,
    required this.errors,
    required this.saves,
    required this.strikeOuts,
    required this.stolenBases,
    required this.plateAppearances,
    required this.weightedOnBasePercentage,
    required this.price,
    required this.timeStamp,
  });

  factory MLBAthlete.fromJson(Map<String, dynamic> json) =>
      _$MLBAthleteFromJson(json);

  Map<String, dynamic> toJson() => _$MLBAthleteToJson(this);
}
