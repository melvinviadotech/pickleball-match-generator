import 'package:flutter/material.dart';
import '../services/database.dart';

class DatabaseControls extends StatelessWidget {
  DatabaseControls({super.key});

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Database Controls'),
        ),
        body: Center(
            child: Column(children: [
          // ElevatedButton(
          //     onPressed: () {
          //       _dbHelper.executeOne();
          //     },
          //     child: const Text('Execute')),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                _dbHelper.emptyAllTables();
              },
              child: const Text('Delete All Data'))
        ])));
  }
}
