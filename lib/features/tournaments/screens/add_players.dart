import 'package:flutter/material.dart';
// import 'seeding.dart';
import 'rounds.dart';

class AddPlayers extends StatelessWidget {
  const AddPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Players'),
      ),
      body: const FavoriteWidget(),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  final _players = ['John Doe', 'Jane Doe', 'Jane Poe', 'John Smith'];
  final playerInputController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    playerInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15.0),
        child: Center(
            child: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: _players.length,
              prototypeItem: ListTile(
                title: Text(_players.first),
              ),
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  minTileHeight: 50.0,
                  title: Text(_players[index]),
                  trailing: IconButton(
                      icon: Icon(Icons.close, size: 30),
                      onPressed: () {
                        if (_players.length > 1) {
                          setState(() {
                            _players.remove(_players[index]);
                          });
                        }
                      }),
                ));
              },
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: playerInputController,
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
                      setState(() {
                        _players.add(playerInputController.text);
                      });

                      playerInputController.clear();
                    },
                    child: const Icon(Icons.add_circle,
                        color: Colors.black, size: 40))
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // If the format is random, skip the seed page
                if (_players.length >= 4) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RoundsWidget(players: _players)));
                  // If the format is seeded, proceed to seed page
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           SeedPlayersWidget(players: _players)),
                  // );
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Players Not Added'),
                            content: const Text('Add At Least 4 Players!'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'Back');
                                  },
                                  child: const Text('Back'))
                            ],
                          ));
                }
              },
              child: const Text('Next'),
            )
          ],
        )));
  }
}
