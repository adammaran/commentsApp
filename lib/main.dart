import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:q_agency_test/app/constants/build_config.dart';

import 'app/routes/app_pages.dart';

void main() async {
  BuildConfig.setEnvironment(Environment.prod);
  runApp(
    GetMaterialApp(
      title: BuildConfig.appState,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner:
          BuildConfig.environment == 'dev' ? true : false,
    ),
  );
}
