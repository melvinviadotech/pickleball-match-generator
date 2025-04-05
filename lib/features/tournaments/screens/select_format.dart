import 'package:flutter/material.dart';
import 'create_round_robin.dart';

class RoundRobin extends StatelessWidget {
  const RoundRobin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Format'),
        ),
        body: Container(
          margin: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: 500.0,
                    height: 60.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateRoundRobin()),
                          );
                        },
                        child: const Text('Random')))
              ],
            ),
          ),
        ));
  }
}
