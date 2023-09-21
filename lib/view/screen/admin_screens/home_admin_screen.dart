import 'package:flutter/material.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});
  static const route = "/homeAdminScreen";

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistencia Laboral"),
        centerTitle: true,
        backgroundColor: const Color(0xffD9D9D9),
      ),
      drawer: Drawer(
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0X00990303), Color(0xff990303)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 120,
                  margin: const EdgeInsets.only(top: 30),
                  child: DrawerHeader(
                    child: Text(
                      maxLines: 2,
                      'Control de asistencia Laboral'.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.settings_outlined,
                            size: 26, color: Colors.black),
                        title: const Text(
                          'Configuracion',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app_outlined,
                      size: 26, color: Colors.white),
                  title: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Cerrar Sesión'),
                          content:
                              const Text('¿Seguro que quiere Cerrar sesión?'),
                          actions: [
                            TextButton(
                              child: const Text('Aceptar'),
                              onPressed: () async {
                                debugPrint("Cerrar Sesion presionado");
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            )),
      ),
      body: Stack(
        children: [
          Container(
            width: media.width,
            height: media.height,
            color: const Color(0xffD9D9D9),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: media.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0XFFF4F4F4),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 5.0),
                  ],
                ),
                child: const Row(
                  children: [
                    Material(
                      color: Color(0xffE1E1E1),
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.person_outline,
                        size: 60,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Admin Prueba"),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 145,
                    width: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0XFFF4F4F4),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 5.0),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff990303),
                            ),
                          ),
                          icon: const Icon(Icons.list,
                              size: 70, color: Colors.white),
                          onPressed: () =>
                              debugPrint("Boton asistencia presionado"),
                        ),
                        const Text("Asistencia",
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Container(
                    height: 145,
                    width: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0XFFF4F4F4),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 5.0),
                      ],
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff990303),
                            ),
                          ),
                          icon: const Icon(Icons.description_outlined,
                              size: 70, color: Colors.white),
                          onPressed: () =>
                              debugPrint("Boton reportes presionado"),
                        ),
                        const Text("Reportes", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 145,
                    width: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0XFFF4F4F4),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 5.0),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff990303),
                            ),
                          ),
                          icon: const Icon(Icons.groups_outlined,
                              size: 70, color: Colors.white),
                          onPressed: () =>
                              debugPrint("Boton Trabajadores presionado"),
                        ),
                        const Text("Trabajadores",
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
