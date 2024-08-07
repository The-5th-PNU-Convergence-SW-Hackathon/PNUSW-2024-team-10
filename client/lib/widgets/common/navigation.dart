import 'package:flutter/material.dart';
import 'package:heron_app/constants/theme/colors.dart';
import 'package:heron_app/constants/theme/typography.dart';

const double _navigationHeight = 62.0;

class HeronNavigation extends StatelessWidget implements PreferredSizeWidget {
  final List<HeronNavigationItem> items;
  final int currentIndex;
  final void Function(int) onTap;

  const HeronNavigation(
      {super.key,
      required this.items,
      required this.currentIndex,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    double height = _navigationHeight + MediaQuery.of(context).padding.bottom;

    return Container(
        height: height,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
            color: colors.background.page,
            border:
                Border(top: BorderSide(color: colors.tabBorder, width: .33))),
        child: Material(
            color: Colors.transparent,
            child: Row(children: [
              for (int i = 0; i < items.length; i++)
                _NavigationItemWidget(
                    label: items[i]._label,
                    icon: items[i]._icon,
                    index: i,
                    currentIndex: currentIndex,
                    onTap: onTap)
            ])));
  }

  @override
  Size get preferredSize => const Size.fromHeight(_navigationHeight);
}

class HeronNavigationItem {
  final String label;
  final IconData icon;

  const HeronNavigationItem({required this.label, required this.icon});

  String get _label => label;

  IconData get _icon => icon;
}

class _NavigationItemWidget extends StatefulWidget {
  final String label;
  final IconData icon;
  final int index;
  final int currentIndex;
  final void Function(int)? onTap;

  const _NavigationItemWidget(
      {required this.label,
      required this.icon,
      required this.index,
      required this.currentIndex,
      this.onTap});

  @override
  State<_NavigationItemWidget> createState() => _NavigationItemWidgetState();
}

class _NavigationItemWidgetState extends State<_NavigationItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAniamtion;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      value: widget.index == widget.currentIndex ? 1.0 : 0.0,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void didUpdateWidget(_NavigationItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentIndex != oldWidget.currentIndex) {
      if (widget.index == widget.currentIndex) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    final typography = getTypography(context);

    _colorAniamtion = ColorTween(begin: colors.tabGray, end: colors.global.blue)
        .animate(_controller);

    return Expanded(
        child: GestureDetector(
            onTap: () {
              if (widget.onTap != null) widget.onTap!(widget.index);
            },
            child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(widget.icon,
                          color: _colorAniamtion.value ?? colors.tabGray),
                      const SizedBox(height: 4),
                      Text(widget.label,
                          style: typography.label.copyWith(
                            fontWeight: HeronFontWeight.bold,
                            color: _colorAniamtion.value ?? colors.tabGray,
                          ))
                    ]))));
  }
}
