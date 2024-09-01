import 'package:flutter/material.dart';
import 'package:heron/models/auth/types.dart';

class HeronPreferences extends InheritedWidget {
  final Locale? locale;
  final ThemeMode themeMode;
  final UserInfo? user;
  final void Function(Locale?) setLocale;
  final void Function(ThemeMode?) setThemeMode;
  final void Function() updateUser;
  final void Function() clearUser;

  const HeronPreferences({
    super.key,
    required super.child,
    this.locale,
    required this.themeMode,
    this.user,
    required this.setLocale,
    required this.setThemeMode,
    required this.updateUser,
    required this.clearUser,
  });

  static HeronPreferences of(BuildContext context) {
    final HeronPreferences? result =
        context.dependOnInheritedWidgetOfExactType<HeronPreferences>();
    assert(result != null, 'No HeronInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HeronPreferences oldWidget) {
    return locale != oldWidget.locale ||
        themeMode != oldWidget.themeMode ||
        user != oldWidget.user;
  }
}

// getters
void setLocale(BuildContext context, Locale? locale) {
  HeronPreferences.of(context).setLocale(locale);
}

void setThemeMode(BuildContext context, ThemeMode? themeMode) {
  HeronPreferences.of(context).setThemeMode(themeMode);
}

void updateUser(BuildContext context) {
  HeronPreferences.of(context).updateUser();
}

void clearUser(BuildContext context) {
  HeronPreferences.of(context).clearUser();
}

Locale? getLocale(BuildContext context) {
  return HeronPreferences.of(context).locale;
}

ThemeMode getThemeMode(BuildContext context) {
  return HeronPreferences.of(context).themeMode;
}

UserInfo? getUser(BuildContext context) {
  return HeronPreferences.of(context).user;
}
