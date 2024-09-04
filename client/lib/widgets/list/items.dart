import 'package:heron/utilities/ripple.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HeronListItem extends StatelessWidget {
  final EdgeInsets padding;
  final Widget? child;

  const HeronListItem({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DefaultTextStyle(
      style: textTheme.bodyLarge!,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: padding,
        constraints: const BoxConstraints(minHeight: 50.0),
        child: child,
      ),
    );
  }
}

class HeronPressableListItem extends HeronListItem {
  final void Function()? onPressed;

  const HeronPressableListItem({
    super.key,
    super.padding,
    super.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashFactory: HeronRipple.splashFactory,
        splashColor: colorScheme.outlineVariant.withOpacity(0.5),
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: super.build(context),
      ),
    );
  }
}

class HeronNavigationListItem extends HeronPressableListItem {
  const HeronNavigationListItem({
    super.key,
    super.padding,
    super.child,
    super.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return HeronPressableListItem(
      padding: padding.copyWith(right: 8.0),
      onPressed: onPressed,
      child: Row(
        children: [
          Expanded(child: child ?? const SizedBox()),
          const SizedBox(width: 8.0),
          HugeIcon(
            icon: HugeIcons.strokeRoundedArrowRight01,
            color: colorScheme.outline,
          ),
        ],
      ),
    );
  }
}

class HeronToggleListItem extends HeronPressableListItem {
  final bool value;
  final void Function(bool)? onChange;

  const HeronToggleListItem({
    super.key,
    super.padding,
    super.child,
    this.value = false,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return HeronPressableListItem(
      padding: padding.copyWith(right: 8.0),
      onPressed: () {
        onChange?.call(!value);
      },
      child: Row(
        children: [
          child ?? const SizedBox(),
          const Spacer(),
          const SizedBox(width: 16.0),
          Switch(
            value: value,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
