import 'package:flutter/cupertino.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/utilities/auth.dart';

Future<HeronCourseDetails?> apiCoursesDetailsGet(
  BuildContext context,
  String id,
) async {
  final dio = await getDioWithAccessToken(context);
  final response = await dio.get('/courses/$id');

  if (response.statusCode != 200) {
    return null;
  }

  return HeronCourseDetails.fromJson(response.data);
}
