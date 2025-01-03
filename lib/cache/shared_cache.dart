import 'package:shared_preferences/shared_preferences.dart';

enum SharedKeys { counter }

class SharedManager {
  SharedPreferences? preferences;
  SharedManager() {
    init();
  }

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveString(SharedKeys key, String value) async {
    await preferences?.setString(key.name, value);
  }

  Future<String?> getString(SharedKeys key) async {
    return preferences?.getString(key.name);
  }

  Future<void> saveStringList(SharedKeys key, List<String> value) async {
    await preferences?.setStringList(key.name, value);
  }

  List<String>? getStringList(SharedKeys key) {
    return preferences?.getStringList(key.name);
  }

  Future<bool> removeItem(SharedKeys key) async {
    return (await preferences?.remove(key.name)) ?? false;
  }
}
