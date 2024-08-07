import 'package:flutter/material.dart';
import 'package:heron_app/constants/theme/colors.dart';
import 'package:heron_app/constants/theme/typography.dart';
import 'package:heron_app/widgets/common/appbar.dart';
import 'package:heron_app/widgets/common/segments.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    final typography = getTypography(context);

    return Scaffold(
        appBar: HeronAppBar(
          child: Text("Course", style: typography.h1),
        ),
        body: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.background.page,
            ),
            child: Column(
                children: [
                  Container(
                      height: 48.0,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(child: HeronSegments(
                            items: const ["All", "Wish", "Done"],
                            onTap: (i) => setState(() => index = i ?? 0),
                            currentIndex: index,
                          )),
                          const SizedBox(width: 8.0),
                        ]
                      )
                  ),
                  const Expanded(
                    child: Placeholder()
                  )
                ]
            ))
    );
  }
}
