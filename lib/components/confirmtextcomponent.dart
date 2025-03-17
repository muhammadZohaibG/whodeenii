import 'package:flutter/material.dart';

class ConfirmTextWidget extends StatelessWidget {
  final double width;

  const ConfirmTextWidget({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    bool isTablet = width > 600;
    return Text.rich(
      TextSpan(
        text: "Please ",
        style: TextStyle(
          fontSize: isTablet ? width * 0.025 : width * 0.037,
          color: Colors.black,
        ),
        children: const [
          TextSpan(
            text: "Confirm",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: " to Proceed further."),
        ],
      ),
    );
  }
}
