import 'package:heron/screens/map/widgets/googlemap.dart';
import 'package:flutter/material.dart';
import 'package:heron/screens/map/widgets/overlay.dart';
import 'package:heron/widgets/appbar/status.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusBarColor(
      child: Stack(
        children: [
          HeronGoogleMap(),
          MapFilterOverlay(),
        ],
      ),
    );
  }
}
