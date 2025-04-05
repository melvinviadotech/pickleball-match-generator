import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import '../models/team.dart';
import '../models/player.dart';
import '../models/match.dart';
import '../models/tournament.dart';
import '../models/tournament_player.dart';
import '../repositories/team_repository.dart';
import '../repositories/player_repository.dart';
import '../repositories/match_repository.dart';
import '../repositories/tournament_repository.dart';
import '../repositories/tournament_player_repository.dart';
import 'add_score.dart';

class MatchupTabSectionOfRounds extends StatefulWidget {
  final int tournamentId;

  const MatchupTabSectionOfRounds({super.key, required this.tournamentId});

  @override
  State<MatchupTabSectionOfRounds> createState() =>
      _MatchupTabSectionOfRounds();
}

class _MatchupTabSectionOfRounds extends State<MatchupTabSectionOfRounds> {
  final PlayerRepository _playerRepository = PlayerRepository();
  final TeamRepository _teamRepository = TeamRepository();
  final MatchRepository _matchRepository = MatchRepository();
  final TournamentRepository _tournamentRepository = TournamentRepository();
  final TournamentPlayerRepository _tournamentPlayerRepository = TournamentPlayerRepository();
  late Future<List<Tournament>> _tournament;
  late Future<List<TournamentPlayer>> _tournamentPlayers;
  late Future<List<Player>> _players;
  late Match? _currentMatch;

  Widget _courtScore = const Text("VS");
  final List _byeList = [];
  final bool _byeListVisible = false;
  String _courtScoreLabel = "Add Score";
  final Color _shuffleButtonColor = Colors.white;

  @override
  void initState() {
    super.initState();
    // Fetch players from the database when the widget is initialized
    setState(() {
      _tournament = getTournamentById();
      _tournamentPlayers =
          _tournamentPlayerRepository.getTournamentPlayersById(widget.tournamentId);
      _players = _playerRepository.getPlayersInTournament(widget.tournamentId);
    });

    updateLatestMatch();
  }

  void updateLatestMatch() async {
    List<Tournament> tournament = await _tournament;
    int? id = tournament[0].latestMatchId;
    if (tournament[0].latestMatchId != null) {
      Match currentMatch = await _matchRepository.getMatchById(id!);
      setState(() {
        _currentMatch = currentMatch;
      });
    } else {
      setState(() {
        _currentMatch = null;
      });
    }
  }

  Future<List<Tournament>> getTournamentById() async {
    return await _tournamentRepository.getTournamentById(widget.tournamentId);
  }

  getTournamentLatestMatchId() async {
    var tournament = await getTournamentById();
    return tournament[0].latestMatchId;
  }

  createNewMatch() async {
    int teamOneId;
    int teamTwoId;

    Future<int> addTeam(int id1, int id2) async {
      Team newTeam = Team(id: 0, player1Id: id1, player2Id: id2);

      try {
        return _teamRepository.addTeam(newTeam);
      } catch (e) {
        print('Combination of player already exists in a team');

        Team insertedTeam = await _teamRepository.getTeamByPlayerIds(id1, id2);

        return insertedTeam.id;
      }
    }

    /*
    Add two new teams
     */
    // Get the participating players
    List<TournamentPlayer> tournamentPlayers = await _tournamentPlayers;

    // Add team 1
    teamOneId = await addTeam(tournamentPlayers[0].id, tournamentPlayers[1].id);

    // Add team 2
    teamTwoId = await addTeam(tournamentPlayers[2].id, tournamentPlayers[3].id);

    // Create a match instance
    Match newMatch = Match(
        id: 0,
        team1Id: teamOneId,
        team2Id: teamTwoId,
        team1Score: null,
        team2Score: null,
        teamWinnerId: null,
        matchStatus: 'pending');

    // Add the match and store the added match ID
    int newMatchId = await _matchRepository.addMatch(newMatch);

    // Update latest match ID of tournament
    _tournamentRepository.updateLatestMatchId(widget.tournamentId, newMatchId);

    // Update the state of tournament data and the current match
    Match updatedMatch = await _matchRepository.getMatchById(newMatchId);

    setState(() {
      _tournament = getTournamentById();
      _currentMatch = updatedMatch;
    });
  }

  startMatch() async {
    if (_currentMatch != null) {
      Match? currentMatch = _currentMatch;
      int? currentMatchId = currentMatch?.id;
      int result =
          await _matchRepository.updateMatchStatus(currentMatchId!, "ongoing");

      print(result);

      updateLatestMatch();
    }
  }

