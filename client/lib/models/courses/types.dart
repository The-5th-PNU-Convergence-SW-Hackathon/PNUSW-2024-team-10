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

enum HeronCourseDuration {
  oneday,
  overnight;

  String getDisplayText(AppLocalizations l10n) {
    switch (this) {
      case HeronCourseDuration.oneday:
        return l10n.coursesDurationOneDay;
      case HeronCourseDuration.overnight:
        return l10n.coursesDurationOverNight;
    }
  }

  factory HeronCourseDuration.fromDBString(String value) {
    switch (value) {
      case 'ONEDAY':
        return HeronCourseDuration.oneday;
      case 'OVERNIGHT':
        return HeronCourseDuration.overnight;
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
  final HeronCourseDuration duration;
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
      duration: HeronCourseDuration.fromDBString(data['duration']),
      landmark: data['landmark'],
    );
  }
}

class HeronCourseMission implements HeronResponse {
  final int order;
  final String placeName;
  final String placeId;
  final String description;
  final String time;
  final String? message;
  final String? completion;

  const HeronCourseMission({
    required this.order,
    required this.placeName,
    required this.placeId,
    required this.description,
    required this.time,
    required this.message,
    this.completion,
  });

  @override
  factory HeronCourseMission.fromJson(Map<String, dynamic> data) {
    return HeronCourseMission(
      order: data['order'],
      placeName: data['place']['name'],
      placeId: data['place']['id'],
      description: data['description'],
      time: data['time'],
      message: data['message'],
      completion: data['completion'],
    );
  }

  bool get isCompleted => completion != null;
}

class HeronCourseDetails implements HeronResponse {
  final String name;
  final HeronCourseDuration duration;
  final String imageId;
  final List<String> zones;
  final List<HeronTourSpotTheme> themes;
  final HeronCourseState? state;
  final bool liked;
  final bool startable;
  final List<HeronCourseMission> missions;

  const HeronCourseDetails({
    required this.name,
    required this.duration,
    required this.imageId,
    required this.zones,
    required this.themes,
    this.state,
    required this.liked,
    required this.startable,
    required this.missions,
  });

  @override
  factory HeronCourseDetails.fromJson(Map<String, dynamic> data) {
    return HeronCourseDetails(
      name: data['name'],
      duration: HeronCourseDuration.fromDBString(data['duration']),
      imageId: data['imageId'],
      zones: List<String>.from(data['zones']),
      themes: (data['themes'] as List)
          .map((theme) => HeronTourSpotTheme.fromDBString(theme))
          .toList(),
      state: data['state'] != null
          ? HeronCourseState.fromDBString(data['state'])
          : null,
      liked: data['liked'] ?? false,
      startable: data['startable'] ?? false,
      missions: (data['missions'] as List)
          .map((mission) => HeronCourseMission.fromJson(mission))
          .toList(),
    );
  }
}

class HeronCourseMissionCompletion implements HeronResponse {
  final String imageId;
  final bool isLast;

  const HeronCourseMissionCompletion({
    required this.imageId,
    required this.isLast,
  });

  @override
  factory HeronCourseMissionCompletion.fromJson(Map<String, dynamic> data) {
    return HeronCourseMissionCompletion(
      imageId: data['imageId'],
      isLast: data['isLast'],
    );
  }
}
