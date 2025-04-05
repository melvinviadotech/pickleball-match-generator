import 'package:flutter/material.dart';
// import 'seeding.dart';
import '../models/tournament_player_statistic.dart';
import 'rounds.dart';
import '../models/tournament.dart';
import '../models/player.dart';
import '../models/tournament_player.dart';
import '../repositories/tournament_repository.dart';
import '../repositories/tournament_player_repository.dart';
import '../repositories/tournament_player_statistic_repository.dart';
import '../repositories/player_repository.dart';

class AddPlayers extends StatefulWidget {
  final int tournamentId;

  const AddPlayers(
      {super.key, required this.tournamentId});

  @override
  State<AddPlayers> createState() => _AddPlayers();
}

class _AddPlayers extends State<AddPlayers> {
  final TournamentRepository _tournamentRepository = TournamentRepository();
  final TournamentPlayerRepository _tournamentPlayerRepository =
      TournamentPlayerRepository();
  final TournamentPlayerStatisticRepository
      _tournamentPlayerStatisticRepository =
      TournamentPlayerStatisticRepository();
  final PlayerRepository _playerRepository = PlayerRepository();
  final playerNameController = TextEditingController();
  late int _tournamentId;
  late Future<List<Player>> _tournamentPlayers;

  @override
  void initState() {
    super.initState();

    setState(() {
      _tournamentId = widget.tournamentId;
    });

    updatePlayersInTournament();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    playerNameController.dispose();
    super.dispose();
  }

  Future<void> addPlayer() async {
    // Get the name input
    String playerName = playerNameController.text.trim();

    // Create a player instance
    final Player player = Player(id: 0, name: playerName);

    // Add the player to the database
    _playerRepository.addPlayer(player);
  }

  Future<void> addTournamentPlayer() async {
    // Get the name input
    String playerName = playerNameController.text.trim();

    // Get the inserted player to use the auto-generated ID
    final List<Player> newPlayer =
        await _playerRepository.getPlayerByName(playerName);

    // Create the tournament player instance
    final TournamentPlayer tournamentPlayer = TournamentPlayer(
      id: 0,
      tournamentId: _tournamentId,
      playerId: newPlayer[0].id,
    );

    // Add the tournament player to the database
    _tournamentPlayerRepository.addTournamentPlayer(tournamentPlayer);

    // Add tournament player statistic
    final List<TournamentPlayer> newTournamentPlayer =
        await _tournamentPlayerRepository.getTournamentPlayerByIds(
            _tournamentId, newPlayer[0].id);

    // Create a tournament player statistic instance
    final TournamentPlayerStatistic tournamentPlayerStatistic =
        TournamentPlayerStatistic(
            id: 0,
            tournamentPlayerId: newTournamentPlayer[0].id,
            wins: null,
            losses: null,
            pointDifferential: null);

    // Add the tournament player statistic instance to the database
    _tournamentPlayerStatisticRepository
        .addTournamentPlayerStatistic(tournamentPlayerStatistic);

    // Update the list of tournament players
    updatePlayersInTournament();
  }

  Future<void> updatePlayersInTournament() async {
    setState(() {
      _tournamentPlayers =
          _playerRepository.getPlayersInTournament(_tournamentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Players'),
        ),
        body: Container(
            margin: const EdgeInsets.all(15.0),
            height: 500,
            child: Center(
                child: Column(
              children: <Widget>[
                Text("Add players for tournament: $_tournamentId"),
                Expanded(
                    child: FutureBuilder<List<Player>>(
                        future: _tournamentPlayers,
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
                            return const Center(
                                child: Text('No players found.'));
                          } else {
                            // Data is available, display it in a ListView.builder
                            List<Player> players = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: players.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: ListTile(
                                  minTileHeight: 50.0,
                                  title: Text(players[index].name),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.close, size: 30),
                                      onPressed: () {
                                        // if (players.length > 1) {
                                        //   _dbHelper
                                        //       .deleteUser(players[index]['id']);
                                        //
                                        //   setState(() {
                                        //     _playersFuture =
                                        //         _dbHelper.getUsers();
                                        //   });
                                        // }
                                      }),
                                ));
                              },
                            );
                          }
                        })),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: playerNameController,
                        decoration: const InputDecoration(
                            helperText: "Enter a player name"),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.all(0)),
                        onPressed: () {
                          addPlayer();
                          addTournamentPlayer();
                          playerNameController.clear();
                        },
                        child: const Icon(Icons.add_circle,
                            color: Colors.black, size: 40))
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Rounds(tournamentId: widget.tournamentId)),
                    );
                  },
                  child: const Text('Start a match'),
                )
              ],
            ))));
  }
}
