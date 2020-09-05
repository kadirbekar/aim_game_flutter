import 'package:aim_master/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'core/constants/route_constants.dart';
import 'core/services/navigation_service.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
  
  runApp(
    GetMaterialApp(
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteConstants.HOME_PAGE,
      theme: ThemeData(
        fontFamily: ApplicationConstants.DEFAULT_FONT_FAMILY
      ),
    ),
  );
}
