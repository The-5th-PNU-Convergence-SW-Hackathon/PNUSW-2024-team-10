import 'package:heron/screens/courses/courses.dart';
import 'package:heron/screens/info/info.dart';
import 'package:heron/screens/map/map.dart';
import 'package:heron/screens/more/more.dart';
import 'package:heron/widgets/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          CoursesScreen(),
          InfoScreen(),
          MoreScreen(),
        ],
      ),
      bottomNavigationBar: HeronNavigationBar(
        selectedIndex: _selectedIndex,
        onSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          HeronNavigationBarItem(
            icon: HugeIcons.strokeRoundedRoute01,
            label: l10n.navigationLabelCourses,
          ),
          HeronNavigationBarItem(
            icon: HugeIcons.strokeRoundedLibrary,
            label: l10n.navigationLabelInfo,
          ),
          HeronNavigationBarItem(
            icon: HugeIcons.strokeRoundedMoreHorizontalCircle02,
            label: l10n.navigationLabelMore,
          )
        ],
      ),
    );
  }
}
