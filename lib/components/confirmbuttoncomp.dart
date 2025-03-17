import 'package:flutter/material.dart';
import 'package:emsmeraki/utils/colors.dart';

class ConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;

  const ConfirmButton({
    super.key,
    required this.onPressed,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet = width > 600;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isTablet ? height * 0.01 : height * 0.02,
          horizontal: isTablet ? width * 0.22 : width * 0.33,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.primaryColor,
        ),
        child: Text(
          "Confirm",
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
