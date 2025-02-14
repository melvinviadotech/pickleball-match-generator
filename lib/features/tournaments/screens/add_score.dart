import 'package:flutter/material.dart';

class AddScore extends StatelessWidget {
  final dynamic players;

  AddScore({super.key, required this.players});

  final firstScoreController = TextEditingController();
  final secondScoreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Score'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(""),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                Text(players[0]),
                Text(players[1]),
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
                Text(players[2]),
                Text(players[3]),
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
