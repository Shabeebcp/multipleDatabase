import 'package:flutter/material.dart';
import 'package:polosystest/Core/sharedPrefs.dart';
import 'package:polosystest/Model/accountsModel.dart';
import 'package:polosystest/Model/userModel.dart';
import 'package:polosystest/Service/DataBase/IDatabaseService.dart';
import 'package:polosystest/Service/services.dart';
import 'package:polosystest/viewstate/db_viewstate.dart';

class MainState extends ChangeNotifier {
  String? test1;
  TextEditingController txtbusinessName = TextEditingController();
  TextEditingController txtproductSerial = TextEditingController();
  TextEditingController txtcontactEmail = TextEditingController();
  TextEditingController txtdatabaseName = TextEditingController();
  FocusNode fcsbusinessName = FocusNode();
  FocusNode fcsproductSerial = FocusNode();
  FocusNode fcscontactEmail = FocusNode();
  FocusNode fcsdatabaseName = FocusNode();
  List<AccountsModel> accModel = List<AccountsModel>.empty(growable: true);

  late IDatabaseService databaseService;
  MainState() {
    DBViewState().database;
    SharedPrefs.readLocalCache();
    databaseService = Services.databaseService;
  }

  Future insertNewDatas() async {
    AccountsModel model = AccountsModel();
    model.businessName = txtbusinessName.text;
    model.productSerial = txtproductSerial.text;
    model.contactEmail = txtcontactEmail.text;
    model.databaseName = txtdatabaseName.text;

    bool? result = await databaseService.insertNewDBInfo(model);
    if (result!) {
      await createDbIfNotExist(model);
      return true;
    } else {
      return false;
    }
  }

  Future getAllDatabase() async {
    var res = await databaseService.getAllDatabase();
    if (res.isNotEmpty) {
      accModel = res;
      notifyListeners();
    } else {
      [];
      notifyListeners();
    }
  }

  Future setAsDefaultAccount(AccountsModel? model) async {
    try {
      var res = await databaseService.setAsDefaultAccount(model);
      await getAllDatabase();
      notifyListeners();
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  Future createDbIfNotExist(AccountsModel? model) async {
    String? dbName = '${model!.databaseName}.db';
    await DBViewState().databseNow(dbName: dbName);
    SharedPrefs.openedDbName = dbName;
    await SharedPrefs.writeLocalCache();
    await SharedPrefs.readLocalCache();
    notifyListeners();
  }

  Future insertUserToDefaultDatabase() async {
    UserModel model = UserModel();
    model.userName = txtbusinessName.text;
    model.password = txtproductSerial.text;
    model.isActive = 1;
    model.userId =1;

    bool? result = await databaseService.insertUserTable(model);
    if (result!) {
      // await createDbIfNotExist(model);
      return true;
    } else {
      return false;
    }
  }




}
