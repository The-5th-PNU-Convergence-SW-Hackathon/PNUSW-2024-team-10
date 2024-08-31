import 'package:flutter/material.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/widgets/list/items.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/place/place.dart';
import 'package:hugeicons/hugeicons.dart';

class ItineraryListItem extends HeronListItem {
  final HeronPlaceType type;
  final String placeId;
  final String title;
  final String description;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? mission;

  const ItineraryListItem({
    super.key,
    required this.type,
    required this.placeId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.mission,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return HeronPressableListItem(
      padding: const EdgeInsets.all(10.0),
      onPressed: () {
        // TODO: 연동 후 정확한 데이터 삽입
        if (type == HeronPlaceType.tourSpot) {
          showHeronTourSpotSheet(
            context: context,
            placeId: "ChIJUV0TbriSaDURK4AmxXitluY",
            name: "Busan Museum of Art",
            address: "58, APEC-ro, Haeundae-gu, Busan",
            themes: [
              HeronTourSpotThemeType.culture,
            ],
            zone: HeronPlaceZoneType.haeundae,
          );
        } else if (type == HeronPlaceType.food) {
          showHeronFoodSheet(
            context: context,
            placeId: "ChIJwek01K2SaDURtJMgxNliEKE",
            name: "Oreok",
            address: "51, Marine city 3-ro, Haeundae-gu, Busan",
            menu: "Beef bone soup",
            labels: [
              HeronFoodType.single,
            ],
            zone: HeronPlaceZoneType.haeundae,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium!.copyWith(
              color: colorScheme.primary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: 100.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedCamera02,
                  color: colorScheme.outline,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${l10n.coursesDetailSuggestTime}: ${startTime.format(context)} - ${endTime.format(context)}',
                      style: textTheme.labelSmall!.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (mission != null) ...[
            const SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${l10n.coursesDetailMission}  ",
                    style: textTheme.labelSmall!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: mission,
                    style: textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
