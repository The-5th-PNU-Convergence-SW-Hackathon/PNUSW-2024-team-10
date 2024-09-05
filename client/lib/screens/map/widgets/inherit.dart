import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heron/models/map/types.dart';

class MapContext extends InheritedWidget {
  final CameraPosition cameraPosition;
  final GoogleMapController? controller;
  final Set<Marker> markers;

  final List<HeronTourSpotTheme> allowedThemes;
  final List<HeronFoodType> allowedFoodTypes;
  final bool showLikedOnly;

  final void Function({
    required List<HeronTourSpotTheme> themes,
    required List<HeronFoodType> foodTypes,
  }) setFilters;
  final void Function(bool) setLikedOnly;

  const MapContext({
    super.key,
    required this.cameraPosition,
    this.controller,
    required this.markers,
    required this.allowedThemes,
    required this.allowedFoodTypes,
    required this.showLikedOnly,
    required this.setFilters,
    required this.setLikedOnly,
    required super.child,
  });

  static MapContext of(BuildContext context) {
    final MapContext? result =
        context.dependOnInheritedWidgetOfExactType<MapContext>();
    assert(result != null, 'No MapContext found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MapContext oldWidget) {
    return oldWidget.cameraPosition != cameraPosition ||
        oldWidget.markers != markers ||
        oldWidget.allowedThemes != allowedThemes ||
        oldWidget.allowedFoodTypes != allowedFoodTypes ||
        oldWidget.showLikedOnly != showLikedOnly;
  }
}
