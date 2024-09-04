import 'package:flutter/material.dart';
import 'package:heron/models/courses/types.dart';

class CourseInfo extends InheritedWidget {
  final String id;
  final HeronCourseState? state;
  final List<HeronCourseMission>? missions;
  final Future<void> Function() startCourse;
  final Future<String?> Function(int) completeMission;
  final Future<void> Function() abortCourse;

  const CourseInfo({
    super.key,
    required this.id,
    required this.state,
    required super.child,
    required this.missions,
    required this.startCourse,
    required this.completeMission,
    required this.abortCourse,
  });

  static CourseInfo of(BuildContext context) {
    final CourseInfo? result = context
        .dependOnInheritedWidgetOfExactType<CourseInfo>();
    assert(result != null, 'No _CourseDetailsStateModifier found in context');
    return result!;
  }

  int get missionLength => missions!.length;
  int get completedMissionLength => missions!.where((m) => m.completion != null).length;
  int get currentMissionIndex => missions!.indexWhere((m) => m.completion == null);

  @override
  bool updateShouldNotify(CourseInfo oldWidget) {
    return id != oldWidget.id ||
        state != oldWidget.state ||
        missions != oldWidget.missions;
  }
}

String getCourseId(BuildContext context) {
  return CourseInfo.of(context).id;
}

Future<void> startCourse(BuildContext context) {
  return CourseInfo.of(context).startCourse();
}