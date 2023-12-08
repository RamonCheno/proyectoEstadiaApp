import 'package:control_asistencia_app/app/packages/packages_pub.dart';

class DropDownMenuCustomWidget extends StatelessWidget {
  const DropDownMenuCustomWidget(
      {super.key,
      required this.options,
      required this.selectOption,
      required this.onChanged,
      required this.title});
  final List<String> options;
  final String selectOption;
  final String title;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 30.w),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: 169.w,
          color: Colors.white,
          child: DropdownButton(
            isExpanded: true,
            iconSize: 24.r,
            value: selectOption,
            items: options.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ));
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
