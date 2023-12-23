import 'dart:io';

import 'package:control_asistencia_app/app/packages/packagelocal_provider.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_widgets.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';
import 'package:control_asistencia_app/app/view/provider/permissionprovider.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart' as pdfh;

class ReportsProvider extends ChangeNotifier {
  final AttendanceProvider _attendanceProvider = AttendanceProvider();
  // final PermissionProvider _permissionProvider = PermissionProvider();

  final Set<String> _uniqueDate = <String>{};

  Future<String> generateAttendanceDayReportPDF(
      String dateSelectText, BuildContext context) async {
    final permissionProvider =
        Provider.of<PermissionProvider>(context, listen: false);
    await _attendanceProvider.getListAttendance(dateSelectText);
    List<AttendanceViewModel> reportAttendanceDayList =
        _attendanceProvider.attendanceViewModelList;
    String htmlContent = '''
<style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th,
        td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
    <h1>Reporte diario de asistencias</h1>
    <p>Fecha: $dateSelectText</p>
    <table>
        <thead>
            <tr>
                <th>Numero Trabajador</th>
                <th>Nombre del Trabajador</th>
                <th>Hora de Entrada</th>
                <th>Hora de Salida</th>
            </tr>
        </thead>
        <tbody>
            ${buildTableHTMLAttendanceDay(reportAttendanceDayList)}
        </tbody>
    </table>''';
    final pdf = pdfh.Document();
    final widgets = await pdfh.HTMLToPdf().convert(htmlContent);
    pdf.addPage(
      pdfh.MultiPage(
        maxPages: 200,
        build: (context) {
          return widgets;
        },
      ),
    );

    String fileName = 'lista_de_asistencia_$dateSelectText.pdf';

    final String filePath = await obtainFilePath(fileName);

    File file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }

