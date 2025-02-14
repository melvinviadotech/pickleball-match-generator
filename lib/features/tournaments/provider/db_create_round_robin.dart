import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton pattern to ensure a single instance of the database
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the path to the database file
    String path = join(await getDatabasesPath(), 'app_database.db');
    print(path);
    // Open the database (or create it if it doesn't exist)
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create the table(s) in the database
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        players INTEGER,
        courts INTEGER
      )
    ''');
  }
}

class Robin {
  final int? id;
  final int players;
  final int courts;

  const Robin({
    required this.id,
    required this.players,
    required this.courts,
  });

  Map<String, Object?> toMap() {
    return {'id': id, 'players': players, 'courts': courts};
  }

  factory Robin.fromMap(Map<String, dynamic> map) {
    return Robin(
      id: map['id'],
      players: map['players'],
      courts: map['courts'],
    );
  }
}

void connect() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'app_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE robins(id INTEGER PRIMARY KEY, players INTEGER, courts INTEGER)');
    },
    version: 1,
  );
}

Future<void> insertRobin() async {
  final db = await DatabaseHelper().database;

  await db.insert(
    'robins',
    Robin(id: 0, players: 4, courts: 1).toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> robins() async {
  final db = await DatabaseHelper().database;

  final List<Map<String, Object?>> robinMaps = await db.query('robins');

  for (final {
        'id': id as int,
        'players': players as int,
        'courts': courts as int
      } in robinMaps) {
    print('$id, $players, $courts');
  }
}
