import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

extension LightTheme on BuildContext {
  static const Color primaryColor = Color(0xFFF07F25);
  static const Color secondaryColor = Colors.white;
  static Color backgroundColor = Colors.white;
  static Color greyLight = Colors.grey.shade400;
  static Color primarySeed = HexColor.fromHex('#eb9d37');

  ThemeData get lightTheme => ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: primaryColor),
    ),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: primarySeed),
    primaryColorLight: primaryColor.withOpacity(0.5),
    primarySwatch: Colors.orange,
    primaryColor: primaryColor,
    disabledColor: secondaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: GoogleFonts.nunitoSansTextTheme(),
    iconTheme: const IconThemeData(color: primaryColor),
  );
}

class AppColors {
  static Color lightPrimaryColor = const Color(0xFFFFF5E6);
  static Color transparentPrimaryColor = const Color(0xFFFFF0E3);
  static Color transparentBlackColor = const Color(0x83000000);
  static Color gray = const Color(0xffa8a8a8);
  static Color gray2 = const Color(0xFFE9E9F0);
  static Color lightGray = const Color(0xffEBEBEB);
  static Color transparentGrayColor = const Color.fromARGB(107, 168, 168, 168);

  static Color shadowColor = const Color(0x0f000000);
  static Color borderColor = const Color(0xffeeeeee);

  static Color pink = const Color(0xffD80042);
  static Color black = const Color(0xff3f3f3f);
  static Color white = const Color(0xffffffff);
  static Color headerColor = const Color(0xff404040);

  static List<Color> segmentedProgressBarColors = [
    const Color(0xFFF07F25),
    const Color(0xFFFFD391),
    const Color(0xFFB6935C),
    const Color(0xFF5D3A00),
    const Color(0xFF887759),
    const Color(0xFFAB6A01),
  ];

  static List<Color> pieChartColors = [
    const Color(0xFFB4282D),
    const Color(0xFF0C5272),
    const Color(0xFFA87F10),
    const Color(0xFFAA407B),
    const Color(0xFF5455D2),
  ];

  static Map<Color, Color> profileImageBGColors = {
    const Color(0xFFE56166): const Color(0xFFB4282D),
    const Color(0xFF8FA1B4): const Color(0xFF345B85),
    const Color(0xFF12A6D0): const Color(0xFF0C5272),
    const Color(0xFFC6B484): const Color(0xFFA87F10),
    const Color(0xFFDEAEC9): const Color(0xFFAA407B),
    const Color(0xFF9E9FE5): const Color(0xFF5455D2),
  };
}

final class AppStyles {
  static List<BoxShadow> get boxShadow => [
    BoxShadow(
      color: AppColors.transparentGrayColor,
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];
}
