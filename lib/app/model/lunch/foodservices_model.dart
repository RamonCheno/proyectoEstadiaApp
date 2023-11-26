abstract class FoodServicesModel {
  String? _date;
  String? _hour;
  int? _quantity;

  String get date => _date!;

  String get hour => _hour!;

  int get quantity => _quantity!;

  FoodServicesModel.instance();

  FoodServicesModel(
      {required String date, required String hour, required int quantity}) {
    _hour = hour;
    _quantity = quantity;
    _date = date;
  }

  FoodServicesModel fromMap(Map<String, dynamic> json);

  Map<String, dynamic> toMap();
}
