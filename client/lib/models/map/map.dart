import 'package:flutter/material.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/utilities/auth.dart';

Future<List<HeronZone>?> apiMapGet(BuildContext context) async {
  final dio = await getDioWithAccessToken(context);
  final response = await dio.get('/places');

  return response.data
      .map<HeronZone>((zone) => HeronZone.fromJson(zone))
      .toList();
}
