import 'package:go_router/go_router.dart';
import 'package:heron/constants/preferences.dart';
import 'package:heron/screens/courses/details/details.dart';
import 'package:heron/screens/error/error.dart';
import 'package:heron/screens/home.dart';
import 'package:heron/screens/info/details/details.dart';
import 'package:heron/screens/profile/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:heron/widgets/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final languageCode = prefs.getString(kPrefLanguage);
  final themeModeCode = prefs.getString(kPrefThemeMode);

  runApp(
    MyApp(
      languageCode: languageCode,
      themeModeCode: themeModeCode,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? languageCode;
  final String? themeModeCode;

  const MyApp({super.key, this.languageCode, this.themeModeCode});

  @override
  Widget build(BuildContext context) {
    return HeronApp(
      routerConfig: _router,
      locale: languageCode != null ? Locale(languageCode!) : null,
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.toString() == themeModeCode,
        orElse: () => ThemeMode.system,
      ),
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: "courses/:id",
          builder: (context, state) => CourseDetailsScreen(
            state.pathParameters["id"],
          ),
        ),
        GoRoute(
          path: "info/:id",
          builder: (context, state) {
            final id = state.pathParameters["id"];

            if (id != null) {
              return InfoDetailsScreen(id);
            }

            return const ErrorScreen();
          },
        ),
        GoRoute(
          path: "profile/settings",
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
