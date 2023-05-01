import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const _dbName = 'my-climbs.db';
Database? _database;

Future<Database> getDb(
    {Future<void> Function(Database, int?)? onCreate, int? version}) async {
  if (_database != null) return _database!;
  _database = await _initDb(version: version, onCreate: onCreate);
  return _database!;
}

Future<Database> _initDb(
    {int? version, Future<void> Function(Database, int?)? onCreate}) async {
  final path = join(await getDatabasesPath(), _dbName);
  return await openDatabase(path, version: version, onCreate: onCreate);
}
