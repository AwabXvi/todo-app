import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/constants.dart';
import 'package:todo/controllers/baseController.dart';

class Utils {
  /// here u can add ur response success conditions
  static Future<dynamic> processResponse(
      {var response,
      required Function(dynamic data) onCompleted,
      required Function onError}) async {
    final BaseController baseController = Get.find();
    baseController.isLoading.value = false;
    if (response != null) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (json.decode(response.body).runtimeType == List<dynamic>) {
          final List<dynamic> data = json.decode(response.body);
          onCompleted.call(data);
        } else {
          final dynamic data = json.decode(response.body);
          onCompleted.call(data);
        }
      } else {
        /// here u can handle
        Get.snackbar('Error', 'Something went wrong ${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM,
            snackStyle: SnackStyle.FLOATING,
            backgroundColor: Constants.sweetRed,
            colorText: Colors.white);
      }
    } else {
      Get.snackbar('Error', 'Something went wrong ',
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Constants.sweetRed,
          colorText: Colors.white);

      onError.call();
    }
  }
}
