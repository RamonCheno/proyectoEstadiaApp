import 'package:control_asistencia_app/app/model/lunch/foodservices_model.dart';

class LunchModel extends FoodServicesModel {
  LunchModel.instance() : super.instance();

  LunchModel(
      {required String date, required String hour, required int quantity})
      : super(date: date, hour: hour, quantity: quantity);

  @override
  LunchModel fromMap(Map<String, dynamic> json) => LunchModel(
      date: json["fecha"], hour: json["hora"], quantity: json["cantidad"]);

  @override
  Map<String, dynamic> toMap() => {
        "Almuerzo": {
          "hora": hour,
          "cantidad": quantity,
        },
        "fecha": date
      };
}
