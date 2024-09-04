import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heron/screens/map/widgets/filter.dart';
import 'package:heron/screens/map/widgets/googlemap.dart';
import 'package:heron/screens/map/widgets/inherit.dart';
import 'package:heron/widgets/button/button.dart';
import 'package:heron/widgets/chip/chip.dart';
import 'package:heron/widgets/theme/icon.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapFilterButtons extends StatelessWidget {
  const MapFilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final topMargin = MediaQuery.of(context).padding.top;
    final l10n = AppLocalizations.of(context)!;
    final controller = MapContext.of(context).controller;

    return Positioned(
      top: topMargin + 16.0,
      left: 16.0,
      right: 16.0,
      bottom: 16.0,
      child: Column(
        children: [
          Row(
            children: [
              HeronFilterChip(
                cornerRadius: 8.0,
                icon: HugeIcons.strokeRoundedFilterHorizontal,
                selected: false,
                onSelect: (selected) {
                  showPlacesFilterSheet(
                    context: context,
                    onApply: (themes, foods) {},
                  );
                },
                height: 40.0,
              ),
              const SizedBox(width: 10.0),
              HeronFilterChip(
                cornerRadius: 8.0,
                icon: HugeIcons.strokeRoundedLocation03,
                selected: true,
                onSelect: (selected) {},
                height: 40.0,
                child: Text(l10n.mapTourSpot),
              ),
              const SizedBox(width: 10.0),
              HeronFilterChip(
                cornerRadius: 8.0,
                icon: HugeIcons.strokeRoundedRestaurant02,
                selected: true,
                onSelect: (selected) {},
                height: 40.0,
                child: Text(l10n.mapFood),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              HeronButton(
                onPressed: () {
                  controller?.animateCamera(
                    CameraUpdate.newCameraPosition(kInitialCameraPosition),
                  );
                },
                variant: HeronButtonVariant.outline,
                child: Text(l10n.mapResetCamera),
              ),
              const SizedBox(width: 16.0),
              HeronButton(
                variant: HeronButtonVariant.outline,
                onPressed: () {},
                height: 50.0,
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: const Icon(HeronIcons.heartStroke),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
