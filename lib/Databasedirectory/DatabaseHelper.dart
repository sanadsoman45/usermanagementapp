import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stepperdemo/Model/datamodel.dart';

class DatabaseHelper{
  static final _databasename="persons.db";
  static final _databaseversion=1;
  static final table="persons_table";

  static final column_id="id";
  static final column_f_name="f_name";
  static final column_l_name="l_name";
  static final column_address="address";
  static final column_pincode="pincode";
  static final column_mob_num="mob_num";

  static Database _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async{
    if(_database!=null){
      return _database;
    }
    else{
      _database=await _initDatabase();
      return _database;
    }
  }

  _initDatabase() async{
    Directory documentsdirectory = await getApplicationDocumentsDirectory();
    debugPrint("dblocation${documentsdirectory.path}");
    String path=join(documentsdirectory.path,_databasename);
    return await openDatabase(path,version: _databaseversion,onCreate: _onCreate);
  }


  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
    $column_id INTEGER PRIMARY KEY AUTOINCREMENT,
    $column_f_name TEXT NOT NULL,
    $column_l_name TEXT NOT NULL,
    $column_address TEXT NOT NULL,
    $column_pincode TEXT NOT NULL,
    $column_mob_num TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertcontact(datamodel dm) async{
    Database db = await database;
    return await db.insert(table, dm.tomap());
  }

  fetchdetails() async{
    Database db = await database;
    var res = await db.query(table);
    List<datamodel> list = res.isNotEmpty ? res.map((c) => datamodel.frommap(c)).toList() : [];
    return list;
  }

  Future<int> deleteContact(String mob_num)async{
    Database db = await database;
    return await db.delete(table,where: '${column_mob_num}=?',whereArgs: [mob_num]);
  }

  getmob_num(String mob_num) async{
    debugPrint("mobile number from database is:$mob_num");
    final Database db= await database;
    var res = await db.query(table,where: "$column_mob_num=?",whereArgs: [mob_num]);
    debugPrint("${res[0]}");
    return res.isNotEmpty ? datamodel.frommap(res.first):Null;
  }


  Future<int> updateContact(datamodel dm,String mobile_num)async{
    Database db = await database;
    return await db.update(table,dm.tomap(),where: '${column_mob_num}=?',whereArgs: [mobile_num]);
  }


}