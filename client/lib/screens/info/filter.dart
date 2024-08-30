import 'package:flutter/material.dart';
import 'package:heron/models/info/types.dart';
import 'package:heron/widgets/chip/chip.dart';
import 'package:heron/widgets/filter/filter.dart';
import 'package:webview_flutter/webview_flutter.dart';

void showInfoFilterSheet({
  required BuildContext context,
  required void Function(List<HeronInfoFilter>) onApply,
  required List<HeronInfoFilter> initialFilters,
}) {
  final GlobalKey<_FilterSheetBodyState> filterSheetBodyKey =
      GlobalKey<_FilterSheetBodyState>();

  showFilterSheet(
    context: context,
    onApply: () {
      onApply(filterSheetBodyKey.currentState!.filters);
    },
    child: FilterSheetBody(
      key: filterSheetBodyKey,
      initialFilters: initialFilters,
    ),
    onReset: () {
      filterSheetBodyKey.currentState!.reset();
    },
  );
}

class FilterSheetBody extends StatefulWidget {
  final List<HeronInfoFilter> initialFilters;

  const FilterSheetBody({
    super.key,
    required this.initialFilters,
  });

  @override
  State<FilterSheetBody> createState() => _FilterSheetBodyState();
}

class _FilterSheetBodyState extends State<FilterSheetBody> {
  late List<HeronInfoFilter> filters;

  @override
  void initState() {
    super.initState();
    filters = widget.initialFilters;
  }

  void reset() {
    setState(() {
      filters = filters.map(_resetFilter).toList();
    });
  }

  HeronInfoFilter _resetFilter(HeronInfoFilter filter) {
    return HeronInfoFilter(
      name: filter.name,
      id: filter.id,
      options: filter.options.map((option) {
        return option.copyWith(isSelected: true);
      }).toList(),
    );
  }

  void _updateFilterSelection(
      String filterId, String optionId, bool isSelected) {
    setState(() {
      filters = filters.map((filter) {
        if (filter.id == filterId) {
          return filter.copyWith(
            options: filter.options.map((option) {
              return option.id == optionId
                  ? option.copyWith(isSelected: isSelected)
                  : option;
            }).toList(),
          );
        }
        return filter;
      }).toList();
    });
  }

  void _selectAllOptions(String filterId) {
    _updateAllOptions(filterId, true);
  }

  void _deselectAllOptions(String filterId) {
    _updateAllOptions(filterId, false);
  }

  void _updateAllOptions(String filterId, bool isSelected) {
    setState(() {
      filters = filters.map((filter) {
        if (filter.id == filterId) {
          return filter.copyWith(
            options: filter.options.map((option) {
              return option.copyWith(isSelected: isSelected);
            }).toList(),
          );
        }
        return filter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < filters.length; i++) ...[
          HeronFilterSelector(
            title: filters[i].name,
            items: filters[i].options,
            onSelectAll: () => _selectAllOptions(filters[i].id),
            onDeselectAll: () => _deselectAllOptions(filters[i].id),
            builder: (_, option) => HeronFilterChip(
              selected: option.selected,
              child: Text(option.value),
              onSelect: (selected) =>
                  _updateFilterSelection(filters[i].id, option.id, selected),
            ),
          ),
          if (i < filters.length - 1) const SizedBox(height: 24.0),
        ]
      ],
    );
  }
}

extension on HeronInfoFilterOption {
  HeronInfoFilterOption copyWith({bool? isSelected}) {
    return HeronInfoFilterOption(
      id: id,
      value: value,
      selected: isSelected ?? selected,
    );
  }
}

extension on HeronInfoFilter {
  HeronInfoFilter copyWith({List<HeronInfoFilterOption>? options}) {
    return HeronInfoFilter(
      id: id,
      name: name,
      options: options ?? this.options,
    );
  }
}
