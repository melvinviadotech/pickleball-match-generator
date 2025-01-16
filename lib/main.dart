import 'package:flutter/material.dart';
import 'format.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Robin Tool',
      home: MyHomePage(title: 'Create a session'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
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
                        borderRadius:
                            BorderRadius.circular(10), // Set the radius here
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
