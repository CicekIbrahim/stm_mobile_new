import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../core/widgets/appbar.dart';
import '../viewmodel/controllers/bluetoothController.dart';
import '../viewmodel/controllers/serverController.dart';

class ReadDetail extends StatefulWidget {
  const ReadDetail({Key? key}) : super(key: key);

  @override
  State<ReadDetail> createState() => _ReadDetailState();
}

final serverController = Get.find<ServerController>();
final btController = Get.find<bluetoothController>();

class _ReadDetailState extends State<ReadDetail> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          btController.device!.disconnect();
          Get.toNamed("/readDevices");
          return false;
        },
        child: Scaffold(
            appBar:
                appbar("${btController.device!.name.toString()} Properties"),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Toggle(),
                  const Divider(
                    thickness: 2,
                  )
                ],
              ),
            )));
  }

  Toggle() {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Toggle Led",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            ToggleSwitch(
              minWidth: 60.0,
              minHeight: 40.0,
              initialLabelIndex: 0,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              icons: const [
                FontAwesomeIcons.lightbulb,
                FontAwesomeIcons.solidLightbulb,
              ],
              iconSize: 30.0,
              activeBgColors: const [
                [Colors.black45, Colors.black26],
                [Colors.yellow, Colors.green]
              ],
              animate:
                  true, // with just animate set to true, default curve = Curves.easeIn
              curve: Curves
                  .bounceInOut, // animate must be set to true when using custom curve
              onToggle: (index) {
                if (index == 1) {
                  btController.toggleLed("Y");
                } else if (index == 0) {
                  btController.toggleLed("N");
                }
              },
            ),
            Obx(() => Text(
                 "${btController.data.value.toString()} C°",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}
