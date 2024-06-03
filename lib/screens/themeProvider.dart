import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class Themeprovider with ChangeNotifier {
  final box = GetStorage();
  bool isDark = true;

  void setTheme(bool isDarkMode) {
    isDark = isDarkMode;
    box.write("theme", isDarkMode);
    notifyListeners();
  }

  Future<void> getTheme() async {
    bool currentTheme = box.read("theme") ?? true;
    isDark = currentTheme;
    notifyListeners();
  }
}
