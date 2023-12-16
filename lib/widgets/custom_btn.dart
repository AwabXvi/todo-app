import 'package:flutter/material.dart';
import 'package:todo/constants.dart';

class CustomBtn extends StatelessWidget {
  final void Function()? onPressed;
  final double? width;
  final Widget child;
  final Color? color;
  final double? height;
  final double? radius;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;

  const CustomBtn(
      {Key? key,
      this.onPressed,
      required this.child,
      this.width,
      this.color,
      this.margin,
      this.height,
      this.radius,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? double.infinity,
      height: height ?? 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius==null?0:(radius!+4.0)),
        border: Border.all(color:borderColor??Colors.transparent ,width: 2.5)
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Constants.orange,
          // side: BorderSide(
          //   style: BorderStyle.solid,
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 0.0),
          ),

        ),
        child: child,
      ),
    );
  }
}
