import 'package:flutter/material.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/screens/courses/details/widgets/dialog.dart';
import 'package:heron/screens/courses/details/widgets/modifier.dart';
import 'package:heron/widgets/button/button.dart';
import 'package:heron/widgets/signin/signin.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/theme/prefs.dart';

class CourseDetailsBottom extends StatelessWidget {
  final bool startable;

  const CourseDetailsBottom({super.key, required this.startable});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final state = CourseInfo.of(context).state;

    Future<void> startCourse() {
      return CourseInfo.of(context).startCourse();
    }

    Future<void> abortCourse() {
      return CourseInfo.of(context).abortCourse();
    }

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0.0, 0.3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface.withOpacity(0.0),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        padding: EdgeInsets.only(
          top: 10.0,
          left: 24.0,
          right: 24.0,
          bottom: bottomPadding + 20.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: state == null
                  ? HeronButton(
                      disabled: !startable,
                      onPressed: () async {
                        if (getUser(context) != null) {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return CourseStartDialog(
                                onConfirm: startCourse,
                              );
                            },
                          );
                        } else {
                          showSignInSheet(context: context);
                        }
                      },
                      child: Text(
                        startable
                            ? l10n.coursesDetailStart
                            : l10n.coursesDetailStartAlreadyExists,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 2,
                          child: HeronButton(
                            disabled: state != HeronCourseState.inProgress,
                            onPressed: () {
                              if (state == HeronCourseState.inProgress) {
                                showDialog(
                                  context: context,
                                  builder: (context) => CourseAbortDialog(
                                    onConfirm: abortCourse,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              state == HeronCourseState.done
                                  ? l10n.coursesTabDone
                                  : l10n.coursesDetailAbort,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Flexible(flex: 5, child: CourseProgress()),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseProgress extends StatelessWidget {
  const CourseProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final inherited = CourseInfo.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final percentage =
        inherited.completedMissionLength / inherited.missionLength;

    return AbsorbPointer(
      absorbing: true,
      child: HeronButton(
        variant: HeronButtonVariant.outline,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.coursesDetailProgress,
                  style: TextStyle(
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "${(percentage * 100).floor()}%",
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            CourseProgressIndicator(percentage),
          ],
        ),
      ),
    );
  }
}

class CourseProgressIndicator extends StatelessWidget {
  final double percentage;

  const CourseProgressIndicator(this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1.0,
        ),
      ),
      child: AnimatedFractionallySizedBox(
        widthFactor: percentage,
        duration: const Duration(milliseconds: 180),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
      ),
    );
  }
}
