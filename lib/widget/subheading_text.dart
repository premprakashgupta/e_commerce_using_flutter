import 'package:flutter/material.dart';

class SubHeadingText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontweight;
  const SubHeadingText({
    super.key,
    required this.text,
    this.size = 16,
    this.color = Colors.grey,
    this.fontweight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontweight),
    );
  }
}
