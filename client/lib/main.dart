import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:heron/constants/preferences.dart';
import 'package:heron/models/auth/types.dart';
import 'package:heron/models/user.dart';
import 'package:heron/screens/courses/details/details.dart';
import 'package:heron/screens/error/error.dart';
import 'package:heron/screens/home.dart';
import 'package:heron/screens/image/image.dart';
import 'package:heron/screens/info/details/details.dart';
import 'package:flutter/material.dart';
import 'package:heron/screens/more/policy/policy.dart';
import 'package:heron/screens/more/terms/terms.dart';
import 'package:heron/widgets/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final languageCode = prefs.getString(kPrefLanguage);
  final themeModeCode = prefs.getString(kPrefThemeMode);

  UserInfo? user;

  try {
    user = await apiUserGet(null);
  } catch (e) {
    await const FlutterSecureStorage().deleteAll();
  }

  runApp(
    MyApp(
      languageCode: languageCode,
      themeModeCode: themeModeCode,
      user: user,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? languageCode;
  final String? themeModeCode;
  final UserInfo? user;

  const MyApp({super.key, this.languageCode, this.themeModeCode, this.user});

  @override
  Widget build(BuildContext context) {
    return HeronApp(
      routerConfig: _router,
      locale: languageCode != null ? Locale(languageCode!) : null,
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.toString() == themeModeCode,
        orElse: () => ThemeMode.system,
      ),
      user: user,
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
          builder: (context, state) {
            final id = state.pathParameters["id"];

            if (id != null) {
              return CourseDetailsScreen(id);
            }

            return const ErrorScreen();
          },
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
          path: "more/terms",
          builder: (context, state) {
            return const TermsScreen();
          },
        ),
        GoRoute(
          path: "more/privacy",
          builder: (context, state) {
            return const PrivacyScreen();
          },
        ),
      ],
    ),
  ],
);
