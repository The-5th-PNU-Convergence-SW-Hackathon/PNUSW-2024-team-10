import 'package:flutter/material.dart';
import 'package:heron/constants/request.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/screens/courses/details/widgets/modifier.dart';
import 'package:heron/widgets/button/button.dart';
import 'package:heron/widgets/list/items.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/other/image.dart';
import 'package:heron/widgets/place/place.dart';
import 'package:hugeicons/hugeicons.dart';

class ItineraryListItem extends HeronListItem {
  final int order;
  final String placeId;
  final String title;
  final String description;
  final String time;
  final String? mission;
  final String? completion;

  const ItineraryListItem({
    super.key,
    required this.order,
    required this.placeId,
    required this.title,
    required this.description,
    required this.time,
    this.mission,
    this.completion,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final courseInfo = CourseInfo.of(context);
    final index = order - 1;

    final isInProgress = courseInfo.state == HeronCourseState.inProgress;

    final isNotCompleted = !isInProgress ||
        (isInProgress && index <= courseInfo.currentMissionIndex);

    final isActiveItem = courseInfo.state == null ||
        (courseInfo.state == HeronCourseState.done && completion != null) ||
        (isInProgress && index == courseInfo.currentMissionIndex);

    final activeColor =
        isActiveItem ? colorScheme.primary : colorScheme.outline;

    return HeronPressableListItem(
      padding: const EdgeInsets.all(10.0),
      onPressed: () {
        showHeronPlaceSheet(context, placeId);
      },
      child: AnimatedOpacity(
        opacity: isNotCompleted ? 1.0 : 0.5,
        duration: const Duration(milliseconds: 180),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleMedium!.copyWith(
                color: activeColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (courseInfo.state != null) ...[
                  _MissionCompleteButton(
                    order: order,
                    isActiveItem: isActiveItem,
                    activeColor: activeColor,
                    completion: completion,
                    absorbing: !isActiveItem,
                  ),
                  const SizedBox(width: 10.0),
                ],
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: textTheme.bodyMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '${l10n.coursesDetailSuggestTime}: $time',
                        style: textTheme.labelSmall!.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (mission != null) ...[
              const SizedBox(height: 8.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${l10n.coursesDetailMission}  ",
                      style: textTheme.labelSmall!.copyWith(
                        color: activeColor,
                      ),
                    ),
                    TextSpan(
                      text: mission,
                      style: textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MissionCompleteButton extends StatefulWidget {
  final int order;
  final bool isActiveItem;
  final Color activeColor;
  final String? completion;
  final bool absorbing;

  const _MissionCompleteButton({
    required this.order,
    required this.isActiveItem,
    required this.activeColor,
    required this.completion,
    required this.absorbing,
  });

  @override
  State<_MissionCompleteButton> createState() => _MissionCompleteButtonState();
}

class _MissionCompleteButtonState extends State<_MissionCompleteButton> {
  bool _isLoading = false;
  String? _completion;

  @override
  void initState() {
    super.initState();
    _completion = widget.completion;
  }

  @override
  Widget build(BuildContext context) {
    final courseInfo = CourseInfo.of(context);

    return SizedBox(
      width: 100.0,
      height: 80.0,
      child: AbsorbPointer(
        absorbing: widget.absorbing,
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: _completion == null ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 180),
              child: HeronButton(
                isLoading: _isLoading,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  final completion =
                      await courseInfo.completeMission(widget.order);

                  setState(() {
                    _completion = completion;
                    _isLoading = false;
                  });
                },
                elevation: widget.isActiveItem ? 2.0 : 0.0,
                borderColor: widget.activeColor,
                extrudeColor: Color.alphaBlend(
                    widget.activeColor.withOpacity(0.7), Colors.black),
                borderRadius: 10,
                variant: HeronButtonVariant.outline,
                height: 80.0,
                child: Icon(
                  HugeIcons.strokeRoundedCamera02,
                  color: widget.activeColor,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _completion != null ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 180),
              child: _completion != null
                  ? HeronFadeInImage(
                      "$kThumbBaseURL/$_completion",
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
