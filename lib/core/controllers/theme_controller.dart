import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController  {
  final storage = GetStorage();

  //change current theme
  Future<void> saveTheme(bool themeValue) async {
    if(themeValue == false) {
      await storage.write("theme", themeValue);
    } else {
      await storage.write("theme", themeValue);
    }
    update(); //  == notifyListeners();
  }
}
