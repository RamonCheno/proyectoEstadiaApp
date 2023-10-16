import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_controller.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/screen/worker_screens/checkin_method_screens/more_options_screen.dart';
// import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';

class FingerPrintCheckinScreen extends StatefulWidget {
  const FingerPrintCheckinScreen({super.key});
  static const route = "/CheckInfingerprintScreen";

  @override
  State<FingerPrintCheckinScreen> createState() =>
      _FingerPrintCheckinScreenState();
}

class _FingerPrintCheckinScreenState extends State<FingerPrintCheckinScreen>
    with AfterLayoutMixin<FingerPrintCheckinScreen> {
  /*
  TODO: buscar una forma para mostrar un alertDialog cuando se reciba un dato desde arduinoBluetooth
  */
  BluetoothController bluetoothController = BluetoothController();
  bool isVisible = false;
  String messagge = "";
  // void showCustomDialog(BuildContext context, String messagge, Icon iconData) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => CustomDialogWidget(
  //       messagge: Text(messagge),
  //       iconData: iconData,
  //       action: [
  //         ElevatedButton(
  //           child: const Text("Aceptar"),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget dialog(BuildContext context, List<Widget> data) {
  //   return CustomDialogWidget(
  //     messagge: Column(children: data),
  //     iconData: const Icon(
  //       Icons.check_circle,
  //     ),
  //     action: [
  //       ElevatedButton(
  //         child: const Text("Aceptar"),
  //         onPressed: () {
  //           bluetoothController.sendMessageBluetooth("b");
  //           Navigator.of(context).pop();
  //         },
  //       )
  //     ],
  //   );
  // }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    isVisible = false;
    bluetoothController.sendMessageBluetooth("b");
  }

  @override
  void dispose() {
    super.dispose();
    isVisible = false;
    messagge = "";
  }

  void textBluetooth() {
    final bluetoothProvider = Provider.of<BluetoothController>(context);
    messagge = bluetoothProvider.sendSerialData;
    isVisible = messagge.contains(RegExp(r'\d+')) ? true : false;
    setState(() {});
  }

  // Future dialogScreen(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return dialog(context, [
  //         Text("Id: #$messagge"),
  //         const Text("Numero:"),
  //         const Text("Hora Entrada:"),
  //         const Text("Fecha Entrada: ")
  //       ]);
  //     },
  //   );
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    textBluetooth();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistencia Laboral"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              isVisible
                  ? const Icon(
                      Icons.check_circle,
                      size: 84,
                      color: Colors.green,
                    )
                  : messagge.contains("error")
                      ? const Icon(
                          Icons.cancel,
                          size: 84,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.fingerprint,
                          size: 84,
                        ),
              // IconButton(
              //   onPressed: () {
              //     textBluetooth();
              //   },
              //   icon: const Icon(
              //     Icons.fingerprint,
              //     size: 84,
              //   ),
              // ),
              const SizedBox(
                height: 25,
              ),
              Text(
                isVisible
                    ? messagge
                    : messagge.contains("error")
                        ? "Error"
                        : "toque el sensor para registrar entrada",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              isVisible
                  ? Center(
                      child: Column(children: [
                        const Text(
                          "Hora Entrada: ",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        const Text(
                          "Fecha Entrada: ",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              bluetoothController.sendMessageBluetooth("b");
                              setState(() {
                                isVisible = false;
                                messagge = "";
                              });
                            },
                            child: const Text("Siguiente"))
                      ]),
                    )
                  : messagge.contains("error")
                      ? Center(
                          child: ElevatedButton(
                              onPressed: () {
                                bluetoothController.sendMessageBluetooth("b");
                              },
                              child: const Text("Intente de nuevo")),
                        )
                      : Container(),
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
              ),
              // if (isVisible == true)
              //   FutureBuilder(
              //     future: dialogScreen(context),
              //     builder: (context, snapshot) {
              //       WidgetsBinding.instance.addPostFrameCallback((_) {
              //         // setState(() {});
              //         dialog(context, [
              //           Text("Id: #$messagge"),
              //           const Text("Numero:"),
              //           const Text("Hora Entrada:"),
              //           const Text("Fecha Entrada: ")
              //         ]);
              //       });
              //       return Container();
              //     },
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

// showDialog(
//                           context: context,
//                           builder: (context) {
//                             return CustomDialogWidget(
//                                 messagge: Column(children: [
//                                   Text("Id: $text"),
//                                   Text("Hora de entrada: $nowTimeFormat"),
//                                   Text("Fecha de entrada: $nowDayFormat"),
//                                 ]),
//                                 iconData: const Icon(
//                                   Icons.check_circle,
//                                   color: Colors.green,
//                                   size: 42,
//                                 ),
//                                 action: [
//                                   ElevatedButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                         bluetoothController
//                                             .sendMessageBluetooth("b");
//                                         setState(() {
//                                           isVisible = false;
//                                         });
//                                       },
//                                       child: const Text("Aceptar")),
//                                 ]);
//                           });
