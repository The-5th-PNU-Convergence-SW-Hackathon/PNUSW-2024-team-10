import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapContext extends InheritedWidget {
  final CameraPosition cameraPosition;
  final GoogleMapController? controller;
  final Set<Marker> markers;
  final void Function(Set<Marker>) setMarkers;

  const MapContext({
    super.key,
    required this.cameraPosition,
    this.controller,
    required this.markers,
    required this.setMarkers,
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
    return false;
  }
}
