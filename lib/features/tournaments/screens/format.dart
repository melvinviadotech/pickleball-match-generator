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
          margin: EdgeInsets.all(15.0),
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
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Set the radius here
                          ),
                        ),
                        child: const Column(children: <Widget>[
                          Text(
                            'Random',
                            style: TextStyle(fontSize: 24.0),
                          ),
                          Text('Random teams and opponents')
                        ]))),
                const SizedBox(height: 10),
                SizedBox(
                    width: 500.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Set the radius here
                        ),
                      ),
                      child: const Text(
                        'Placeholder Button',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
