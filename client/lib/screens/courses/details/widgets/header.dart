import 'package:flutter/material.dart';
import 'package:heron/constants/request.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/widgets/label/label.dart';
import 'package:heron/widgets/label/spot.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/other/image.dart';

class CourseDetailsHeader extends StatelessWidget {
  final String title;
  final HeronCourseDuration duration;
  final List<String> zones;
  final String imageId;
  final List<HeronTourSpotTheme> themes;

  const CourseDetailsHeader({
    super.key,
    required this.title,
    required this.duration,
    required this.zones,
    required this.imageId,
    required this.themes,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final diviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$title  ",
                        style: textTheme.headlineSmall,
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.73),
                          child: HeronLabel(
                            child: Text(
                              HeronCourseDuration.oneday
                                  .getDisplayText(l10n)
                                  .toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  width: double.infinity,
                  height: (diviceWidth - 32) * (9 / 16),
                  child: HeronFadeInImage(
                    borderRadius: BorderRadius.circular(6.0),
                    "$kImageBaseURL/$imageId",
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    Text(
                      "${zones.join(', ')} ",
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.outline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    for (final theme in themes) HeronSpotThemeLabel(theme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
