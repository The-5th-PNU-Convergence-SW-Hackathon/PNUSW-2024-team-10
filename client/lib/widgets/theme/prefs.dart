import 'package:flutter/material.dart';

class HeronPreferences extends InheritedWidget {
  final Locale? locale;
  final ThemeMode themeMode;
  final void Function(Locale?) setLocale;
  final void Function(ThemeMode?) setThemeMode;

  const HeronPreferences({
    super.key,
    required super.child,
    this.locale,
    required this.themeMode,
    required this.setLocale,
    required this.setThemeMode,
  });

  static HeronPreferences of(BuildContext context) {
    final HeronPreferences? result =
    context.dependOnInheritedWidgetOfExactType<HeronPreferences>();
    assert(result != null, 'No HeronInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HeronPreferences oldWidget) {
    return locale != oldWidget.locale || themeMode != oldWidget.themeMode;
  }
}

// getters
void setLocale(BuildContext context, Locale? locale) {
  HeronPreferences.of(context).setLocale(locale);
}

void setThemeMode(BuildContext context, ThemeMode? themeMode) {
  HeronPreferences.of(context).setThemeMode(themeMode);
}

Locale? getLocale(BuildContext context) {
  return HeronPreferences.of(context).locale;
}

ThemeMode getThemeMode(BuildContext context) {
  return HeronPreferences.of(context).themeMode;
}