import 'package:control_asistencia_app/view/screen/admin_screens/home_admin_screen.dart';
import 'package:control_asistencia_app/view/screen/worker_screens/home_worker_screeen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const route = "/";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 65,
                    child: ClipOval(
                        child: Image(
                      image: AssetImage("assets/images/logo_grupo_mexico.png"),
                      fit: BoxFit.cover,
                      width: 130,
                      height: 130,
                    )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Control de asistencia laboral"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Column(
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Color(0xffD9D9D9))),
                    onPressed: () {
                      Navigator.pushNamed(context, HomeWorkerScreen.route);
                    },
                    child: const Text(
                      "Soy trabajador",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Color(0xffD9D9D9))),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeAdminScreen.route);
                    },
                    child: const Text(
                      "Soy administrador",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
