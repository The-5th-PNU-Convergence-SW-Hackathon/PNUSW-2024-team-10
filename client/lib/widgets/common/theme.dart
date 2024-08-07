import 'package:flutter/material.dart';
import 'package:heron_app/constants/theme/colors.dart';
import 'package:heron_app/constants/theme/typography.dart';

class HeronTheme extends StatelessWidget {
  final Widget home;

  const HeronTheme({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    const colors = HeronColors();
    final typography = HeronTypography(
      headingColor: colors.text.title,
      bodyColor: colors.text.body,
    );

    return MaterialApp(
        theme: ThemeData(
            fontFamily: "Manrope",
            extensions: <ThemeExtension<dynamic>>[
              colors,
              typography,
            ]),
        home: home);
  }
}
