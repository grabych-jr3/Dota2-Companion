class MatchupModel {
  final int heroId;
  final int gamesPlayed;
  final int wins;

  MatchupModel({
    required this.heroId,
    required this.gamesPlayed,
    required this.wins,
  });

  factory MatchupModel.fromJson(Map<String, dynamic> json) {
    return MatchupModel(
      heroId: json['hero_id'] ?? 0,
      gamesPlayed: json['games_played'] ?? 0,
      wins: json['wins'] ?? 0,
    );
  }

  double get winRate {
    if (gamesPlayed == 0) return 0;
    return wins / gamesPlayed * 100;
  }
}