  endMatch() async {
    Match? currentMatch = _currentMatch;
    int? currentMatchId = currentMatch?.id;
    int? winnerId;
    int? loserId;

    // If there is a current match
    if (_currentMatch != null) {
      // Team 1 has a higher score
      if (currentMatch!.team1Score! > currentMatch.team2Score!) {
        winnerId = currentMatch.team1Id;
        loserId = currentMatch.team2Id;
      }
      // Team 2 has a higher score
      else {
        winnerId = currentMatch.team2Id;
        loserId = currentMatch.team1Id;
      }

      // Update winner
      _matchRepository.updateTeamWinner(
        currentMatchId!,
        winnerId
      );

      // Update match status
      _matchRepository.updateMatchStatus(currentMatchId, "completed");

      // Update tournament player statistics

      // Update match display
      updateLatestMatch();
    }
  }

  updateScore() async {
    int winnerId = 7;
    final updates = {'wins': 5, 'losses': 3, 'point_differential': 8};

    _teamRepository.updateTeamPlayerStatistics(winnerId, updates);
  }

  nextMatch() async {

  }

  showBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15.0),
        child: Center(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder(
                future: _tournament,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Tournament> tournament = snapshot.data!;
                    String currentMatchId;
                    tournament[0].latestMatchId == null
                        ? currentMatchId = 'No matches created'
                        : currentMatchId = '${tournament[0].latestMatchId}';
                    return Text("Current Match ID: $currentMatchId");
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            // Court 1 with players
            const Text(
              'Court 1',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
            Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: SizedBox(
                  width: 500,
                  child: FutureBuilder<List<Player>>(
                      future: _players,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No players found.'));
                        } else {
                          // Data is available, display it in a ListView.builder
                          List<Player> players = snapshot.data!;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Column(children: [
                                Text(players[0].name),
                                const SizedBox(height: 10),
                                Text(players[1].name)
                              ])),
                              Column(
                                children: [
                                  Container(
                                      width: 1.5,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black))),
                                  _courtScore,
                                  Container(
                                      width: 1.5,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)))
                                ],
                              ),
                              Expanded(
                                  child: Column(children: [
                                Text(players[2].name),
                                const SizedBox(height: 10),
                                Text(players[3].name)
                              ]))
                            ],
                          );
                        }
                      }),
                )),
            // Bye list container
            Visibility(
                visible: _byeListVisible,
                child: Column(children: [
                  const Text('Bye List',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                  Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: _byeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 30,
                              child: Center(
                                  child: Text('Player ${_byeList[index]}')),
                            );
                          }))
                ])),
            const SizedBox(height: 20),
            Text(
                "Current Match: ${_currentMatch?.matchStatus}"),
            Text(
                "Current Score: "
                "${_currentMatch?.team1Score == null ? 0 : _currentMatch?.team1Score}"
                " - " +
                "${_currentMatch?.team2Score == null ? 0 :_currentMatch?.team2Score }"),
            const SizedBox(height: 20),
            FutureBuilder(
                future: _tournament,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Tournament> tournament = snapshot.data!;
                    String display;
                    if (tournament[0].latestMatchId == null) {
                      display = 'Create New Match';
                    } else {
                      display = 'Create Match ${tournament[0].latestMatchId}';
                    }
                    return ElevatedButton(
                        onPressed: () {
                          createNewMatch();
                        },
                        child: Text(display, style: const TextStyle(fontSize: 12)));
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            ElevatedButton(
                onPressed: () {
                  startMatch();
                },
                child: const Text("Start Current Match", style: TextStyle(fontSize: 12))),
            ElevatedButton(
                onPressed: () {
                  endMatch();
                },
                child: const Text("End Current Match", style: TextStyle(fontSize: 12))),
            ElevatedButton(
                onPressed: () {
                  print(_currentMatch!.id);
                  _navigateAndDisplayScore(context, _currentMatch!.id);
                },
                child: const Text("Add Score", style: TextStyle(fontSize: 12))),
            ElevatedButton(
                onPressed: () {
                  updateScore();
                },
                child: const Text("Update Team Player Stats", style: TextStyle(fontSize: 12))),
            ElevatedButton(
                onPressed: () {
                  nextMatch();
                },
                child: const Text("Create Next Match", style: TextStyle(fontSize: 12)))
          ],
        )));
  }

  // Show the AddScore Screen
  Future<void> _navigateAndDisplayScore(
      BuildContext context, int matchId) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddScoreScreen.
    final result = await Navigator.push(
      context,
      // Create the AddScoreScreen in the next step.
      MaterialPageRoute(
          builder: (context) => AddScore(
                matchId: matchId,
              )),
    );

    // Check the mounted property for the StatefulWidget
    if (!context.mounted) return;

    // Show that score is added in a SnackBar
    String displayString = result['display'];

    // Update scores to the database
    _matchRepository.updateTeamScores(_currentMatch!.id,
        int.parse(result['firstScore']), int.parse(result['secondScore']));

    updateLatestMatch();

    // Display the added score in a snackbar
    showBarMessage(context, 'Added Score: $displayString');

    // Update the score when returned the score numbers
    if (result != null) {
      setState(() {
        _courtScoreLabel = displayString;
      });
    }
  }
}
