import 'package:flutter/material.dart';
import 'package:heron/constants/map.dart';
import 'package:heron/constants/request.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/screens/map/widgets/inherit.dart';
import 'package:heron/widgets/other/image.dart';

class MapFloatings extends StatefulWidget {
  final List<HeronZone> zones;

  const MapFloatings({super.key, required this.zones});

  @override
  State<MapFloatings> createState() => _MapFloatingsState();
}

class _MapFloatingsState extends State<MapFloatings> {
  List<Offset> _offsets = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateScreenCoordinates();
  }

  void _calculateScreenCoordinates() async {
    final mapContext = MapContext.of(context);
    final controller = mapContext.controller;
    final media = MediaQuery.of(context);

    final screenSize = Size(
      media.size.width,
      media.size.height - media.padding.top,
    );

    if (controller != null) {
      final futures = widget.zones.map((zone) async {
        final screenCoordinate =
            await controller.getScreenCoordinate(zone.latLng);
        return Offset(
          screenCoordinate.x - screenSize.width / 2,
          screenCoordinate.y - screenSize.height / 2,
        );
      }).toList();

      final results = await Future.wait(futures);

      setState(() {
        _offsets = results.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              for (int i = 0; i < _offsets.length; i++)
                MapFloatingItem(
                  offset: _offsets[i],
                  imageId: widget.zones[i].imageId,
                  name: widget.zones[i].name,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class MapFloatingItem extends StatelessWidget {
  final Offset offset;
  final String imageId;
  final String name;

  const MapFloatingItem({
    super.key,
    required this.offset,
    required this.imageId,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cameraPosition = MapContext.of(context).cameraPosition;

    final isVisible = cameraPosition.zoom > kMapZoomPlaceholderThreshold &&
        cameraPosition.zoom < kMapZoomMarkerThreshold;

    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 180),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 24),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(offset.dx, offset.dy, 0),
        width: 120.0,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: colorScheme.surfaceBright,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: colorScheme.outlineVariant,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeronFadeInImage(
              "$kThumbBaseURL/$imageId",
              height: 80,
              borderRadius: BorderRadius.circular(3.5),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                name,
                style: textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
