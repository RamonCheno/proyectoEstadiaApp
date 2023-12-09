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

  void generateReport() {}

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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        height: 60.h,
        child: FittedBox(
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFFC8C8C8),
            onPressed: null,
            child: Icon(
              Icons.save_outlined,
              size: 30.r,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                "Seleccione el tipo de reporte y periodo que desee generar",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 340.w,
              // height: 295.h,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              color: const Color(0xFFC8C8C8),
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
                        if (_selectPeriod == "rango de fechas") {
                          _isVisible = true;
                        } else {
                          _isVisible = false;
                        }
                      });
                    },
                  ),
                  if (_isVisible)
                    Column(children: [
                      SizedBox(height: 23.h),
                      Text(
                        "Seleccione fecha de inicio y final",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 23.h),
                      DateCustomWidget(
                        title: "inicial:",
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
                        title: "final: ",
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
                    ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
