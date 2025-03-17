import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String fairmontLogo;
  final String poweredByLogo;

  const HeaderWidget({
    super.key,
    required this.fairmontLogo,
    required this.poweredByLogo,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    bool isTablet = width > 600;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          isTablet
              ? [
                SizedBox(width: width * 0.06),
                const Spacer(),
                SizedBox(
                  width: width * 0.4,
                  height: height * 0.04,
                  child: Image.asset(fairmontLogo),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(poweredByLogo, width: width * 0.04),
                    const Text("Powered by"),
                    const Text("Whodeenii"),
                  ],
                ),
              ]
              : [
                SizedBox(),
                SizedBox(
                  width: width * 0.3,
                  height: height * 0.11,
                  child: Image.asset(fairmontLogo),
                ),
                SizedBox(),
              ],
    );
  }
}
