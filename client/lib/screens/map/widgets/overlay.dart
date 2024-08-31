import 'package:flutter/material.dart';
import 'package:heron/screens/map/widgets/filter.dart';
import 'package:heron/widgets/chip/chip.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapFilterOverlay extends StatelessWidget {
  const MapFilterOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final topMargin = MediaQuery.of(context).padding.top;
    final l10n = AppLocalizations.of(context)!;

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
              HeronFilterChip(
                selected: false,
                iconSize: 24.0,
                onSelect: (selected) {},
                icon: HugeIcons.strokeRoundedFavourite,
                height: 50.0,
                cornerRadius: 8.0,
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
