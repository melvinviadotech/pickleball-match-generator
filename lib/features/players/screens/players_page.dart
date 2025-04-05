import 'package:flutter/material.dart';
import '../../../widgets/main_drawer.dart';

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
          margin: const EdgeInsets.all(15.0),
          child: Center(child: const Text('Player List')),
        ));
  }
}
