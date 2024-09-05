import 'package:heron/widgets/appbar/status.dart';
import 'package:heron/widgets/button/icon.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

const kHeronAppBarHeight = 56.0;

class HeronAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool forceElevation;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool hasBackButton;
  final PreferredSizeWidget? bottom;
  final Icon backButtonIcon;

  // elevation
  final bool largeTitle;
  final bool hideTitleOnTop;
  final bool disableBorder;
  final double scrollOffset;
  final double scrollOffsetStart;
  final double scrollOffsetEnd;

  const HeronAppBar({
    super.key,
    this.forceElevation = false,
    this.title,
    this.actions,
    this.leading,
    this.hasBackButton = true,
    this.bottom,
    this.backButtonIcon = const Icon(HugeIcons.strokeRoundedArrowLeft01),
    this.largeTitle = false,
    this.hideTitleOnTop = false,
    this.disableBorder = false,
    this.scrollOffset = 0.0,
    this.scrollOffsetStart = 0.0,
    this.scrollOffsetEnd = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final padding = MediaQuery.of(context).padding;
    final hasPop = hasBackButton && Navigator.of(context).canPop();
    final hasLeading = leading != null || hasPop;

    final opacity = ((scrollOffset - scrollOffsetStart) /
            (scrollOffsetEnd - scrollOffsetStart))
        .clamp(0.0, 1.0);

    return StatusBarColor(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Opacity(
              opacity: forceElevation ? 1.0 : opacity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceBright,
                  border: disableBorder
                      ? null
                      : Border(
                          bottom: BorderSide(
                            color: colorScheme.outlineVariant,
                            width: 1.0,
                          ),
                        ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: padding.top),
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: kHeronAppBarHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (leading != null && !hasPop) leading!,
                        if (hasPop)
                          HeronIconButton(
                            icon: Icon(
                              backButtonIcon.icon,
                              color: backButtonIcon.color,
                              size: 32.0,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: hasLeading ? 6.0 : 10.0,
                            right: 10.0,
                          ),
                          child: DefaultTextStyle(
                            style: largeTitle
                                ? textTheme.headlineMedium!
                                : textTheme.headlineSmall!,
                            child: Opacity(
                              opacity: hideTitleOnTop ? opacity : 1.0,
                              child: title,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (actions != null) ...actions!,
                      ],
                    ),
                  ),
                  if (bottom != null) bottom!,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    double height = kHeronAppBarHeight;
    if (bottom != null) {
      height += bottom!.preferredSize.height;
    }
    return Size.fromHeight(height);
  }
}
