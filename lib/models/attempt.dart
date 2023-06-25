import 'package:sqflite/sqflite.dart';
import 'package:climb/models/db.dart';
import 'package:climb/models/gym.dart';
import 'package:climb/models/session.dart';

class Attempt {
  Attempt({
    required this.id,
    required this.gymId,
    required this.sessionId,
    this.notes,
    this.routeId,
    this.sent,
  });

  final int id;
  int sessionId;
  int gymId;
  String? notes;
  int? routeId;
  bool? sent = false;

  Future<Gym> get gym async {
    return await Gym.get(gymId);
  }

  Future<Session> get session async {
    return await Session.get(sessionId);
  }

  /*
   * DB init
   */
  static const _table = 'attempts';
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
        session_id INTEGER NOT NULL,
        notes TEXT,
        route_id INTEGER,
        sent BOOLEAN DEFAULT FALSE,
        CONSTRAINT fk_gyms
          FOREIGN KEY(gym_id)
            REFERENCES gyms(id),
        CONSTRAINT fk_sessions
          FOREIGN KEY(session_id)
            REFERENCES sessions(id),
        CONSTRAINT fk_routes
          FOREIGN KEY(route_id)
            REFERENCES routes(id)
        )
      ''');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gym_id': gymId,
      'session_id': sessionId,
      'notes': notes,
      'route_id': routeId,
      'sent': sent,
    };
  }

  static Attempt fromDb(Map<String, dynamic> entry) {
    return Attempt(
      id: entry['id'],
      gymId: entry['gym_id'],
      sessionId: entry['session_id'],
      notes: entry['notes'],
      routeId: entry['route_id'],
      sent: entry['sent'],
    );
  }

  static Future<List<Attempt>> getForSession(int sessionId) async {
    final db = await database;

    final List<Map<String, dynamic>> queryResult =
        await db.query(_table, where: 'session_id = ?', whereArgs: [sessionId]);

    return List.generate(queryResult.length, (i) {
      return Attempt.fromDb(queryResult[i]);
    });
  }

  static Future<List<Attempt>> getForRoute(int routeId) async {
    final db = await database;

    final List<Map<String, dynamic>> queryResult =
        await db.query(_table, where: 'route_id = ?', whereArgs: [routeId]);

    return List.generate(queryResult.length, (i) {
      return Attempt.fromDb(queryResult[i]);
    });
  }
}
