import 'package:get/get.dart';
import 'package:stm_mobile_new/viewmodel/controllers/bluetoothController.dart';

class bluettothBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<bluetoothController>(bluetoothController());
  }

}