import 'package:e_commerce_app/utils/media_query.dart';
import 'package:flutter/material.dart';

class SubHeadingText extends StatelessWidget {
  final String text;
  final double? size;
  final Color color;
  final FontWeight fontweight;
  const SubHeadingText({
    super.key,
    required this.text,
    this.size,
    this.color = Colors.grey,
    this.fontweight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    double s = CustomMediaQuery(context).width;
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: size ?? s * .032, fontWeight: fontweight),
    );
  }
}
