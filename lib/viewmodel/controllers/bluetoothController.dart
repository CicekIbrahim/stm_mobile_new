import 'dart:convert';
import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';

import 'package:get/get.dart';
import 'package:stm_mobile_new/views/services/IBtService.dart';

class bluetoothController extends GetxController {
  final IBtService service;
  bluetoothController(this.service);
  var data = "".obs;
  var devicesList = [].obs;
  BluetoothDevice? device;
  BluetoothCharacteristic? characteristic;
  List<BluetoothService> btServiceList = <BluetoothService>[];

  readData() async {
   await characteristic?.setNotifyValue(true);
    characteristic!.value.listen((value) {
      var result = String.fromCharCodes(value);
   
        data.value=result;
        print(result);
      
    });
  }

  bindDevice() async {
    device = devicesList.value[0].device;
  }

  connectDevice() async {
    await device!.connect();
  }

  disconnectDevice() async {
    await device!.disconnect();
  }

  bindCharacteristic() async {
    await connectDevice();
    await listenService();
    await getCharacteristic();
    await readData();
  }

  listenService() async {
    btServiceList = await device!.discoverServices();
  }

  getCharacteristic() {
    for (var element in btServiceList) {
      if (element.uuid.toString() == "0000ffe0-0000-1000-8000-00805f9b34fb") {
        for (var element in element.characteristics) {
          characteristic = element;
          inspect(characteristic);
        }
      }
    }
  }

  toggleLed(String value) async {
    await characteristic?.write(utf8.encode(value), withoutResponse: true);
  }

  startScan() {
    FlutterBlue.instance.startScan(timeout: const Duration(seconds: 4));
  }
}
