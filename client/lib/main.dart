import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:heron_app/screens/course.dart';
import 'package:heron_app/screens/info.dart';
import 'package:heron_app/screens/map.dart';
import 'package:heron_app/widgets/common/navigation.dart';
import 'package:heron_app/widgets/common/theme.dart';

main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return HeronTheme(
        home: Scaffold(
            bottomNavigationBar: HeronNavigation(
                currentIndex: index,
                onTap: (int i) => setState(() => index = i),
                items: const [
                  HeronNavigationItem(label: "Map", icon: LucideIcons.map),
                  HeronNavigationItem(label: "Course", icon: LucideIcons.route),
                  HeronNavigationItem(
                      label: "Info", icon: LucideIcons.book_open_text),
                ]),
            body: IndexedStack(
              index: index,
              children: const <Widget>[
                MapScreen(),
                CourseScreen(),
                InfoScreen()
              ],
            )));
  }
}
