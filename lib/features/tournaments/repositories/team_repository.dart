import '../services/database.dart';
import '../models/team.dart';

class TeamRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Create: Add a team
  Future<int> addTeam(Team team) async {
    return await _dbHelper.insertTeam(team.toMap());
  }

  // Read: Get a team by player IDs
  Future<Team> getTeamByPlayerIds(int id1, int id2) async {
    final List<Map<String, dynamic>> maps =
    await _dbHelper.getTeamByPlayerIds(id1, id2);
    List<Team> team = List.generate(maps.length, (i) {
      return Team.fromMap(maps[i]);
    });

    return team[0];
  }

  // Update:
  Future<void> updateTeamPlayerStatistics(int teamId, Map<String, dynamic> statisticUpdates) {
    return _dbHelper.updateTeamPlayerStatistics(teamId, statisticUpdates);
  }
}
