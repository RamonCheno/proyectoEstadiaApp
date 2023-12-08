import 'package:control_asistencia_app/app/packages/packages_pub.dart';

class CustomDialogWidget extends StatelessWidget {
  final Widget messagge;
  final String? title;
  final Icon iconData;
  final List<Widget>? actions;
  const CustomDialogWidget(
      {this.title,
      required this.messagge,
      required this.iconData,
      this.actions,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconData,
          10.horizontalSpace,
          if (title != null)
            Text(
              title!,
              style: TextStyle(fontSize: 16.sp),
            ),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 16.h),
      content: SingleChildScrollView(
        child: Center(
          child: messagge,
        ),
      ),
      actions: actions ?? [],
    );
  }
}
