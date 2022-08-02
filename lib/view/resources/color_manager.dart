import 'package:flutter/material.dart';

class ColorManager {
  static Color swatch = HexColor.fromHex("#ffd2d5c4");
  static const Color primary =  Color(0xff012a36);
  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);
  static Color lightGrey = const Color(0xff9E9E9E);
  static Color black = const Color(0xff000000);
  static const kGreenColor = Color(0xFF6AC259);
  static const Color indicatorColor = Color(0xffF7F7F7);
  static const Color labelUnSelectedColor = Color(0xffB2B2B2);
  static const Color prerequisiteCardColor = Color(0xffFCFCFC);
  static const Color cardColor = Color(0xffd2d5c4);
  static const Color cardColor1 = Color(0xffE3F2FD);
  static const Color frameColor = Color(0xffF06292);



  // new colors
  static Color darkPrimary = const Color(0xffd17d11);
  static Color lightPrimary = const Color(0xCCd17d11); // color with 80% opacity
  static Color grey1 = const Color(0xff707070);
  static Color grey2 = const Color(0xff797979);
  static Color white = const Color(0xffFFFFFF);
  static const Color error =  Color(0xffb71c1c); // red color
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
