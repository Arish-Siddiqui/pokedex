import 'package:hive/hive.dart';

class AppLocalPrefs {
  final String boxName;
  late Box box;

  AppLocalPrefs(this.boxName);

  /// Initialize the box
  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      box = await Hive.openBox(boxName);
    } else {
      box = Hive.box(boxName);
    }
  }

  /// Create or Update by ID
  Future<void> createOrUpdate(String id, Map<String, dynamic> data) async {
    await box.put(id, data);
  }

  /// Read by ID
  Map<String, dynamic>? read(String id) {
    final data = box.get(id);
    return data != null ? Map<String, dynamic>.from(data) : null;
  }

  /// Read all records
  Map<dynamic, dynamic> readAll() {
    return box.toMap();
  }

  /// Delete by ID
  Future<void> delete(String id) async {
    await box.delete(id);
  }

  /// Delete all records
  Future<void> deleteAll() async {
    await box.clear();
  }
}
