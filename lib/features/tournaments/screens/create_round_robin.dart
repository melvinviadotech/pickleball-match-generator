import 'dart:async';

import 'package:flutter/material.dart';
import 'add_players.dart';

import '../provider/db_create_round_robin.dart';

class CreateRoundRobin extends StatelessWidget {
  const CreateRoundRobin({super.key});

  @override
  Widget build(BuildContext context) {
    return SessionDetails();
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
  int _numberOfCourts = 1;
  String _playerRotation = "Rotate";
  String _format = "Random";
  int _numberOfPlayers = 4;
  bool _editCourtsVisible = false;
  bool _editRotationVisible = false;
  bool _editFormatVisible = false;
  bool _editPlayersVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a round robin'),
        ),
        body: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Icon(Icons.layers),
                Text('$_numberOfCourts Court(s)'),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _editCourtsVisible =
                            toggleVisibility(_editCourtsVisible);
                      });
                    },
                    icon: Icon(Icons.edit))
              ]),
              Visibility(
                  visible: _editCourtsVisible,
                  child: Row(children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_numberOfCourts > 1) {
                            setState(() {
                              _numberOfCourts--;
                            });
                          }
                        },
                        child: Icon(Icons.remove)),
                    Text('$_numberOfCourts Courts'),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _numberOfCourts++;
                          });
                        },
                        child: Icon(Icons.add))
                  ])),
              Divider(),
              Row(children: [
                Icon(Icons.group),
                Text(_playerRotation),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _editRotationVisible =
                            toggleVisibility(_editRotationVisible);
                      });
                    },
                    icon: Icon(Icons.edit))
              ]),
              Visibility(
                  visible: _editRotationVisible,
                  child: Row(children: [
                    ElevatedButton(onPressed: () {}, child: Text('Rotate')),
                    ElevatedButton(onPressed: () {}, child: Text('Fixed'))
                  ])),
              Divider(),
              Row(children: [
                Icon(Icons.sports_cricket),
                Text(_format),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _editFormatVisible =
                            toggleVisibility(_editFormatVisible);
                      });
                    },
                    icon: Icon(Icons.edit))
              ]),
              Visibility(
                  visible: _editFormatVisible,
                  child: ElevatedButton(
                      onPressed: () {}, child: Text("Put Format Here"))),
              Divider(),
              Row(children: [
                Icon(Icons.groups),
                Text('$_numberOfPlayers Players'),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _editPlayersVisible =
                            toggleVisibility(_editPlayersVisible);
                      });
                    },
                    icon: Icon(Icons.edit))
              ]),
              Visibility(
                  visible: _editPlayersVisible,
                  child: Row(children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_numberOfPlayers > 2) {
                            setState(() {
                              _numberOfPlayers--;
                            });
                          }
                        },
                        child: Icon(Icons.remove)),
                    Text('$_numberOfPlayers Players'),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _numberOfPlayers++;
                          });
                        },
                        child: Icon(Icons.add))
                  ])),
              Divider(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPlayers()),
                    );
                  },
                  child: Text('Create Session')),
              ElevatedButton(onPressed: () {}, child: Text('Create DB')),
              ElevatedButton(
                  onPressed: () {
                    insertRobin();
                  },
                  child: Text('Insert Robin')),
              ElevatedButton(
                  onPressed: () {
                    robins();
                  },
                  child: Text('Print Robins')),
            ],
          ),
        ));
  }
}
