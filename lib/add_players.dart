import 'package:flutter/material.dart';
import 'seeding.dart';

class AddPlayers extends StatelessWidget {
  const AddPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Format'),
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
  final _players = ['melvin', 'marl', 'viado'];
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Center(
            child: Column(
      children: <Widget>[
        SizedBox(
            width: 500,
            height: 500,
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(8),
              itemCount: _players.length,
              prototypeItem: ListTile(
                title: Text(_players.first),
              ),
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  title: Text(_players[index]),
                ));
              },
            )),
        Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: myController,
                decoration:
                    const InputDecoration(helperText: "Enter a player name"),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(0)),
                onPressed: () {
                  setState(() {
                    _players.add(myController.text);
                  });
                },
                child:
                    const Icon(Icons.add_circle, color: Colors.black, size: 40))
          ],
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SeedPlayersWidget(players: _players)),
            );
          },
          child: const Text('Next'),
        )
      ],
    )));
  }
}
