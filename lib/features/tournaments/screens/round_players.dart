import 'dart:async';

import 'package:flutter/material.dart';
import 'package:p_round_robin_mobile/features/tournaments/repositories/player_repository.dart';
import '../models/player.dart';
import 'add_players.dart';
import 'add_score.dart';

// Players tab section of rounds screen
class PlayersTabSectionOfRounds extends StatefulWidget {
  final int tournamentId;

  const PlayersTabSectionOfRounds({super.key, required this.tournamentId});

  @override
  State<PlayersTabSectionOfRounds> createState() =>
      _PlayersTabSectionOfRoundsState();
}

class _PlayersTabSectionOfRoundsState extends State<PlayersTabSectionOfRounds> {
  final PlayerRepository _playerRepository = PlayerRepository();
  late Future<List<Player>> _tournamentPlayers;

  @override
  void initState() {
    super.initState();

    // Fetch players from the database when the widget is initialized
    setState(() {
      _tournamentPlayers =
          _playerRepository.getPlayersInTournament(widget.tournamentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(16.0), // Add some padding
        child: SizedBox(
          width: double.infinity, // Expand to full width
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddPlayers(tournamentId: widget.tournamentId)),
                );
              },
              child: const Text('Add Players')),
        ),
      ),
      Expanded(
          child: FutureBuilder<List<Player>>(
              future: _tournamentPlayers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No players found'));
                } else {
                  // Data is available, display it in a ListView.builder
                  List<Player> players = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Card(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Color(int.parse('FF4A506A', radix: 16)),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    title: Text(players[index].name,
                                        style: const TextStyle(color: Colors.white)),
                                  ))));
                    },
                  );
                }
              }))
    ]);
  }
}
