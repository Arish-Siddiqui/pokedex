import '../../../../config/local_storage/app_local_prefs.dart';
import '../../../../core/constants/app_constants.dart';

abstract class SplashLocalDataSource {
  Map<dynamic, dynamic> getUserData();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final AppLocalPrefs userDBPref;
  SplashLocalDataSourceImpl({required this.userDBPref});

  @override
  Map<dynamic, dynamic> getUserData() {
    final Map<dynamic, dynamic> userData = userDBPref.readAll();
    return userData[userDataKey] ?? <dynamic, dynamic>{};
  }
}
