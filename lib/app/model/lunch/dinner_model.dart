import 'package:control_asistencia_app/app/model/lunch/foodservices_model.dart';

class DinnerModel extends FoodServicesModel {
  DinnerModel({required String hour, required String date})
      : super(date: date, hour: hour);

  @override
  DinnerModel fromMap(Map<String, dynamic> json) => DinnerModel(
        date: json["fecha"],
        hour: json["hora"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "Cena": {
          "hora": hour,
        },
        "fecha": date
      };
}
