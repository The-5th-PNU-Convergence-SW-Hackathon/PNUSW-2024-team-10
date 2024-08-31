import 'package:heron/models/courses/types.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/screens/courses/widgets/filter.dart';
import 'package:heron/screens/courses/widgets/list.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:heron/widgets/button/icon.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
        body: const TabBarView(
          children: [
            CourseListAll(_exampleList),
            CourseListLiked(_exampleList),
            CourseListDone(_exampleList),
          ],
        ),
      ),
    );
  }
}

const List<CourseListItem> _exampleList = [
  CourseListItem(
    id: "1",
    title: "Art & Healing Tour",
    imageSrc:
        "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2F15af9355-e1dd-4c9f-ada2-eb1bbfc0cbb2%2Fimage.png?table=block&id=0cc6f44d-9b59-4869-99ae-014466b1e80e&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2",
    zones: [HeronPlaceZoneType.haeundae],
    duration: HeronCourseDurationType.oneDay,
    status: HeronCourseStatusType.now,
    landmark: "Busan Cinema Center",
  ),
  CourseListItem(
    id: "2",
    title: "Modern and Contemporary History Tour of Busan",
    imageSrc:
        "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2F58967660-9615-4bbb-ace2-d17dbb3621e2%2Fimage.png?table=block&id=c3cdda06-4561-48aa-a56c-c440d23eec7f&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2",
    zones: [HeronPlaceZoneType.downtown],
    duration: HeronCourseDurationType.oneDay,
    status: HeronCourseStatusType.liked,
    landmark: "Busan Museum of Modern and Contemporary",
  ),
  CourseListItem(
    id: "3",
    title: "Haeundae Ocean View Tour",
    imageSrc:
        "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2F810b1310-be2a-4fd0-8509-7b4dbbe1f750%2Fimage.png?table=block&id=3b2e247d-b498-43e6-a734-4e132b6b02d3&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2",
    zones: [HeronPlaceZoneType.haeundae],
    duration: HeronCourseDurationType.oneDay,
    landmark: "Haeundae Beach",
  ),
  CourseListItem(
    id: "4",
    title: "Tour of an exotic cultural village",
    imageSrc:
        "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2Fbc3cd5dd-e812-4dab-8eef-93ed34896fa2%2F6367a8b21e462af162160492daee66e6.png?table=block&id=04036b44-9b3c-48fb-8bb6-99e06c91ae65&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2",
    zones: [HeronPlaceZoneType.downtown],
    duration: HeronCourseDurationType.oneDay,
    status: HeronCourseStatusType.done,
    landmark: "Huinnyeoul Culture Village",
  ),
  CourseListItem(
    id: "5",
    title: "Analog, the value of lyricism and slowness",
    imageSrc:
        "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2Ffe23f9a6-2458-4531-ac29-2a93d611eab2%2Fimage.png?table=block&id=656ab5ce-9454-4008-a3f4-7331c7183199&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=1420&userId=&cache=v2",
    zones: [HeronPlaceZoneType.downtown],
    duration: HeronCourseDurationType.overNight,
    landmark: "Busan Air Cruise",
  ),
];
