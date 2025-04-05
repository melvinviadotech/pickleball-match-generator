import 'package:flutter/material.dart';
import '../repositories/match_repository.dart';

class AddScore extends StatefulWidget {
  final dynamic matchId;

  AddScore({super.key, required this.matchId});

  @override
  _AddScoreState createState() => _AddScoreState();
}

class _AddScoreState extends State<AddScore> {
  final firstScoreController = TextEditingController();
  final secondScoreController = TextEditingController();
  final MatchRepository _matchRepository = MatchRepository();

  late Map<String, dynamic> _matchPlayers;

  @override
  void initState() {
    super.initState();
    _loadMatchPlayers();
  }

  _loadMatchPlayers() async {
    Map<String, dynamic> matchPlayers =
        await _matchRepository.getPlayersFromMatch(widget.matchId);
    setState(() {
      _matchPlayers = matchPlayers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Score for Match ${widget.matchId}'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(""),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                Text(_matchPlayers['player1_name']),
                Text(_matchPlayers['player2_name']),
                Container(
                    margin: const EdgeInsets.all(15.0),
                    width: 50,
                    child: TextFormField(
                        controller: firstScoreController,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "0")))
              ]),
              SizedBox(width: 100),
              Column(children: [
                Text(_matchPlayers['player3_name']),
                Text(_matchPlayers['player4_name']),
                Container(
                    margin: const EdgeInsets.all(15.0),
                    width: 50,
                    child: TextFormField(
                        controller: secondScoreController,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "0")))
              ])
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'display':
                      '${firstScoreController.text} - ${secondScoreController.text}',
                  'firstScore': firstScoreController.text,
                  'secondScore': secondScoreController.text
                });
              },
              child: Text('Save Score')),
          ElevatedButton(onPressed: () {}, child: Text('Did Not Play'))
        ])));
  }
}
