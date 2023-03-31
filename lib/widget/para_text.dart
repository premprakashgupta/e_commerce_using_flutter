import 'package:flutter/material.dart';

class ParaText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontweight;
  final int? maxLine;
  const ParaText({
    super.key,
    required this.text,
    this.size = 14,
    this.color = Colors.black,
    this.fontweight = FontWeight.normal,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontweight),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}
