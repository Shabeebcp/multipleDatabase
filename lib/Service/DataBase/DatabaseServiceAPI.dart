import 'package:polosystest/Core/sharedPrefs.dart';
import 'package:polosystest/Model/accountsModel.dart';
import 'package:polosystest/Model/userModel.dart';
import 'package:polosystest/Service/DataBase/IDatabaseService.dart';
import 'package:polosystest/viewstate/db_viewstate.dart';

class DatabaseServiceApi implements IDatabaseService {
  @override
  insertNewDBInfo(AccountsModel? model) async {
    final db = await DBViewState().database;
    var res = await db!.insert('Accounts', model!.toJson());
    return res;
  }

  @override
  getAllDatabase() async {
    final db = await DBViewState().database;
    var res = await db!.rawQuery(""" Select * from Accounts""");
    return res;
  }

  @override
  setAsDefaultAccount(AccountsModel? model) async {
    final db = await DBViewState().database;
    model!.isDefault = 1;
    // var res = await db!.update('Accounts', model.toJson(),
    //     where: 'Id = ?', whereArgs: [model.id]);
    var res11 =
        await db!.rawUpdate("""Update Accounts Set IsDefault=0 Where Id>0""");
    if (res11 > 0) {
      var res = await db.rawUpdate(
          """Update Accounts Set IsDefault=1 Where Id=${model.id} """);
      return res;
    }
  }

  @override
  insertUserTable(UserModel? model) async {
    final db = await DBViewState().gettttt(folderName: 'MyFolder',dbName: SharedPrefs.openedDbName);
    var res = await db!.insert("Users", model!.toJson());
    return res;
  }
}
