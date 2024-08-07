import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heron_app/constants/theme/colors.dart';

const double _appBarHeight = 52.0;

class HeronAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  final Widget? leading;
  final Widget? trailing;
  final PreferredSizeWidget? bottom;
  final bool hasBottomBorder;

  const HeronAppBar(
      {super.key,
      this.child,
      this.leading,
      this.trailing,
      this.bottom,
      this.hasBottomBorder = false});

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    double height = _appBarHeight + MediaQuery.of(context).padding.top;

    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Container(
            height: height,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: colors.background.page,
              border: hasBottomBorder
                  ? Border(
                      bottom: BorderSide(color: colors.tabBorder, width: 1))
                  : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leading != null) Flexible(flex: 1, child: leading!),
                if (child != null)
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: child!),
                if (trailing != null) Flexible(flex: 1, child: trailing!),
              ],
            )));
  }

  @override
  Size get preferredSize => const Size.fromHeight(_appBarHeight);
}
