import 'dart:async';
import 'package:flutter/material.dart';

const kFetchFaderDuration = Duration(milliseconds: 120);
const kBlinkDuration = Duration(seconds: 1);

class HeronFadeInImage extends StatefulWidget {
  final double width;
  final double height;
  final String imageUrl;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;

  const HeronFadeInImage(
    this.imageUrl, {
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  State<HeronFadeInImage> createState() => _FadeInImageWidgetState();
}

class _FadeInImageWidgetState extends State<HeronFadeInImage> {
  bool _isLoading = true;
  bool _isBackgroundColorToggled = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startBackgroundAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startBackgroundAnimation() {
    _timer = Timer.periodic(kBlinkDuration, (timer) {
      setState(() {
        _isBackgroundColorToggled = !_isBackgroundColorToggled;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = _isBackgroundColorToggled
        ? colorScheme.surfaceContainerLow
        : colorScheme.surfaceContainerHighest;

    return AnimatedContainer(
      width: widget.width,
      height: widget.height,
      curve: Curves.easeInOut,
      clipBehavior: Clip.hardEdge,
      duration: kBlinkDuration,
      decoration: BoxDecoration(
        color: _isLoading ? backgroundColor : colorScheme.surfaceContainer,
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
      ),
      child: AnimatedOpacity(
        opacity: _isLoading ? 0.0 : 1.0,
        duration: kFetchFaderDuration,
        child: Image.network(
          widget.imageUrl,
          fit: widget.fit,
          width: double.infinity,
          height: double.infinity,
          frameBuilder: (
            BuildContext context,
            Widget child,
            int? frame,
            bool wasSynchronouslyLoaded,
          ) {
            if (frame == null) {
              return const SizedBox(); // Placeholder while the first frame is not yet available
            } else {
              if (_isLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                });
              }
              return child;
            }
          },
        ),
      ),
    );
  }
}
