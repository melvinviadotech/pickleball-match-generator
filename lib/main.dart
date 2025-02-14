import 'package:flutter/material.dart';
import 'features/tournaments/screens/create_tournament.dart';
import 'widgets/main_drawer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Color(121212),
                  foregroundColor: Colors.black))),
      title: 'Robin Tool',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Create a session'),
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
        drawer: MainDrawer(),
        body: TournamentsPage());
  }
}

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Player List'),
        ),
        drawer: MainDrawer(),
        body: Container(
          margin: EdgeInsets.all(15.0),
          child: Center(child: const Text('Player List')),
        ));
  }
}
