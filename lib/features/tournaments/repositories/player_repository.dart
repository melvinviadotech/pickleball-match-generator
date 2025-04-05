import '../services/database.dart';
import '../models/player.dart';

class PlayerRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Retrieve all player
  Future<List<Player>> getAllPlayers() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getPlayers();
    return List.generate(maps.length, (i) {
      return Player.fromMap(maps[i]);
    });
  }

  // Retrieve all players in a tournament
  Future<List<Player>> getPlayersInTournament(int id) async {
    final List<Map<String, dynamic>> maps =
    await _dbHelper.getPlayersInTournament(id);
    print(maps);
    return List.generate(maps.length, (i) {
      return Player.fromMap(maps[i]);
    });
  }

  // Read: Get a player by their name
  Future<List<Player>> getPlayerByName(String name) async {
    final List<Map<String, dynamic>> maps =
    await _dbHelper.getPlayerByName(name);
    return List.generate(maps.length, (i) {
      return Player.fromMap(maps[i]);
    });
  }

  // Add a single player
  Future<int> addPlayer(Player player) async {
    return await _dbHelper.insertPlayer(player.toMap());
  }


}
