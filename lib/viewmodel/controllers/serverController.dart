import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:stm_mobile_new/core/constants/text.dart';

class ServerController extends GetxController {
  var dio = Dio();
  sendData(int data)async {
    var response =  await dio.post(AppConstatns.baseUrl, data: {'Number': data});
    inspect(response.data);
  }
}
