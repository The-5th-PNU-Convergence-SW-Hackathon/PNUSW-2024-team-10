import 'dart:async';

import 'package:heron/utilities/ripple.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HeronIconButton extends StatefulWidget {
  final Icon icon;
  final void Function()? onPressed;
  final double size;

  const HeronIconButton({
    super.key,
    required this.icon,
    this.size = 44.0,
    this.onPressed,
  });

  @override
  State<HeronIconButton> createState() => _HeronIconButtonState();
}

class _HeronIconButtonState extends State<HeronIconButton>
    with SingleTickerProviderStateMixin {
  final Duration pressDuration = const Duration(milliseconds: 16);
  final Duration releaseWaitDuration = const Duration(milliseconds: 120);
  final Duration releaseDuration = const Duration(milliseconds: 180);

  Completer<void>? _delayCompleter;
  bool _isPressed = false;

  late DateTime _pressStartTime;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  void _handlePointerDown() {
    if (widget.onPressed != null) {
      _pressStartTime = DateTime.now();
      if (_delayCompleter != null && !_delayCompleter!.isCompleted) {
        _delayCompleter!.complete();
      }
      setState(() {
        _controller.forward();
        _isPressed = true;
      });
    }
  }

  void _handlePointerUp() {
    if (_isPressed) {
      final elapsedTime = DateTime.now().difference(_pressStartTime);

      if (elapsedTime >= releaseWaitDuration) {
        setState(() {
          _controller.reverse();
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
                _controller.reverse();
              });
            }
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: pressDuration,
      reverseDuration: releaseDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Listener(
      onPointerDown: (_) {
        _handlePointerDown();
      },
      onPointerUp: (_) {
        _handlePointerUp();
      },
      onPointerCancel: (_) {
        _handlePointerUp();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: InkWell(
          splashFactory: HeronRipple.splashFactory,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          borderRadius: BorderRadius.circular(6.0),
          onTap: widget.onPressed,
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: HugeIcon(
              icon: widget.icon.icon ?? HugeIcons.strokeRoundedCircle,
              color: widget.icon.color ?? colorScheme.onSurface,
              size: widget.icon.size ?? 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
