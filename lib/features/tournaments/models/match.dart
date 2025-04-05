class Match {
  final int id;
  final int team1Id;
  final int team2Id;
  final int? team1Score;
  final int? team2Score;
  final int? teamWinnerId;
  final String matchStatus;

  Match({
    required this.id,
    required this.team1Id,
    required this.team2Id,
    required this.team1Score,
    required this.team2Score,
    required this.teamWinnerId,
    required this.matchStatus,
  });

  // 'id' is omitted to let SQLite auto-generate it
  Map<String, dynamic> toMap() {
    return {
      'team1_id': team1Id,
      'team2_id': team2Id,
      'team1_score': team1Score,
      'team2_score': team2Score,
      'team_winner_id': teamWinnerId,
      'match_status': matchStatus
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      id: map['id'],
      team1Id: map['team1_id'],
      team2Id: map['team2_id'],
      team1Score: map['team1_score'],
      team2Score: map['team2_score'],
      teamWinnerId: map['team_winner_id'],
      matchStatus: map['match_status']
    );
  }
}