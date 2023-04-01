import 'package:e_commerce_app/utils/media_query.dart';
import 'package:flutter/material.dart';

class ParaText extends StatelessWidget {
  final String text;
  final double? size;
  final Color color;
  final FontWeight fontweight;
  final int? maxLine;
  const ParaText({
    super.key,
    required this.text,
    this.size,
    this.color = Colors.black,
    this.fontweight = FontWeight.normal,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    double s = CustomMediaQuery(context).width;
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: size ?? s * .03, fontWeight: fontweight),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}
