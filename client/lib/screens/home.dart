import 'package:client/screens/courses/courses.dart';
import 'package:client/screens/info/info.dart';
import 'package:client/screens/map/map.dart';
import 'package:client/screens/more/more.dart';
import 'package:client/widgets/navigation/navigation.dart';
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
          MapScreen(),
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
            icon: HugeIcons.strokeRoundedMapsLocation01,
            label: l10n.navigationLabelMap,
          ),
          HeronNavigationBarItem(
            icon: HugeIcons.strokeRoundedRoute01,
            label: l10n.navigationLabelCourses,
          ),
          HeronNavigationBarItem(
            icon: HugeIcons.strokeRoundedLibrary,
            label: l10n.navigationLabelInfo,
          ),
          HeronNavigationBarItem(
            icon: HugeIcons.strokeRoundedMoreHorizontalCircle01,
            label: l10n.navigationLabelMore,
          )
        ],
      ),
    );
  }
}
