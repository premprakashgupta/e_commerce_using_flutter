import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontweight;

  const HeadingText({
    super.key,
    required this.text,
    this.size = 24,
    this.color = Colors.black,
    this.fontweight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontweight),
    );
  }
}
