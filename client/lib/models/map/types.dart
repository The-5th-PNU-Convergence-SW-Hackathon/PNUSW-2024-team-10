import 'package:flutter/material.dart';
import 'package:heron/models/types.dart';
import 'package:heron/widgets/theme/label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hugeicons/hugeicons.dart';

class HeronZoneSummary extends HeronResponse {
  final String id;
  final String name;

  const HeronZoneSummary({
    required this.id,
    required this.name,
  });

  @override
  factory HeronZoneSummary.fromJson(Map<String, dynamic> data) {
    return HeronZoneSummary(
      id: data['id'],
      name: data['name'],
    );
  }
}

enum HeronPlaceType {
  tourSpot,
  food,
}

enum HeronPlaceZoneType {
  haeundae(HugeIcons.strokeRoundedBeach),
  downtown(HugeIcons.strokeRoundedCity03),
  gijang(HugeIcons.strokeRoundedMoonLanding);

  const HeronPlaceZoneType(this.icon);

  final IconData icon;

  String getDisplayText(AppLocalizations l10n) {
    switch (this) {
      case HeronPlaceZoneType.haeundae:
        return l10n.placeZoneHaeundae;
      case HeronPlaceZoneType.downtown:
        return l10n.placeZoneDowntown;
      case HeronPlaceZoneType.gijang:
        return l10n.placeZoneGijang;
    }
  }
}

enum HeronFoodType {
  vegan(HeronLabelColorType.green, HugeIcons.strokeRoundedVegetarianFood),
  blueribbon(HeronLabelColorType.blue, HugeIcons.strokeRoundedBowTie),
  halal(HeronLabelColorType.yellow, HugeIcons.strokeRoundedHalal),
  michelin(HeronLabelColorType.red, HugeIcons.strokeRoundedBookBookmark02),
  single(HeronLabelColorType.purple, HugeIcons.strokeRoundedSofaSingle);

  const HeronFoodType(this.color, this.icon);

  final HeronLabelColorType color;
  final IconData icon;

  String getDisplayText(AppLocalizations l10n) {
    switch (this) {
      case HeronFoodType.vegan:
        return l10n.foodVegan;
      case HeronFoodType.blueribbon:
        return l10n.foodBlueRibbon;
      case HeronFoodType.halal:
        return l10n.foodHalal;
      case HeronFoodType.michelin:
        return l10n.foodMichelin;
      case HeronFoodType.single:
        return l10n.foodSingle;
    }
  }
}

enum HeronTourSpotThemeType {
  history(HeronLabelColorType.yellow, HugeIcons.strokeRoundedClock03),
  nature(HeronLabelColorType.green, HugeIcons.strokeRoundedNaturalFood),
  culture(HeronLabelColorType.blue, HugeIcons.strokeRoundedMapsGlobal01),
  shopping(HeronLabelColorType.red, HugeIcons.strokeRoundedShoppingBasket01);

  const HeronTourSpotThemeType(this.color, this.icon);

  final HeronLabelColorType color;
  final IconData icon;

  String getDisplayText(AppLocalizations l10n) {
    switch (this) {
      case HeronTourSpotThemeType.history:
        return l10n.tourSpotThemeHistory;
      case HeronTourSpotThemeType.nature:
        return l10n.tourSpotThemeNature;
      case HeronTourSpotThemeType.culture:
        return l10n.tourSpotThemeCulture;
      case HeronTourSpotThemeType.shopping:
        return l10n.tourSpotThemeShopping;
    }
  }
}
