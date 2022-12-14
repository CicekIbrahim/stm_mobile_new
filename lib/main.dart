import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:stm_mobile_new/viewmodel/bindings/btbinding.dart';
import 'package:stm_mobile_new/views/BluetoothOfScreen.dart';
import 'package:stm_mobile_new/views/FindDeviceScreen.dart';
import 'package:stm_mobile_new/views/readDetaild.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: bluettothBinding(),
      
      getPages: [
        GetPage(
            name: "/readDevices",
            page: (() => const FindDeviceScreen()),
            binding: bluettothBinding()),
        GetPage(
          name: "/dataRead",
          page: (() => const ReadDetail()),
        )
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return const FindDeviceScreen();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
}
