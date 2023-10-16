import 'package:flutter/material.dart';
import 'checkin_method_screens/fingerprint_checkin_screen.dart';

class HomeWorkerScreen extends StatelessWidget {
  const HomeWorkerScreen({super.key});
  static const route = "/homeWorkScreen";

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Asistencia laboral"),
          centerTitle: true,
          backgroundColor: const Color(0xffEBEBEB),
        ),
        backgroundColor: const Color(0xffEBEBEB),
        body: SizedBox(
          width: media.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff28C925),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(FingerPrintCheckinScreen.route);
                          },
                          icon: const Icon(Icons.check,
                              color: Colors.white, size: 70),
                        ),
                        const Text("Entrada"),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                    ),
                    Column(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff990303),
                            ),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.close,
                              color: Colors.white, size: 70),
                        ),
                        const Text("Salida"),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60),
                ),
                IconButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color(0xffC99B25),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.fastfood_outlined,
                      color: Colors.white, size: 70),
                ),
                const Text("Comida"),
              ],
            ),
          ),
        ));
  }
}
