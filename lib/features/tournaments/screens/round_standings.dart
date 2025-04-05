import 'dart:async';

import 'package:flutter/material.dart';
import 'package:p_round_robin_mobile/features/tournaments/repositories/player_repository.dart';
import 'package:p_round_robin_mobile/features/tournaments/repositories/tournament_player_statistic_repository.dart';
import '../models/player.dart';
import '../models/tournament_player_statistic.dart';
import 'add_score.dart';

class StandingsSectionOfRounds extends StatefulWidget {
  final int tournamentId;

  const StandingsSectionOfRounds({super.key, required this.tournamentId});

  @override
  State<StandingsSectionOfRounds> createState() => _StandingsSectionsOfRounds();
}

class _StandingsSectionsOfRounds extends State<StandingsSectionOfRounds> {
  final PlayerRepository _playerRepository = PlayerRepository();
  final TournamentPlayerStatisticRepository
      _tournamentPlayerStatisticRepository =
      TournamentPlayerStatisticRepository();
  late Future<List<Player>> _tournamentPlayers;
  late Future<List<TournamentPlayerStatistic>> _tournamentPlayerStatistics;
  late Future<List<Map<dynamic, dynamic>>> _statistics;
  late Future<List<Map<String, dynamic>>> _combinedList;

  @override
  void initState() {
    super.initState();

    setState(() {
      _tournamentPlayers =
          _playerRepository.getPlayersInTournament(widget.tournamentId);
      _tournamentPlayerStatistics = _tournamentPlayerStatisticRepository
          .getTournamentPlayerStatisticsByTournamentId(widget.tournamentId);
      _combinedList = getStandings();
    });
  }

  Future<List<Map<String, dynamic>>> getStandings() async {
    List<Player> players =
        await _playerRepository.getPlayersInTournament(widget.tournamentId);
    List<TournamentPlayerStatistic> stats =
        await _tournamentPlayerStatisticRepository
            .getTournamentPlayerStatisticsByTournamentId(widget.tournamentId);

    return List.generate(players.length, (index) {
      return {'player': players[index], 'stats': stats[index]};
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: _combinedList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No players found.'));
          } else {
            // Data is available, display it in a ListView.builder
            List<Map<String, dynamic>> list = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                String winrate = 'N/A';
                var wins = list[index]['stats'].wins;
                var losses = list[index]['stats'].losses;
                var pointDifferential = list[index]['stats'].pointDifferential;
                String display = "W:" +
                    (wins == null ? "0" : wins.toString()) +
                    " - " +
                    "L:" +
                    (losses == null ? "0" : losses.toString()) +
                    " - " +
                    "Pt D:" +
                    (pointDifferential == null
                        ? "0"
                        : pointDifferential.toString());

                if (wins != null && losses != null) {
                  var totalGames = wins + losses;

                  if (wins > 0 || losses > 0) {
                    winrate = "${((wins / totalGames) * 100).toString()}%";
                  } else {
                    winrate = "DNP";
                  }
                }

                return Padding(padding: EdgeInsets.symmetric(horizontal: 6),child: Card(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(int.parse('FF4A506A',
                              radix: 16)), // Your desired background color
                          borderRadius: BorderRadius.circular(
                              10.0), // Your desired rounded corners
                        ),
                        child: ListTile(
                          dense: true,
                          isThreeLine: true,
                          leading: Text("${index + 1}",
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white)),
                          title: Text(list[index]['player'].name,
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(display,
                              style: const TextStyle(color: Colors.white70)),
                          trailing: Text(
                            winrate,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                        ))));
              },
            );
          }
        });
  }
}
