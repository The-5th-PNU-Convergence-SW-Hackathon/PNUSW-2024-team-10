import 'package:flutter/material.dart';
import 'package:heron/models/auth/types.dart';
import 'package:heron/utilities/auth.dart';

Future<UserInfo?> apiUserGet(BuildContext? context) async {
  final dio = await getDioWithAccessToken(context);
  final response = await dio.get('/user');

  if (response.statusCode != 200) {
    return null;
  }

  final data = response.data;
  return UserInfo.fromJson(data);
}
