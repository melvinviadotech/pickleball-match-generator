import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      // onCreate: _onCreate,
    );
  }

  /*
  Eventually include all the tables needed
  Include all CRUD (Create, Read, Update, Delete) Methods
   */

  // region Tournament Methods

  // Create: Add one tournament
  Future<int> insertTournament(Map<String, dynamic> tournament) async {
    final db = await database;
    return await db.insert('tournament', tournament);
  }

  // Read: Get all tournaments
  Future<List<Map<String, dynamic>>> getTournaments() async {
    final db = await database;
    return await db.query('tournament');
  }

  // Read: Get tournament by name
  Future<List<Map<String, dynamic>>> getTournamentByName(String name) async {
    final db = await database;
    return await db.query(
      'tournament',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );
  }

  // Read: Get tournament by ID
  Future<List<Map<String, dynamic>>> getTournamentById(int id) async {
    final db = await database;
    return await db.query(
      'tournament',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
  }

  // Update the latest match ID of a tournament
  Future<void> updateLatestMatchId(int tournamentId, int latestMatchId) async {
    final db = await database;
    await db.update(
      'tournament',
      {'latest_match_id': latestMatchId},
      where: 'id = ?',
      whereArgs: [tournamentId],
    );
  }

  // Delete a tournament by ID
  Future<void> deleteTournamentById(int id) async {
    final db = await database;
    await db.execute("PRAGMA foreign_keys = ON");
    await db.delete(
      'tournament',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  //endregion

  // region Player Methods
  // Get all players
  Future<List<Map<String, dynamic>>> getPlayers() async {
    final db = await database;
    return await db.query('tournament');
  }

  // Get player names in tournament
  Future<List<Map<String, dynamic>>> getPlayersInTournament(int id) async {
    final db = await database;
    return db.rawQuery('''
      SELECT player.id, player.name
      FROM player
      INNER JOIN tournament_player
      ON tournament_player.player_id = player.id
      WHERE tournament_player.tournament_id = ?
    ''', [id]);
  }

  // Get a player by name
  Future<List<Map<String, dynamic>>> getPlayerByName(String name) async {
    final db = await database;
    return await db.query(
      'player',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );
  }

  // Insert one player
  Future<int> insertPlayer(Map<String, dynamic> player) async {
    final db = await database;
    return await db.insert('player', player);
  }
  // endregion

  // region Tournament Player Methods

  // Create one tournament player
  Future<int> insertTournamentPlayer(
      Map<String, dynamic> tournamentPlayer) async {
    final db = await database;
    return await db.insert('tournament_player', tournamentPlayer);
  }

  // Read: Get all tournament players
  Future<List<Map<String, dynamic>>> getTournamentPlayers() async {
    final db = await database;
    return await db.query('tournament_player');
  }

  // Read: Get a tournament player by IDs
  Future<List<Map<String, dynamic>>> getTournamentPlayersById(int id) async {
    final db = await database;
    return await db.query('tournament_player',
        where: 'tournament_id = ?',
        whereArgs: [id]
    );
  }

  // Read: Get a tournament player by IDs
  Future<List<Map<String, dynamic>>> getTournamentPlayerByIds(
      int tournamentId, int playerId) async {
    final db = await database;
    return await db.query('tournament_player',
        where: 'tournament_id = ? AND player_id = ?',
        whereArgs: [tournamentId, playerId],
        limit: 1);
  }

  // endregion

  // region Tournament Player Statistic Methods
  // Create: Insert one tournament player statistic
  Future<int> insertTournamentPlayerStatistic(
      Map<String, dynamic> tournamentPlayerStatistic) async {
    final db = await database;
    return await db.insert(
        'tournament_player_statistic', tournamentPlayerStatistic);
  }

  // Read: Get all tournament player statistics
  Future<List<Map<String, dynamic>>> getTournamentPlayerStatistics() async {
    final db = await database;
    return await db.query('tournament_player_statistic');
  }

  // Read: Get tournament player statistics by tournament player ID
  Future<List<Map<String, dynamic>>>
      getTournamentPlayerStatisticsByTournamentId(int tournamentId) async {
    final db = await database;
    return db.rawQuery('''
      SELECT tournament_player_statistic.*
      FROM tournament_player_statistic
      INNER JOIN tournament_player
      ON tournament_player.id = tournament_player_statistic.tournament_player_id
      WHERE tournament_player.tournament_id = ?
    ''', [tournamentId]);
  }

  // Update: Statistics of a tournament player
  Future<void> updateTeamPlayerStatistics(int teamId, Map<String, dynamic> statisticUpdates) async {
    final db = await database;

    List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT *
        FROM tournament_player_statistic AS tps
        JOIN tournament_player AS tp ON tps.tournament_player_id = tp.id
        JOIN team AS t ON tp.id = t.player1_id
        WHERE t.id=11;
    ''');

    print(result);

    List<String> columns = ['player1_id', 'player2_id'];

    for (int i = 0; i < columns.length; i++) {
      db.rawUpdate('''
      UPDATE tournament_player_statistic
      SET
        'wins' = 1,
        'losses' = 1,
        'point_differential' = 14    
      WHERE tournament_player_statistic.id IN (
        SELECT tps.id
        FROM tournament_player_statistic AS tps
        JOIN tournament_player AS tp ON tps.tournament_player_id = tp.id
        JOIN team AS t ON tp.id = t.${columns[i]}
        WHERE t.id=12
      );    
    ''');
    }
  }

  // endregion

  // region Team Methods
  // Insert one team
  Future<int> insertTeam(Map<String, dynamic> team) async {
    final db = await database;
    try {
      return await db.insert('team', team);
    } catch (e) {
      print('Team already exists: $e');
      return 0;
    }
  }

  // Get team by player IDs
  Future<List<Map<String, dynamic>>> getTeamByPlayerIds(
      int id1, int id2) async {
    final db = await database;
    return await db.query(
      'team',
      where: 'player1_id = ? AND player2_id = ?',
      whereArgs: [id1, id2],
      limit: 1,
    );
  }
  // endregion

  // region Match Methods
  // Create: Insert one match
  Future<int> insertMatch(Map<String, dynamic> match) async {
    final db = await database;
    return await db.insert('match', match);
  }

  // Read: Get a match by ID
  Future<List<Map<String, dynamic>>> getMatchById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'match',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return maps;
  }

  // Read: Get player names in a match
  Future<List<Map<String, dynamic>>> getPlayersByMatchId(int id) async {
    final db = await database;
    return db.rawQuery('''
      SELECT 
        p1.name AS player1_name,
        p2.name AS player2_name,
        p3.name AS player3_name,
        p4.name AS player4_name
      FROM match m
      JOIN
        team t1 ON m.team1_id = t1.id
      JOIN
        tournament_player tp1 ON t1.player1_id = tp1.id
      JOIN
        player p1 ON tp1.player_id = p1.id
      JOIN
        tournament_player tp2 ON t1.player2_id = tp2.id
      JOIN
        player p2 ON tp2.player_id = p2.id
      JOIN
        team t2 ON m.team2_id = t2.id
      JOIN
        tournament_player tp3 ON t2.player1_id = tp3.id
      JOIN
        player p3 ON tp3.player_id = p3.id
        JOIN
        tournament_player tp4 ON t2.player2_id = tp4.id
      JOIN
        player p4 ON tp4.player_id = p4.id
      WHERE
          m.id = ?;
    ''', [id]);
  }

  // Update: Match Status
  Future<int> updateMatchStatus(int id, String status) async {
    final db = await database;
    return await db.update(
      'match',
      { 'match_status': status },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateTeamScores(int id, int score1, int score2) async {
    final db = await database;
    return await db.update(
      'match',
      {
        'team1_score': score1,
        'team2_score': score2
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateTeamWinner(int matchId, int winnerId) async {
    final db = await database;
    return await db.update(
      'match',
      { 'team_winner_id': winnerId },
      where: 'id = ?',
      whereArgs: [matchId],
    );
  }

  // endregion

  // region One Time Execute Methods
  // Execute once
  Future<void> executeOne() async {
    final db = await database;
    return await db.execute('''
    DELETE FROM tournament_player_statistic;
    ''');
  }

  Future<void> emptyAllTables() async {
    final db = await database;
    db.execute('DELETE FROM match');
    db.execute('DELETE FROM team');
    db.execute('DELETE FROM tournament_player');
    db.execute('DELETE FROM tournament');
    db.execute('DELETE FROM player');
    db.execute('DELETE FROM tournament_player_statistic');
  }
  // endregion
}
