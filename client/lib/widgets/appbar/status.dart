import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarColor extends StatelessWidget {
  final Widget child;
  final Brightness? brightness;

  const StatusBarColor({super.key, required this.child, this.brightness});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: brightness ??
            (Theme.of(context).brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light),
      ),
      child: child,
    );
  }
}
