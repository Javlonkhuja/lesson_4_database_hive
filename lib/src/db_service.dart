import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:lesson_4_database_hive/model/user_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveDbService<T> {
  static final box = Hive.openBox('_data');

  static void setup() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      if (kDebugMode) {
        print('DB INITED');
      }
      await Hive.openBox('_data');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<void> writeData({required User? user}) async {
    try {
      if ((await box).containsKey(user!.id)) {
        await delete(id: user.id);
      }
      await (await box).put('${user.id}', user);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (kDebugMode) {
      print("USER ADDED");
    }
  }

  static Future<User?> getDataUser({required String? id}) async {
    try {
      if (kDebugMode) {
        print('USER GET');
      }
      return (await box).get('$id');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<void> delete({required String? id}) async {
    return (await box).delete(id);
  }
}
