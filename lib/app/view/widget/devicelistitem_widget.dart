// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

// class DeviceListItemWidget extends StatefulWidget {
//   final BluetoothDevice device;
//   final bool isConnected;
//   final Function onTap;

//   const DeviceListItemWidget(
//       {required this.device,
//       required this.isConnected,
//       required this.onTap,
//       Key? key})
//       : super(key: key);

//   @override
//   State<DeviceListItemWidget> createState() => _DeviceListItemStateWidget();
// }

// class _DeviceListItemStateWidget extends State<DeviceListItemWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {
//         widget.onTap();
//       },
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             widget.device.name.toString(),
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: widget.isConnected ? Colors.green : Colors.blue,
//             ),
//           ),
//         ],
//       ),
//       subtitle: widget.isConnected
//           ? const Text('Clic para desconectar')
//           : const Text('Clic para conectar'),
//     );
//   }
// }
