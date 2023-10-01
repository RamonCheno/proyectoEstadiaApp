// import 'package:control_asistencia_app/app/view/screen/devices_bluetooth_search_screen.dart';
import 'package:flutter/material.dart';
// import 'devices_bluetooth_search_screen.dart';
import 'scan_devices_bluetooth_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const route = "/settings";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color(0xFFD9D9D9),
                  foregroundColor: const Color(0xFF000000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ScanDevicesBluetoothScreen.route);
                },
                child: const Text(
                  'Buscar Dispositivos Bluetooth',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
