import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/sizeconf.dart';
import 'package:flutter/material.dart';

class MobHeaderComponent extends StatelessWidget {
  final String lineLogo;
  final String farimontlogo;
  final String heading;
  final String contentline;

  const MobHeaderComponent({
    super.key,
    required this.lineLogo,
    required this.farimontlogo,
    required this.heading,
    required this.contentline,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    MySize().init(context);
    return Padding(
      padding: EdgeInsets.only(left: width * 0.01, right: width * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.3,
            height: height * 0.11,
            child: Image.asset(farimontlogo),
          ),
          Image.asset(lineLogo, width: width * 0.3),
          Text(
            heading,
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: MySize.size18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            contentline,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF3D4959),
              fontSize: MySize.size12,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
