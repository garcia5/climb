import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final Map<String, Database> _nameInstanceMap = {};

Future<Database> getDb(String dbName,
    {Future<void> Function(Database, int?)? onCreate, int? version}) async {
  if (_nameInstanceMap[dbName] != null) return _nameInstanceMap[dbName]!;
  final db = await _initDb(dbName, version: version, onCreate: onCreate);
  _nameInstanceMap[dbName] = db;
  return db;
}

Future<Database> _initDb(String dbName,
    {int? version, Future<void> Function(Database, int?)? onCreate}) async {
  final path = join(await getDatabasesPath(), dbName);
  return await openDatabase(path, version: version, onCreate: onCreate);
}
