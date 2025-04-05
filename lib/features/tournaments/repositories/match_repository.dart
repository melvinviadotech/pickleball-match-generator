import '../services/database.dart';
import '../models/match.dart';

class MatchRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Create: Add a single player
  Future<int> addMatch(Match match) async {
    return await _dbHelper.insertMatch(match.toMap());
  }

  // Read: Get match by ID
  Future<Match> getMatchById(int id) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getMatchById(id);
    List<Match> match =  List.generate(maps.length, (i) {
      return Match.fromMap(maps[i]);
    });

    return match[0];
  }

  // Read: Get players of a match by match ID
  Future<Map<String, dynamic>> getPlayersFromMatch(int id) async {
    List<Map<String, dynamic>> players = await _dbHelper.getPlayersByMatchId(id);

    return players[0];
  }

  // Update: Match status
  Future<int> updateMatchStatus(int id, String status) async {
    return await _dbHelper.updateMatchStatus(id, status);
  }

  // Update: Set team scores
  Future<int> updateTeamScores(int id, int score1, int score2) async {
    return await _dbHelper.updateTeamScores(id, score1, score2);
  }

  // Update: Set team winner
  Future<int> updateTeamWinner(int matchId, int winnerId) async {
    return await _dbHelper.updateTeamWinner(matchId, winnerId);
  }
}
