import 'package:e_commerce_app/colors/color.dart';
import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final Color color;
  const ShadowContainer(
      {super.key,
      this.width,
      this.height,
      this.child,
      this.color = MyColors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
