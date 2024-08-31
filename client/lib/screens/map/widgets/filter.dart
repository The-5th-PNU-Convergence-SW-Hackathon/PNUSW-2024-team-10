import 'package:flutter/material.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/widgets/chip/chip.dart';
import 'package:heron/widgets/filter/filter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showPlacesFilterSheet({
  required BuildContext context,
  required void Function(
    List<HeronTourSpotThemeType> themes,
    List<HeronFoodType> foodTypes,
  ) onApply,
  List<HeronTourSpotThemeType>? initialThemes,
  List<HeronFoodType>? initialFoodTypes,
}) {
  final GlobalKey<_FilterSheetBodyState> filterSheetBodyKey =
      GlobalKey<_FilterSheetBodyState>();

  showFilterSheet(
    context: context,
    onApply: () {
      onApply(
        filterSheetBodyKey.currentState!.selectedThemes,
        filterSheetBodyKey.currentState!.selectedFoodTypes,
      );
    },
    child: FilterSheetBody(
      key: filterSheetBodyKey,
      initialThemes: initialThemes,
      initialFoodTypes: initialFoodTypes,
    ),
    onReset: () {
      filterSheetBodyKey.currentState!.reset();
    },
  );
}

class FilterSheetBody extends StatefulWidget {
  final List<HeronTourSpotThemeType>? initialThemes;
  final List<HeronFoodType>? initialFoodTypes;

  const FilterSheetBody({
    super.key,
    this.initialThemes,
    this.initialFoodTypes,
  });

  @override
  State<FilterSheetBody> createState() => _FilterSheetBodyState();
}

class _FilterSheetBodyState extends State<FilterSheetBody> {
  List<HeronTourSpotThemeType> selectedThemes = [];
  List<HeronFoodType> selectedFoodTypes = [];

  @override
  void initState() {
    super.initState();
    selectedThemes = widget.initialThemes ?? HeronTourSpotThemeType.values;
    selectedFoodTypes = widget.initialFoodTypes ?? HeronFoodType.values;
  }

  void reset() {
    setState(() {
      selectedThemes = HeronTourSpotThemeType.values;
      selectedFoodTypes = HeronFoodType.values;
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
          title: l10n.placeFilterTheme,
          items: HeronTourSpotThemeType.values,
          onSelectAll: () {
            setState(() {
              selectedThemes = List.from(HeronTourSpotThemeType.values);
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
        const SizedBox(height: 24.0),
        HeronFilterSelector(
          title: l10n.placeFilterRestaurantType,
          items: HeronFoodType.values,
          onSelectAll: () {
            setState(() {
              selectedFoodTypes = List.from(HeronFoodType.values);
            });
          },
          onDeselectAll: () {
            setState(() {
              selectedFoodTypes = [];
            });
          },
          builder: (i, foodType) => HeronFilterChip(
            icon: foodType.icon,
            selected: selectedFoodTypes.contains(foodType),
            child: Text(foodType.getDisplayText(l10n)),
            onSelect: (selected) {
              setState(() {
                if (selected) {
                  selectedFoodTypes = [...selectedFoodTypes, foodType];
                } else {
                  selectedFoodTypes =
                      selectedFoodTypes.where((z) => z != foodType).toList();
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
