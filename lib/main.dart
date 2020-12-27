import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/constants/app_constants.dart';
import 'core/constants/route_constants.dart';
import 'core/services/navigation_service.dart';

void main() async {
  //initialize get storage
  await GetStorage.init();

  final storage = GetStorage();
  if (await storage.read(ApplicationConstants.APP_THEME) == null) {
    await storage.write(ApplicationConstants.APP_THEME, false);
  }

  //remove status bar
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(
    GetMaterialApp(
        defaultTransition: Transition.cupertino,
        getPages: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        initialRoute: RouteConstants.HOME_PAGE,
        theme: storage.read(ApplicationConstants.APP_THEME) == false
            ? ThemeData.light()
            : ThemeData.dark()),
  );
}
