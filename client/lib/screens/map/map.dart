// DISCONTINUED
// 성능 상 문제를 극복하기 어려워, 지도 기능은 중단합니다.

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heron/models/map/map.dart';
import 'package:heron/screens/map/widgets/floating.dart';
import 'package:heron/screens/map/widgets/googlemap.dart';
import 'package:flutter/material.dart';
import 'package:heron/screens/map/widgets/inherit.dart';
import 'package:heron/screens/map/widgets/buttons.dart';
import 'package:heron/widgets/appbar/status.dart';
import 'package:heron/widgets/other/future.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition _cameraPosition = kInitialCameraPosition;
  GoogleMapController? _controller;
  Set<Marker> _markers = {};

  void _setMarkers(Set<Marker> markers) {
    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return StatusBarColor(
      child: HeronFutureBuilder(
          future: () => apiMapGet(context),
          builder: (context, snapshot) {
            return MapContext(
              cameraPosition: _cameraPosition,
              controller: _controller,
              markers: _markers,
              setMarkers: _setMarkers,
              child: Stack(
                children: [
                  HeronGoogleMap(
                    onMapCreated: (controller) {
                      setState(() {
                        _controller = controller;
                      });
                    },
                    onCameraMove: (position) {
                      setState(() {
                        _cameraPosition = position;
                      });
                    },
                  ),
                  if (snapshot.data != null)
                    MapFloatings(zones: snapshot.data!),
                  const MapFilterButtons(),
                ],
              ),
            );
          }),
    );
  }
}