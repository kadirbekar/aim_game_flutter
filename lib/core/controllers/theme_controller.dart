import 'package:aim_master/core/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final storage = GetStorage();

  //change current theme
  Future<void> saveTheme(bool themeValue) async {
    await storage.write(ApplicationConstants.APP_THEME, themeValue);
    update(); //  == notifyListeners();
  }
}
