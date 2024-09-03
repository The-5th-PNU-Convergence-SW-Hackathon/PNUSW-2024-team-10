import 'package:flutter/material.dart';
import 'package:heron/models/courses/details/details.dart';
import 'package:heron/models/courses/details/missions/details.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/screens/courses/details/widgets/bottom.dart';
import 'package:heron/screens/courses/details/widgets/header.dart';
import 'package:heron/screens/courses/details/widgets/list.dart';
import 'package:heron/screens/courses/details/widgets/map.dart';
import 'package:heron/screens/courses/details/widgets/modifier.dart';
import 'package:heron/utilities/auth.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:heron/widgets/button/like.dart';
import 'package:heron/widgets/list/items.dart';
import 'package:heron/widgets/list/list.dart';
import 'package:heron/widgets/other/future.dart';
import 'package:heron/widgets/scroll/scroll.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/theme/prefs.dart';
import 'package:image_picker/image_picker.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String id;

  const CourseDetailsScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ScrollOffsetProvider(
      builder: (context, scrollOffset, scrollController) => HeronFutureBuilder(
        future: () => apiCoursesDetailsGet(context, id),
        builder: (context, snapshot) => Scaffold(
          appBar: HeronAppBar(
            scrollOffset: scrollOffset,
            scrollOffsetEnd: 8.0,
            title: Text(l10n.coursesDetailHeader),
            hideTitleOnTop: true,
            actions: [
              if (snapshot.hasData)
                HeronStatefulLikeButton(
                  initialIsLiked: snapshot.data!.liked,
                  likeEndpoint: "/courses/$id/likes",
                ),
            ],
          ),
          body: HeronFutureFader(
            snapshot: snapshot,
            builder: (context, snapshot) => _CourseDetailsBody(
              id: id,
              data: snapshot.data!,
              scrollController: scrollController,
            ),
          ),
        ),
      ),
    );
  }
}

class _CourseDetailsBody extends StatefulWidget {
  final String id;
  final HeronCourseDetails data;
  final ScrollController scrollController;

  const _CourseDetailsBody({
    required this.id,
    required this.data,
    required this.scrollController,
  });

  @override
  State<_CourseDetailsBody> createState() => _CourseDetailsBodyState();
}

class _CourseDetailsBodyState extends State<_CourseDetailsBody> {
  late HeronCourseState? _state;
  late List<HeronCourseMission> _missions;

  @override
  void initState() {
    super.initState();
    _state = widget.data.state;
    _missions = widget.data.missions;
  }

  Future<void> _startCourse() async {
    if (_state == null && getUser(context) != null) {
      final dio = await getDioWithAccessToken(context);
      final res = await dio.post("/courses/${widget.id}/missions");

      if (res.statusCode == 200) {
        setState(() {
          _state = HeronCourseState.inProgress;
        });
      }
    }
  }

  Future<String?> _completeMission(int order) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (context.mounted && pickedFile != null) {
      final completion = await apiCoursesDetailsMissionsIndexPost(
        context,
        widget.id,
        order,
        pickedFile,
      );

      if (completion != null) {
        setState(() {
          _missions = _missions.map((m) {
            if (m.order == order) {
              return HeronCourseMission(
                order: m.order,
                placeName: m.placeName,
                placeId: m.placeId,
                description: m.description,
                time: m.time,
                message: m.message,
                completion: completion.imageId,
              );
            }
            return m;
          }).toList();
        });

        if (completion.isLast) {
          setState(() {
            _state = HeronCourseState.done;
          });
        }

        return completion.imageId;
      }
    }

    return null;
  }

  Future<void> _abortCourse() async {
    if (_state == HeronCourseState.inProgress && getUser(context) != null) {
      final dio = await getDioWithAccessToken(context);
      final res = await dio.delete("/courses/${widget.id}/missions");

      if (res.statusCode == 200) {
        setState(() {
          _state = HeronCourseState.done;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return CourseInfo(
      id: widget.id,
      state: _state,
      missions: _missions,
      startCourse: _startCourse,
      completeMission: _completeMission,
      abortCourse: _abortCourse,
      child: Stack(
        children: [
          CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: CourseDetailsHeader(
                  title: widget.data.name,
                  imageId: widget.data.imageId,
                  duration: widget.data.duration,
                  zones: widget.data.zones,
                  themes: widget.data.themes,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: bottomPadding + 110.0,
                  ),
                  child: Column(
                    children: [
                      HeronListGroup(
                        header: l10n.coursesDetailItinerary,
                        labelIndent: 10.0,
                        dividerIndent: 0.0,
                        children: [
                          for (final mission in widget.data.missions)
                            ItineraryListItem(
                              order: mission.order,
                              placeId: mission.placeId,
                              title: mission.placeName,
                              description: mission.description,
                              mission: mission.message,
                              time: mission.time,
                              completion: mission.completion,
                            ),
                        ],
                      ),
                      HeronListGroup(
                        header: l10n.coursesDetailMap,
                        labelIndent: 10.0,
                        children: const [
                          HeronListItem(
                            padding: EdgeInsets.zero,
                            child: CourseDetailsMap(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          CourseDetailsBottom(startable: widget.data.startable),
        ],
      ),
    );
  }
}
