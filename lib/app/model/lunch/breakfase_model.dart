import 'package:control_asistencia_app/app/model/lunch/foodservices_model.dart';

class BreakFastModel extends FoodServicesModel {
  BreakFastModel.instance() : super.instance();

  BreakFastModel(
      {required String date, required String hour, required int quantity})
      : super(date: date, hour: hour, quantity: quantity);

  @override
  BreakFastModel fromMap(json) => BreakFastModel(
      date: json["fecha"], hour: json["hora"], quantity: json["cantidad"]);

  @override
  Map<String, dynamic> toMap() => {
        "Desayuno": {
          "hora": hour,
          "cantidad": quantity,
        },
        "fecha": date
      };
}
