import 'package:flutter/material.dart';

class BottomModalSheet {
  final BuildContext context;
  BottomModalSheet(this.context);

  void showModal({required Widget child}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) => child,
    );
  }
}
