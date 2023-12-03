import 'package:control_asistencia_app/app/controller/admin_controllers/admin_controller.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';
import 'package:control_asistencia_app/app/view/provider/image_provider.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_admin/edit_info_admin_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          // FutureBuilder(
          //   future: Future.wait([
          //     Provider.of<AdminProvider>(context, listen: false)
          //         .getAdminViewModel(),
          //   ]),
          //   builder: (context, snapshot) {
          //     return
          //   },
          // ),
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

class HeaderPerfilWidget extends StatefulWidget {
  const HeaderPerfilWidget({super.key});

  @override
  State<HeaderPerfilWidget> createState() => _HeaderPerfilWidgetState();
}

class _HeaderPerfilWidgetState extends State<HeaderPerfilWidget> {
  @override
  void initState() {
    super.initState();
    // getAdminVModel();
  }

  void getAdminVModel() async {
    await Provider.of<AdminProvider>(context, listen: false)
        .getAdminViewModel();
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant HeaderPerfilWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    getAdminVModel();
  }

  @override
  Widget build(BuildContext context) {
    // getAdminVModel();
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) {
        // final imgProvider = Provider.of<ImageProviders>(context, listen: false);
        return Column(
          children: [
            Consumer<ImageProviders>(
              builder: (context, imgProvider, child) {
                if (adminProvider.urlPhoto != "") {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 50.r,
                        backgroundColor: const Color(0xffE1E1E1),
                        foregroundImage: imgProvider
                            .imageInternetLocal(adminProvider.urlPhoto),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Material(
                        color: const Color(0xffE1E1E1),
                        shape: const CircleBorder(),
                        child: Icon(
                          Icons.person_outline,
                          size: 60.r,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            Text(
                "${adminProvider.firstNameProvider} ${adminProvider.lastNameProvider}",
                style: TextStyle(fontSize: 16.sp)),
            SizedBox(
              height: 5.h,
            ),
            Text("${adminProvider.numHumanResource}",
                style: TextStyle(fontSize: 12.sp)),
          ],
        );
      },
    );
  }
}
