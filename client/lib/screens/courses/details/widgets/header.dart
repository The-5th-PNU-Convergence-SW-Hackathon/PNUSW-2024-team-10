import 'package:flutter/material.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/widgets/label/label.dart';
import 'package:heron/widgets/label/spot.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseDetailsHeader extends StatelessWidget {
  final String title;
  final HeronCourseDurationType duration;
  final List<HeronPlaceZoneType> zones;
  final String? imageSrc;
  final List<HeronTourSpotThemeType> themes;

  const CourseDetailsHeader({
    super.key,
    required this.title,
    required this.duration,
    required this.zones,
    required this.imageSrc,
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$title  ",
                        style: textTheme.headlineSmall,
                      ),
                      WidgetSpan(
                        child: HeronLabel(
                          child: Text(
                            HeronCourseDurationType.oneDay.getDisplayText(l10n).toUpperCase(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Container(
                  width: double.infinity,
                  height: (diviceWidth - 32) * (9 / 16),
                  color: colorScheme.surfaceContainerHigh,
                  child: imageSrc != null
                      ? Image.network(
                          imageSrc!,
                          width: double.infinity,
                          height: (diviceWidth - 32) * (9 / 16),
                          fit: BoxFit.cover,
                        )
                      : null,
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
                      "${zones.map((zone) => zone.getDisplayText(l10n)).join(', ')} ",
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
