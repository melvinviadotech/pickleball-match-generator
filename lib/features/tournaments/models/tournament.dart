import 'dart:ffi';

class Tournament {
  final int id;
  final String name;
  final int? latestMatchId;

  Tournament({
    required this.id,
    required this.name,
    required this.latestMatchId
  });

  // 'id' is omitted to let SQLite auto-generate it
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'latest_match_id': latestMatchId
    };
  }

  factory Tournament.fromMap(Map<String, dynamic> map) {
    return Tournament(
      id: map['id'],
      name: map['name'],
      latestMatchId: map['latest_match_id']
    );
  }
}