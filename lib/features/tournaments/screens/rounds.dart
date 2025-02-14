import 'dart:async';

import 'package:flutter/material.dart';
import 'add_score.dart';

class RoundStateProvider extends InheritedWidget {
  final String data;
  final List players;
  final List playerListData;

  const RoundStateProvider({
    super.key,
    required this.data,
    required this.players,
    required this.playerListData,
    required super.child,
  });

  static RoundStateProvider? of(BuildContext context) {
    // This method looks for the nearest `RoundStateProvider` widget ancestor.
    return context.dependOnInheritedWidgetOfExactType<RoundStateProvider>();
  }

  @override
  // This method should return true if the old widget's data is different
  // from this widget's data. If true, any widgets that depend on this widget
  // by calling `of()` will be re-built.
  bool updateShouldNotify(RoundStateProvider oldWidget) {
    return oldWidget.data != data;
  }
}

class RoundsWidget extends StatefulWidget {
  const RoundsWidget({super.key, required this.players});

  final dynamic players;

  @override
  State<RoundsWidget> createState() => _RoundsWidgetState();
}

class _RoundsWidgetState extends State<RoundsWidget> {
  // Set state variable

  final List _playerListData = [
    {
      'name': 'John Doe',
      'totalPoints': 5,
      'wins': 40,
      'losses': 10,
      'ties': 5,
      'totalMatches': 0,
      'winPercentage': 100
    }
  ];

  @override
  Widget build(BuildContext context) {
    List playerList = widget.players;

    // Update total matches
    setState(() {
      _playerListData[0]['totalMatches'] =
          _playerListData[0]['wins'] + _playerListData[0]['losses'];
    });

    // Update win percentage
    setState(() {
      _playerListData[0]['winPercentage'] =
          (_playerListData[0]['wins'] / _playerListData[0]['totalMatches']) *
              100;
    });

    return MaterialApp(
        home: RoundStateProvider(
            data: "TestData",
            players: playerList,
            playerListData: _playerListData,
            child: DefaultTabController(
                length: 3,
                child: Scaffold(
                    appBar: AppBar(
                      bottom: const TabBar(tabs: [
                        Tab(icon: Icon(Icons.group), text: 'Players'),
                        Tab(icon: Icon(Icons.gamepad), text: 'Matchups'),
                        Tab(icon: Icon(Icons.emoji_events), text: 'Standings')
                      ]),
                      title: const Text('Round Robin'),
                    ),
                    body: TabBarView(children: [
                      PlayersTabSectionOfRounds(),
                      MatchupTabSectionOfRounds(
                        players: playerList,
                      ),
                      StandingsSectionOfRounds(players: playerList)
                    ])))));
  }
}

// Players tab section of rounds screen
class PlayersTabSectionOfRounds extends StatelessWidget {
  const PlayersTabSectionOfRounds({super.key});

  @override
  Widget build(BuildContext context) {
    final roundStateProvider = RoundStateProvider.of(context);
    final data = roundStateProvider?.data;
    final players = roundStateProvider?.players;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: players?.length,
      prototypeItem: ListTile(
        title: Text(players?.first),
      ),
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          trailing: Text(data!),
          title: Text(players![index]),
        ));
      },
    );
  }
}

class MatchupTabSectionOfRounds extends StatefulWidget {
  final dynamic players;

  const MatchupTabSectionOfRounds({super.key, required this.players});

  @override
  State<MatchupTabSectionOfRounds> createState() =>
      _MatchupTabSectionOfRounds();
}

class _MatchupTabSectionOfRounds extends State<MatchupTabSectionOfRounds> {
  Widget _courtScore = const Text("VS");
  List _byeList = [];
  bool _byeListVisible = false;
  String _courtScoreLabel = "Add Score";
  bool _roundActive = false;
  Widget _roundButtonText = const Text("Start Round");
  Color _shuffleButtonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    List playerList = widget.players;

