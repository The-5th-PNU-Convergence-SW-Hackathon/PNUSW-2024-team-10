import 'package:flutter/material.dart';
import 'package:heron_app/constants/theme/colors.dart';
import 'package:heron_app/constants/theme/typography.dart';

class HeronSegments extends StatefulWidget {
  final List<String> items;
  final int currentIndex;
  final void Function(int) onTap;

  const HeronSegments({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<HeronSegments> createState() => _HeronSegmentsState();
}

class _HeronSegmentsState extends State<HeronSegments> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  GlobalKey containerKey = GlobalKey();
  double containerWidth = 0.0;
  double moveLength = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      value: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 240),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setWidth();
    });
  }

  void _setWidth() {
    final RenderBox containerRenderBox = containerKey.currentContext!.findRenderObject() as RenderBox;
    if (containerRenderBox.size.width != containerWidth) {
      setState(() {
        containerWidth = containerRenderBox.size.width;
      });
    }
  }

  @override
  void didUpdateWidget(covariant HeronSegments oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentIndex != widget.currentIndex) {
      moveLength = (widget.currentIndex - oldWidget.currentIndex).toDouble() *
          containerWidth /
          widget.items.length;
      _controller.reverse(from: 1.0);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setWidth();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    final typography = getTypography(context);

    double indicatorWidth = containerWidth / widget.items.length;

    return Container(
      key: containerKey,
      height: 28.0,
      decoration: BoxDecoration(
        color: colors.label.gray,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                left: indicatorWidth * widget.currentIndex - moveLength * _animation.value,
                top: 0.0,
                child: Container(
                  width: indicatorWidth,
                  height: 28.0,
                  padding: const EdgeInsets.all(2.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.global.white,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
              );
            },
          ),
          Row(
            children: List.generate(widget.items.length, (i) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onTap(i);
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      widget.items[i],
                      style: typography.label.copyWith(
                        color: colors.text.title,
                        fontWeight: i == widget.currentIndex
                            ? HeronFontWeight.bold
                            : HeronFontWeight.regular,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}