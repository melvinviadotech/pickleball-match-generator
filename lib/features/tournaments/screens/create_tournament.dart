import 'package:flutter/material.dart';
import '../../../widgets/main_drawer.dart';
import 'format.dart';

class TournamentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
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
                                builder: (context) => const RoundRobin()),
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
                            'Round Robin',
                            style: TextStyle(fontSize: 24.0),
                          ),
                          Text('Generate matchups, add scores and see who wins')
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