    if (permissionProvider.statusPermision) {
      await file.writeAsBytes(await pdf.save());
      return filePath;
    } else {
      return "Permiso denegado";
    }
  }

  Future<String> generateAttendanceRangeDayReportPDF(
      String initDay, String finishDay, BuildContext context) async {
    final permissionProvider =
        Provider.of<PermissionProvider>(context, listen: false);
    await _attendanceProvider.getListAttendanceForRangeDay(initDay, finishDay);
    List<AttendanceViewModel> reportAttendanceDayList =
        _attendanceProvider.attendanceViewModelList;
    debugPrint(daysHeaders(reportAttendanceDayList));
    String htmlContent = '''
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th,
        td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>

    <h1>Reporte de asistencias por dias</h1>
    <table>
        <thead>
            <tr>
                <th colspan = "2" style="background-color: transparent;">&nbsp;</th>
                <th style="background-color: transparent;">&nbsp;</th>
                <th >Fecha</th>
            </tr>
            <tr>
                <th>Numero</th>
                <th>Nombre</th>
                ${daysHeaders(reportAttendanceDayList)}
            </tr>
        </thead>
        <tbody>
            ${buildTableHTMLAttendanceRangeDay(reportAttendanceDayList)}
        </tbody>
    </table>
</body>
    </table>''';
    final pdf = pdfh.Document();
    final widgets = await pdfh.HTMLToPdf().convert(htmlContent);
    pdf.addPage(
      pdfh.MultiPage(
        maxPages: 200,
        build: (context) {
          return widgets;
        },
        orientation: pdfh.PageOrientation.landscape,
      ),
    );

    String fileName = 'lista_de_asistencia_${initDay}_$finishDay.pdf';

    final String filePath = await obtainFilePath(fileName);

    var file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }
    if (permissionProvider.statusPermision) {
      await file.writeAsBytes(await pdf.save());
      notifyListeners();
      return filePath;
    } else {
      return "Permiso denegado";
    }
  }

  String daysHeaders(List<AttendanceViewModel> reportAttendanceDayList) {
    for (var attendance in reportAttendanceDayList) {
      _uniqueDate.add(attendance.dayEntrance);
    }
    final headerDay = _uniqueDate.map((attendance) {
      return "<th>$attendance</th>";
    });
    return headerDay.join();
  }

  String buildTableHTMLAttendanceDay(
      List<AttendanceViewModel> reportAttendanceList) {
    //Cuerpo para reporte diario
    final row = reportAttendanceList.map((attendance) {
      return '''
        <tr>
            <td>${attendance.numberWorker}</td>
            <td>${attendance.firstNameWorker} ${attendance.lastNameWorker}</td>
            <td>${attendance.checkInHour}</td>
            <td>${attendance.checkOutHour}</td>
        </tr>
      ''';
    });
    return row.join();
  }

  Future<String?> generateReportAttendancePDF(BuildContext context,
      String optionPeriod, String initDay, String finishDay) async {
    String filePath = "";
    switch (optionPeriod) {
      case "Diaria":
        filePath = await generateAttendanceDayReportPDF(initDay, context);
        await openFileFromPath(filePath);
        break;
      case "rango de fechas":
        // ignore: use_build_context_synchronously
        filePath = await generateAttendanceRangeDayReportPDF(
            initDay, finishDay, context);
        await openFileFromPath(filePath);
        break;
      default:
        return "Seleccione una opcion valida";
    }
    return null;
  }

  void showDialogResponse(BuildContext context, String titleDialog,
      List<Widget> response, bool isNotError) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
        return CustomDialogWidget(
          title: titleDialog,
          messagge: Column(
            children: response,
          ),
          iconData: isNotError
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.cancel, color: Colors.red),
        );
      },
    );
  }

  String buildTableHTMLAttendanceRangeDay(
      List<AttendanceViewModel> reportAttendanceList) {
    Map<String, List<AttendanceViewModel>> attendanceByWorker = {};
    for (var attendance in reportAttendanceList) {
      if (!attendanceByWorker.containsKey(attendance.numberWorker)) {
        attendanceByWorker[attendance.numberWorker] = [];
      }
      attendanceByWorker[attendance.numberWorker]!.add(attendance);
    }

    final rows = attendanceByWorker.entries.map((entry) {
      final attendances = entry.value;

      attendances.sort((a, b) => a.dayEntrance.compareTo(b.dayEntrance));

      final dateCells = _uniqueDate.map((uniqueDate) {
        final AttendanceViewModel attendance = attendances.firstWhere(
            (a) => a.dayEntrance == uniqueDate,
            orElse: () => AttendanceViewModel.instance());

        return '<td>${attendance.checkInHour ?? "no"} - ${attendance.checkOutHour ?? "asistió"}</td>';
      });

      return '''
      <tr>
        <td>${attendances.first.numberWorker}</td>
        <td>${attendances.first.firstNameWorker} ${attendances.first.lastNameWorker}</td>
        ${dateCells.join()}</td>
      </tr>
    ''';
    });

    return rows.join();
  }

  Future<void> generateReportFoodServicePDF(
      String optionPeriod, String initDay, String finishDay) async {
    switch (optionPeriod) {
      case "Diaria":
        // String filePath = await generateAttendanceDayReportPDF(initDay);
        // await openFileFromPath(filePath);
        break;
      case "rango de fechas":
        // generateAttendanceRangeDayReportPDF(initDay, finishDay);
        break;
      default:
    }
  }

  Future<void> openFileFromPath(String path) async {
    final OpenResult result = await OpenFile.open(path);
    if (result.type == ResultType.done) {
      debugPrint(result.message);
    } else if (result.type == ResultType.permissionDenied) {
      debugPrint(result.message);
    }
    notifyListeners();
  }

  Future<String> obtainFilePath(String filename) async {
    String downloadPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    final String filepath = "$downloadPath/$filename";
    // debugPrint(filepath);
    return filepath;
  }
}
