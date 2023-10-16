import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BluetoothController with ChangeNotifier {
  static final BluetoothController _instance = BluetoothController._internal();

  factory BluetoothController() {
    return _instance;
  }

  BluetoothController._internal();

  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  late BluetoothConnection connection;
  List<BluetoothDevice> _devicesList = [];

  // List<Map<String, String>> inComingData = [];
  bool devicesLoad = false;

  String _deviceMacAddress = "";

  String _sendSerialData = "";

  String get sendSerialData => _sendSerialData;

  String get deviceMacAddress => _deviceMacAddress;

  bool get isConnected => connection.isConnected;

  List<BluetoothDevice> get devicesList => _devicesList;

  Future<List<BluetoothDevice>> getPairedDevices() async {
    try {
      _devicesList = await _bluetooth.getBondedDevices();
    } on PlatformException {
      debugPrint("Error");
    }
    return _devicesList;
  }

  void connectDevice(String address) {
    BluetoothConnection.toAddress(address).then((conn) async {
      connection = conn;
      _deviceMacAddress = address;
      await saveDeviceMacAddress(_deviceMacAddress);
      listenForData();
      notifyListeners();
    });
  }

  Future<void> saveDeviceMacAddress(String macAddress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceMacAddress', macAddress);
  }

  Future<String?> loadDeviceMacAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('deviceMacAddress');
  }

  void disconnectDevice() async {
    _deviceMacAddress = '';
    // inComingData = [];
    connection.close();
    await clearDeviceMacAddress();
    notifyListeners();
  }

  void listenForData() async {
    connection.input!.listen((Uint8List data) {
      String serialData = ascii.decode(data);
      debugPrint('Data incoming: $serialData');
      connection.output.add(data);
      _sendSerialData = serialData;
      if (ascii.decode(data).contains('!')) {
        connection.finish();
        debugPrint('Disconnecting by local host');
      }
      notifyListeners();
    }).onDone(() {
      debugPrint('Disconnected by remote request');
      notifyListeners();
    });
  }

  void sendMessageBluetooth(String messagge) async {
    debugPrint('sending data');
    if (isConnected) {
      connection.output.add(Uint8List.fromList(utf8.encode(messagge)));
      await connection.output.allSent;
    } else {
      disconnectDevice();
    }
  }

  Future<void> clearDeviceMacAddress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('deviceMacAddress');
  }

  void disponse() {
    if (isConnected) {
      disconnectDevice();
    }
  }
}
