import 'package:flutter_blue/flutter_blue.dart';

abstract class IBtService {
  startScan();
  connectDevice();
  disconnectDevice();
  bindCharacteristic(BluetoothCharacteristic? characteristic);
  listenService();
  bindDevice();
  getCharacteristic();
  toggleLed();
  readData(BluetoothCharacteristic? characteristic);
}
