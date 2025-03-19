import 'package:flutter/material.dart';
import 'package:whodeenii/utils/colors.dart';

class ConfirmTextWidget extends StatelessWidget {
  final double width;

  const ConfirmTextWidget({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    bool isTablet = width > 600;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.015),
      child: Text.rich(
        TextSpan(
          text: "Please ",
          style: TextStyle(
            fontSize: isTablet ? width * 0.015 : width * 0.037,
            color: AppColors.gray4959,
          ),
          children: [
            TextSpan(
              text: "Confirm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            TextSpan(
              text: " to Proceed further.",
              style: TextStyle(color: AppColors.gray4959),
            ),
          ],
        ),
      ),
    );
  }
}
