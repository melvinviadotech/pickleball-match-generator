import 'package:flutter/material.dart';
import 'add_players.dart';

class RoundRobin extends StatelessWidget {
  const RoundRobin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Format'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 500.0,
                height: 60.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Text('Singles'))),
                      ElevatedButton(
                          onPressed: () {},
                          child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Text('Doubles'))),
                    ])),
            SizedBox(
                width: 500.0,
                height: 60.0,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPlayers()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set the radius here
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
                    'Tournament Bracket',
                    style: TextStyle(fontSize: 24.0),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
