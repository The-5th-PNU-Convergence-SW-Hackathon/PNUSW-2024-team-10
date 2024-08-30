import 'package:heron/constants/preferences.dart';
import 'package:heron/widgets/theme/label.dart';
import 'package:heron/utilities/ripple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/theme/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kDefaultLocale = null;
const _kDefaultThemeMode = ThemeMode.system;

class HeronApp extends StatefulWidget {
  final Locale? locale;
  final ThemeMode? themeMode;
  final RouterConfig<Object> routerConfig;

  const HeronApp({
    super.key,
    this.locale,
    this.themeMode,
    required this.routerConfig,
  });

  @override
  State<HeronApp> createState() => _HeronAppState();
}

class _HeronAppState extends State<HeronApp> {
  late Locale? locale;
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();

    locale = widget.locale ?? _kDefaultLocale;
    themeMode = widget.themeMode ?? _kDefaultThemeMode;
  }

  void setLocale(Locale? locale) async {
    setState(() {
      this.locale = locale ?? _kDefaultLocale;
    });
    final prefs = await SharedPreferences.getInstance();
    if (locale != null) {
      prefs.setString(kPrefLanguage, locale.languageCode);
    } else {
      prefs.remove(kPrefLanguage);
    }
  }

  void setThemeMode(ThemeMode? themeMode) async {
    setState(() {
      this.themeMode = themeMode ?? _kDefaultThemeMode;
    });
    final prefs = await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.light || themeMode == ThemeMode.dark) {
      prefs.setString(kPrefThemeMode, themeMode.toString());
    } else {
      prefs.remove(kPrefThemeMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return HeronPreferences(
      locale: locale,
      themeMode: themeMode,
      setLocale: setLocale,
      setThemeMode: setThemeMode,
      child: MaterialApp.router(
        title: 'Heron',
        themeMode: themeMode,
        // InheritedWidget에서 가져온 themeMode 사용
        theme: MaterialTheme.light(),
        darkTheme: MaterialTheme.dark(),
        locale: locale,
        // InheritedWidget에서 가져온 locale 사용
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: widget.routerConfig,
      ),
    );
  }
}

const labelColors = HeronLabelColors(
  gray: Color(0xFFABABAB),
  red: Color(0xFFDC3A3A),
  green: Color(0xFFA8DC3A),
  blue: Color(0xFF3A8EDC),
  yellow: Color(0xFFDCA13A),
  purple: Color(0xFFA83ADC),
);

const darkLabelColors = HeronLabelColors(
  gray: Color(0xFF565656),
  red: Color(0xFF683535),
  green: Color(0xFF5A6C35),
  blue: Color(0xFF36526C),
  yellow: Color(0xFF6E5A38),
  purple: Color(0xFF5D396E),
);

class MaterialTheme {
  const MaterialTheme();

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0070eb),
      surfaceTint: Color(0xff005bc1),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0070eb),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff405e96),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffacc6ff),
      onSecondaryContainer: Color(0xff11346b),
      tertiary: Color(0xff801aa4),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa949cd),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff181c23),
      onSurfaceVariant: Color(0xff414755),
      outline: Color(0xff717786),
      outlineVariant: Color(0xffe3e4e6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3039),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff004493),
      secondaryFixed: Color(0xffd8e2ff),
      onSecondaryFixed: Color(0xff001a41),
      secondaryFixedDim: Color(0xffadc6ff),
      onSecondaryFixedVariant: Color(0xff26467d),
      tertiaryFixed: Color(0xfffad7ff),
      onTertiaryFixed: Color(0xff330045),
      tertiaryFixedDim: Color(0xffeeb1ff),
      onTertiaryFixedVariant: Color(0xff75059a),
      surfaceDim: Color(0xffd8d9e5),
      surfaceBright: Color(0xffffffff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f3fe),
      surfaceContainer: Color(0xffecedf9),
      surfaceContainerHigh: Color(0xffe6e8f3),
      surfaceContainerHighest: Color(0xffe0e2ed),
    );
  }

  static ThemeData light() {
    return theme(lightScheme(), labelColors);
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff74b4ff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff002e69),
      primaryContainer: Color(0xff0071ed),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xffadc6ff),
      onSecondary: Color(0xff082f65),
      secondaryContainer: Color(0xff1b3c73),
      onSecondaryContainer: Color(0xffbed1ff),
      tertiary: Color(0xffeeb1ff),
      onTertiary: Color(0xff53006f),
      tertiaryContainer: Color(0xffa949cd),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff10131b),
      onSurface: Color(0xffe0e2ed),
      onSurfaceVariant: Color(0xffc1c6d7),
      outline: Color(0xff8b90a0),
      outlineVariant: Color(0xff282b33),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2ed),
      inversePrimary: Color(0xff005bc1),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff004493),
      secondaryFixed: Color(0xffd8e2ff),
      onSecondaryFixed: Color(0xff001a41),
      secondaryFixedDim: Color(0xffadc6ff),
      onSecondaryFixedVariant: Color(0xff26467d),
      tertiaryFixed: Color(0xfffad7ff),
      onTertiaryFixed: Color(0xff330045),
      tertiaryFixedDim: Color(0xffeeb1ff),
      onTertiaryFixedVariant: Color(0xff75059a),
      surfaceDim: Color(0xff0b0e16),
      surfaceBright: Color(0xff181c23),
      surfaceContainerLowest: Color(0xff0b0e16),
      surfaceContainerLow: Color(0xff181c23),
      surfaceContainer: Color(0xff1c2028),
      surfaceContainerHigh: Color(0xff272a32),
      surfaceContainerHighest: Color(0xff31353d),
    );
  }

  static ThemeData dark() {
    return theme(darkScheme(), darkLabelColors);
  }

  static const textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 30,
      height: 1.25,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    headlineMedium: TextStyle(
      fontSize: 26,
      height: 1.25,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    headlineSmall: TextStyle(
      fontSize: 22,
      height: 1.25,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      height: 1.25,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      height: 1.25,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 1.42,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 1.42,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      height: 1.42,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      height: 1.42,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      height: 1.42,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      height: 1.42,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
  );

  static ThemeData theme(
    ColorScheme colorScheme,
    HeronLabelColors labelColors,
  ) =>
      ThemeData(
        fontFamily: "Pretendard",
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme,
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        extensions: [
          labelColors,
        ],
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            splashFactory: HeronRipple.splashFactory,
            shadowColor: WidgetStateProperty.all(Colors.transparent),
            overlayColor: WidgetStateProperty.all(
              colorScheme.onSurface.withOpacity(0.05),
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          indicatorColor: colorScheme.primary,
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.outline,
          indicator: UnderlineTabIndicator(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 3,
            ),
          ),
        ),
        switchTheme: SwitchThemeData(
          trackOutlineWidth: WidgetStateProperty.all(1.0),
          thumbColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return colorScheme.outlineVariant;
              }
              if (states.contains(WidgetState.selected)) {
                return colorScheme.onPrimaryContainer;
              }
              return colorScheme.outline;
            },
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return colorScheme.surfaceContainerHighest;
              }
              if (states.contains(WidgetState.selected)) {
                return colorScheme.primaryContainer;
              }
              return colorScheme.outline.withOpacity(0.1);
            },
          ),
          trackOutlineColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return colorScheme.outlineVariant;
              }
              if (states.contains(WidgetState.selected)) {
                return colorScheme.primaryContainer;
              }
              return colorScheme.outline.withOpacity(0.7);
            },
          ),
        ),
      );
}
