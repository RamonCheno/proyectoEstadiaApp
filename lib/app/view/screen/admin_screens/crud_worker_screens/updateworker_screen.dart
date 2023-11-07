import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/provider/image_provider.dart';
import 'package:control_asistencia_app/app/view/provider/worker_provider.dart';
import 'package:control_asistencia_app/app/view/screen/camera_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UpdateWorkerScreen extends StatefulWidget {
  const UpdateWorkerScreen({super.key});
  static const route = "/updateWorkScreen";

  @override
  State<UpdateWorkerScreen> createState() => _UpdateWorkerScreenState();
}

class _UpdateWorkerScreenState extends State<UpdateWorkerScreen> {
  final TextEditingController _conNumWorker = TextEditingController();
  final TextEditingController _conFirstNameWorker = TextEditingController();
  final TextEditingController _conLastNameWorker = TextEditingController();
  final TextEditingController _conRFCWorker = TextEditingController();
  final TextEditingController _conCurpWorker = TextEditingController();
  final TextEditingController _conIMSSWorker = TextEditingController();
  final TextEditingController _conworkerPosition = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  WorkerController workerController = WorkerController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Map<String, dynamic> _args = {};
  WorkerModel? workerModelSelect;
  int? numWorkerSelect;
  String? _imagePath;
  final picker = ImagePicker();
  bool isEnable = true;

  void updateWorker() async {
    final FormState? form = _formKey.currentState;
    WorkerProvider workerProvider =
        Provider.of<WorkerProvider>(context, listen: false);
    String firstNameWorker = _conFirstNameWorker.text;
    String lastNameWorker = _conLastNameWorker.text;
    String rfcWorker = _conRFCWorker.text.toUpperCase();
    String curpWorker = _conCurpWorker.text.toUpperCase();
    int numIMSSWorker = int.parse(_conIMSSWorker.text);
    String workerPosition = _conworkerPosition.text;
    String urlImage = await workerProvider.getUrlImage(
        File(_imagePath!), firstNameWorker, lastNameWorker);

    if (form != null) {
      if (form.validate()) {
        form.save();
        WorkerModel workerModel = WorkerModel(
          numTrabajador: numWorkerSelect,
          nombre: firstNameWorker.trim(),
          apellido: lastNameWorker.trim(),
          curp: curpWorker.trim(),
          rfc: rfcWorker.trim(),
          numImss: numIMSSWorker,
          puesto: workerPosition.trim(),
          urlPhoto: urlImage,
          // idHuella: idWorker,
        );
        String response = await workerProvider.updateWorkerProvider(
            workerModel, numWorkerSelect!);
        if (!mounted) return;
        if (response == "Trabajador actualizado") {
          workerProvider.showResponseDialog(context, response, addWorker: true);
        } else {
          workerProvider.showResponseDialog(context, response);
        }
      }
    }
  }

