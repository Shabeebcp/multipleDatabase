import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DatabaseContext {
  static Future gettttt({String? folderName, String? dbName}) async {
    return await _init(foldName: folderName, dbName: dbName);
  }

  static Future<Database> _init({String? foldName, String? dbName}) async {
    await createFolder(folderName: foldName);
    var newPath1 = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    String? dbPath = join(newPath1, foldName, dbName);
    if (dbName == 'Accounts.db') {
      final db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
      return db;
    } else {
      final db = await openDatabase(dbPath);
      return db;
    }
  }

  static Future createFolder({String? folderName}) async {
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

  static _onCreate(Database? db, int? version) async {
    version = 1;
    await db!.execute(_accounts);
  }

  static const String _accounts = """ Create Table Accounts 
      ( 
        Id INTEGER PRIMARY KEY, 
        BusinessName Text , 
        ProductSerial Text , 
        ContactEmail Text ,
        IsDefault int,
        DatabaseName Text  
      )  """;
}
