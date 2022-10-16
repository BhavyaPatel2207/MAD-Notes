import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database db;
  Future<Database> createDB() async {
    if (db == null) {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = join(dir.path, "user_notes");
      var db = await openDatabase(path, version: 1, onCreate: create_table);
      return db;
    }
    return db;
  }

  create_table(Database db, int version) async {
    db.execute(
        "CREATE TABLE NOTES(PID INTEGER PRIMARY KEY,TITLE TEXT,DESC TEXT)");
    print("Table Created");
  }

  Future<int> addNote(title, description) async {
    var db = await createDB();
    var id = await db.rawInsert(
        "INSERT INTO NOTES (TITLE,DESC) values(?,?)", [title, description]);
    return id;
  }

  Future<List> singleNote(pid) async {
    var db = await createDB();
    var data = await db.rawQuery("SELECT * FROM NOTES WHERE PID= ?", [pid]);
    return data.toList();
  }

  Future<List> getNotes() async {
    var db = await createDB();
    var data = await db.rawQuery("SELECT * FROM NOTES");
    return data.toList();
  }

  Future<int> deleteproducts(pid) async {
    var db = await createDB();
    var id = await db.rawDelete("DELETE FROM NOTES WHERE PID=?", [pid]);
    return id;
  }

  Future<int> updateNote(title, desc, pid) async {
    var db = await createDB();
    var id = db.rawUpdate(
        "UPDATE NOTES SET TITLE = ?, DESC = ? WHERE PID = ?", [title, desc,pid]);
    return id;
  }
}
