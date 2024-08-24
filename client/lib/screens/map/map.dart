import 'package:heron/screens/map/googlemap.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HeronGoogleMap(),
      ],
    );
  }
}
