import 'dart:io';

import 'package:control_asistencia_app/app/packages/packagelocal_controller.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_model.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_provider.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_widgets.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';

class UpdateWorkerScreen extends StatefulWidget {
  const UpdateWorkerScreen({super.key});
  static const route = "/updateWorkScreen";

  @override
  State<UpdateWorkerScreen> createState() => _UpdateWorkerScreenState();
}

class _UpdateWorkerScreenState extends State<UpdateWorkerScreen>
    with AfterLayoutMixin<UpdateWorkerScreen> {
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
  bool isEnable = false;
  bool onlyRead = true;

  Future<void> updateWorker() async {
    final FormState? form = _formKey.currentState;
    final WorkerProvider workerProvider =
        Provider.of<WorkerProvider>(context, listen: false);
    // ImageProviders imageProvider =
    //     Provider.of<ImageProviders>(context, listen: false);
    if (form != null) {
      if (form.validate()) {
        // if (_imagePath == null) {
        //   String assetPath =
        //       await imageProvider.getAssetPath("assets/images/usuario.png");
        //   _imagePath = assetPath;
        //   // workerProvider.showResponseDialog(context, "Agregar una foto");
        // }
        form.save();
        String firstNameWorker = _conFirstNameWorker.text;
        String lastNameWorker = _conLastNameWorker.text;
        String rfcWorker = _conRFCWorker.text.toUpperCase();
        String curpWorker = _conCurpWorker.text.toUpperCase();
        int numIMSSWorker = int.parse(_conIMSSWorker.text);
        String workerPosition = _conworkerPosition.text.toUpperCase();
        String urlImage = await workerProvider.getUrlImage(
            File(_imagePath!), firstNameWorker, lastNameWorker);
        WorkerModel workerModel = WorkerModel(
          numTrabajador: numWorkerSelect,
          nombre: firstNameWorker.trim(),
          apellido: lastNameWorker.trim(),
          curp: curpWorker.trim(),
          rfc: rfcWorker.trim(),
          numImss: numIMSSWorker,
          puesto: workerPosition.trim(),
          urlPhoto: _imagePath!.startsWith("https") ? _imagePath! : urlImage,
          visible: true,
          // idHuella: idWorker,
        );
        workerProvider
            .updateWorkerProvider(workerModel, numWorkerSelect!)
            .then((response) {
          if (response == "Trabajador actualizado") {
            workerProvider.showResponseDialog(context, response,
                addWorker: true);
          } else {
            workerProvider.showResponseDialog(context, response);
          }
        });
      }
    }
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
                  onPressed: () {
                    //Metodo para tomar foto por galeria
                    final imageProvider =
                        Provider.of<ImageProviders>(context, listen: false);
                    imageProvider.pickImageFromGallery().then((value) {
                      setState(() {
                        _imagePath = value;
                      });
                      Navigator.pop(context);
                    });
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _args = args;
    numWorkerSelect = _args["numWorkerSelectArg"];
    workerModelSelect = _args["workerModelSelectArg"];
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    if (workerModelSelect != null) {
      _conNumWorker.text = workerModelSelect!.numTrabajador.toString();
      _conFirstNameWorker.text = workerModelSelect!.nombre;
      _conLastNameWorker.text = workerModelSelect!.apellido;
      _conRFCWorker.text = workerModelSelect!.rfc!;
      _conCurpWorker.text = workerModelSelect!.curp!;
      _conIMSSWorker.text = workerModelSelect!.numImss.toString();
      _conworkerPosition.text = workerModelSelect!.puesto!;
      if (workerModelSelect!.urlPhoto != null &&
          workerModelSelect!.urlPhoto != "") {
        _imagePath = workerModelSelect!.urlPhoto;
        setState(() {});
      } else {
        final imageProvider =
            Provider.of<ImageProviders>(context, listen: false);
        await imageProvider.getAssetPath("assets/images/usuario.png");
        setState(() {
          _imagePath = imageProvider.assetFilePath;
        });
      }
    }
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
                  onlyRead = !onlyRead;
                });
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(alignment: Alignment.bottomRight, children: [
              Consumer<ImageProviders>(
                builder: (context, imgProvider, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: const Color(0xffE1E1E1),
                      foregroundImage:
                          imgProvider.imageInternetLocal(_imagePath),
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
                    controller: _conNumWorker,
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
                    controller: _conFirstNameWorker,
                    hintName: "Nombre",
                    icon: Icons.person_outline,
                    isObscureText: false,
                    inputType: TextInputType.text,
                    action: TextInputAction.next,
                    soloLeer: onlyRead,
                    isEnable: isEnable,
                  ),
                  CustomTextFormWidget(
                    controller: _conLastNameWorker,
                    hintName: "Apellido",
                    icon: Icons.person_outline,
                    isObscureText: false,
                    inputType: TextInputType.text,
                    action: TextInputAction.next,
                    soloLeer: onlyRead,
                    isEnable: isEnable,
                  ),
                  CustomTextFormWidget(
                      controller: _conRFCWorker,
                      hintName: "RFC",
                      icon: Icons.person_outline,
                      isObscureText: false,
                      inputType: TextInputType.text,
                      action: TextInputAction.next,
                      soloLeer: onlyRead,
                      isEnable: isEnable,
                      lengthChar: 13),
                  CustomTextFormWidget(
                      controller: _conCurpWorker,
                      hintName: "Curp",
                      icon: Icons.person_outline,
                      isObscureText: false,
                      inputType: TextInputType.text,
                      action: TextInputAction.next,
                      soloLeer: onlyRead,
                      isEnable: isEnable,
                      lengthChar: 18),
                  CustomTextFormWidget(
                      controller: _conIMSSWorker,
                      hintName: "Num Imss",
                      icon: Icons.numbers,
                      isObscureText: false,
                      inputType: TextInputType.number,
                      action: TextInputAction.next,
                      soloLeer: onlyRead,
                      isEnable: isEnable,
                      lengthChar: 11),
                  CustomTextFormWidget(
                    controller: _conworkerPosition,
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
    );
  }
}
