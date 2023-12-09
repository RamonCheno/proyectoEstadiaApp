import 'package:control_asistencia_app/app/packages/packages_pub.dart';

class DateCustomWidget extends StatelessWidget {
  const DateCustomWidget(
      {super.key,
      required this.title,
      required this.initDate,
      required this.onPressed});

  final String title;
  final String initDate;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        // SizedBox(width: 5.w),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
          width: 169.w,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                initDate,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.date_range,
                  color: Color(0xffF69100),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
