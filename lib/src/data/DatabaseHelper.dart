import 'dart:io';
import 'package:flutter_task/src/models/UserModel.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;
  final String tableUser = "User";
  final String columnName = "name";
  final String columnEmail = "email";
  final String columnPassword = "password";
  final String columnNumber = "number";
  final String columnImage = "image";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT, "
            "number TEXT, image TEXT, flaglogged TEXT)");
  }

  //insertion
  Future<int> saveUser(UserModel user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    print(list);
    return res;
  }

  //deletion
  Future<int> deleteUser(UserModel user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }
  Future<UserModel> selectUser(UserModel user) async{
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnEmail, columnPassword],
        where: "$columnEmail = ? and $columnPassword = ?",
        whereArgs: [user.email,user.password]);
    print(maps);
    if (maps.length > 0) {
      print("User Exist !!!");
      return user;
    }else {
      return null;
    }
  }

  Future<UserModel> getUserDetails(String email)async{
    var database = await _db;
    UserModel user = new UserModel();
    List<Map<String, dynamic>> map =
    await database.query(tableUser, where: "$columnEmail = ?", whereArgs: [email]);
    List<UserModel> userList = new List();

    print(map);
    for(Map m in map){
      userList.add(UserModel.map(m));
    }

    if(userList.length==1){
      user = userList.elementAt(0);
    }
    return user;
  }
}
