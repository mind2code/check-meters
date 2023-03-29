

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/data_local.dart';

class DatabaseHelper {
  static final _databaseName = "meters_checker.db";
  static final _databaseVersion = 1;
  static final table = "compteurs";

  static final columnData = "data";
  static final columnId = "id";
  static final columnSync = "sync";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(path, version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnData TEXT NOT NULL,
      $columnSync INTEGER
    )
    ''');
  }


  Future<int> insert(LocalData localData) async {
    Database db = await instance.database;
    var res = await db.insert(table, localData.toJson());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllNotSynchronized() async {
    Database db = await instance.database;
    var res = await db.query(table,
        where: "$columnSync = ?",
        whereArgs: [0],
        orderBy: "$columnId DESC");
    return res;
  }

  remove(int id) async {
    Database db = await instance.database;
    var res = await db.delete(table,
      where: "$columnId = ?",
      whereArgs: [id]
    );
  }

}