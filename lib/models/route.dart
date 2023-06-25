import 'package:sqflite/sqflite.dart';
import 'package:climb/models/db.dart';
import 'package:climb/models/gym.dart';
import 'package:climb/models/attempt.dart';

class Route {
  Route({
    required this.id,
    required this.gymId,
    this.name,
    this.notes,
    this.sent,
  });

  final int id;
  int gymId;
  String? name;
  String? notes;
  bool? sent;

  Future<Gym> get gym async {
    return await Gym.get(gymId);
  }

  Future<List<Attempt>> get attempts async {
    return await Attempt.getForRoute(id);
  }

  /*
   * DB init
   */
  static const _table = 'routes';
  static const _version = 1;

  static Future<Database> get database async {
    final db = await getDb(onCreate: _onCreate, version: _version);
    if (!await doesTableExist(db, _table)) {
      await _onCreate(db, _version);
    }
    return db;
  }

  static Future<void> _onCreate(Database db, int? version) async {
    await db.execute('''
        CREATE TABLE $_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        gym_id INTEGER NOT NULL,
        name TEXT,
        notes TEXT,
        sent BOOLEAN DEFAULT FALSE,
        CONSTRAINT fk_gyms
          FOREIGN KEY(gym_id)
            REFERENCES gyms(id),
        )
      ''');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gym_id': gymId,
      'name': name,
      'notes': notes,
      'sent': sent,
    };
  }
}
