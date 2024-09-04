import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/utilities/auth.dart';
import 'package:image_picker/image_picker.dart';

Future<HeronCourseMissionCompletion?> apiCoursesDetailsMissionsIndexPost(
  BuildContext context,
  String id,
  int order,
  XFile image,
) async {
  final dio = await getDioWithAccessToken(context);
  final formData = FormData.fromMap({
    "image": await MultipartFile.fromFile(image.path),
  });

  final res = await dio.post("/courses/$id/missions/$order", data: formData);

  if (res.statusCode != 200) {
    return null;
  }

  return HeronCourseMissionCompletion.fromJson(res.data);
}
