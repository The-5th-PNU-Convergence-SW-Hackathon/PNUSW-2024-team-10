import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  food;

  factory HeronPlaceType.fromDBString(String value) {
    switch (value) {
      case 'TOUR_SPOT':
        return HeronPlaceType.tourSpot;
      case 'RESTAURANT':
        return HeronPlaceType.food;
      default:
        throw Exception('Unknown HeronPlaceType: $value');
    }
  }
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

enum HeronCuisineCountry {
  korean,
  chinese,
  japanese,
  western,
  asian,
  fusion,
  etc;

  String getDisplayText(AppLocalizations l10n) {
    switch (this) {
      case HeronCuisineCountry.korean:
        return l10n.cuisineCountryKorean;
      case HeronCuisineCountry.chinese:
        return l10n.cuisineCountryChinese;
      case HeronCuisineCountry.japanese:
        return l10n.cuisineCountryJapanese;
      case HeronCuisineCountry.western:
        return l10n.cuisineCountryWestern;
      case HeronCuisineCountry.asian:
        return l10n.cuisineCountryAsian;
      case HeronCuisineCountry.fusion:
        return l10n.cuisineCountryFusion;
      case HeronCuisineCountry.etc:
        return l10n.cuisineCountryEtc;
    }
  }

  factory HeronCuisineCountry.fromDBString(String value) {
    switch (value) {
      case 'KOREAN':
        return HeronCuisineCountry.korean;
      case 'CHINESE':
        return HeronCuisineCountry.chinese;
      case 'JAPANESE':
        return HeronCuisineCountry.japanese;
      case 'WESTERN':
        return HeronCuisineCountry.western;
      case 'ASIAN':
        return HeronCuisineCountry.asian;
      case 'FUSION':
        return HeronCuisineCountry.fusion;
      case 'ETC':
        return HeronCuisineCountry.etc;
      default:
        throw Exception('Unknown HeronCuisineCountry: $value');
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

  factory HeronFoodType.fromDBString(String value) {
    switch (value) {
      case 'VEGAN':
        return HeronFoodType.vegan;
      case 'BLUERIBBON':
        return HeronFoodType.blueribbon;
      case 'HALAL':
        return HeronFoodType.halal;
      case 'MICHELIN':
        return HeronFoodType.michelin;
      case 'SINGLE':
        return HeronFoodType.single;
      default:
        throw Exception('Unknown HeronFoodType: $value');
    }
  }
}

enum HeronTourSpotTheme {
  history(HeronLabelColorType.yellow, HugeIcons.strokeRoundedClock03),
  nature(HeronLabelColorType.green, HugeIcons.strokeRoundedNaturalFood),
  culture(HeronLabelColorType.blue, HugeIcons.strokeRoundedMapsGlobal01),
  shopping(HeronLabelColorType.red, HugeIcons.strokeRoundedShoppingBasket01);

  const HeronTourSpotTheme(this.color, this.icon);

  final HeronLabelColorType color;
  final IconData icon;

  String getDisplayText(AppLocalizations l10n) {
    switch (this) {
      case HeronTourSpotTheme.history:
        return l10n.tourSpotThemeHistory;
      case HeronTourSpotTheme.nature:
        return l10n.tourSpotThemeNature;
      case HeronTourSpotTheme.culture:
        return l10n.tourSpotThemeCulture;
      case HeronTourSpotTheme.shopping:
        return l10n.tourSpotThemeShopping;
    }
  }

  static HeronTourSpotTheme fromDBString(String value) {
    switch (value) {
      case 'HISTORY':
        return HeronTourSpotTheme.history;
      case 'NATURE':
        return HeronTourSpotTheme.nature;
      case 'CULTURE':
        return HeronTourSpotTheme.culture;
      case 'SHOPPING':
        return HeronTourSpotTheme.shopping;
      default:
        throw Exception('Unknown HeronTourSpotTheme: $value');
    }
  }
}

class HeronZone extends HeronResponse {
  final String id;
  final String name;
  final String imageId;
  final LatLng latLng;
  final List<HeronTourSpotLatLng> tourSpots;
  final List<HeronRestaurantLatLng> restaurants;

  const HeronZone({
    required this.id,
    required this.name,
    required this.imageId,
    required this.latLng,
    this.tourSpots = const [],
    this.restaurants = const [],
  });

  factory HeronZone.fromJson(Map<String, dynamic> data) {
    final tourSpots = data['places']
        .where((place) => place['type'] == 'TOUR_SPOT')
        .map<HeronTourSpotLatLng>(
            (place) => HeronTourSpotLatLng.fromJson(place))
        .toList();

    final restaurants = data['places']
        .where((place) => place['type'] == 'RESTAURANT')
        .map<HeronRestaurantLatLng>(
            (place) => HeronRestaurantLatLng.fromJson(place))
        .toList();

    return HeronZone(
      id: data['id'],
      name: data['name'],
      imageId: data['imageId'],
      latLng: LatLng(data['latitude'], data['longitude']),
      tourSpots: tourSpots,
      restaurants: restaurants,
    );
  }
}

class HeronTourSpotLatLng extends HeronResponse {
  final String id;
  final String name;
  final LatLng latLng;
  final bool liked;
  final HeronPlaceType type;
  final List<HeronTourSpotTheme> themes;

  const HeronTourSpotLatLng({
    required this.id,
    required this.name,
    required this.latLng,
    required this.liked,
    required this.type,
    this.themes = const [],
  });

  factory HeronTourSpotLatLng.fromJson(Map<String, dynamic> data) {
    return HeronTourSpotLatLng(
      id: data['id'],
      name: data['name'],
      latLng: LatLng(data['latitude'], data['longitude']),
      liked: data['liked'] ?? false,
      type: HeronPlaceType.fromDBString(data['type']),
      themes: (data['themes'] as List<dynamic>)
          .map((value) => HeronTourSpotTheme.fromDBString(value as String))
          .toList(),
    );
  }
}

class HeronRestaurantLatLng extends HeronResponse {
  final String id;
  final String name;
  final LatLng latLng;
  final bool liked;
  final HeronPlaceType type;

  final HeronCuisineCountry cuisine;
  final List<HeronFoodType> foodTypes;

  const HeronRestaurantLatLng({
    required this.id,
    required this.name,
    required this.latLng,
    required this.liked,
    required this.type,
    required this.cuisine,
    this.foodTypes = const [],
  });

  factory HeronRestaurantLatLng.fromJson(Map<String, dynamic> data) {
    return HeronRestaurantLatLng(
      id: data['id'],
      name: data['name'],
      latLng: LatLng(data['latitude'], data['longitude']),
      liked: data['liked'] ?? false,
      type: HeronPlaceType.fromDBString(data['type']),
      cuisine: HeronCuisineCountry.fromDBString(data['cuisine']),
      foodTypes: (data['foodTypes'] as List<dynamic>)
          .map((value) => HeronFoodType.fromDBString(value as String))
          .toList(),
    );
  }
}
