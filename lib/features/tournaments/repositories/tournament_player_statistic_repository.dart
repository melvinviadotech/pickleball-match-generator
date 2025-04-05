import '../services/database.dart';
import '../models/tournament_player_statistic.dart';

class TournamentPlayerStatisticRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Retrieve all tournament player statistics
  Future<List<TournamentPlayerStatistic>>
      getAllTournamentPlayerStatistics() async {
    final List<Map<String, dynamic>> maps =
        await _dbHelper.getTournamentPlayerStatistics();
    return List.generate(maps.length, (i) {
      return TournamentPlayerStatistic.fromMap(maps[i]);
    });
  }

  // Get all tournament player statistic by tournament player ID
  Future<List<TournamentPlayerStatistic>>
      getTournamentPlayerStatisticsByTournamentId(int tournamentId) async {
    final List<Map<String, dynamic>> maps = await _dbHelper
        .getTournamentPlayerStatisticsByTournamentId(tournamentId);
    return List.generate(maps.length, (i) {
      return TournamentPlayerStatistic.fromMap(maps[i]);
    });
  }

  // Add a single tournament player statistic
  Future<int> addTournamentPlayerStatistic(
      TournamentPlayerStatistic tournamentPlayerStatistic) async {
    print(tournamentPlayerStatistic.toMap());
    return await _dbHelper
        .insertTournamentPlayerStatistic(tournamentPlayerStatistic.toMap());
  }
}
