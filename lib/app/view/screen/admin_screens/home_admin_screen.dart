import 'package:control_asistencia_app/app/packages/packagelocal_controller.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_provider.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_widgets.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';

class HomeAdminScreen extends StatelessWidget {
  HomeAdminScreen({super.key});

  static const route = "/homeAdminScreen";

  final AdminController _adminController = AdminController();

  void getDatVMAdmin(BuildContext context) async {
    await Provider.of<AdminProvider>(context, listen: false)
        .getAdminViewModel();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Asistencia Laboral",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffD9D9D9),
      ),
      drawer: Drawer(
        width: 0.8.sw,
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
                  height: 0.18.sh,
                  margin: EdgeInsets.only(top: 30.h),
                  child: DrawerHeader(
                    child: Text(
                      maxLines: 2,
                      'Control de asistencia Laboral'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 16.sp),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.settings_outlined,
                            size: 26.r, color: Colors.black),
                        title: Text(
                          'Configuracion',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(SettingsScreen.route);
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app_outlined,
                      size: 26.r, color: Colors.white),
                  title: Text(
                    'Cerrar Sesión',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return CustomDialogWidget(
                          title: 'Cerrar Sesión',
                          messagge: Text('¿Seguro que quiere Cerrar sesión?',
                              style: TextStyle(fontSize: 16.sp)),
                          iconData:
                              Icon(Icons.exit_to_app_outlined, size: 26.r),
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
                ),
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: media.width,
              height: media.height,
              color: const Color(0xffD9D9D9),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    getDatVMAdmin(context);
                    Navigator.of(context).pushNamed(PerfilUserScreen.route);
                  },
                  child: Container(
                    margin: EdgeInsets.all(15.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    width: media.width,
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
                    child: const HeaderWidget(),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 145.h,
                      width: 145.w,
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
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Column(
                        children: [
                          IconButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Color(0xff990303),
                              ),
                            ),
                            icon: Icon(Icons.list,
                                size: 70.r, color: Colors.white),
                            onPressed: () => Navigator.of(context)
                                .pushNamed(ListAttendance.route),
                          ),
                          Text("Asistencia", style: TextStyle(fontSize: 14.sp)),
                        ],
                      ),
                    ),
                    Container(
                      height: 145.h,
                      width: 145.w,
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Column(
                        children: [
                          IconButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Color(0xff990303),
                              ),
                            ),
                            icon: Icon(Icons.description_outlined,
                                size: 70.r, color: Colors.white),
                            onPressed: () => Navigator.of(context)
                                .pushNamed(ReportsScreen.route),
                          ),
                          Text("Reportes", style: TextStyle(fontSize: 14.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 145.h,
                      width: 145.w,
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
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Column(
                        children: [
                          IconButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Color(0xff990303),
                              ),
                            ),
                            icon: Icon(Icons.groups_outlined,
                                size: 70.r, color: Colors.white),
                            onPressed: () => Navigator.of(context)
                                .pushNamed(ListWorkerScreen.route),
                          ),
                          Text("Trabajadores",
                              style: TextStyle(fontSize: 14.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  // void getAdminVModel() async {
  //   await Provider.of<AdminProvider>(context, listen: false)
  //       .getAdminViewModel();
  //   setState(() {});
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   getAdminVModel();
  // }

  // @override
  // void didUpdateWidget(covariant HeaderWidget oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) {
        return Row(
          children: [
            Consumer<ImageProviders>(
              builder: (context, imgProvider, child) {
                // if (adminProvider.urlPhoto != "") {
                return CircleAvatar(
                  radius: 30.r,
                  backgroundColor: const Color(0xffE1E1E1),
                  foregroundImage:
                      imgProvider.imageInternetLocal(adminProvider.urlPhoto),
                );
                // } else {
                //   return Material(
                //     color: const Color(0xffE1E1E1),
                //     shape: const CircleBorder(),
                //     child: Icon(
                //       Icons.person_outline,
                //       size: 60.r,
                //     ),
                //   );
                // }
              },
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              "${adminProvider.firstNameProvider} ${adminProvider.lastNameProvider}",
              style: TextStyle(fontSize: 18.sp),
            ),
          ],
        );
      },
    );
  }
}
