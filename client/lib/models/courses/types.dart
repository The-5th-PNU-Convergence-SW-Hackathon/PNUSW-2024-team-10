import 'package:heron/models/map/types.dart';
import 'package:heron/models/types.dart';
import 'package:heron/widgets/theme/label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum HeronCourseStateLabelType {
  now(HeronLabelColorType.red),
  liked(HeronLabelColorType.blue),
  done(HeronLabelColorType.gray);

  const HeronCourseStateLabelType(this.color);

  final HeronLabelColorType color;

  String getDisplayText(AppLocalizations l10n) {
    switch (this) {
      case HeronCourseStateLabelType.now:
        return l10n.coursesStatusNow;
      case HeronCourseStateLabelType.liked:
        return l10n.coursesStatusLiked;
      case HeronCourseStateLabelType.done:
        return l10n.coursesStatusDone;
    }
  }
}

HeronCourseStateLabelType? getStateLabelType(
    HeronCourseState? state, bool liked) {
  if (state == HeronCourseState.inProgress) {
    return HeronCourseStateLabelType.now;
  } else if (liked) {
    return HeronCourseStateLabelType.liked;
  } else if (state == HeronCourseState.done) {
    return HeronCourseStateLabelType.done;
  }
  return null;
}

enum HeronCourseState {
  inProgress,
  done;

  factory HeronCourseState.fromDBString(String value) {
    switch (value) {
      case 'IN_PROGRESS':
        return HeronCourseState.inProgress;
      case 'COMPLETED':
        return HeronCourseState.done;
      default:
        throw Exception('Unknown HeronCourseState: $value');
    }
  }
}

enum HeronCourseDurationType {
  oneday,
  overnight;

  String getDisplayText(AppLocalizations l10n) {
    switch (this) {
      case HeronCourseDurationType.oneday:
        return l10n.coursesDurationOneDay;
      case HeronCourseDurationType.overnight:
        return l10n.coursesDurationOverNight;
    }
  }

  factory HeronCourseDurationType.fromDBString(String value) {
    switch (value) {
      case 'ONEDAY':
        return HeronCourseDurationType.oneday;
      case 'OVERNIGHT':
        return HeronCourseDurationType.overnight;
      default:
        throw Exception('Unknown HeronCourseDurationType: $value');
    }
  }
}

class HeronCourseSummary implements HeronResponse {
  final String id;
  final String name;
  final String imageId;
  final List<HeronZoneSummary> zones;
  final HeronCourseState? state;
  final bool liked;
  final HeronCourseDurationType duration;
  final String landmark;

  const HeronCourseSummary({
    required this.id,
    required this.name,
    required this.imageId,
    required this.zones,
    this.state,
    required this.liked,
    required this.duration,
    required this.landmark,
  });

  @override
  factory HeronCourseSummary.fromJson(Map<String, dynamic> data) {
    return HeronCourseSummary(
      id: data['id'],
      name: data['name'],
      imageId: data['imageId'],
      zones: (data['zones'] as List)
          .map((zone) => HeronZoneSummary.fromJson(zone))
          .toList(),
      state: data['state'] != null
          ? HeronCourseState.fromDBString(data['state'])
          : null,
      liked: data['liked'] ?? false,
      duration: HeronCourseDurationType.fromDBString(data['duration']),
      landmark: data['landmark'],
    );
  }
}
