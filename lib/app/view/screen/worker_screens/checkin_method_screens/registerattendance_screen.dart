import 'package:after_layout/after_layout.dart';
import 'package:control_asistencia_app/app/common/shared_preferences_common.dart';
import 'package:control_asistencia_app/app/model/attendance/attendance_model.dart';
import 'package:control_asistencia_app/app/model/attendance/checkout_model.dart';
import 'package:control_asistencia_app/app/model/attendance/ckeckin_model.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/provider/attendande_provider.dart';
import 'package:control_asistencia_app/app/view/provider/worker_provider.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RegisterAttendanceScreen extends StatefulWidget {
  const RegisterAttendanceScreen({super.key});
  static const route = "/registerAttendanceScreen";

  @override
  State<RegisterAttendanceScreen> createState() =>
      _RegisterAttendanceScreenState();
}

class _RegisterAttendanceScreenState extends State<RegisterAttendanceScreen>
    with AfterLayoutMixin<RegisterAttendanceScreen> {
  //TODO: Rehacer el apartado de registro utilizando providers

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _conSearchNumWorker = TextEditingController();

  DateFormat formatoFecha = DateFormat('dd-MM-yyyy');
  DateFormat formatoHora = DateFormat('hh:mm a');
  String? nowDayText;
  String? nowTimeText;
  String? id;
  String? _title;
  String? fechaEntrada;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    nowDayText = formatoFecha.format(DateTime.now());
    nowTimeText = formatoHora.format(
      DateTime(1, 1, 1, TimeOfDay.now().hour, TimeOfDay.now().minute),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _title = args["title"];
    debugPrint(_title);
  }

  void registerAttendance() async {
    final FormState? from = _formKey.currentState;
    String titleMayus = toBeginningOfSentenceCase(_title)!;
    final WorkerProvider workerProvider =
        Provider.of<WorkerProvider>(context, listen: false);
    final attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);

    if (from != null && from.validate()) {
      from.save();
      String searchNumWorker = _conSearchNumWorker.text;
      WorkerModel? foundWorker = await workerProvider
          .selectWorkerModel(int.parse(searchNumWorker), useAnominoAuth: true);
      if (foundWorker == null) {
        if (mounted) {
          attendanceProvider.showResponseDialog(context,
              [const Text("Trabajador no encontrado")], _conSearchNumWorker,
              titleDialog: "Error");
        }
      } else {
        if (_title == "entrada" || _title == "salida") {
          AttendanceModel attendanceModel;
          if (_title == "entrada") {
            attendanceModel =
                CheckInModel(hour: nowTimeText!, day: nowDayText!);
          } else {
            attendanceModel =
                CheckOutModel(hour: nowTimeText!, day: nowDayText!);
          }
          bool isCheckIn = _title == "entrada";

          String response;
          if (isCheckIn) {
            response = await attendanceProvider.addCheckInProvider(
                attendanceModel, foundWorker.numTrabajador);
            fechaEntrada = attendanceModel.fecha;
            await SharedPreferencesCommon.saveString(
                "fechaEntrada", fechaEntrada!);
          } else {
            fechaEntrada =
                await SharedPreferencesCommon.loadString("fechaEntrada");
            response = await attendanceProvider.addCheckOutProvider(
                attendanceModel, foundWorker.numTrabajador, fechaEntrada!);
          }
          if (mounted) {
            if (response == "asistencia guardado") {
              attendanceProvider.showResponseDialog(
                  context,
                  [
                    Text(
                        "Trabajador: ${foundWorker.apellido} ${foundWorker.nombre}"),
                    Text("Hora: $nowTimeText"),
                    Text("Fecha: $nowDayText")
                  ],
                  _conSearchNumWorker,
                  addWorker: true,
                  titleDialog: titleMayus);
            } else {
              attendanceProvider.showResponseDialog(
                  context,
                  [const Text("Error al guardar asistencia")],
                  _conSearchNumWorker,
                  titleDialog: "Error");
            }
          }
        } else {
          if (!mounted) return;
          attendanceProvider.showResponseDialog(
              context,
              [
                Text(
                    "Trabajador: ${foundWorker.apellido} ${foundWorker.nombre}"),
                Text("Hora: $nowTimeText"),
                Text("Fecha: $nowDayText")
              ],
              _conSearchNumWorker,
              addWorker: true,
              titleDialog: titleMayus);
        }
      }
      setState(() {
        nowDayText = formatoFecha.format(DateTime.now());
        nowTimeText = formatoHora.format(
          DateTime(1, 1, 1, TimeOfDay.now().hour, TimeOfDay.now().minute),
        );
      });
    }
  }

  // void registerAttendanceVDos() async {
  //   final FormState? form = _formKey.currentState;
  //   String titleMayus = toBeginningOfSentenceCase(_title)!;
  //   WorkerProvider workerProvider =
  //       Provider.of<WorkerProvider>(context, listen: false);
  //   final attendanceProvider =
  //       Provider.of<AttendanceProvider>(context, listen: false);

  //   if (form == null || !form.validate()) return;

  //   form.save();
  //   String searchNumWorker = _conSearchNumWorker.text;
  //   WorkerModel? foundWorker = await workerProvider
  //       .selectWorkerModel(int.parse(searchNumWorker), useAnominoAuth: true);

  //   if (foundWorker == null) {
  //     if (mounted) {
  //       attendanceProvider.showResponseDialog(context,
  //           [const Text("Trabajador no encontrado")], _conSearchNumWorker,
  //           titleDialog: "Error");
  //     }
  //     return;
  //   }

  //   if (_title == "entrada") {
  //     CheckInModel checkInModel =
  //         CheckInModel(hour: nowTimeText!, day: nowDayText!);
  //     bool response = await attendanceProvider.addCheckInProvider(
  //         checkInModel, foundWorker.numTrabajador);

  //     if (response) {
  //       fechaEntrada = checkInModel.fecha;
  //       if (mounted) {
  //         attendanceProvider.showResponseDialog(
  //           context,
  //           [
  //             Text("Trabajador: ${foundWorker.apellido} ${foundWorker.nombre}"),
  //             Text("Hora: $nowTimeText"),
  //             Text("Fecha: $nowDayText")
  //           ],
  //           _conSearchNumWorker,
  //           addWorker: true,
  //           titleDialog: titleMayus,
  //         );
  //       }
  //       await SharedPreferencesCommon.saveString("fechaEntrada", fechaEntrada!);
  //     } else {
  //       if (mounted) {
  //         attendanceProvider.showResponseDialog(context,
  //             [const Text("Error al guardar asistencia")], _conSearchNumWorker,
  //             titleDialog: "Error");
  //       }
  //     }
  //   } else if (_title == "salida") {
  //     fechaEntrada = await SharedPreferencesCommon.loadString("fechaEntrada");
  //     CheckOutModel checkOutModel =
  //         CheckOutModel(hour: nowTimeText!, day: nowDayText!);
  //     String response = await attendanceProvider.addCheckOutProvider(
  //         checkOutModel, foundWorker.numTrabajador, fechaEntrada!);

  //     if (mounted) {
  //       if (response == "asistencia guardado") {
  //         attendanceProvider.showResponseDialog(
  //           context,
  //           [
  //             Text("Trabajador: ${foundWorker.apellido} ${foundWorker.nombre}"),
  //             Text("Hora: $nowTimeText"),
  //             Text("Fecha: $nowDayText")
  //           ],
  //           _conSearchNumWorker,
  //           addWorker: true,
  //           titleDialog: titleMayus,
  //         );
  //       } else {
  //         attendanceProvider.showResponseDialog(context,
  //             [const Text("Error al guardar asistencia")], _conSearchNumWorker,
  //             titleDialog: "Error");
  //       }
  //     }
  //   }
  // }

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
                  "Ingrese su numero de trabajador para registar $_title",
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
            ],
          ),
        ),
      ),
    );
  }
}
