import 'package:flutter/material.dart';
import '../main.dart';
import '../features/players/screens/players_page.dart';

class MainDrawer extends StatelessWidget {
  Color drawerColor = Color(int.parse('FF153158', radix: 16));
  Color drawerBackgroundColor = Color(int.parse('FF4a506a', radix: 16));

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: drawerBackgroundColor,
        child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
              decoration: BoxDecoration(color: drawerColor),
              child: const Text('MatchGen',
                  style: TextStyle(color: Colors.white70))),
          ListTile(
            tileColor: Color(int.parse('FF282A2C', radix: 16)),
              title:
                  const Text('Play', style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                              title: 'Home Page',
                            )));
              }),
          const SizedBox(height: 10),
          ListTile(
              tileColor: Color(int.parse('FF282A2C', radix: 16)),
              title: const Text('Players',
                  style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlayerPage()));
              }),
        ]));
  }
}
