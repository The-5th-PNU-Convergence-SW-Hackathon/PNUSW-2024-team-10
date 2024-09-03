import 'package:heron/models/courses/courses.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/screens/courses/widgets/list.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:heron/widgets/other/future.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<HeronCourseSummary> allCourses = [];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: HeronAppBar(
          hasBackButton: false,
          title: Text(l10n.navigationLabelCourses),
          largeTitle: true,
          forceElevation: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: TabBar(
              padding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              tabs: [
                Tab(text: l10n.coursesTabAll),
                Tab(text: l10n.coursesTabLiked),
                Tab(text: l10n.coursesTabDone),
              ],
            ),
          ),
        ),
        body: HeronFutureBuilder(
          future: () => apiCoursesGet(context).then((data) {
            setState(() {
              allCourses = data ?? [];
            });

            return data;
          }),
          builder: (context, snapshot) {
            return TabBarView(
              children: [
                CourseListAll(
                  allCourses,
                ),
                CourseListGeneral(
                  allCourses.where((course) => course.liked).toList(),
                ),
                CourseListGeneral(
                  allCourses
                      .where((course) => course.state == HeronCourseState.done)
                      .toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
