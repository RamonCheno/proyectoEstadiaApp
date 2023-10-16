// ignore_for_file: depend_on_referenced_packages
import 'package:control_asistencia_app/app/controller/settings_controllers/bluetooth_controller.dart';
import 'package:control_asistencia_app/app/view/screen/worker_screens/checkin_method_screens/more_options_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckInFingerprintScreen extends StatefulWidget {
  const CheckInFingerprintScreen({super.key});
  static const route = "/fingerprintCheckInScreen";

  @override
  State<CheckInFingerprintScreen> createState() =>
      _CheckInFingerprintScreenState();
}

class _CheckInFingerprintScreenState extends State<CheckInFingerprintScreen> {
  String nowDayFormat = "";
  String nowTimeFormat = "";

  BluetoothController bluetoothController = BluetoothController();
  String text = "";
  String firstName = "";
  String lastName = "";
  bool isVisible = false;

  void textBluetooth(BuildContext context) {
    final bluetoothProvider = Provider.of<BluetoothController>(context);
    String data = bluetoothProvider.sendSerialData;
    if (data.contains('Reconocer')) {
      debugPrint(data);
      text = "toque el sensor para registrar entrada";
      isVisible = false;
    } else if (data.contains(RegExp(r'\d+'))) {
      debugPrint(data);
      // int id = int.parse(data);
      text = "id: # $data";
      isVisible = true;
    } else {
      isVisible = false;
    }
  }

  // Future dialog(BuildContext context) {
  //   return showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       Future.delayed(
  //         const Duration(seconds: 2),
  //         () {
  //           Navigator.of(context).pop();
  //         },
  //       );
  //       return CustomDialogWidget(
  //         messagge: Column(children: [
  //           Text("Id: $text"),
  //           Text("Hora de entrada: $nowTimeFormat"),
  //           Text("Fecha de entrada: $nowDayFormat"),
  //         ]),
  //         iconData: const Icon(
  //           Icons.check_circle,
  //           color: Colors.green,
  //           size: 42,
  //         ),
  //       );
  //     },
  //   );
  // }

  // void guardarAsistencia() async {}

  Future<bool> reciveData() async {
    // final bluetoothProvider = Provider.of<BluetoothController>(context);
    String data = bluetoothController.sendSerialData;
    setState(() {
      text = data;
      isVisible = true;
    });
    return isVisible;
  }

  @override
  void initState() {
    super.initState();
    bluetoothController.sendMessageBluetooth("b");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistencia Laboral"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(
          children: [
            const Icon(
              Icons.fingerprint,
              size: 84,
            ),
            // FutureBuilder(
            //   future: reciveData(),
            //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            //     if (snapshot.hasData) {
            //       WidgetsBinding.instance.addPostFrameCallback((_) {
            //         if (isVisible) {
            //           showDialog(
            //               context: context,
            //               builder: (context) {
            //                 return CustomDialogWidget(
            //                     messagge: Column(children: [
            //                       Text("Id: $text"),
            //                       Text("Hora de entrada: $nowTimeFormat"),
            //                       Text("Fecha de entrada: $nowDayFormat"),
            //                     ]),
            //                     iconData: const Icon(
            //                       Icons.check_circle,
            //                       color: Colors.green,
            //                       size: 42,
            //                     ),
            //                     action: [
            //                       ElevatedButton(
            //                           onPressed: () {
            //                             Navigator.of(context).pop();
            //                             bluetoothController
            //                                 .sendMessageBluetooth("b");
            //                             setState(() {
            //                               isVisible = false;
            //                             });
            //                           },
            //                           child: const Text("Aceptar")),
            //                     ]);
            //               });
            //         }
            //       });
            //     }
            //     return const Text("");
            //   },
            // ),
            // IconButton(
            //     icon: const Icon(
            //       Icons.fingerprint,
            //       size: 96,
            //     ),
            //     onPressed: () {
            //       Future.delayed(const Duration(microseconds: 500));
            //       if (isVisible) {

            //       }
            //     }),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "toque el sensor para registrar entrada",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(MoreOptionsScreen.route),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                  Color(0xff990303),
                ),
              ),
              child: const Text(
                "Más opciones",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
