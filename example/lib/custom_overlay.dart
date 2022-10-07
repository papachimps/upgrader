import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showCustomUpgraderModalSheet({
  BuildContext context,
  String title,
  String message,
  String releaseNotes,
  bool canDismissDialog,
}) async {
  return showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isDismissible: true,
    enableDrag: true,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.5,
        child: ClipPath(
          clipBehavior: Clip.hardEdge,
          clipper: MyCustomClipper(),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1,
                colors: [
                  Color(0xff191988),
                  Color(0xff16164E),
                ],
              ),
              backgroundBlendMode: BlendMode.difference,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xff175A7F),
                    const Color(0xff0D173A).withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // This variable define for better understanding you can direct specify value in quadraticBezierTo method
    var controlPoint1 = Offset(size.width / 5, 0);
    var controlPoint2 = Offset(size.width / 2, 0);
    var endPoint = Offset(size.width, size.height / 5);

    Path path = Path()
      ..moveTo(0, size.height / 4)
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
