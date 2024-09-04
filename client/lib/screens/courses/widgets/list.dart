import 'package:flutter/material.dart';
import 'package:heron/constants/request.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/widgets/label/label.dart';
import 'package:heron/widgets/list/items.dart';
import 'package:heron/widgets/label/course.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/list/list.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';
import 'package:heron/widgets/other/empty.dart';
import 'package:heron/widgets/other/future.dart';
import 'package:heron/widgets/other/image.dart';

class CourseListAll extends StatelessWidget {
  final List<HeronCourseSummary> list;

  const CourseListAll(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final activeItem = list
        .firstWhereOrNull((item) => item.state == HeronCourseState.inProgress);

    return list.isNotEmpty
        ? SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              children: [
                if (activeItem != null)
                  HeronListGroup(
                    labelIndent: 10.0,
                    dividerIndent: 0.0,
                    header: l10n.coursesListHeaderNow,
                    children: [
                      CourseListItem(
                        id: activeItem.id,
                        name: activeItem.name,
                        zones: activeItem.zones,
                        duration: activeItem.duration,
                        state: activeItem.state,
                        liked: activeItem.liked,
                        imageId: activeItem.imageId,
                        landmark: activeItem.landmark,
                      )
                    ],
                  ),
                HeronListGroup(
                  labelIndent: 10.0,
                  dividerIndent: 0.0,
                  header: activeItem != null ? l10n.coursesListHeaderAll : null,
                  children: [
                    for (final item in list)
                      if (item.state != HeronCourseState.inProgress)
                        CourseListItem(
                          id: item.id,
                          name: item.name,
                          zones: item.zones,
                          duration: item.duration,
                          state: item.state,
                          liked: item.liked,
                          imageId: item.imageId,
                          landmark: item.landmark,
                        ),
                  ],
                ),
              ],
            ),
          )
        : const HeronEmpty();
  }
}

class CourseListGeneral extends StatelessWidget {
  final List<HeronCourseSummary> list;

  const CourseListGeneral(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              children: [
                HeronListGroup(
                  labelIndent: 10.0,
                  dividerIndent: 0.0,
                  children: [
                    for (final item in list)
                      CourseListItem(
                        id: item.id,
                        name: item.name,
                        zones: item.zones,
                        duration: item.duration,
                        state: item.state,
                        liked: item.liked,
                        imageId: item.imageId,
                        landmark: item.landmark,
                      ),
                  ],
                ),
              ],
            ),
          )
        : const HeronEmpty();
  }
}

class CourseListItem extends HeronListItem {
  final String id;
  final String name;
  final List<HeronZoneSummary> zones;
  final HeronCourseDuration duration;
  final HeronCourseState? state;
  final bool liked;
  final String imageId;
  final String landmark;

  const CourseListItem({
    super.key,
    required this.id,
    required this.name,
    required this.zones,
    required this.duration,
    this.state,
    required this.liked,
    required this.imageId,
    required this.landmark,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final refetch = getRefetch(context);

    return HeronPressableListItem(
      onPressed: () async {
        await context.push('/courses/$id');
        refetch();
      },
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: Container(
                  color: colorScheme.surfaceContainerHigh,
                  child: HeronFadeInImage(
                    width: 100.0,
                    height: 100.0,
                    "$kThumbBaseURL/$imageId",
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        zones.map((zone) => zone.name).join(', '),
                        style: textTheme.bodyMedium!
                            .copyWith(color: colorScheme.outline),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6.0),
                      Wrap(
                        spacing: 6.0,
                        children: [
                          HeronLabel(
                            child: Text(
                              duration.getDisplayText(l10n).toUpperCase(),
                            ),
                          ),
                          if (state == HeronCourseState.inProgress)
                            const HeronCourseStatusLabel(
                                HeronCourseStateLabelType.now)
                          else if (state == HeronCourseState.done)
                            const HeronCourseStatusLabel(
                                HeronCourseStateLabelType.done)
                          else if (liked)
                            const HeronCourseStatusLabel(
                                HeronCourseStateLabelType.liked)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${l10n.coursesLandmark.toUpperCase()}  ",
                  style: textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                TextSpan(
                  text: landmark,
                  style: textTheme.labelMedium!.copyWith(
                    color: colorScheme.primary,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
