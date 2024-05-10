import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _prefs;

  Future<void> connectToInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> getBoolValue(String localVariableName) async {

    await connectToInstance();

    bool? value = _prefs.getBool(localVariableName);

    return value ?? true;
  }

  Future<void> setBoolValue(String localVariableName, bool newValue) async {

    await connectToInstance();

    _prefs.setBool(localVariableName, newValue);
  }

  Future<int?> getIntegerValue(String localVariableName) async {

    await connectToInstance();

    int? value = _prefs.getInt(localVariableName);

    return value;
  }

  Future<void> setIntegerValue(String localVariableName, int newValue) async {

    await connectToInstance();

    _prefs.setInt(localVariableName, newValue);
  }

  Future<String?> getStringValue(String localVariableName) async {

    await connectToInstance();

    String? value = _prefs.getString(localVariableName);

    return value;
  }

  Future<void> setStringValue(String localVariableName, String newValue) async {

    await connectToInstance();

    _prefs.setString(localVariableName, newValue);
  }
}