    // make a bye list if there are more than 4 players
    if (playerList.length > 4) {
      setState(() {
        _byeList = <String>[];
      });

      for (var i = 4; i < playerList.length; i++) {
        setState(() {
          _byeList.add(playerList[i]);
        });
      }

      setState(() {
        _byeListVisible = true;
      });
    }

    return Container(
        margin: EdgeInsets.all(15.0),
        child: Center(
            child: Column(
          children: [
            const Text(
              'Court 1',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
            Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: SizedBox(
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Column(children: [
                        Text(playerList[0]),
                        SizedBox(height: 10),
                        Text(playerList[3])
                      ])),
                      Column(
                        children: [
                          Container(
                              width: 1.5,
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black))),
                          _courtScore,
                          Container(
                              width: 1.5,
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)))
                        ],
                      ),
                      Expanded(
                          child: Column(children: [
                        Text(playerList[1]),
                        SizedBox(height: 10),
                        Text(playerList[2])
                      ]))
                    ],
                  )),
            ),
            // Bye list container
            const Text(
              'Bye List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
            Visibility(
                visible: _byeListVisible,
                child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: _byeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 30,
                            child: Center(
                                child: Text('Player ${_byeList[index]}')),
                          );
                        }))),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.all(5),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _courtScore = ElevatedButton(
                                  onPressed: () {
                                    _navigateAndDisplayScore(
                                        context, widget.players);
                                  },
                                  child: Text(_courtScoreLabel));

                              _roundActive = true;

                              _roundButtonText = const Text("End Round");

                              _shuffleButtonColor = Colors.grey;
                            });
                          },
                          child: _roundButtonText))),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.all(5),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _shuffleButtonColor),
                          onPressed: () {
                            if (!_roundActive) {
                              setState(() {
                                playerList.shuffle();
                              });
                            }
                          },
                          child: Text("Shuffle"))))
            ])
          ],
        )));
  }

  // Show the AddScore Screen
  Future<void> _navigateAndDisplayScore(
      BuildContext context, playerList) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddScoreScreen.
    final result = await Navigator.push(
      context,
      // Create the AddScoreScreen in the next step.
      MaterialPageRoute(builder: (context) => AddScore(players: playerList)),
    );

    // Check the mounted property for the StatefulWidget
    if (!context.mounted) return;

    // Show that score is added in a SnackBar
    String displayString = result['display'];
    int firstScore = int.parse(result['firstScore']);
    int secondScore = int.parse(result['secondScore']);

    // Display the added score in a snackbar
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Added Score: $displayString')));

    // Update the score when returned the score numbers
    if (result != null) {
      setState(() {
        _courtScoreLabel = displayString;

        _courtScore = ElevatedButton(
            onPressed: () {
              _navigateAndDisplayScore(context, widget.players);
            },
            child: Text(_courtScoreLabel));
      });
    }
  }
}

class StandingsSectionOfRounds extends StatefulWidget {
  final dynamic players;

  const StandingsSectionOfRounds({super.key, required this.players});

  @override
  State<StandingsSectionOfRounds> createState() => _StandingsSectionsOfRounds();
}

class _StandingsSectionsOfRounds extends State<StandingsSectionOfRounds> {
  @override
  Widget build(BuildContext context) {
    final roundStateProvider = RoundStateProvider.of(context);
    final players = roundStateProvider?.players;
    final playerData = roundStateProvider?.playerListData;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: players?.length,
      prototypeItem: ListTile(
        title: Text(players?.first),
      ),
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          dense: true,
          isThreeLine: true,
          leading: Text(
            (index + 1).toString(),
            style: TextStyle(fontSize: 25),
          ),
          title: Text(widget.players[index]),
          subtitle: Text(
              "${playerData?[0]['wins']}-${playerData?[0]['losses']}-${playerData?[0]['ties']}"),
          trailing: Text(
            "${playerData?[0]['winPercentage'].round()}%",
            style: TextStyle(fontSize: 25),
          ),
        ));
      },
    );
  }
}
