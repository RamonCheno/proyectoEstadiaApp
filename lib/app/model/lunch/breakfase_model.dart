import 'package:control_asistencia_app/app/model/lunch/foodservices_model.dart';

class BreakFastModel extends FoodServicesModel {
  BreakFastModel.instance() : super.instance();

  BreakFastModel({required String date, required String hour})
      : super(date: date, hour: hour);

  @override
  BreakFastModel fromMap(json) => BreakFastModel(
        date: json["fecha"],
        hour: json["hora"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "Desayuno": {
          "hora": hour,
        },
        "fecha": date
      };
}
