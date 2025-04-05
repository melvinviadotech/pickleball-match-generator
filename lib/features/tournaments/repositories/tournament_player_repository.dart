import '../services/database.dart';
import '../models/tournament_player.dart';

class TournamentPlayerRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Retrieve all player
  Future<List<TournamentPlayer>> getAllTournamentPlayers() async {
    final List<Map<String, dynamic>> maps =
        await _dbHelper.getTournamentPlayers();
    return List.generate(maps.length, (i) {
      return TournamentPlayer.fromMap(maps[i]);
    });
  }

  // Get all tournament players by tournament ID
  Future<List<TournamentPlayer>> getTournamentPlayersById(int id) async {
    final List<Map<String, dynamic>> maps =
    await _dbHelper.getTournamentPlayersById(id);
    print(maps);
    return List.generate(maps.length, (i) {
      return TournamentPlayer.fromMap(maps[i]);
    });
  }

  // Get tournament player by IDs
  Future<List<TournamentPlayer>> getTournamentPlayerByIds(
      int tournamentId,
      int playerId
      ) async {
    final List<Map<String, dynamic>> maps =
    await _dbHelper.getTournamentPlayerByIds(tournamentId, playerId);
    return List.generate(maps.length, (i) {
      return TournamentPlayer.fromMap(maps[i]);
    });
  }

  // Add a single player
  Future<int> addTournamentPlayer(TournamentPlayer tournamentPlayer) async {
    print(tournamentPlayer.toMap());
    return await _dbHelper.insertTournamentPlayer(tournamentPlayer.toMap());
  }
}
