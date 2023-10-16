import 'package:control_asistencia_app/app/controller/admin_controllers/admin_controller.dart';
import 'package:control_asistencia_app/app/model/admin_model.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter/material.dart';

import 'login_register_tabbar_screen.dart';

class RegisterAdminScreen extends StatefulWidget {
  const RegisterAdminScreen({super.key});

  static const route = "/RegisterAdminScreen";

  @override
  State<RegisterAdminScreen> createState() => _RegisterAdminScreenState();
}

class _RegisterAdminScreenState extends State<RegisterAdminScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _conNumWorkerAdmin;
  late TextEditingController _conFirtNameAdmin;
  late TextEditingController _conLastNameAdmin;
  late TextEditingController _conEmailAdmin;
  late TextEditingController _conPassAdmin;
  late TextEditingController _conConfirmPassAdmin;
  AdminController adminController = AdminController();

  void register() async {
    final FormState? form = _formKey.currentState;
    String numWorkerAdmin = _conNumWorkerAdmin.text;
    String firstName = _conFirtNameAdmin.text;
    String lastName = _conLastNameAdmin.text;
    String emailAdmin = _conEmailAdmin.text;
    String password = _conPassAdmin.text;
    String confirmPassword = _conConfirmPassAdmin.text;

    if (form != null) {
      if (form.validate()) {
        if (password != confirmPassword) {
        } else {
          AdminModel adminModel = AdminModel(
            numTrabajador: int.parse(numWorkerAdmin),
            nombre: firstName,
            apellido: lastName,
            email: emailAdmin,
          );
          String response = await adminController
              .registerAdmin(adminModel, password)
              .then((methodResponse) => methodResponse);
          if (!mounted) return;
          if (response == "Registro con exito") {
            showDialog(
              context: context,
              builder: (context) {
                Future.delayed(
                  const Duration(seconds: 2),
                  () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushReplacementNamed(TabBarLoginRegisterScreen.route);
                  },
                );
                return CustomDialogWidget(
                  messagge: Text(response),
                  iconData: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                Future.delayed(
                  const Duration(seconds: 2),
                  () {
                    Navigator.of(context).pop();
                  },
                );
                return CustomDialogWidget(
                  messagge: Text(response),
                  iconData: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  ),
                );
              },
            );
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _conNumWorkerAdmin = TextEditingController();
    _conFirtNameAdmin = TextEditingController();
    _conLastNameAdmin = TextEditingController();
    _conEmailAdmin = TextEditingController();
    _conPassAdmin = TextEditingController();
    _conConfirmPassAdmin = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        title: const Text("Registro"),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomTextFormWidget(
                controller: _conNumWorkerAdmin,
                hintName: "Numero",
                icon: Icons.numbers,
                isObscureText: false,
                inputType: TextInputType.number,
                action: TextInputAction.next,
                soloLeer: false,
              ),
              CustomTextFormWidget(
                controller: _conFirtNameAdmin,
                hintName: "Nombre",
                icon: Icons.person_outline,
                isObscureText: false,
                inputType: TextInputType.text,
                action: TextInputAction.next,
                soloLeer: false,
              ),
              CustomTextFormWidget(
                controller: _conLastNameAdmin,
                hintName: "Apellido",
                icon: Icons.person_outline,
                isObscureText: false,
                inputType: TextInputType.text,
                action: TextInputAction.next,
                soloLeer: false,
              ),
              CustomTextFormWidget(
                controller: _conEmailAdmin,
                hintName: "Correo electronico",
                icon: Icons.email_outlined,
                isObscureText: false,
                inputType: TextInputType.emailAddress,
                action: TextInputAction.next,
                soloLeer: false,
              ),
              CustomTextFormWidget(
                controller: _conPassAdmin,
                hintName: "Contraseña nueva",
                icon: Icons.password,
                isObscureText: true,
                inputType: TextInputType.visiblePassword,
                action: TextInputAction.next,
                soloLeer: false,
              ),
              CustomTextFormWidget(
                controller: _conConfirmPassAdmin,
                hintName: "Confirmar Contraseña",
                icon: Icons.password,
                isObscureText: true,
                inputType: TextInputType.visiblePassword,
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
                      foregroundColor: const Color(0xFF000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: register,
                    child: const Text(
                      'Registrar',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
