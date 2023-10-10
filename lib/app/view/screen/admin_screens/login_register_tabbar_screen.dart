import 'package:flutter/material.dart';

import 'login_admin_screen.dart';
import 'register_admin_screen.dart';

class TabBarLoginRegisterScreen extends StatefulWidget {
  const TabBarLoginRegisterScreen({super.key});

  static const route = "/tabbarLoginRegisterScreen";

  @override
  State<TabBarLoginRegisterScreen> createState() =>
      _TabBarLoginRegisterScreenState();
}

class _TabBarLoginRegisterScreenState extends State<TabBarLoginRegisterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Center(
        child: Column(
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
                ],
              ),
            ),
            TabBar(
              labelColor: const Color(0xff990303),
              indicatorColor: const Color(0xff990303),
              unselectedLabelColor: const Color.fromARGB(255, 131, 131, 131),
              controller: _tabController,
              tabs: const [
                Tab(text: "Iniciar Sesión"),
                Tab(text: "Registro"),
              ],
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const LoginAdminScreen(),
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
                              .pushNamed(RegisterAdminScreen.route);
                        },
                        child: const Text(
                          'Registrarse con E-mail',
                        ),
                      ),
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

// Padding(
//               padding: EdgeInsets.symmetric(vertical: 15),
//               child: Column(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.transparent,
//                     radius: 65,
//                     child: ClipOval(
//                         child: Image(
//                       image: AssetImage("assets/images/logo_grupo_mexico.png"),
//                       fit: BoxFit.cover,
//                       width: 130,
//                       height: 130,
//                     )),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                 ],
//               ),
//             ),