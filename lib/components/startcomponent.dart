import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:whodeenii/sharedpreferences/setvaluespref.dart';

class HeaderWidget extends StatefulWidget {
  final String fairmontLogo;
  final String poweredByLogo;

  const HeaderWidget({
    super.key,
    required this.fairmontLogo,
    required this.poweredByLogo,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  Uint8List? logoBytes;

  @override
  void initState() {
    super.initState();
    loadLogo();
  }

  Future<void> loadLogo() async {
    Uint8List? logo = await LogoHelper.getLogoBytes();
    if (mounted) {
      setState(() {
        logoBytes = logo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    bool isTablet = width > 600;

    return Padding(
      padding: EdgeInsets.only(left: width * 0.016, right: width * 0.016),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            isTablet
                ? [
                  SizedBox(width: width * 0.01),
                  const Spacer(),
                  SizedBox(
                    width: width * 0.3,
                    height: height * 0.2,
                    child:
                        logoBytes != null
                            ? Image.memory(logoBytes!)
                            : CircularProgressIndicator(),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Image.asset(widget.poweredByLogo, width: width * 0.02),
                      Text(
                        "Powered by",
                        style: TextStyle(fontSize: width * 0.009),
                      ),
                      Text(
                        "Whodeenii",
                        style: TextStyle(
                          fontSize: width * 0.009,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ]
                : [
                  SizedBox(),
                  SizedBox(
                    width: width * 0.3,
                    height: height * 0.11,
                    child: Image.asset(widget.fairmontLogo),
                  ),
                  SizedBox(),
                ],
      ),
    );
  }
}
