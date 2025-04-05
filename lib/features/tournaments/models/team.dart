class Team {
  final int id;
  final int player1Id;
  final int player2Id;

  Team({
    required this.id,
    required this.player1Id,
    required this.player2Id
  });

  // 'id' is omitted to let SQLite auto-generate it
  Map<String, dynamic> toMap() {
    return {
      'player1_id': player1Id,
      'player2_id': player2Id
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
        id: map['id'],
        player1Id: map['player1_id'],
        player2Id: map['player2_id']);
  }
}
