import 'package:flutter/material.dart';
import 'package:whodeenii/utils/colors.dart';

class WelcomeTextWidget extends StatelessWidget {
  final String title;
  final String description;
  final double width;

  const WelcomeTextWidget({
    super.key,
    required this.title,
    required this.description,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet = width > 600;
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTablet ? width * 0.03 : width * 0.05,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(
            width: isTablet ? width * 0.5 : width,
            child: Text(
              description,
              style: TextStyle(
                fontSize: isTablet ? width * 0.022 : width * 0.035,
                color: AppColors.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
