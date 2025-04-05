class TournamentPlayerStatistic {
  final int id;
  final int tournamentPlayerId;
  final int? wins;
  final int? losses;
  final int? pointDifferential;

  TournamentPlayerStatistic({
    required this.id,
    required this.tournamentPlayerId,
    required this.wins,
    required this.losses,
    required this.pointDifferential
  });

  // 'id' is omitted to let SQLite auto-generate it
  Map<String, dynamic> toMap() {
    return {
      'tournament_player_id': tournamentPlayerId,
      'wins': wins,
      'losses': losses,
      'point_differential': pointDifferential
    };
  }

  factory TournamentPlayerStatistic.fromMap(Map<String, dynamic> map) {
    return TournamentPlayerStatistic(
      id: map['id'],
      tournamentPlayerId: map['tournament_player_id'],
      wins: map['wins'],
      losses: map['losses'],
      pointDifferential: map['point_differential']
    );
  }
}
