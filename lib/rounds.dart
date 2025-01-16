import 'package:flutter/material.dart';

class RoundsWidget extends StatefulWidget {
  const RoundsWidget({super.key, required this.players});

  final dynamic players;

  @override
  State<RoundsWidget> createState() => _RoundsWidgetState();
}

class _RoundsWidgetState extends State<RoundsWidget> {
  final _playerList = ['melvin', 'marl', 'viado', 'player'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Format'),
        ),
        body: Center(
            child: Column(
          children: [
            Text(
              'Court 1',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
            SizedBox(
                width: 1000,
                child: Row(
                  children: [
                    Column(
                        children: [Text(_playerList[0]), Text(_playerList[1])]),
                    Column(
                        children: [Text(_playerList[2]), Text(_playerList[3])])
                  ],
                ))
          ],
        )));
  }
}
