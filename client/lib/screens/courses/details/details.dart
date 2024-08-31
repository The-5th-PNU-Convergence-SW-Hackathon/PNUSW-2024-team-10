import 'package:flutter/material.dart';
import 'package:heron/models/courses/types.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/screens/courses/details/widgets/header.dart';
import 'package:heron/screens/courses/details/widgets/list.dart';
import 'package:heron/screens/courses/details/widgets/map.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:heron/widgets/button/button.dart';
import 'package:heron/widgets/button/icon.dart';
import 'package:heron/widgets/list/items.dart';
import 'package:heron/widgets/list/list.dart';
import 'package:heron/widgets/scroll/scroll.dart';
import 'package:heron/widgets/signin/signin.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String? id;

  const CourseDetailsScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return ScrollOffsetProvider(
      builder: (context, scrollOffset, scrollController) => Scaffold(
        appBar: HeronAppBar(
          scrollOffset: scrollOffset,
          scrollOffsetEnd: 8.0,
          title: Text(l10n.coursesDetailHeader),
          hideTitleOnTop: true,
          actions: [
            HeronIconButton(
              onPressed: () {
                showSignInSheet(context: context);
              },
              icon: const Icon(HugeIcons.strokeRoundedFavourite),
            ),
          ],
        ),
        body: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                const SliverToBoxAdapter(
                  child: CourseDetailsHeader(
                    title: "Art & Healing Tour",
                    imageSrc:
                        "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2F15af9355-e1dd-4c9f-ada2-eb1bbfc0cbb2%2Fimage.png?table=block&id=0cc6f44d-9b59-4869-99ae-014466b1e80e&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2",
                    duration: HeronCourseDurationType.oneDay,
                    zones: [
                      HeronPlaceZoneType.downtown,
                    ],
                    themes: [
                      HeronTourSpotThemeType.history,
                      HeronTourSpotThemeType.culture,
                    ],
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
                          children: _exampleItineraryList,
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
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0.0, 0.3],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.surface.withOpacity(0.0),
                      Theme.of(context).colorScheme.surface,
                    ],
                  ),
                ),
                padding: EdgeInsets.only(
                  top: 10.0,
                  left: 24.0,
                  right: 24.0,
                  bottom: bottomPadding + 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: HeronButton(
                        onPressed: () {
                          showSignInSheet(context: context);
                        },
                        child: Text(l10n.coursesDetailStart),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const List<ItineraryListItem> _exampleItineraryList = [
  ItineraryListItem(
    type: HeronPlaceType.food,
    placeId: "1",
    title: "Oreok",
    description: "Beef bone soup",
    startTime: TimeOfDay(hour: 12, minute: 0),
    endTime: TimeOfDay(hour: 12, minute: 30),
  ),
  ItineraryListItem(
    type: HeronPlaceType.tourSpot,
    placeId: "2",
    title: "Busan Museum of Art",
    description:
        "It is an art museum where you can see various exhibitions and works.",
    startTime: TimeOfDay(hour: 13, minute: 0),
    endTime: TimeOfDay(hour: 14, minute: 0),
    mission: "Find BTS RM's signature in \"Lee Woo Hwan Space.\"",
  ),
  ItineraryListItem(
    type: HeronPlaceType.tourSpot,
    placeId: "3",
    title: "Busan Cinema Center",
    description:
        "It is the place where the Busan International Film Festival will be held, and you can also watch movies.",
    startTime: TimeOfDay(hour: 14, minute: 30),
    endTime: TimeOfDay(hour: 17, minute: 0),
    mission: "Book a movie or program you want to see yourself.",
  ),
  ItineraryListItem(
    type: HeronPlaceType.tourSpot,
    placeId: "4",
    title: "Shinsegae (Centum City)",
    description:
        "It is a representative department store located in Centum City.",
    startTime: TimeOfDay(hour: 17, minute: 10),
    endTime: TimeOfDay(hour: 18, minute: 10),
  ),
  ItineraryListItem(
    type: HeronPlaceType.food,
    placeId: "5",
    title: "Haeundae Wonjo Halmae Gukbab",
    description: "Beef and Rice soup",
    startTime: TimeOfDay(hour: 18, minute: 20),
    endTime: TimeOfDay(hour: 19, minute: 0),
  ),
  ItineraryListItem(
    type: HeronPlaceType.tourSpot,
    placeId: "6",
    title: "Gunam-ro",
    description:
        "It is a busy street that connects Haeundae Station and Haeundae Beach.",
    startTime: TimeOfDay(hour: 19, minute: 0),
    endTime: TimeOfDay(hour: 20, minute: 0),
  ),
  ItineraryListItem(
    type: HeronPlaceType.tourSpot,
    placeId: "7",
    title: "Haeundae Beach",
    description:
        "It is the most famous beach in Korea, which is visited by more than 10 million people every year.",
    startTime: TimeOfDay(hour: 20, minute: 0),
    endTime: TimeOfDay(hour: 21, minute: 0),
  ),
];
