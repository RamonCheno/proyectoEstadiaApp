import 'package:control_asistencia_app/app/controller/admin_controllers/admin_controller.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/home_admin_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter/material.dart';

class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({super.key});
  static const route = "/loginAdminScreen";

  @override
  State<LoginAdminScreen> createState() => _LoginAdminScreenState();
}

class _LoginAdminScreenState extends State<LoginAdminScreen> {
  late TextEditingController _conEmailAdmin;
  late TextEditingController _conPass;
  AdminController adminController = AdminController();

  @override
  void initState() {
    super.initState();
    _conEmailAdmin = TextEditingController();
    _conPass = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _conEmailAdmin.dispose();
    _conPass.dispose();
  }

  void login() async {
    String email = _conEmailAdmin.text;
    String pass = _conPass.text;

    String response = await adminController
        .loginAdmin(email, pass)
        .then((responseMessagge) => responseMessagge);
    if (response == "Sesion iniciada") {
      //hacer autenticacion con local Auth
    } else {
      /*mostrar un customDialog donde muestre al usuario cual fue la falla*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  CustomTextFormWidget(
                    controller: _conEmailAdmin,
                    hintName: "Correo electronico",
                    icon: Icons.email_outlined,
                    isObscureText: false,
                    inputType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                  ),
                  CustomTextFormWidget(
                    controller: _conPass,
                    hintName: "Contraseña",
                    icon: Icons.numbers,
                    isObscureText: true,
                    inputType: TextInputType.number,
                    action: TextInputAction.done,
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
                        onPressed: login,
                        child: const Text(
                          'Entrar',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
