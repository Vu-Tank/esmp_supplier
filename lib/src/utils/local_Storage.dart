import 'dart:html';

class LocalStorage {
  static Storage localStorage = window.localStorage;
  static void saveValue(String key, String value) {
    localStorage[key] = value;
  }

  static String? getValue(String key) {
    return localStorage[key];
  }

  static void clearAll() {
    localStorage.clear();
  }
}
