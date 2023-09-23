import 'package:control_asistencia_app/app/view/screen/admin_screens/home_admin_screen.dart';
import 'package:control_asistencia_app/app/view/screen/home_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter/material.dart';

class LoginAdminScreen extends StatelessWidget {
  const LoginAdminScreen({super.key});
  static const route = "/loginAdminScreen";

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
                  Text("Iniciar Sesion"),
                ],
              ),
            ),
            Form(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomTextFormWidget(
                      hintName: "Num Trabajador",
                      icon: Icons.numbers,
                      isObscureText: false,
                      inputType: TextInputType.number,
                      action: TextInputAction.next,
                      soloLeer: false,
                    ),
                    const CustomTextFormWidget(
                      hintName: "Contraseña",
                      icon: Icons.numbers,
                      isObscureText: true,
                      inputType: TextInputType.number,
                      action: TextInputAction.done,
                      soloLeer: false,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            textStyle: const TextStyle(fontSize: 18),
                            backgroundColor: const Color(0xFFD9D9D9),
                            foregroundColor: const Color(0xff000000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(HomeAdminScreen.route),
                          child: const Text(
                            'Entrar',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            textStyle: const TextStyle(fontSize: 18),
                            backgroundColor: const Color(0xFFD9D9D9),
                            foregroundColor: const Color(0xff000000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.route),
                          child: const Text(
                            'Regresar',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
