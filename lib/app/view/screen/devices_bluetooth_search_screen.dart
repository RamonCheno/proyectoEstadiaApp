// // ignore_for_file: depend_on_referenced_packages
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

// class DevicesBluetoothSearchScreen extends StatefulWidget {
//   const DevicesBluetoothSearchScreen({Key? key}) : super(key: key);
//   static const route = "/searchBluetoothDevices";

//   @override
//   State<DevicesBluetoothSearchScreen> createState() =>
//       _DevicesBluetoothSearchScreenState();
// }

// class _DevicesBluetoothSearchScreenState
//     extends State<DevicesBluetoothSearchScreen> {
//   final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
//   List<BluetoothDevice> _devicesList = [];
//   late BluetoothDevice _device;

//   void showSnackBar(String value) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(value),
//         margin: const EdgeInsets.all(50),
//         elevation: 1,
//         duration: const Duration(milliseconds: 800),
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getDevices();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void _getDevices() async {
//     List<BluetoothDevice> devices = await _bluetooth.getBondedDevices();
//     setState(() {
//       _devicesList = devices;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var widthScreen = MediaQuery.of(context).size.width * 0.9;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.black),
//         centerTitle: true,
//         title: const Text('Comunicacion datos serie'),
//       ),
//       body: ListView.builder(
//         itemCount: _devicesList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(_devicesList[index].name!),
//             subtitle: Text(_devicesList[index].address),
//             onTap: () {
//               setState(() {
//                 _device = _devicesList[index];
//               });
//             },
//           );
//         },
//       ),
//     );
//   }
// }
