import 'package:flutter/material.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/widgets/label/label.dart';
import 'package:heron/widgets/list/items.dart';
import 'package:heron/widgets/label/course.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/list/list.dart';
import 'package:go_router/go_router.dart';

class CourseListAll extends StatelessWidget {
  final List<CourseListItem> list;

  const CourseListAll(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Column(
        children: [
          if (list.any((item) => item.status == HeronCourseStatusType.now))
            HeronListGroup(
              labelIndent: 10.0,
              dividerIndent: 0.0,
              header: l10n.coursesListHeaderNow,
              children: [
                for (final item in list)
                  if (item.status == HeronCourseStatusType.now) item,
              ],
            ),
          HeronListGroup(
            labelIndent: 10.0,
            dividerIndent: 0.0,
            header: l10n.coursesListHeaderAll,
            children: [
              for (final item in list)
                if (item.status != HeronCourseStatusType.now) item,
            ],
          ),
        ],
      ),
    );
  }
}

class CourseListLiked extends StatelessWidget {
  final List<CourseListItem> list;

  const CourseListLiked(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Column(
        children: [
          HeronListGroup(
            labelIndent: 10.0,
            dividerIndent: 0.0,
            children: [
              for (final item in list)
                if (item.status == HeronCourseStatusType.liked) item,
            ],
          ),
        ],
      ),
    );
  }
}

class CourseListDone extends StatelessWidget {
  final List<CourseListItem> list;

  const CourseListDone(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Column(
        children: [
          HeronListGroup(
            labelIndent: 10.0,
            dividerIndent: 0.0,
            children: [
              for (final item in list)
                if (item.status == HeronCourseStatusType.done) item,
            ],
          ),
        ],
      ),
    );
  }
}

class CourseListItem extends HeronListItem {
  final String id;
  final String title;
  final List<HeronPlaceZoneType> zones;
  final HeronCourseDurationType duration;
  final HeronCourseStatusType? status;
  final String imageSrc;
  final String landmark;

  const CourseListItem({
    super.key,
    required this.id,
    required this.title,
    required this.zones,
    required this.duration,
    this.status,
    required this.imageSrc,
    required this.landmark,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return HeronPressableListItem(
      onPressed: () {
        context.go('/courses/$id');
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
                  child: Image.network(
                    imageSrc,
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
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
                        title,
                        style: textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        zones
                            .map((zone) => zone.getDisplayText(l10n))
                            .join(', '),
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
                          if (status != null) HeronCourseStatusLabel(status!),
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
