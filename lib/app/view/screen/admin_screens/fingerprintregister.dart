import 'package:control_asistencia_app/app/controller/settings_controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';

class FingerPrintRegisterScreen extends StatefulWidget {
  const FingerPrintRegisterScreen({super.key});

  static const route = "/fingerPrintRegister";
  @override
  State<FingerPrintRegisterScreen> createState() =>
      _FingerPrintRegisterScreenState();
}

class _FingerPrintRegisterScreenState extends State<FingerPrintRegisterScreen> {
  BluetoothController bluetoothController = BluetoothController();
  int contId = 0;
  bool _isVisible = false;

  String messagge = "";

  void valueFingerPrintSensor(BuildContext context) async {
    final bluetoothProvider = Provider.of<BluetoothController>(context);
    String data = bluetoothProvider.sendSerialData;
    if (data.contains('ingrese')) {
      ++contId;
      bluetoothProvider.sendMessageBluetooth("$contId");
      await saveContId(contId);
      debugPrint("$contId");
      messagge = "Espere que responda el sensor";
    }
    if (data.contains('Primer')) {
      messagge = "Ponga su huella en el sensor";
    }
    if (data.contains('Retirar')) {
      messagge = "Retire la huella";
    }
    if (data.contains('Segundo')) {
      messagge = "Ponga su huella en el sensor otra vez";
    }
    if (data.contains('terminado')) {
      messagge = "Registro de huella Terminado";
      _isVisible = true;
    }
    if (mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadContId();
    bluetoothController.sendMessageBluetooth("a");
  }

  @override
  void dispose() {
    super.dispose();
    _isVisible = false;
    messagge = "";
  }

  void loadContId() async {
    contId = await loadContIdPersistent();
  }

  Future<void> saveContId(int contId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("contId", contId);
  }

  Future<int> loadContIdPersistent() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("contId") ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    valueFingerPrintSensor(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registar Huella Dactilar"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(messagge),
            if (_isVisible == true)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, contId);
                },
                child: const Text("Aceptar"),
              ),
          ],
        ),
      ),
    );
  }
}
