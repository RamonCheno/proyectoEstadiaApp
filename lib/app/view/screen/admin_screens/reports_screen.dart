import 'package:control_asistencia_app/app/packages/packagelocal_widgets.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});
  static const String route = "/reportsScreen";

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  bool _isVisible = false;
  String _selectedOptionReport = "Seleccione";
  String _selectPeriod = "Seleccione";
  String _initDate = "";
  String _finishtDate = "";
  final List<String> _optionReport = [
    "Seleccione",
    "Asistencia",
    "Comedor",
  ];
  final List<String> _optionPeriod = [
    "Seleccione",
    "Diaria",
    "rango de fechas"
  ];
  DateFormat formatoFecha = DateFormat('dd-MM-yyyy');

  Future<DateTime?> _selectedInitialDay(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    return picked;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initDate = formatoFecha.format(DateTime.now());
    _finishtDate = formatoFecha.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generar Reportes",
            style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: const Color(0xffEBEBEB),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                "Seleccione el tipo de reporte y periodo que desee generar",
                style: TextStyle(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 340.w,
              height: 295.h,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              color: const Color(0xffD9D9D9),
              child: Column(
                children: [
                  DropDownMenuCustomWidget(
                    title: "Reporte",
                    selectOption: _selectedOptionReport,
                    options: _optionReport,
                    onChanged: (value) {
                      setState(() {
                        _selectedOptionReport = value!;
                      });
                    },
                  ),
                  SizedBox(height: 45.h),
                  DropDownMenuCustomWidget(
                    title: "Periodo",
                    selectOption: _selectPeriod,
                    options: _optionPeriod,
                    onChanged: (value) {
                      setState(() {
                        _selectPeriod = value!;
                      });
                    },
                  ),
                  SizedBox(height: 45.h),
                  DateCustomWidget(
                    title: "Fecha Inicial:",
                    initDate: _initDate,
                    onPressed: () async {
                      DateTime? selectedDate =
                          await _selectedInitialDay(context);
                      if (selectedDate != null) {
                        setState(() {
                          _initDate = formatoFecha.format(selectedDate);
                        });
                      }
                    },
                  ),
                  SizedBox(height: 45.h),
                  DateCustomWidget(
                    title: "Fecha final:",
                    initDate: _finishtDate,
                    onPressed: () async {
                      DateTime? selectedDate =
                          await _selectedInitialDay(context);
                      if (selectedDate != null) {
                        setState(() {
                          _finishtDate = formatoFecha.format(selectedDate);
                        });
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateCustomWidget extends StatelessWidget {
  const DateCustomWidget(
      {super.key,
      required this.title,
      required this.initDate,
      required this.onPressed});

  final String title;
  final String initDate;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(width: 32.w),
        Container(
          // margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          width: 169.w,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                initDate,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.date_range,
                  color: Color(0xffF69100),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
