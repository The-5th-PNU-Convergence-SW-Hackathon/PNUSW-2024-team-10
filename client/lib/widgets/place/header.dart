import 'package:float_column/float_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/button/like.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HeronPlaceSheetHeader extends StatelessWidget {
  final String name;
  final String address;
  final String googleId;
  final bool liked;
  final String likeEndpoint;

  const HeronPlaceSheetHeader({
    super.key,
    required this.name,
    required this.address,
    required this.googleId,
    required this.liked,
    required this.likeEndpoint,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        launchUrlString(
          "https://www.google.com/maps/search/?api=1&query=$address&query_place_id=$googleId",
          mode: LaunchMode.externalApplication,
        );
      },
      child: FloatColumn(
        children: [
          Floatable(
            padding: const EdgeInsets.only(right: 10.0),
            float: FCFloat.right,
            child: HeronStatefulLikeButton(initialIsLiked: liked, likeEndpoint: likeEndpoint),
          ),
          WrappableText(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10.0,
            ),
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$name  ",
                  style: textTheme.titleLarge,
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 1.14),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: colorScheme.primary,
                            width: .33,
                          ),
                        ),
                      ),
                      child: Text(
                        l10n.placeMore,
                        style: textTheme.labelLarge!.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
