import 'package:flutter/material.dart';

class CourseDetailsMap extends StatelessWidget {
  const CourseDetailsMap({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width - 32.0;

    return Container(
      width: deviceWidth,
      height: deviceWidth * (10 / 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Image.asset(
        "assets/examples/course_map.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
