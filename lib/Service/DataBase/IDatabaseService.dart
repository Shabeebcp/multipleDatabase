import 'package:polosystest/Model/accountsModel.dart';
import 'package:polosystest/Model/userModel.dart';

abstract class IDatabaseService {
  insertNewDBInfo(AccountsModel? model);
  getAllDatabase();
  setAsDefaultAccount(AccountsModel? model);

  ///[-------------------------------------]
  insertUserTable(UserModel? model);
}
