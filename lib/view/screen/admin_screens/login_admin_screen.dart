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
          ],
        ),
      ),
    );
  }
}
