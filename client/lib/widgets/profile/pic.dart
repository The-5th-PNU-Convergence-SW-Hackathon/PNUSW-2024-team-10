import 'package:flutter/material.dart';

class HeronAvatar extends StatelessWidget {
  final String? imageSrc;
  final double size;

  const HeronAvatar(
    this.imageSrc, {
    super.key,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(40.0),
        image: DecorationImage(
          image: imageSrc != null
              ? NetworkImage(imageSrc!)
              : AssetImage(
                  brightness == Brightness.dark
                      ? "assets/images/profile_pic_dark.png"
                      : "assets/images/profile_pic.png",
                ),
        ),
      ),
    );
  }
}
