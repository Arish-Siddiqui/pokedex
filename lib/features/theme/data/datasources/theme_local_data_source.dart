import '../../../../config/local_storage/app_local_prefs.dart';
import '../../../../core/constants/app_constants.dart';

abstract class ThemeLocalDataSource {
  Future<void> updateUserData(Map<String, dynamic> userData);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final AppLocalPrefs userDBPref;
  ThemeLocalDataSourceImpl({required this.userDBPref});

  @override
  Future<void> updateUserData(Map<String, dynamic> userData) async {
    final Map<dynamic, dynamic> storedData = userDBPref.readAll();
    Map<String, dynamic> storedUserData = Map<String, dynamic>.from(
      storedData[userDataKey] ?? {},
    );
    storedUserData.addAll(userData);
    await userDBPref.createOrUpdate(userDataKey, storedUserData);
  }
}
