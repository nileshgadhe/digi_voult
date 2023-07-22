

import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  //Mark:- Database
  static final _databasename = "voult.db";
  static final _databaseversion = 1;

  //Mark:- Crediential Table
  static final table = "crediential";
  static final columnID = "id";
  static final columnType = "type";
  static final columnTitle = "title";
  static final columnUsername = "username";
  static final columnPassword = "password";
  static final columnHint = "hint";

  //Mark:- Notes Table
  static final tableNote = "notes";
  static final columnIDNote = "id";
  static final columnTitleNote = "title";
  static final columnDetailsNote = "details";
  static final columnDateNote = "date";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initiateDatabase();
    }
    return _database!;
  }

  _initiateDatabase() async{
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return openDatabase(path, version: _databaseversion, onCreate: _create);
  }

  Future _create(Database db, int version) async{
    await db.execute('''
      CREATE TABLE $table(
        $columnID INTEGER PRIMARY KEY,
        $columnType TEXT NOT NULL,
        $columnTitle TEXT NOT NULL,
        $columnUsername TEXT NOT NULL,
        $columnPassword TEXT NOT NULL,
        $columnHint TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableNote(
        $columnIDNote INTEGER PRIMARY KEY,
        $columnTitleNote TEXT NOT NULL,
        $columnDetailsNote TEXT NOT NULL,
        $columnDateNote TEXT NOT NULL
      )
    ''');
  }

//function to oprate on crediential table
  Future<int> insertCrediential(Map<String, String> row) async{
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> fetchAllCrediential() async{
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> fetchSingleCrediential(int id) async{
    Database db = await instance.database;
    //var res = await db.query(table, where: "id = ?", whereArgs: [id]);
    var res = await db.rawQuery('SELECT * FROM my_table WHERE id = ?', [id]);
    return res;
  }

  Future<int> deleteCrediential(int id) async{
    Database db = await instance.database;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> updateCrediential(int id) async{
    Database db = await instance.database;
    var  res  = await db.update(table, {"name" : "Chetan", "age" : 10}, where: "id = ?", whereArgs: [id]);
    return res;
  }

  //function to oprate on notes table
  Future<int> insertNote(Map<String, String> row) async{
    Database db = await instance.database;
    return await db.insert(tableNote, row);
  }

  Future<List<Map<String, dynamic>>> fetchAllNotes() async{
    Database db = await instance.database;
    return await db.query(tableNote);
  }

  Future<int> deleteNote(int id) async{
    Database db = await instance.database;
    var res = await db.delete(tableNote, where: "id = ?", whereArgs: [id]);
    return res;
  }

}