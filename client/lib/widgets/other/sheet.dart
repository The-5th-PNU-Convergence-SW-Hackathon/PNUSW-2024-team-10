import 'package:flutter/material.dart';

class HeronSheetHandle extends StatelessWidget {
  final Color? handleColor;

  const HeronSheetHandle({
    super.key,
    this.handleColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 15.0,
      alignment: Alignment.center,
      child: Container(
        width: 36.0,
        height: 5.0,
        decoration: BoxDecoration(
          color: handleColor ?? colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(2.5),
        ),
      ),
    );
  }
}
