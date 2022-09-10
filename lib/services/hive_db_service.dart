import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/model_user.dart';

enum StorageKeys {
  users
}

class HiveService {
  static const String dbName = "AppData";

  static Future<void> setUsers(List<ModelUser> users) async {
    var box = Hive.box(dbName);
    List<Map<String, dynamic>> json = users.map((user) => user.toJson()).toList();
    box.put(StorageKeys.users.name, jsonEncode(json));
  }

  static List<ModelUser> readUsers() {
    var box = Hive.box(dbName);
    String data = box.get(StorageKeys.users.name, defaultValue: '[]');
    List json = jsonDecode(data);
    List<ModelUser> users = json.map((item) => ModelUser.fromJson(item)).toList();
    return users;
  }

  static Future<void> deleteAllUsers() async {
    var box = Hive.box(dbName);
    await box.clear();
  }
}