  ImageProvider<Object>? imageInternetLocal() {
    ImageProvider? image;
    ImageProvider imgNetwork = CachedNetworkImageProvider(_imagePath!);
    ImageProvider imgAssets = const AssetImage("assets/images/usuario.png");
    if (_imagePath != null) {
      image = _imagePath!.startsWith("https")
          ? imgNetwork
          : FileImage(File(_imagePath!));
    } else {
      image = imgAssets;
    }

    return image;
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
                    Navigator.pop(context);
                    Navigator.of(context)
                        .pushNamed(CameraScreen.route)
                        .then((img) {
                      if (img != null) {
                        setState(() {
                          _imagePath = img as String;
                        });
                      }
                    });
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
                    await imageProvider.pickImageFromGallery();
                    if (!mounted) return;
                    setState(() {
                      _imagePath = imageProvider.imagePath;
                    });
                    Navigator.pop(context);
                  },
                ),
                const Text("Subir Foto"),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // loadMacAddress();
  }

  @override
  void dispose() {
    super.dispose();
    _conNumWorker.dispose();
    _conFirstNameWorker.dispose();
    _conLastNameWorker.dispose();
    _conRFCWorker.dispose();
    _conCurpWorker.dispose();
    _conIMSSWorker.dispose();
    _conworkerPosition.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _args = args;
    numWorkerSelect = _args["numWorkerSelectArg"];
    workerModelSelect = _args["workerModelSelectArg"];
    if (workerModelSelect != null) {
      _conNumWorker.text = workerModelSelect!.numTrabajador.toString();
      _conFirstNameWorker.text = workerModelSelect!.nombre;
      _conLastNameWorker.text = workerModelSelect!.apellido;
      _conRFCWorker.text = workerModelSelect!.rfc;
      _conCurpWorker.text = workerModelSelect!.curp;
      _conIMSSWorker.text = workerModelSelect!.numImss.toString();
      _conworkerPosition.text = workerModelSelect!.puesto;
      _imagePath = workerModelSelect!.urlPhoto;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar Trabajador"),
        centerTitle: true,
        backgroundColor: const Color(0xffEBEBEB),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isEnable = !isEnable;
                });
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(alignment: Alignment.bottomRight, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: const Color(0xffE1E1E1),
                        foregroundImage: imageInternetLocal(),
                      ),
                    ],
                  ),
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

              CustomTextFormWidget(
                controller: _conNumWorker,
                hintName: "Num Trabajador",
                icon: Icons.numbers,
                isObscureText: false,
                inputType: TextInputType.number,
                action: TextInputAction.next,
                soloLeer: true,
                lengthChar: 8,
              ),
              CustomTextFormWidget(
                controller: _conFirstNameWorker,
                hintName: "Nombre",
                icon: Icons.person_outline,
                isObscureText: false,
                inputType: TextInputType.text,
                action: TextInputAction.next,
                soloLeer: isEnable,
              ),
              CustomTextFormWidget(
                controller: _conLastNameWorker,
                hintName: "Apellido",
                icon: Icons.person_outline,
                isObscureText: false,
                inputType: TextInputType.text,
                action: TextInputAction.next,
                soloLeer: isEnable,
              ),
              CustomTextFormWidget(
                  controller: _conRFCWorker,
                  hintName: "RFC",
                  icon: Icons.person_outline,
                  isObscureText: false,
                  inputType: TextInputType.text,
                  action: TextInputAction.next,
                  soloLeer: isEnable,
                  lengthChar: 13),
              CustomTextFormWidget(
                  controller: _conCurpWorker,
                  hintName: "Curp",
                  icon: Icons.person_outline,
                  isObscureText: false,
                  inputType: TextInputType.text,
                  action: TextInputAction.next,
                  soloLeer: isEnable,
                  lengthChar: 18),
              CustomTextFormWidget(
                  controller: _conIMSSWorker,
                  hintName: "Num Imss",
                  icon: Icons.numbers,
                  isObscureText: false,
                  inputType: TextInputType.number,
                  action: TextInputAction.next,
                  soloLeer: isEnable,
                  lengthChar: 11),
              CustomTextFormWidget(
                controller: _conworkerPosition,
                hintName: "Puesto",
                icon: Icons.person_outline,
                isObscureText: false,
                inputType: TextInputType.text,
                action: TextInputAction.done,
                soloLeer: isEnable,
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 10),
              //   child: Center(
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         elevation: 1,
              //         padding: const EdgeInsets.symmetric(horizontal: 24),
              //         textStyle: const TextStyle(fontSize: 18),
              //         backgroundColor: const Color(0xFFD9D9D9),
              //         foregroundColor: const Color(0xFF000000),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20),
              //         ),
              //       ),
              //       onPressed: () {
              //         // _showAlertDialog(context, data);
              //         //Ir a la pantalla FingerPrintRegisterScreen
              //         Navigator.of(context)
              //             .pushNamed(FingerPrintRegisterScreen.route)
              //             .then((value) {
              //           setState(() {
              //             if (value != null) {
              //               idWorker = value as int;
              //             }
              //             debugPrint("$idWorker");
              //           });
              //         });
              //       },
              //       child: const Text(
              //         'Registrar Huella Dactilar',
              //       ),
              //     ),
              //   ),
              // ),
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
                    onPressed: updateWorker,
                    child: const Text(
                      'Actualizar',
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
