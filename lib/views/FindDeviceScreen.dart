import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:stm_mobile_new/viewmodel/controllers/bluetoothController.dart';
import 'package:stm_mobile_new/viewmodel/controllers/serverController.dart';

import '../core/widgets/appbar.dart';

class FindDeviceScreen extends StatefulWidget {
  const FindDeviceScreen({Key? key}) : super(key: key);

  @override
  State<FindDeviceScreen> createState() => _FindDeviceScreenState();
}

final btController = Get.find<bluetoothController>();

final serverController = Get.find<ServerController>();
class _FindDeviceScreenState extends State<FindDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("StmMobile"),
      floatingActionButton: floatingactionbutton(),
      body: StreamBuilder<List<ScanResult>>(
          stream: FlutterBlue.instance.scanResults,
          initialData: const [],
          builder: (context, snapshot) {
            List<ScanResult> list = [];
            for (var element in snapshot.data!) {
              if (element.device.id.toString() == "50:65:83:76:0C:B2") {
                list.add(element);
                btController.devicesList.add(element);
              }
            }
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  btController.devicesList.value = list;
                  return Column(
                    children: [
                      ListTile(
                          title: Text(list[index].device.name.toString()),
                          subtitle: Text(list[index].device.id.toString()),
                          trailing: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                            child: const Text("Connect"),
                            onPressed: () {
                              btController.bindDevice();
                              btController.disconnectDevice();
                              btController.bindCharacteristic();
                              
                              Get.toNamed("/dataRead");
                            },
                          ),
                          leading: _avatar())
                    ],
                  );
                });
          }),
    );
  }

  _avatar() {
    return AvatarGlow(
      duration: const Duration(microseconds: 1000000),
      animate: true,
      showTwoGlows: true,
      glowColor: Colors.black,
      endRadius: 30,
      child: Image.network(
          "https://res.cloudinary.com/dinqa9wqr/image/upload/v1671004697/images-removebg-preview_1_nv5xsb.png"),
    );
  }

  StreamBuilder<bool> floatingactionbutton() {
    return StreamBuilder<bool>(
      stream: FlutterBlue.instance.isScanning,
      initialData: false,
      builder: (c, snapshot) {
        if (snapshot.data!) {
          return FloatingActionButton(
            onPressed: () => FlutterBlue.instance.stopScan(),
            backgroundColor: Colors.red,
            child: const Icon(Icons.stop),
          );
        } else {
          return FloatingActionButton(
              backgroundColor: Colors.black,
              child: const Icon(Icons.search),
              onPressed: () {
                FlutterBlue.instance
                    .startScan(timeout: const Duration(seconds: 4));
              });
        }
      },
    );
  }
}
