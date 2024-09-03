import 'package:flutter/cupertino.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/utilities/auth.dart';

Future<List<HeronCourseSummary>?> apiCoursesGet(BuildContext context) async {
  final dio = await getDioWithAccessToken(context);
  final response = await dio.get('/courses');

  if (response.statusCode != 200) {
    return null;
  }

  return response.data
      .map<HeronCourseSummary>((course) => HeronCourseSummary.fromJson(course))
      .toList();
}
