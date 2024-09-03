import 'package:heron/models/courses/courses.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/screens/courses/widgets/filter.dart';
import 'package:heron/screens/courses/widgets/list.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:heron/widgets/button/icon.dart';
import 'package:flutter/material.dart';
import 'package:heron/widgets/other/future.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final courses = apiCoursesGet(context);

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
            child: Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  Expanded(
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
                  const SizedBox(width: 6.0),
                  HeronIconButton(
                    onPressed: () {
                      showCoursesFilterSheet(
                          context: context, onApply: (zones, themes) {});
                    },
                    size: 36.0,
                    icon: Icon(HugeIcons.strokeRoundedFilterHorizontal,
                        color: colorScheme.outline, size: 20.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: HeronFutureFader(
            future: courses,
            builder: (context, snapshot) {
              final List<HeronCourseSummary>? courses = snapshot.data;

              return TabBarView(
                children: [
                  CourseListAll(courses!),
                  CourseListGeneral(
                    courses.where((course) => course.liked).toList(),
                  ),
                  CourseListGeneral(
                    courses
                        .where(
                            (course) => course.state == HeronCourseState.done)
                        .toList(),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
