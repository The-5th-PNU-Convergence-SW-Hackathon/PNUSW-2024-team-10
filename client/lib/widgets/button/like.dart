import 'package:flutter/material.dart';
import 'package:heron/utilities/auth.dart';
import 'package:heron/widgets/button/icon.dart';
import 'package:heron/widgets/theme/icon.dart';

class HeronLikeButton extends StatelessWidget {
  final bool isLiked;
  final void Function(bool) onPressed;

  const HeronLikeButton({
    super.key,
    required this.isLiked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return HeronIconButton(
      icon: Icon(
        isLiked ? HeronIcons.heartFilled : HeronIcons.heartStroke,
        color: isLiked ? colorScheme.primary : colorScheme.outline,
      ),
      onPressed: () => onPressed(!isLiked),
    );
  }
}

class HeronStatefulLikeButton extends StatefulWidget {
  final bool initialIsLiked;
  final String likeEndpoint;

  const HeronStatefulLikeButton({
    super.key,
    required this.initialIsLiked,
    required this.likeEndpoint,
  });

  @override
  State<HeronStatefulLikeButton> createState() =>
      _HeronStatefulLikeButtonState();
}

class _HeronStatefulLikeButtonState extends State<HeronStatefulLikeButton> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.initialIsLiked;
  }

  @override
  Widget build(BuildContext context) {
    return HeronLikeButton(
      isLiked: isLiked,
      onPressed: (state) async {
        final dio = await getDioWithAccessToken(context);
        if (state) {
          dio.post(widget.likeEndpoint);
        } else {
          dio.delete(widget.likeEndpoint);
        }

        setState(() {
          isLiked = state;
        });
      },
    );
  }
}
