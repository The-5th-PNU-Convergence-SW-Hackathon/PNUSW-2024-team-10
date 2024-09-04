import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heron/utilities/auth.dart';
import 'package:heron/widgets/label/food.dart';
import 'package:heron/widgets/label/label.dart';
import 'package:heron/models/map/types.dart';
import 'package:heron/widgets/label/spot.dart';
import 'package:heron/widgets/other/image.dart';
import 'package:heron/widgets/place/header.dart';
import 'package:heron/widgets/place/table.dart';
import 'package:heron/widgets/other/sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapping_bottom_sheet/snapping_bottom_sheet.dart';

Future<void> showHeronPlaceSheet(BuildContext context, String id) async {
  final dio = await getDioWithAccessToken(context);
  final res = await dio.get('/places/$id');

  if (res.statusCode != 200 || !context.mounted) {
    return;
  }

  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  final bottomPadding =
      MediaQueryData.fromView(View.of(context)).padding.bottom;
  final imageWidth = MediaQuery.of(context).size.width - 32.0;
  final l10n = AppLocalizations.of(context)!;

  final String googleId = res.data['googleId'];
  final String name = res.data['name'];
  final String address = res.data['address'];
  final String zone = res.data['zone'];
  final bool liked = res.data['liked'];

  final imageFuture = dio.get('/places/images/$googleId');

// for tourspot
  final themes = (res.data['themes'] as List<dynamic>?)
      ?.map((value) => HeronTourSpotTheme.fromDBString(value as String))
      .toList();

// for restaurant
  final String? menu = res.data['menu'] as String?;
  final cuisine = res.data['cuisine'] != null
      ? HeronCuisineCountry.fromDBString(res.data['cuisine'] as String)
      : null;
  final foodTypes = (res.data['foodTypes'] as List<dynamic>?)
      ?.map((value) => HeronFoodType.fromDBString(value as String))
      .toList();

  return showSnappingBottomSheet(
    context,
    builder: (context) => SnappingBottomSheetDialog(
      snapSpec: const SnapSpec(
        initialSnap: 0.9,
        snappings: [0.9],
      ),
      color: colorScheme.surfaceBright,
      cornerRadius: 10.0,
      duration: const Duration(milliseconds: 300),
      headerBuilder: (context, _) => const HeronSheetHandle(),
      scrollSpec: const ScrollSpec(
        overscroll: false,
        physics: ClampingScrollPhysics(),
      ),
      builder: (context, _) => Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 4.0,
                bottom: 24.0 + bottomPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeronPlaceSheetHeader(
                    name: name,
                    address: address,
                    googleId: googleId,
                    liked: liked,
                    likeEndpoint: '/places/$id/likes',
                  ),
                  const SizedBox(height: 6.0),
                  HeronPlaceSheetDataTable(
                    address: address,
                    menu: menu,
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        Text(
                          zone,
                          style: textTheme.bodyMedium!.copyWith(
                            color: colorScheme.outline,
                          ),
                        ),
                        if (themes != null)
                          ...themes.map((theme) => HeronSpotThemeLabel(theme)),
                        if (cuisine != null)
                          HeronLabel(child: Text(cuisine.getDisplayText(l10n))),
                        if (foodTypes != null)
                          ...foodTypes.map((type) => HeronFoodLabel(type)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: imageWidth,
                      height: imageWidth * (10 / 16) + 40,
                      child: _PlaceGoogleImage(imageFuture),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _PlaceGoogleImage extends StatelessWidget {
  final Future<Response<dynamic>> imageFuture;

  const _PlaceGoogleImage(this.imageFuture);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final imageWidth = MediaQuery.of(context).size.width - 32.0;
    final l10n = AppLocalizations.of(context)!;

    return FutureBuilder(
      future: imageFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.statusCode == 200) {
          final String photoUri = snapshot.data!.data['photoUri'];
          final String authors = snapshot.data!.data['authors'];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeronFadeInImage(
                photoUri,
                fit: BoxFit.cover,
                width: imageWidth,
                height: imageWidth * (10 / 16),
                borderRadius: BorderRadius.circular(6.0),
              ),
              Container(
                height: 40.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text(
                  "${l10n.placeImageAuthor} $authors",
                  style: textTheme.labelSmall!.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
              )
            ],
          );
        }

        return Column(
          children: [
            Container(
              width: imageWidth,
              height: imageWidth * (10 / 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: colorScheme.surfaceContainerHighest,
              ),
            ),
          ],
        );
      },
    );
  }
}
