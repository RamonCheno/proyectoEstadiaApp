import 'dart:io';

import 'package:control_asistencia_app/app/model/user/admin_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/provider/adminprovider.dart';
import 'package:control_asistencia_app/app/view/provider/image_provider.dart';
import 'package:control_asistencia_app/app/view/provider/perfil_provide.dart';
import 'package:control_asistencia_app/app/view/screen/camera_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditInfoAdminScreen extends StatefulWidget {
  const EditInfoAdminScreen({super.key});
  static const String route = "/editInfoAdmin";

  @override
  State<EditInfoAdminScreen> createState() => _EditInfoAdminScreenState();
}

class _EditInfoAdminScreenState extends State<EditInfoAdminScreen> {
  bool isEnable = false;
  bool onlyRead = true;
  // String? newImgUrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void editInformation() async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    final perfilProvider =
        Provider.of<UpdatePerfilProvider>(context, listen: false);
    final imageProvider = Provider.of<ImageProviders>(context, listen: false);
    if (perfilProvider.imagePath == "") {
      String assetPath =
          await imageProvider.getAssetPath("assets/images/usuario.png");
      perfilProvider.setNewImagePath(assetPath);
    }
    final FormState? form = _formKey.currentState;
    final int numAdmin = int.parse(perfilProvider.conNumWorker.text);
    final String firstName = perfilProvider.conFirstNameWorker.text;
    final String lastName = perfilProvider.conLastNameWorker.text;
    final String rfcAdmin = perfilProvider.conRFCWorker.text.toUpperCase();
    final String curp = perfilProvider.conCurpWorker.text.toUpperCase();
    final int imss = int.parse(perfilProvider.conIMSSWorker.text);
    final String position = perfilProvider.conAdminPosition.text.trim();
    await adminProvider.getUrlImage(
        File(perfilProvider.imagePath!), firstName, lastName);
    final String imagePath = adminProvider.urlPhoto!;
    if (form != null) {
      if (form.validate()) {
        form.save();
        AdminModel adminModel = AdminModel(
          numTrabajador: numAdmin,
          nombre: firstName.trim(),
          apellido: lastName.trim(),
          curp: curp.trim(),
          rfc: rfcAdmin.trim(),
          numImss: imss,
          email: perfilProvider.email,
          puesto: position.trim(),
          urlPhoto: perfilProvider.imagePath!.startsWith("https")
              ? perfilProvider.imagePath!
              : imagePath,
        );
        adminProvider.updateInfoProvider(adminModel).then((response) {
          if (response == "Informacion actualizado") {
            adminProvider.showResponseDialog(context, response,
                updateInfo: true);
          } else {
            adminProvider.showResponseDialog(context, response);
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<UpdatePerfilProvider>(context, listen: false)
        .getDataPerfil(context);
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () async {
                    //Metodo para tomar foto por camara
                    final updateAdmin = Provider.of<UpdatePerfilProvider>(
                        context,
                        listen: false);
                    Navigator.pop(context);
                    String? img = await Navigator.of(context)
                        .pushNamed(CameraScreen.route)
                        .then((img) {
                      return img as String;
                    });
                    if (img != null) {
                      setState(() {
                        updateAdmin.setNewImagePath(img);
                      });
                    }
                  },
                ),
                const Text("Tomar Foto"),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_library_outlined),
                  onPressed: () async {
                    //Metodo para tomar foto por galeria
                    final imageProvider =
                        Provider.of<ImageProviders>(context, listen: false);
                    String newImagePath =
                        await imageProvider.pickImageFromGallery();
                    if (!mounted) return;
                    setState(() {
                      Provider.of<UpdatePerfilProvider>(context, listen: false)
                          .setNewImagePath(newImagePath);
                    });
                    Navigator.pop(context);
                  },
                ),
                const Text("Subir Foto"),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_library_outlined),
                  onPressed: () async {
                    //Metodo para tomar foto por galeria
                    String assetPath = await Provider.of<ImageProviders>(
                            context,
                            listen: false)
                        .getAssetPath("assets/images/usuario.png");
                    if (!mounted) return;
                    setState(() {
                      Provider.of<UpdatePerfilProvider>(context, listen: false)
                          .setNewImagePath(assetPath);
                    });
                    Navigator.pop(context);
                  },
                ),
                const Text("Elimiar Foto"),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar informacion"),
        backgroundColor: const Color(0xffD9D9D9),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isEnable = !isEnable;
                  onlyRead = !onlyRead;
                });
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      backgroundColor: const Color(0xffD9D9D9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<UpdatePerfilProvider>(
              builder: (context, updateperfilProvider, child) {
                return Column(
                  children: [
                    Stack(alignment: Alignment.bottomRight, children: [
                      Consumer<ImageProviders>(
                        builder: (context, imgProvider, child) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: CircleAvatar(
                              radius: 50.r,
                              backgroundColor: const Color(0xffE1E1E1),
                              foregroundImage: imgProvider.imageInternetLocal(
                                  updateperfilProvider.imagePath),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade400), // Color de fondo
                        ),
                        color: Colors.black,
                        iconSize: 30.r,
                        onPressed: () {
                          showBottomSheet();
                        },
                        icon: const Icon(Icons.add_a_photo_outlined),
                      ),
                    ]),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormWidget(
                            controller: updateperfilProvider.conNumWorker,
                            hintName: "Num Trabajador",
                            icon: Icons.numbers,
                            isObscureText: false,
                            inputType: TextInputType.number,
                            action: TextInputAction.next,
                            soloLeer: true,
                            lengthChar: 8,
                            isEnable: false,
                          ),
                          CustomTextFormWidget(
                            controller: updateperfilProvider.conFirstNameWorker,
                            hintName: "Nombre",
                            icon: Icons.person_outline,
                            isObscureText: false,
                            inputType: TextInputType.text,
                            action: TextInputAction.next,
                            soloLeer: onlyRead,
                            isEnable: isEnable,
                          ),
                          CustomTextFormWidget(
                            controller: updateperfilProvider.conLastNameWorker,
                            hintName: "Apellido",
                            icon: Icons.person_outline,
                            isObscureText: false,
                            inputType: TextInputType.text,
                            action: TextInputAction.next,
                            soloLeer: onlyRead,
                            isEnable: isEnable,
                          ),
                          CustomTextFormWidget(
                              controller: updateperfilProvider.conRFCWorker,
                              hintName: "RFC",
                              icon: Icons.person_outline,
                              isObscureText: false,
                              inputType: TextInputType.text,
                              action: TextInputAction.next,
                              soloLeer: onlyRead,
                              isEnable: isEnable,
                              lengthChar: 13),
                          CustomTextFormWidget(
                              controller: updateperfilProvider.conCurpWorker,
                              hintName: "Curp",
                              icon: Icons.person_outline,
                              isObscureText: false,
                              inputType: TextInputType.text,
                              action: TextInputAction.next,
                              soloLeer: onlyRead,
                              isEnable: isEnable,
                              lengthChar: 18),
                          CustomTextFormWidget(
                              controller: updateperfilProvider.conIMSSWorker,
                              hintName: "Num Imss",
                              icon: Icons.numbers,
                              isObscureText: false,
                              inputType: TextInputType.number,
                              action: TextInputAction.next,
                              soloLeer: onlyRead,
                              isEnable: isEnable,
                              lengthChar: 11),
                          CustomTextFormWidget(
                            controller: updateperfilProvider.conAdminPosition,
                            hintName: "Puesto",
                            icon: Icons.person_outline,
                            isObscureText: false,
                            inputType: TextInputType.text,
                            action: TextInputAction.done,
                            soloLeer: onlyRead,
                            isEnable: isEnable,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
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
                  onPressed: editInformation,
                  child: const Text(
                    'Actualizar',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
