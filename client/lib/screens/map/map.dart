import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heron/constants/map.dart';
import 'package:heron/models/map/map.dart';
import 'package:heron/screens/map/widgets/floating.dart';
import 'package:heron/screens/map/widgets/googlemap.dart';
import 'package:flutter/material.dart';
import 'package:heron/screens/map/widgets/inherit.dart';
import 'package:heron/screens/map/widgets/buttons.dart';
import 'package:heron/widgets/appbar/status.dart';
import 'package:heron/widgets/other/future.dart';
import 'package:heron/widgets/place/place.dart';
import 'package:label_marker/label_marker.dart';

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
      child: HeronFutureBuilder(future: () async {
        final results = await apiMapGet(context);

        if (results != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            for (final zone in results) {
              for (final place in zone.places) {
                final markerId = MarkerId(place.id);

                setState(() {
                  _markers.addLabelMarker(
                    LabelMarker(
                      label: place.name,
                      markerId: markerId,
                      position: place.latLng,
                      backgroundColor: colorScheme.primaryContainer,
                      textStyle: textTheme.labelLarge!.copyWith(
                        fontSize: 40.0,
                        color: colorScheme.onPrimaryContainer,
                      ),
                      onTap: () => showHeronPlaceSheet(context, place.id),
                    ),
                  );
                });
              }
            }
          });
        }

        return results;
      }, builder: (context, snapshot) {
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
                  final isZoomedDown =
                      _cameraPosition.zoom < kMapZoomMarkerThreshold &&
                          position.zoom >= kMapZoomMarkerThreshold;

                  final isZoomedUp =
                      _cameraPosition.zoom >= kMapZoomMarkerThreshold &&
                          position.zoom < kMapZoomMarkerThreshold;

                  if (isZoomedUp) {
                    setState(() {
                      _markers.clear();
                    });
                  } else if (isZoomedDown) {
                    for (final zone in snapshot.data!) {
                      for (final place in zone.places) {
                        final markerId = MarkerId(place.id);

                        setState(() {
                          _markers.addLabelMarker(
                            LabelMarker(
                              label: place.name,
                              markerId: markerId,
                              position: place.latLng,
                              backgroundColor: colorScheme.primaryContainer,
                              textStyle: textTheme.labelLarge!.copyWith(
                                fontSize: 40.0,
                                color: colorScheme.onPrimaryContainer,
                              ),
                              onTap: () =>
                                  showHeronPlaceSheet(context, place.id),
                            ),
                          );
                        });
                      }
                    }
                  }

                  setState(() {
                    _cameraPosition = position;
                  });
                },
              ),
              if (snapshot.data != null) MapFloatings(zones: snapshot.data!),
              const MapFilterButtons(),
            ],
          ),
        );
      }),
    );
  }
}
