import 'dart:async';
import 'package:flutter/material.dart';
import 'add_players.dart';
import '../repositories/tournament_repository.dart';
import '../models/tournament.dart';

class CreateRoundRobin extends StatelessWidget {
  const CreateRoundRobin({super.key});

  @override
  Widget build(BuildContext context) {
    return const SessionDetails();
  }
}

class SessionDetails extends StatefulWidget {
  const SessionDetails({super.key});

  @override
  State<SessionDetails> createState() => _SessionDetailsState();
}

toggleVisibility(bool visible) {
  if (visible) {
    return false;
  } else {
    return true;
  }
}

class _SessionDetailsState extends State<SessionDetails> {
  // Variables
  int _numberOfCourts = 1;
  final String _playerRotation = "Rotate";
  final String _format = "Random";
  int _numberOfPlayers = 4;
  bool _editCourtsVisible = false;
  bool _editRotationVisible = false;
  bool _editFormatVisible = false;
  bool _editPlayersVisible = false;
  late int _matchId = 0;

  final TextEditingController _tournamentNameController =
      TextEditingController();

  final TournamentRepository _tournamentRepository = TournamentRepository();

  // Functions
  Future<void> _addTournament() async {
    final String name = _tournamentNameController.text.trim();

    final Tournament tournament =
        Tournament(id: 0, name: name, latestMatchId: null);

    if (name.isEmpty) {
      showSnackBar('Please enter a tournament name');
      return;
    } else {
      try {
        await _tournamentRepository.addTournament(tournament);
        showSnackBar('Tournament added successfully!');

        List<Tournament> createdTournament =
            await _tournamentRepository.getTournamentByName(name);

        navigateToAddPlayersScreen(createdTournament[0].id, name);
      } catch (e) {
        showSnackBar('Error: Tournament name already exists');
      }
    }
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  navigateToAddPlayersScreen(int tournamentId, String tournamentName) {
    // To add players screen
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddPlayers(tournamentId: tournamentId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create New Tournament'),
        ),
        body: Container(
            margin: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.layers),
                        Text('$_numberOfCourts Court(s)'),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _editCourtsVisible =
                                    toggleVisibility(_editCourtsVisible);
                              });
                            },
                            icon: const Icon(Icons.edit))
                      ]),
                  Visibility(
                      visible: _editCourtsVisible,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (_numberOfCourts > 1) {
                                    setState(() {
                                      _numberOfCourts--;
                                    });
                                  }
                                },
                                child: const Icon(Icons.remove)),
                            Text('$_numberOfCourts Courts'),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _numberOfCourts++;
                                  });
                                },
                                child: const Icon(Icons.add))
                          ])),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.group),
                        Text(_playerRotation),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _editRotationVisible =
                                    toggleVisibility(_editRotationVisible);
                              });
                            },
                            icon: const Icon(Icons.edit))
                      ]),
                  Visibility(
                      visible: _editRotationVisible,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: const Text('Rotate')),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: () {}, child: const Text('Fixed'))
                          ])),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.sports_cricket),
                        Text(_format),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _editFormatVisible =
                                    toggleVisibility(_editFormatVisible);
                              });
                            },
                            icon: const Icon(Icons.edit))
                      ]),
                  Visibility(
                      visible: _editFormatVisible,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Put Format Here"))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.groups),
                        Text('$_numberOfPlayers Players'),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _editPlayersVisible =
                                    toggleVisibility(_editPlayersVisible);
                              });
                            },
                            icon: const Icon(Icons.edit))
                      ]),
                  Visibility(
                      visible: _editPlayersVisible,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        ElevatedButton(
                            onPressed: () {
                              if (_numberOfPlayers > 2) {
                                setState(() {
                                  _numberOfPlayers--;
                                });
                              }
                            },
                            child: const Icon(Icons.remove)),
                        Text('$_numberOfPlayers Players'),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _numberOfPlayers++;
                              });
                            },
                            child: const Icon(Icons.add))
                      ])),
                  SizedBox(height: 30),
                  TextField(
                    controller: _tournamentNameController,
                    decoration: const InputDecoration(
                      labelText: 'Enter tournament name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        // Add tournament
                        _addTournament();
                      },
                      child: const Text('Create New Tournament')),
                ],
              ),
            )));
  }
}
