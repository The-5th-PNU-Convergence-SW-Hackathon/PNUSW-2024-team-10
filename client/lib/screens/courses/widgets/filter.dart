import 'package:flutter/material.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/widgets/chip/chip.dart';
import 'package:heron/widgets/filter/filter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showCoursesFilterSheet({
  required BuildContext context,
  required void Function(
      List<HeronPlaceZoneType> zones,
      List<HeronTourSpotTheme> themes,
      ) onApply,
  List<HeronPlaceZoneType>? initialZones,
  List<HeronTourSpotTheme>? initialThemes,
}) {
  final GlobalKey<_FilterSheetBodyState> filterSheetBodyKey =
  GlobalKey<_FilterSheetBodyState>();

  showFilterSheet(
    context: context,
    onApply: () {
      onApply(
        filterSheetBodyKey.currentState!.selectedZones,
        filterSheetBodyKey.currentState!.selectedThemes,
      );
    },
    child: FilterSheetBody(
      key: filterSheetBodyKey,
      initialZones: initialZones,
      initialThemes: initialThemes,
    ),
    onReset: () {
      filterSheetBodyKey.currentState!.reset();
    },
  );
}

class FilterSheetBody extends StatefulWidget {
  final List<HeronPlaceZoneType>? initialZones;
  final List<HeronTourSpotTheme>? initialThemes;

  const FilterSheetBody({
    super.key,
    this.initialZones,
    this.initialThemes,
  });

  @override
  State<FilterSheetBody> createState() => _FilterSheetBodyState();
}

class _FilterSheetBodyState extends State<FilterSheetBody> {
  List<HeronPlaceZoneType> selectedZones = [];
  List<HeronTourSpotTheme> selectedThemes = [];

  @override
  void initState() {
    super.initState();
    selectedZones = widget.initialZones ?? HeronPlaceZoneType.values;
    selectedThemes = widget.initialThemes ?? HeronTourSpotTheme.values;
  }

  void reset() {
    setState(() {
      selectedZones = HeronPlaceZoneType.values;
      selectedThemes = HeronTourSpotTheme.values;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeronFilterSelector(
          title: l10n.coursesFilterZone,
          items: HeronPlaceZoneType.values,
          onSelectAll: () {
            setState(() {
              selectedZones = List.from(HeronPlaceZoneType.values);
            });
          },
          onDeselectAll: () {
            setState(() {
              selectedZones = [];
            });
          },
          builder: (i, zone) => HeronFilterChip(
            icon: zone.icon,
            selected: selectedZones.contains(zone),
            child: Text(zone.getDisplayText(l10n)),
            onSelect: (selected) {
              setState(() {
                if (selected) {
                  selectedZones = [...selectedZones, zone];
                } else {
                  selectedZones =
                      selectedZones.where((z) => z != zone).toList();
                }
              });
            },
          ),
        ),
        const SizedBox(height: 24.0),
        HeronFilterSelector(
          title: l10n.coursesFilterTheme,
          items: HeronTourSpotTheme.values,
          onSelectAll: () {
            setState(() {
              selectedThemes = List.from(HeronTourSpotTheme.values);
            });
          },
          onDeselectAll: () {
            setState(() {
              selectedThemes = [];
            });
          },
          builder: (i, theme) => HeronFilterChip(
            icon: theme.icon,
            selected: selectedThemes.contains(theme),
            child: Text(theme.getDisplayText(l10n)),
            onSelect: (selected) {
              setState(() {
                if (selected) {
                  selectedThemes = [...selectedThemes, theme];
                } else {
                  selectedThemes =
                      selectedThemes.where((t) => t != theme).toList();
                }
              });
            },
          ),
        ),
      ],
    );
  }
}