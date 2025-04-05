class TournamentPlayer {
  final int id;
  final int tournamentId;
  final int playerId;

  TournamentPlayer({
    required this.id,
    required this.tournamentId,
    required this.playerId
  });

  // 'id' is omitted to let SQLite auto-generate it
  Map<String, dynamic> toMap() {
    return {
      'tournament_id': tournamentId,
      'player_id': playerId
    };
  }

  factory TournamentPlayer.fromMap(Map<String, dynamic> map) {
    return TournamentPlayer(
      id: map['id'],
      tournamentId: map['tournament_id'],
      playerId: map['player_id'],
    );
  }
}
