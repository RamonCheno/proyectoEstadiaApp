abstract class FoodServicesModel {
  String? _date;
  String? _hour;

  String get date => _date!;

  String get hour => _hour!;

  FoodServicesModel.instance();

  FoodServicesModel({
    required String date,
    required String hour,
  }) {
    _hour = hour;
    _date = date;
  }

  FoodServicesModel fromMap(Map<String, dynamic> json);

  Map<String, dynamic> toMap();
}


/*
  desayuno: {
    hora: 
  },
  almuerzo: {
    hora: 5:00 pm
  }
  fecha: 04/12/2023

*/