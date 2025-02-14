import 'package:flutter/material.dart';
import 'rounds.dart';

class SeedPlayersWidget extends StatefulWidget {
  const SeedPlayersWidget({super.key, required this.players});

  final dynamic players;

  @override
  State<SeedPlayersWidget> createState() => _SeedPlayersWidgetState();
}

class _SeedPlayersWidgetState extends State<SeedPlayersWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Seed Players'),
        ),
        body: Column(children: [
          const Text('Seed Players',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          Expanded(
              child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            children: <Widget>[
              for (int index = 0; index < widget.players.length; index += 1)
                ListTile(
                  key: Key('$index'),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5)),
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle),
                  ),
                  title: Text(widget.players[index]),
                )
            ],
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final String item = widget.players.removeAt(oldIndex);
                widget.players.insert(newIndex, item);
              });
            },
          )),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RoundsWidget(players: widget.players)),
                );
              },
              child: const Text('Create Round 1 Matchups'))
        ]));
  }
}
