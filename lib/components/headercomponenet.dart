import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/sizeconf.dart';
import 'package:flutter/material.dart';

class HeaderComponent extends StatefulWidget {
  final String lineLogo;
  final String poweredByLogo;
  final String heading;
  final String contentline;

  const HeaderComponent({
    super.key,
    required this.lineLogo,
    required this.poweredByLogo,
    required this.heading,
    required this.contentline,
  });

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    MySize().init(context);
    return Padding(
      padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.lineLogo,
                width: width * 0.08,
                height: height * 0.03,
              ),
              Text(
                widget.heading,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: width * 0.018,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DM Sans',
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                widget.contentline,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.silver95,
                  fontSize: width * 0.012,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Image.asset(widget.poweredByLogo, width: width * 0.02),
              Text("Powered by", style: TextStyle(fontSize: width * 0.009)),
              Text(
                "Whodeenii",
                style: TextStyle(
                  fontSize: width * 0.009,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
