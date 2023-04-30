import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Gym {
  Gym({required this.id, required this.name, required this.address});

  final int id;
  final String name;
  final String? address;

  /*
   * DB init
   */
  static const _dbName = 'gyms.db';
  static const _table = 'gyms';
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
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
