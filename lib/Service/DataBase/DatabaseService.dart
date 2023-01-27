import 'package:polosystest/Model/accountsModel.dart';
import 'package:polosystest/Model/userModel.dart';
import 'package:polosystest/Service/DataBase/IDatabaseService.dart';

class DatabaseService implements IDatabaseService {
  late IDatabaseService service;
  DatabaseService(IDatabaseService _service) {
    service = _service;
  }

  @override
  insertNewDBInfo(AccountsModel? model) async {
    var res = await service.insertNewDBInfo(model);
    if (res > 0) {
      return true;
    } else
      false;
  }

  @override
  getAllDatabase() async {
    List<AccountsModel> accModel = List<AccountsModel>.empty(growable: true);
    var res = await service.getAllDatabase();
    if (res.isNotEmpty) {
      List.generate(res.length, (index) {
        accModel.add(AccountsModel.fromJson(res[index]));
      });
      return accModel;
    }
    return accModel;
  }

  @override
  setAsDefaultAccount(AccountsModel? model) async {
    var res = await service.setAsDefaultAccount(model);
    if (res > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  insertUserTable(UserModel? model) async {
    var res = await service.insertUserTable(model);
    if (res > 0) {
      return true;
    } else {
      return false;
    }
  }
}
