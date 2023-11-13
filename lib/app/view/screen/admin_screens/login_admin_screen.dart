import 'package:control_asistencia_app/app/controller/admin_controllers/admin_controller.dart';
// import 'package:control_asistencia_app/app/controller/settings_controllers/localauthcontroller.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/home_admin_tabbar_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  // final LocalAuthController _localAuthController = LocalAuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _conEmailAdmin = TextEditingController();
    _conPass = TextEditingController();
    // _localAuthController.checkBiometric();
    // _localAuthController.getAvailableBiometric();
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
    final FormState? form = _formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        String response = await adminController
            .loginAdmin(email, pass)
            .then((responseMessagge) => responseMessagge);
        if (response == "Sesion iniciada") {
          // bool autenticated = await _localAuthController.authenticate();
          // if (autenticated) {
          //   if (!mounted) return;
          //   Navigator.pushReplacementNamed(context, HomeAdminScreen.route);
          // }
          if (!mounted) return;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(
                      context, HomeAdminTabBarScreen.route);
                },
              );
              return CustomDialogWidget(
                iconData: const Icon(Icons.check_circle,
                    color: Colors.green, size: 42),
                messagge: Text(response),
              );
            },
          );
        } else {
          if (!mounted) return;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  Navigator.of(context).pop();
                },
              );
              return CustomDialogWidget(
                  iconData: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 42,
                  ),
                  messagge: Text(response),
                  title: "Error");
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
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
                    inputType: TextInputType.visiblePassword,
                    action: TextInputAction.done,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          textStyle: TextStyle(fontSize: 18.sp),
                          backgroundColor: const Color(0xFFD9D9D9),
                          foregroundColor: const Color(0xff000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20).w,
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
