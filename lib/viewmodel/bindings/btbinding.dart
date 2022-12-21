import 'package:get/get.dart';
import 'package:stm_mobile_new/viewmodel/controllers/bluetoothController.dart';
import 'package:stm_mobile_new/viewmodel/controllers/serverController.dart';
import 'package:stm_mobile_new/views/services/BtService.dart';

class bluettothBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<bluetoothController>(bluetoothController(BtService()));
    Get.put<ServerController>(ServerController());
  }
}