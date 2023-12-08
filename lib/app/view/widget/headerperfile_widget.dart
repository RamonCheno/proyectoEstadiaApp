import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_provider.dart';

class HeaderPerfilWidget extends StatefulWidget {
  const HeaderPerfilWidget({super.key});

  @override
  State<HeaderPerfilWidget> createState() => _HeaderPerfilWidgetState();
}

class _HeaderPerfilWidgetState extends State<HeaderPerfilWidget> {
  @override
  void initState() {
    super.initState();
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
