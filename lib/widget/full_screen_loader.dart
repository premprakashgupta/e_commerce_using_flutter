import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  final bool isLoading;

  FullScreenLoader({this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // add a transparent black background
        Opacity(
          opacity: isLoading ? 0.5 : 0.0,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: Visibility(
            visible: isLoading,
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
