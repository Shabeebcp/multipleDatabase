import 'package:polosystest/Service/DataBase/DatabaseService.dart';
import 'package:polosystest/Service/DataBase/DatabaseServiceAPI.dart';
import 'package:polosystest/Service/DataBase/IDatabaseService.dart';

class Services {
  static IDatabaseService get databaseService {
    return DatabaseService(DatabaseServiceApi());
  }
}
