// import 'package:control_asistencia_app/app/controller/settings_controllers/bluetooth_controller.dart';
// import 'package:control_asistencia_app/app/view/widget/devicelistitem_widget.dart';
// import 'package:flutter/material.dart';

// class ScanDevicesBluetoothScreen extends StatefulWidget {
//   const ScanDevicesBluetoothScreen({Key? key}) : super(key: key);
//   static const route = "/scanBluetoothDevices";

//   @override
//   State<ScanDevicesBluetoothScreen> createState() =>
//       _ScanDevicesBluetoothScreenState();
// }

// class _ScanDevicesBluetoothScreenState
//     extends State<ScanDevicesBluetoothScreen> {
//   final BluetoothController _controller = BluetoothController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var widthScreen = MediaQuery.of(context).size.width * 0.9;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.black),
//         centerTitle: true,
//         title: const Text('Buscar Dispositvos bluetooth'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: widthScreen,
//                 child: ElevatedButton(
//                   onPressed: () =>
//                       _controller.getPairedDevices().then((devices) {
//                     setState(() {
//                       _controller.devicesLoad = true;
//                     });
//                   }),
//                   child: const Text('Buscar dispositivos'),
//                 ),
//               ),
//               if (_controller.devicesLoad && _controller.devicesList.isNotEmpty)
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black12,
//                       width: 1,
//                     ),
//                   ),
//                   height: 200,
//                   width: widthScreen,
//                   child: ListView.builder(
//                     physics: _controller.devicesList.length < 3
//                         ? const NeverScrollableScrollPhysics()
//                         : const ClampingScrollPhysics(),
//                     itemCount: _controller.devicesList.length,
//                     itemBuilder: (context, index) {
//                       final device = _controller.devicesList[index];
//                       final isConnected = _controller.deviceMacAddress ==
//                           device.address.toString();
//                       return DeviceListItemWidget(
//                         device: device,
//                         isConnected: isConnected,
//                         onTap: () {
//                           if (isConnected) {
//                             _controller.disconnectDevice();
//                           } else {
//                             _controller
//                                 .connectDevice(device.address.toString());
//                           }
//                           setState(() {});
//                         },
//                       );
//                     },
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
