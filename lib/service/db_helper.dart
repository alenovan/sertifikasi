import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:softwaresertifikasi/service/database.query/CashFlow.dart';
import 'package:softwaresertifikasi/service/database.query/UserQuery.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sqflite.dart';
class DbHelper {
  //membuat method singleton
  static DbHelper _dbHelper = DbHelper._singleton();

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._singleton();

  //baris terakhir singleton

  final tables = [
    UserQuery.CREATE_TABLE,
    CashFlowQuery.CREATE_TABLE
  ]; // membuat daftar table yang akan dibuat

  Future<Database> openDB() async {
    final dbPath = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(path.join(dbPath, 'sertifikasi.db'),
        onCreate: (db, version) {
          tables.forEach((table) async {
            await db.execute(table).then((value) {
              print("success");
              return "berhasil";
            }).catchError((err) {
              print("errornya ${err.toString()}");
              return err.toString();
            });
          });
          print('Table Created');
        }, version: 1);
  }

  Future<dynamic>  insert(String table, Map<String, Object> data) async {
    final datax = openDB().then((db) {
      db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
    }).catchError((err) {
      print("error $err");
    });
    return datax;
  }
  Future<dynamic>  update(String table, Map<String, Object> data,int id) async {
    final datax = openDB().then((db) {
      db.update(table, data, where: 'id = ?', whereArgs: [id]);
    }).catchError((err) {
      print("error $err");
    });
    return datax;
  }


  Future<List> getData(String tableName) async {
    final db = await openDB();
    var result = await db.query(tableName);
    return result.toList();
  }

  Future<List> getDataSingleUsername(String tableName,String Param) async {
    final db = await openDB();
    var result = await db.query(tableName,where: 'name = ?', whereArgs: [Param]);
    return result.toList();
  }

  Future<List> getDataSingleUser(String tableName,String Param) async {
    final db = await openDB();
    var result = await db.query(tableName,where: 'password = ?', whereArgs: [Param]);
    return result.toList();
  }

  Future<List> postLogin(String tableName,String Param,String Param2) async {
    final db = await openDB();
    var result = await db.query(tableName,where: 'password = "$Param" and name = "$Param2"');
    debugPrint(result.toString());
    return result.toList();
  }
}