import 'package:flutter/material.dart';

class CustomMediaQuery {
  final BuildContext context;
  CustomMediaQuery(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}
