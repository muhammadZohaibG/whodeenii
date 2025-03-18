import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/sizeconf.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color btnbg;
  final Color btnfg;

  const MainButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.btnbg,
    required this.btnfg,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      width: MySize.screenWidth,
      margin: EdgeInsets.symmetric(
        horizontal: MySize.size20,
        vertical: MySize.size7,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btnbg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: MySize.size14),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: MySize.size16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
