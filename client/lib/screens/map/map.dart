import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heron/constants/map.dart';
import 'package:heron/models/map/map.dart';
import 'package:heron/models/map/types.dart';
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
  final Set<Marker> _markers = {};

  List<HeronTourSpotLatLng> tourSpots = [];
  List<HeronRestaurantLatLng> restaurants = [];

  List<HeronTourSpotTheme> allowedThemes = HeronTourSpotTheme.values;
  List<HeronFoodType> allowedFoodTypes = HeronFoodType.values;
  bool showLikedOnly = false;

  void _addMarkers({
    required List<HeronTourSpotLatLng> tourSpots,
    required List<HeronRestaurantLatLng> restaurants,
    bool initialVisible = false,
  }) async {
    final newMarkers = <Marker>{}; // 새로운 마커를 추가할 Set

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 마커 생성 작업들을 모두 비동기적으로 실행하는 리스트
    List<Future<void>> markerFutures = [];

    for (final spot in tourSpots) {
      if (!spot.themes.any((theme) => allowedThemes.contains(theme)) ||
          (showLikedOnly && !spot.liked)) {
        continue;
      }

      final markerId = MarkerId(spot.id);

      // 병렬 실행을 위해 작업을 Future 리스트에 추가
      markerFutures.add(
        newMarkers.addLabelMarker(
          LabelMarker(
            visible: initialVisible,
            label: spot.name,
            markerId: markerId,
            position: spot.latLng,
            backgroundColor: colorScheme.primaryContainer,
            textStyle: textTheme.labelLarge!.copyWith(
              fontSize: 40.0,
              color: colorScheme.onPrimaryContainer,
            ),
            onTap: () => showHeronPlaceSheet(context, spot.id),
          ),
        ),
      );
    }

    for (final restaurant in restaurants) {
      if (!restaurant.foodTypes
              .any((foodType) => allowedFoodTypes.contains(foodType)) ||
          showLikedOnly && !restaurant.liked) {
        continue;
      }

      final markerId = MarkerId(restaurant.id);

      // 병렬 실행을 위해 작업을 Future 리스트에 추가
      markerFutures.add(
        newMarkers.addLabelMarker(
          LabelMarker(
            visible: initialVisible,
            label: restaurant.name,
            markerId: markerId,
            position: restaurant.latLng,
            backgroundColor: colorScheme.secondaryContainer,
            textStyle: textTheme.labelLarge!.copyWith(
              fontSize: 40.0,
              color: colorScheme.onSecondaryContainer,
            ),
            onTap: () => showHeronPlaceSheet(context, restaurant.id),
          ),
        ),
      );
    }

    // 모든 마커 생성 작업이 완료될 때까지 대기
    await Future.wait(markerFutures);

    // 마커가 모두 추가된 후 상태 업데이트
    setState(() {
      _markers
        ..clear()
        ..addAll(newMarkers);
    });
  }

  void _setFilters({
    required List<HeronTourSpotTheme> themes,
    required List<HeronFoodType> foodTypes,
  }) {
    setState(() {
      allowedThemes = themes;
      allowedFoodTypes = foodTypes;
    });

    _addMarkers(
      tourSpots: tourSpots,
      restaurants: restaurants,
      initialVisible: _cameraPosition.zoom >= kMapZoomMarkerThreshold,
    );
  }

  void _setLikedOnly(bool value) {
    setState(() {
      showLikedOnly = value;
    });

    _addMarkers(
      tourSpots: tourSpots,
      restaurants: restaurants,
      initialVisible: _cameraPosition.zoom >= kMapZoomMarkerThreshold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarColor(
      child: HeronFutureBuilder(future: () async {
        final results = await apiMapGet(context);

        tourSpots.clear();
        restaurants.clear();

        if (results != null) {
          for (final zone in results) {
            tourSpots.addAll(zone.tourSpots);
            restaurants.addAll(zone.restaurants);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              _addMarkers(
                tourSpots: zone.tourSpots,
                restaurants: zone.restaurants,
              );
            });
          }
        }

        return results;
      }, builder: (context, snapshot) {
        return MapContext(
          cameraPosition: _cameraPosition,
          controller: _controller,
          markers: _markers,
          allowedThemes: allowedThemes,
          allowedFoodTypes: allowedFoodTypes,
          showLikedOnly: showLikedOnly,
          setFilters: _setFilters,
          setLikedOnly: _setLikedOnly,
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
                      _cameraPosition.zoom >= kMapZoomMarkerThreshold &&
                          position.zoom < kMapZoomMarkerThreshold;

                  final isZoomedUp =
                      _cameraPosition.zoom < kMapZoomMarkerThreshold &&
                          position.zoom >= kMapZoomMarkerThreshold;

                  if (isZoomedDown) {
                    setState(() {
                      _markers.clear();
                    });
                  } else if (isZoomedUp) {
                    _addMarkers(
                      tourSpots: tourSpots,
                      restaurants: restaurants,
                      initialVisible: true,
                    );
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
