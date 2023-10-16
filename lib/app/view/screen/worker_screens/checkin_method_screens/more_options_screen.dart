// import 'package:control_asistencia_app/app/view/screen/worker_screens/checkin_method_screens/checkin_fingerprint_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter/material.dart';

class MoreOptionsScreen extends StatefulWidget {
  const MoreOptionsScreen({super.key});
  static const route = "moreOptionScreen";

  @override
  State<MoreOptionsScreen> createState() => _MoreOptionsScreenState();
}

class _MoreOptionsScreenState extends State<MoreOptionsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _conSearchNumWorker;

  @override
  void initState() {
    super.initState();
    _conSearchNumWorker = TextEditingController();
  }

  void registerAttendance() async {
    final FormState? form = _formKey.currentState;
    String searchNumWorker = _conSearchNumWorker.text;
    if (form != null) {
      if (form.validate()) {
        form.save();
        //Llamar al metodo para buscar al trabajador por numero.
        debugPrint("Busqueda de numero ingresado");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _conSearchNumWorker.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registrar Entrada",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffEBEBEB),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              // Row(
              //   children: [

              //   ],
              // ),
              CustomTextFormWidget(
                controller: _conSearchNumWorker,
                hintName: "Num Trabajador",
                icon: Icons.numbers,
                isObscureText: false,
                inputType: TextInputType.number,
                action: TextInputAction.done,
                soloLeer: false,
                lengthChar: 8,
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
                    onPressed: registerAttendance,
                    child: const Text(
                      'Aceptar',
                    ),
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () => Navigator.of(context)
              //       .pushReplacementNamed(CheckInFingerPrintScreen.route),
              //   icon: const Icon(Icons.fingerprint),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
