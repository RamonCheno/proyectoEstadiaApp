import 'package:control_asistencia_app/app/packages/packagelocal_controller.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_widgets.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';

class PerfilUserScreen extends StatelessWidget {
  PerfilUserScreen({super.key});

  static const String route = "/perfilUserScreen";
  final AdminController _adminController = AdminController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        centerTitle: true,
        backgroundColor: const Color(0xffD9D9D9),
      ),
      backgroundColor: const Color(0xffD9D9D9),
      body: Column(
        children: [
          const HeaderPerfilWidget(),
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15).w,
              color: const Color(0XFFF4F4F4),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 5.0),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(EditInfoAdminScreen.route);
              },
              child: Row(children: [
                IconButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color(0xff990303),
                    ),
                  ),
                  onPressed: null,
                  icon: Icon(Icons.edit_outlined,
                      size: 32.r, color: Colors.white),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text("Editar perfil", style: TextStyle(fontSize: 16.sp)),
              ]),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15).w,
              color: const Color(0XFFF4F4F4),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 5.0),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                //accion para cerrar sesion.
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomDialogWidget(
                      title: 'Cerrar Sesión',
                      messagge: Text('¿Seguro que quiere Cerrar sesión?',
                          style: TextStyle(fontSize: 16.sp)),
                      iconData: Icon(Icons.exit_to_app_outlined, size: 26.r),
                      actions: [
                        TextButton(
                          child: Text('Aceptar',
                              style: TextStyle(fontSize: 14.sp)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _adminController.signOut();
                            Navigator.of(context).pushReplacementNamed(
                                TabBarLoginRegisterScreen.route);
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancelar',
                              style: TextStyle(fontSize: 14.sp)),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                children: [
                  IconButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Color(0xff990303),
                      ),
                    ),
                    onPressed: null,
                    icon: Icon(Icons.exit_to_app,
                        size: 32.r, color: Colors.white),
                  ),
                  //*Opcion para cambio de tema
                  SizedBox(
                    width: 10.w,
                  ),
                  Text("Cerrar Sesion", style: TextStyle(fontSize: 16.sp)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
