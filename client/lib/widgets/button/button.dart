import 'package:heron/utilities/ripple.dart';
import 'package:flutter/material.dart';
import 'dart:async';

enum HeronButtonVariant { primary, outline }

const heronButtonItemGap = 10.0;

class HeronButton extends StatefulWidget {
  final bool isLoading;
  final double elevation;
  final HeronButtonVariant variant;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final Color? extrudeColor;
  final void Function()? onPressed;
  final Widget? child;
  final bool disabled;

  const HeronButton({
    super.key,
    this.isLoading = false,
    this.elevation = 3.0,
    this.variant = HeronButtonVariant.primary,
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.height = 50.0,
    this.color,
    this.borderColor,
    this.extrudeColor,
    this.onPressed,
    this.child,
    this.disabled = false,
  });

  @override
  State<HeronButton> createState() => _HeronButtonState();
}

class _HeronButtonState extends State<HeronButton> {
  bool _isPressed = false;
  Completer<void>? _delayCompleter;

  final Duration pressDuration = const Duration(milliseconds: 32);
  final Duration releaseWaitDuration = const Duration(milliseconds: 120);
  final Duration releaseDuration = const Duration(milliseconds: 180);

  late DateTime _pressStartTime;

  void _handlePointerUp() {
    if (_isPressed) {
      final elapsedTime = DateTime.now().difference(_pressStartTime);

      if (elapsedTime >= releaseWaitDuration) {
        // Release immediately if the duration has passed
        setState(() {
          _isPressed = false;
        });
      } else {
        final remainingTime = releaseWaitDuration - elapsedTime;
        _delayCompleter = Completer<void>();
        Future.delayed(remainingTime, () {
          if (_delayCompleter != null && !_delayCompleter!.isCompleted) {
            _delayCompleter!.complete();
            if (mounted) {
              setState(() {
                _isPressed = false;
              });
            }
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final buttonColor = widget.color ??
        (widget.disabled
            ? colorScheme.outline
            : widget.variant == HeronButtonVariant.primary
                ? colorScheme.primaryContainer
                : colorScheme.brightness == Brightness.light
                    ? colorScheme.surfaceBright
                    : const Color(0xFF424656));

    final textColor = (widget.disabled
        ? colorScheme.outlineVariant.withOpacity(0.5)
        : widget.variant == HeronButtonVariant.primary
            ? colorScheme.onPrimaryContainer
            : colorScheme.onSurface);

    final borderColor = widget.borderColor ??
        Color.alphaBlend(buttonColor.withOpacity(0.8), Colors.black);

    final extrudeColor = widget.extrudeColor ??
        Color.alphaBlend(buttonColor.withOpacity(0.5), Colors.black);

    final isPressable = !widget.isLoading && widget.onPressed != null;
    final borderRadius = BorderRadius.circular(widget.borderRadius);

    return AbsorbPointer(
      absorbing: widget.disabled,
      child: Listener(
        onPointerDown: (_) {
          if (isPressable) {
            _pressStartTime =
                DateTime.now(); // Save the start time of the press
            if (_delayCompleter != null && !_delayCompleter!.isCompleted) {
              _delayCompleter!.complete();
            }
            setState(() {
              _isPressed = true;
            });
          }
        },
        onPointerUp: (_) {
          _handlePointerUp();
        },
        onPointerCancel: (_) {
          _handlePointerUp();
        },
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: extrudeColor,
                    borderRadius: borderRadius,
                  ),
                )),
            AnimatedContainer(
              duration: _isPressed ? pressDuration : releaseDuration,
              transform: Matrix4.translationValues(
                  0, !_isPressed ? -widget.elevation : 0, 0),
              child: Material(
                color: buttonColor,
                borderRadius: borderRadius,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                  child: InkWell(
                    borderRadius: borderRadius,
                    splashColor: borderColor.withOpacity(0.5),
                    focusColor: borderColor.withOpacity(0.5),
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashFactory: HeronRipple.splashFactory,
                    onTap: isPressable
                        ? () {
                            widget.onPressed?.call();
                          }
                        : null,
                    child: Container(
                      padding: widget.padding,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                      alignment: Alignment.center,
                      height: widget.height,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: widget.isLoading
                            ? SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.0,
                                  color: textColor,
                                  key: const ValueKey('loading'),
                                ),
                              )
                            : widget.child ??
                                const SizedBox.shrink(key: ValueKey('child')),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
