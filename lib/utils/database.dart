import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/user.dart';

class DataBaseHelper {
  static final dbname = "info.db";
  static final tableName = "user";
  static final version = 1;

  static final columnId = "id";
  static final columnName = "name";
  static final columnEmail = "email";
  static final columnPassword = "password";
  static Database _database;

//  make singleton constructor
  DataBaseHelper._();

  static final DataBaseHelper dataBaseHelper = DataBaseHelper._();

  Future<Database> get database async {
    // print("call database");
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

//creating database
  initDb() async {
    // print("call init db");
    Directory directory = await getApplicationDocumentsDirectory();
    // print(directory);
    String path = join(directory.path, dbname);
    return await openDatabase(path, version: version, onCreate: _createTable);
  }

  Future _createTable(Database db, int version) async {
    // print("createtable");
    await db.execute('''CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnPassword TEXT NOT NULL)''');
  }

  Future<int> insert(Map<String, dynamic> map) async {
    // print("insert");
    Database db = await dataBaseHelper.database;
    return await db.insert(tableName, map);
  }

  Future<List<Map<String, dynamic>>> fetchAllData() async {
    Database database = await dataBaseHelper.database;
    return await database.query(tableName);
  }

  Future<int> update(User user) async {
    Database db = await this.database;
    var result = await db.update(tableName, user.toMapWithId(),
        where: '$columnId=?', whereArgs: [user.getId]);
    return result;
  }

  Future<List<User>> fetchAllUser() async {
    List<User> _list = List<User>();
    var user = await dataBaseHelper.fetchAllData();
    for (int i = 0; i < user.length; i++) {
      _list.add(User.fromJson(user[i]));
    }
    return _list;
  }

  Future<int> deleteUser(int id) async {
    Database db = await dataBaseHelper.database;
    var result =
        await db.delete(tableName, where: "$columnId=?", whereArgs: [id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> login(
      String email, String password) async {
    Database db = await dataBaseHelper.database;
    var result = await db.query(tableName,
        where: "$columnEmail=? AND $columnPassword=?",
        whereArgs: [email, password]);
    print(result);
    return result;
  }
}
