import 'package:control_asistencia_app/app/model/lunch/foodservices_model.dart';

class DinnerModel extends FoodServicesModel {
  DinnerModel(
      {required super.hour, required super.quantity, required super.date});

  @override
  DinnerModel fromMap(Map<String, dynamic> json) => DinnerModel(
        date: json["fecha"],
        hour: json["hora"],
        quantity: json["cantidad"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "Cena": {
          "hora": hour,
          "cantidad": quantity,
        },
        "fecha": date
      };
}
