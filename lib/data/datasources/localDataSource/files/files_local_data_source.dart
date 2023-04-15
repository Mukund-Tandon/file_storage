import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class FilesLocalDataSource {
  Future<void> updateRecentlyAccessed(Map<String, dynamic> jsonData);
  Map<String, dynamic>? getRecentlyAccessed();
}

class FilesLocalDataSourceImpl implements FilesLocalDataSource {
  final SharedPreferences sharedPreferences;
  FilesLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Map<String, dynamic>? getRecentlyAccessed() {
    var jsonData = sharedPreferences.getString('recentlyAccessed');
    if (jsonData == null) {
      return null;
    }
    print(jsonData);
    return jsonDecode(jsonData);
  }

  @override
  Future<void> updateRecentlyAccessed(Map<String, dynamic> jsonData) async {
    print(jsonData);
    await sharedPreferences.setString('recentlyAccessed', jsonEncode(jsonData));
  }
}
