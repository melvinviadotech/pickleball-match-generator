class Player {
  final int id;
  final String name;

  Player({
    required this.id,
    required this.name
  });

  // 'id' is omitted to let SQLite auto-generate it
  Map<String, dynamic> toMap() {
    return {
      'name': name
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
        id: map['id'],
        name: map['name']
    );
  }
}