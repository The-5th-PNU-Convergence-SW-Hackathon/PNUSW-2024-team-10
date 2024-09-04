import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<Offset> calculateElementOffset({
  required Size screenSize,
  required GoogleMapController mapController,
  required LatLng elementLatLng,
}) async {
  final screenCenter = Point(screenSize.width / 2, screenSize.height / 2);

  final ScreenCoordinate elementScreenCoordinate =
  await mapController.getScreenCoordinate(elementLatLng);
  
  final double offsetX = elementScreenCoordinate.x - screenCenter.x;
  final double offsetY = elementScreenCoordinate.y - screenCenter.y;

  return Offset(offsetX, offsetY);
}