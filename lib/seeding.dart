import 'package:flutter/material.dart';
import 'rounds.dart';

class SeedPlayersWidget extends StatefulWidget {
  const SeedPlayersWidget({super.key, required this.players});

  final dynamic players;

  @override
  State<SeedPlayersWidget> createState() => _SeedPlayersWidgetState();
}

class _SeedPlayersWidgetState extends State<SeedPlayersWidget> {
  final _playerList = ['melvin', 'marl', 'viado'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Format'),
        ),
        body: Column(children: [
          const Text('Seed Players',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          Container(
              width: MediaQuery.sizeOf(context).width,
              height: 200,
              child: ReorderableListView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                children: <Widget>[
                  for (int index = 0; index < _playerList.length; index += 1)
                    Card(
                        key: Key('$index'),
                        child: ListTile(
                          title: Text(_playerList[index]),
                        ))
                ],
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final String item = _playerList.removeAt(oldIndex);
                    _playerList.insert(newIndex, item);
                  });
                },
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoundsWidget(players: _playerList)),
                );
              },
              child: const Text('Create Round 1 Matchups'))
        ]));
  }
}
