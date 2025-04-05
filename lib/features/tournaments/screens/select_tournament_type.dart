import 'package:flutter/material.dart';
import '../../../widgets/main_drawer.dart';
import 'select_format.dart';
import 'select_existing_tournament.dart';
import 'database_controls.dart';

class SelectTournamentType extends StatelessWidget {
  const SelectTournamentType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        body: Container(
          margin: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TournamentSelector()),
                      );
                    },
                    child: const Text('Resume Existing Tournament')),
                const SizedBox(height: 5),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RoundRobin()),
                      );
                    },
                    child: const Text(
                      'Round Robin',
                    )),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DatabaseControls()),
                    );
                  },
                  child: const Text('Database Controls'),
                ),
              ],
            ),
          ),
        ));
  }
}
