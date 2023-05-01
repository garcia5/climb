import 'package:sqflite/sqflite.dart';
import 'package:climb/models/db.dart';

class Gym {
  Gym({required this.id, required this.name, required this.address});

  final int id;
  String name;
  String? address;

  /*
   * DB init
   */
  static const _dbName = 'gyms.db';
  static const _table = 'gyms';
  static const _version = 1;

  static Future<Database> get database async {
    return await getDb(_dbName, onCreate: _onCreate, version: _version);
  }

  static Future<void> _onCreate(Database db, int? version) async {
    await db.execute('''
        CREATE TABLE $_table (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        address TEXT
        )
      ''');
  }

  static Future<Gym> create(String name, String? address) async {
    final db = await database;

    final newId = await db.insert(_table, {'name': name, 'address': address});
    return Gym(id: newId, name: name, address: address);
  }
  /*
   * end DB init
   */

  static Future<Gym> get(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> queryResult = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: ['id'],
      limit: 1,
    );

    final entry = queryResult[0];

    return Gym(id: entry['id'], name: entry['name'], address: entry['address']);
  }

  static Future<List<Gym>> all() async {
    final db = await database;

    final List<Map<String, dynamic>> queryResult = await db.query(
      _table,
    );

    return List.generate(queryResult.length, (i) {
      return Gym(
          id: queryResult[i]['id'],
          name: queryResult[i]['name'],
          address: queryResult[i]['address']);
    });
  }

  save() async {
    final db = await database;

    await db.update(_table, {'name': name, 'address': address},
        where: 'id = ?', whereArgs: [id]);
  }

  delete() async {
    final db = await database;

    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'Gym(id: $id, name: $name, address: $address)';
  }
}
