import 'dart:async';

import 'package:flutter/material.dart';
import 'add_score.dart';

import 'round_players.dart';
import 'round_match.dart';
import 'round_standings.dart';

class Rounds extends StatefulWidget {
  const Rounds({super.key, required this.tournamentId});

  final dynamic tournamentId;

  @override
  State<Rounds> createState() => _RoundsWidgetState();
}

class _RoundsWidgetState extends State<Rounds> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.group), text: 'Players'),
                Tab(icon: Icon(Icons.gamepad), text: 'Matchups'),
                Tab(icon: Icon(Icons.emoji_events), text: 'Standings')
              ],
              labelColor: Colors.white,
                labelStyle: TextStyle(
                  fontFamily: 'CustomFont'
                ),
              indicatorColor: Colors.white,
              ),
              title: const Text('Round Robin'),
            ),
            body: TabBarView(children: [
              PlayersTabSectionOfRounds(tournamentId: widget.tournamentId),
              MatchupTabSectionOfRounds(tournamentId: widget.tournamentId),
              StandingsSectionOfRounds(tournamentId: widget.tournamentId)
            ])));
  }
}
