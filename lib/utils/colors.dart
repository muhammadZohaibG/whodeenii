import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xff00677D);

  static Color secondaryColor = const Color(0xff3B4051);
  static Color grayColor = const Color(0xffECEDF2);
  static Color gray300 = const Color(0xFFE0E0E0);

  static Color textgreyColor = const Color(0xff727272);
  static Color blackColor = const Color(0xff000000);
  static Color whiteColor = const Color(0xffffffff);
  static Color fieldColor = const Color(0xFFECEDF2);
  static Color orangeColor = const Color(0xFFFFA500);
  static Color orange38 = const Color(0xFFF68F38);
  static Color pink68 = const Color(0xFFF03668);
  static Color pinkColor = const Color(0xFFFF1493);
  static Color gray4959 = const Color(0xFF3D4959);

  static LinearGradient gradientColor = const LinearGradient(
    colors: [Color(0xFFFFA500), Color(0xFFFF1493)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient gradientdarkColor = const LinearGradient(
    colors: [Color(0xFFF68F38), Color(0xFFF03668)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
