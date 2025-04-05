import '../services/database.dart';
import '../models/tournament.dart';

class TournamentRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Create: Add a single tournament
  Future<int> addTournament(Tournament tournament) async {
    return await _dbHelper.insertTournament(tournament.toMap());
  }

  // Read: Retrieve all tournaments
  Future<List<Tournament>> getAllTournaments() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getTournaments();
    return List.generate(maps.length, (i) {
      return Tournament.fromMap(maps[i]);
    });
  }

  // Read: Retrieve tournament by name
  Future<List<Tournament>> getTournamentByName(String name) async {
    final List<Map<String, dynamic>> maps =
        await _dbHelper.getTournamentByName(name);
    return List.generate(maps.length, (i) {
      return Tournament.fromMap(maps[i]);
    });
  }

  // Read: Retrieve tournament by ID
  Future<List<Tournament>> getTournamentById(int id) async {
    final List<Map<String, dynamic>> maps =
    await _dbHelper.getTournamentById(id);
    return List.generate(maps.length, (i) {
      return Tournament.fromMap(maps[i]);
    });
  }

  // Update: Update the latest match ID of a tournament
  Future<void> updateLatestMatchId(int tournamentId, int latestMatchId) async {
    return await _dbHelper.updateLatestMatchId(tournamentId, latestMatchId);
  }

  // Delete a single tournament
  Future<void> deleteTournamentById(int tournamentId) async {
    return await _dbHelper.deleteTournamentById(tournamentId);
  }
}
