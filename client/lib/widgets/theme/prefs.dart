import 'package:flutter/material.dart';

class HeronInheritedWidget extends InheritedWidget {
  final Locale? locale;
  final ThemeMode themeMode;
  final void Function(Locale?) setLocale;
  final void Function(ThemeMode?) setThemeMode;

  const HeronInheritedWidget({
    super.key,
    required super.child,
    this.locale,
    required this.themeMode,
    required this.setLocale,
    required this.setThemeMode,
  });

  static HeronInheritedWidget of(BuildContext context) {
    final HeronInheritedWidget? result =
    context.dependOnInheritedWidgetOfExactType<HeronInheritedWidget>();
    assert(result != null, 'No HeronInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HeronInheritedWidget oldWidget) {
    return locale != oldWidget.locale || themeMode != oldWidget.themeMode;
  }
}

// getters
void setLocale(BuildContext context, Locale? locale) {
  HeronInheritedWidget.of(context).setLocale(locale);
}

void setThemeMode(BuildContext context, ThemeMode? themeMode) {
  HeronInheritedWidget.of(context).setThemeMode(themeMode);
}

Locale? getLocale(BuildContext context) {
  return HeronInheritedWidget.of(context).locale;
}

ThemeMode getThemeMode(BuildContext context) {
  return HeronInheritedWidget.of(context).themeMode;
}