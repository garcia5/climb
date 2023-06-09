import 'package:sqflite/sqflite.dart';
import 'package:climb/models/db.dart';
import 'package:climb/models/gym.dart';
import 'package:climb/models/attempt.dart';

class Session {
  Session({
    required this.id,
    required this.gymId,
    required this.startTime,
    this.endTime,
    this.notes,
  });

  final int id;
  final int gymId;
  DateTime startTime;
  DateTime? endTime;
  String? notes;

  /*
   * DB init
   */
  static const _table = 'sessions';
  static const _version = 1;

  static Future<void> _onCreate(Database db, int? version) async {
    await db.execute('''
        CREATE TABLE $_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        gym_id INTEGER,
        start_time TEXT,
        end_time TEXT,
        notes TEXT,
        CONSTRAINT fk_gyms
          FOREIGN KEY (gym_id)
            REFERENCES gyms(id)
        )
      ''');
  }

  static Future<Database> get database async {
    final db = await getDb(onCreate: _onCreate, version: _version);
    if (!await doesTableExist(db, _table)) {
      await _onCreate(db, _version);
    }
    return db;
  }
  /*
   * end DB init
   */

  /// Return plain map representation of a Session
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gym_id': gymId,
      'start_time': startTime,
      'end_time': endTime,
      'notes': notes,
    };
  }

  @override
  String toString() {
    return 'Session(id: $id, gymId: $gymId, startTime: ${startTime.toString()}, endTime: ${endTime?.toString()}, notes: $notes';
  }

  Future<Gym> get gym async {
    return await Gym.get(gymId);
  }

  Future<List<Attempt>> get attempts async {
    return await Attempt.getForSession(id);
  }

  static Future<Session> get(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> queryResult = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: ['id'],
      limit: 1,
    );
    final entry = queryResult[0];

    return Session(
      id: entry['id'],
      gymId: entry['gym_id'],
      startTime: DateTime.parse(entry['start_time']),
      endTime: DateTime.tryParse(entry['end_time']),
      notes: entry['notes'],
    );
  }

  static Future<List<Session>> list({int? gymId}) async {
    final db = await database;

    final List<Map<String, dynamic>> queryResult = gymId == null
        ? await db.query(
            _table,
          )
        : await db.query(_table, where: 'gym_id = ?', whereArgs: [gymId]);

    return List.generate(queryResult.length, (i) {
      final endTime = queryResult[i]['end_time'] != null
          ? DateTime.parse(queryResult[i]['end_time'])
          : null;
      return Session(
        id: queryResult[i]['id'],
        gymId: queryResult[i]['gym_id'],
        startTime: DateTime.parse(queryResult[i]['start_time']),
        endTime: endTime,
        notes: queryResult[i]['notes'],
      );
    });
  }

  /// Start a new session at a gym. Defaults startTime to DateTime.Now
  static Future<Session> start(int gymId, {DateTime? startTime}) async {
    final db = await database;

    final insertStartTime = (startTime ?? DateTime.now());

    final newId = await db.insert(_table,
        {'gym_id': gymId, 'start_time': insertStartTime.toIso8601String()});

    return Session(id: newId, gymId: gymId, startTime: insertStartTime);
  }

  /// Complete a session, defaults endTime to DateTime.Now
  Future<void> finish({DateTime? endTime, String? notes}) async {
    if (endTime != null) {
      this.endTime = endTime;
    } else {
      this.endTime = DateTime.now();
    }
    if (notes != null) this.notes = notes;

    await save();
  }

  Future<void> save() async {
    final db = await database;
    await db.update(_table, toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<void> delete() async {
    final db = await database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
