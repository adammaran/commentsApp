import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/strings.dart';

class Dialogs {

  static showOsDialog(String leadingText, String text){
    if(Platform.isIOS) {
      showDialog(
          context: Get.context!,
          builder: (BuildContext context) =>
              CupertinoAlertDialog(
                title: Text(leadingText),
                content: Text(text),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(AppStrings.done))
                ],
              ));
    }
    else if(Platform.isAndroid){
      showDialog(
          context: Get.context!,
          builder: (BuildContext context) =>
              AlertDialog(
                title: Text(leadingText),
                content: Text(text),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(AppStrings.done))
                ],
              ));
    }
  }
}
