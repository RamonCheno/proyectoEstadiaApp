import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:control_asistencia_app/app/common/shared_preferences_common.dart';
import 'package:control_asistencia_app/app/controller/attendance_controllers/attendance_controller.dart';
import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/model/attendance/checkout_model.dart';
import 'package:control_asistencia_app/app/model/attendance/ckeckin_model.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/provider/attendande_provider.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MoreOptionsScreen extends StatefulWidget {
  const MoreOptionsScreen({super.key});
  static const route = "moreOptionScreen";

  @override
  State<MoreOptionsScreen> createState() => _MoreOptionsScreenState();
}

class _MoreOptionsScreenState extends State<MoreOptionsScreen>
    with AfterLayoutMixin<MoreOptionsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final WorkerController _workerController = WorkerController();
  final AttendanceController _attendanceController = AttendanceController();
  late TextEditingController _conSearchNumWorker;

  DateFormat formatoFecha = DateFormat('dd-MM-yyyy');
  DateFormat formatoHora = DateFormat('hh:mm a');
  String? nowDayText;
  String? nowTimeText;
  late bool _isEntrance;
  String? id;
  late String _title;
  String? fechaEntrada;

  @override
  void initState() {
    super.initState();
    _conSearchNumWorker = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _isEntrance = args["isEntrance"]!;
    _title = args["title"];
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    nowDayText = formatoFecha.format(DateTime.now());
    nowTimeText = formatoHora.format(
      DateTime(1, 1, 1, TimeOfDay.now().hour, TimeOfDay.now().minute),
    );
  }

  void registerAttendance() async {
    final FormState? form = _formKey.currentState;
    String searchNumWorker = _conSearchNumWorker.text;
    String titleMayus = toBeginningOfSentenceCase(_title)!;
    if (form != null) {
      if (form.validate()) {
        form.save();
        //Llamar al metodo para buscar al trabajador por numero.
        WorkerModel? foundWorker =
            await _workerController.getWorkerData(int.parse(searchNumWorker));
        if (foundWorker == null) {
          if (!mounted) return;
          showErrorDialog("trabajador");
        } else {
          debugPrint("${foundWorker.toMap()}");
          debugPrint("Busqueda de numero ingresado");
          if (_isEntrance) {
            CheckInModel checkInModel =
                CheckInModel(hour: nowTimeText!, day: nowDayText!);
            // await _attendanceController.addCheckIn(
            //     checkInModel, foundWorker.numTrabajador);
            if (!mounted) return;
            Provider.of<AttendanceProvider>(context, listen: false)
                .addCheckInProvider(checkInModel, foundWorker.numTrabajador);
            fechaEntrada = checkInModel.fechaEntrada;
            showCustomDialog(
                foundWorker.apellido, foundWorker.nombre, titleMayus);
            await SharedPreferencesCommon.saveString(
                "fechaEntrada", fechaEntrada!);
          } else {
            fechaEntrada =
                await SharedPreferencesCommon.loadString("fechaEntrada");
            checkOutAlert(nowTimeText!, nowDayText!, foundWorker, titleMayus);
          }
        }
      }
    }
  }

  void showCustomDialog(String apellido, String nombre, String title) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(
          const Duration(seconds: 3),
          () {
            Navigator.of(context).pop();
            _conSearchNumWorker.clear();
          },
        );
        return CustomDialogWidget(
          iconData: const Icon(Icons.check_circle, color: Colors.green),
          messagge: Column(children: [
            Text("Trabajador: $apellido $nombre"),
            Text("Hora: $nowTimeText"),
            Text("Fecha: $nowDayText")
          ]),
          title: "$title Registrada",
        );
      },
    );
    setState(() {
      nowDayText = formatoFecha.format(DateTime.now());
      nowTimeText = formatoHora.format(
        DateTime(1, 1, 1, TimeOfDay.now().hour, TimeOfDay.now().minute),
      );
    });
  }

  void showErrorDialog(String errorMessagge) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(
          const Duration(seconds: 3),
          () {
            Navigator.of(context).pop();
            _conSearchNumWorker.clear();
          },
        );
        return CustomDialogWidget(
          iconData: const Icon(Icons.cancel, color: Colors.red),
          messagge: Column(
            children: [
              Text("$errorMessagge no encontrado"),
            ],
          ),
          title: "Error",
        );
      },
    );
    setState(() {
      nowDayText = formatoFecha.format(DateTime.now());
      nowTimeText = formatoHora.format(
        DateTime(1, 1, 1, TimeOfDay.now().hour, TimeOfDay.now().minute),
      );
    });
  }

  void checkOutAlert(String timeNow, String dayNow, WorkerModel workerModel,
      String title) async {
    CheckOutModel checkOutModel =
        CheckOutModel(hour: nowTimeText!, day: nowDayText!);
    String response = await _attendanceController.addCheckOut(
        checkOutModel, workerModel.numTrabajador, fechaEntrada!);
    if (response == "asistencia guardado") {
      showCustomDialog(workerModel.apellido, workerModel.nombre, title);
    } else {
      showErrorDialog(response);
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
        title: Text(
          "Registrar $_title",
          style: const TextStyle(fontWeight: FontWeight.w700),
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
              Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 15.w),
                child: Text(
                  "Ingrese su numero de trabajador para registar entrada",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
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
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      textStyle: TextStyle(fontSize: 16.sp),
                      backgroundColor: const Color(0xFFD9D9D9),
                      foregroundColor: const Color(0xFF000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).w,
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
