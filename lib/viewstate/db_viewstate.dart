import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:polosystest/Service/DataBase/IDatabaseService.dart';
import 'package:polosystest/Service/services.dart';
import 'dart:io' as io;

import 'package:sqflite/sqflite.dart';

class DBViewState extends ChangeNotifier {
  late IDatabaseService databaseService;
  DBViewState() {
    databaseService = Services.databaseService;
  }
  Database? _databaseNow;
  Database? _database;
  Future<Database?> get database async {
    if (_database == null) {
      _database = await gettttt(folderName: "MyFolder", dbName: 'Accounts.db');
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database?> databseNow({String? folderName, String? dbName}) async {
    if (_databaseNow == null) {
      _databaseNow = await gettttt(folderName: "MyFolder", dbName: dbName);
      return _databaseNow;
    } else {
      return _databaseNow;
    }
  }

  Future gettttt({String? folderName, String? dbName}) async {
    return await _init(foldName: folderName, dbName: dbName);
  }

  Future<Database> _init({String? foldName, String? dbName}) async {
    await createFolder(folderName: foldName);
    var newPath1 = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    String? dbPath = join(newPath1, foldName, dbName);
    if (dbName == 'Accounts.db') {
      final db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
      return db;
    } else {
      final db = await openDatabase(dbPath, version: 1,onCreate: _onCreateOther);
      return db;
    }
  }

  Future createFolder({String? folderName}) async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.manageExternalStorage,
        Permission.accessMediaLocation,
        Permission.storage,
        Permission.camera
      ].request();
    } catch (e) {
      print(e.toString());
    }
    var newPath1 = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    if (await io.Directory('$newPath1/$folderName').exists()) {
      io.Directory('$newPath1/$folderName').createSync();
    } else {
      await io.Directory('$newPath1/$folderName').create();
    }
  }

  _onCreate(Database? db, int? version) async {
    version = 1;
    await db!.execute(_accounts);
  }
    _onCreateOther(Database? db, int? version) async {
    version = 1;
    await db!.execute(_users);
  }

////[-------------------Accounts.db Database--------------------------]
  final String _accounts = """ Create Table Accounts 
      ( 
        Id INTEGER PRIMARY KEY, 
        BusinessName Text , 
        ProductSerial Text , 
        ContactEmail Text ,
        IsDefault int,
        DatabaseName Text  
      )  """;
/////[-----------------------------------------------------------------]

  final String _users = """ Create Table Users 
    (
      UserID INTEGER PRIMARY KEY,
      UserName Text,
      Password Text,
      IsActive int
    ) """;

}
