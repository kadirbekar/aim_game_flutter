import 'package:get/get.dart';

import '../../ui/views/game_page.dart';
import '../../ui/views/home_page.dart';
import '../constants/route_constants.dart';

class AppRoutes {
  
  static AppRoutes _instance = AppRoutes._init();
  static AppRoutes get instance => _instance;

  static final routes = [
    GetPage(name: RouteConstants.HOME_PAGE, page: () => HomePage()),
    GetPage(name: RouteConstants.GAME_PAGE, page: () => GamePage())
  ];

  AppRoutes._init();
}
