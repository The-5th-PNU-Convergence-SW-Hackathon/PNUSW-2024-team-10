import 'package:flutter/material.dart';
import 'package:heron/widgets/button/button.dart';
import 'package:heron/widgets/button/text.dart';
import 'package:heron/widgets/chip/chip.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/sheet/handle.dart';
import 'package:snapping_bottom_sheet/snapping_bottom_sheet.dart';

void showFilterSheet(
    {required BuildContext context,
    required void Function() onApply,
    required Widget child,
    void Function()? onReset}) {
  final colorScheme = Theme.of(context).colorScheme;
  final l10n = AppLocalizations.of(context)!;

  final devicePadding = MediaQueryData.fromView(View.of(context)).padding;

  showSnappingBottomSheet(
    context,
    builder: (context) => SnappingBottomSheetDialog(
      cornerRadius: 10.0,
      duration: const Duration(milliseconds: 300),
      snapSpec: const SnapSpec(
        snap: true,
        initialSnap: 0.9,
        snappings: [0.9],
        positioning: SnapPositioning.relativeToAvailableSpace,
      ),
      scrollSpec: const ScrollSpec(
        overscroll: false,
        physics: ClampingScrollPhysics(),
      ),
      headerBuilder: (context, sheetState) => Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: colorScheme.surfaceBright,
          // border: Border(
          //   bottom: BorderSide(
          //     color: colorScheme.outlineVariant,
          //     width: 1.0,
          //   ),
          // ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      const SizedBox(width: 10.0),
                      Text(
                        l10n.commonFilterTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Spacer(),
                      HeronTextButton(
                        onPressed: onReset,
                        child: Text(
                          l10n.commonFilterReset,
                          style: TextStyle(color: colorScheme.outline),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: HeronSheetHandle(),
            ),
          ],
        ),
      ),
      builder: (contxt, sheetState) => Container(
        color: colorScheme.surfaceBright,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              child,
              Container(
                color: colorScheme.surfaceBright,
                padding: EdgeInsets.only(
                  top: 40.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: devicePadding.bottom + 16.0,
                ),
                alignment: Alignment.center,
                child: HeronButton(
                  onPressed: () {
                    onApply();
                    Navigator.of(context).pop();
                  },
                  child: Text(l10n.commonFilterApply),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class HeronFilterSelector<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final HeronFilterChip Function(int, T) builder;

  final void Function()? onSelectAll;
  final void Function()? onDeselectAll;

  const HeronFilterSelector({
    super.key,
    required this.title,
    required this.items,
    required this.builder,
    this.onSelectAll,
    this.onDeselectAll,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    final chipItems = [
      for (var i = 0; i < items.length; i++) builder(i, items[i]),
    ];

    final isAllSelected = chipItems.every((item) => item.selected);
    final selectAllText = isAllSelected
        ? l10n.commonFilterUnselectAll
        : l10n.commonFilterSelectAll;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 14.0),
          child: Row(
            children: [
              Text(title, style: textTheme.labelLarge),
              const Spacer(),
              if (onSelectAll != null && onDeselectAll != null)
                HeronTextButton(
                  color: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 4.0),
                  child: Text(selectAllText),
                  onPressed: () {
                    if (isAllSelected) {
                      onDeselectAll!();
                    } else {
                      onSelectAll!();
                    }
                  },
                ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: chipItems,
          ),
        ),
      ],
    );
  }
}
