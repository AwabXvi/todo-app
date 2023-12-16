import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo/constants.dart';
import 'package:todo/controllers/baseController.dart';
import 'package:todo/network/endpoints.dart';

class Api {
  /// add you headers if it's required and we can have different headers depending on what we are calling.

  static const headers = {'Content-Type': 'application/json',};

  /// Before calling api u can add a check for rooted/ jailbroken and vpn and stop app if it's detected.
  static Future<dynamic> getTaskList() async {

    try {
      final http.Response response = await http.get(
          Uri.parse(getUrl()),
          headers: headers);
      return response;
    } catch (e) {
      rethrow;
      /// here u can catch exceptions
      /// and log them for network failures u can call your crash analysis to log
    }
    return null;
  }

  static Future<dynamic> addOrUpdateTask({var req, bool isEdit = false}) async {
    try {
      if (isEdit) {
        final http.Response response = await http.put(
            Uri.parse('${getUrl()}/${req['id']}'),
            body: json.encode(req),
            headers: headers);
        return response;
      } else {
        final http.Response response = await http.post(
            Uri.parse(getUrl()),
            body: json.encode(req),
            headers: headers);
        return response;
      }
    } catch (e) {
      rethrow;

      /// here u can catch exceptions
      /// and log them for network failures u can call your crash analysis to log
    }
    return null;
  }
  static Future<dynamic>deleteTask({var id,}) async {
    try {

        final http.Response response = await http.delete(
            Uri.parse('${getUrl()}/$id'),
            headers: headers);
        return response;
    } catch (e) {
      rethrow;
      /// here u can catch exceptions
      /// and log them for network failures u can call your crash analysis to log
    }
    return null;
  }
  static dynamic getUrl(){
    final BaseController baseController = Get.find();
    baseController.isLoading.value = true;
    return Constants.domainName + EndPoints.todos;
  }
}
