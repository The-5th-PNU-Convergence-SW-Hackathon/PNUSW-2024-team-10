import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HeronFilterChip extends StatelessWidget {
  final Widget? child;
  final IconData? icon;
  final double iconSize;
  final bool selected;
  final void Function(bool) onSelect;
  final EdgeInsetsGeometry padding;
  final bool hasCheckmark;
  final double height;
  final double cornerRadius;

  const HeronFilterChip({
    super.key,
    this.child,
    this.icon,
    this.iconSize = 16.0,
    required this.selected,
    required this.onSelect,
    this.hasCheckmark = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 11.0),
    this.height = 36.0,
    this.cornerRadius = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.surfaceBright;

    final borderColor = selected
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.outlineVariant;

    final textColor = selected
        ? Theme.of(context).colorScheme.onPrimaryContainer
        : Theme.of(context).colorScheme.onSurfaceVariant;

    final splashColor = selected
        ? Colors.transparent
        : Theme.of(context).colorScheme.onSurface.withOpacity(0.1);

    const borderWidth = 1.0;
    const animationDuration = Duration(milliseconds: 140);

    return AnimatedContainer(
      duration: animationDuration,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(cornerRadius - borderWidth),
          splashColor: splashColor,
          highlightColor: Colors.transparent,
          splashFactory: InkRipple.splashFactory,
          onTap: () {
            onSelect(!selected);
          },
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Stack(
                    children: [
                      AnimatedOpacity(
                        opacity: (selected && hasCheckmark) ? 0.0 : 1.0,
                        duration: animationDuration,
                        child: Icon(
                          icon,
                          size: iconSize,
                          color: textColor,
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: (selected && hasCheckmark) ? 1.0 : 0.0,
                        duration: animationDuration,
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedTick02,
                          size: iconSize,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ],
                if (icon != null && child != null) const SizedBox(width: 6.0),
                if (child != null) ...[
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: textColor,
                        ),
                    child: child!,
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
