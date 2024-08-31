import 'package:heron/widgets/list/items.dart';
import 'package:heron/widgets/list/list.dart';
import 'package:heron/widgets/profile/pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum UserPlatformType {
  google,
  apple,
}

class MoreUserProfile extends StatelessWidget {
  final String name;
  final String email;
  final UserPlatformType platform;
  final ImageProvider<Object>? image;

  const MoreUserProfile({
    super.key,
    required this.name,
    required this.email,
    required this.platform,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
          child: Row(
            children: [
              HeronProfilePic(image, size: 56.0),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    email,
                    style: TextStyle(color: colorScheme.outline),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
        HeronListGroup(
          children: [
            HeronNavigationListItem(
              onPressed: () async {},
              child: Row(
                children: [
                  Text(l10n.moreProfileCompletedCourses),
                  const Spacer(),
                  Text(
                    "3",
                    style: TextStyle(
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            HeronNavigationListItem(
              onPressed: () async {},
              child: Text(l10n.moreProfileGallery),
            ),
          ],
        ),
      ],
    );
  }
}

class MoreUserProfileSmall extends StatelessWidget {
  final String name;
  final ImageProvider<Object>? image;

  const MoreUserProfileSmall({
    super.key,
    required this.name,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        HeronProfilePic(image, size: 28.0),
        const SizedBox(width: 10.0),
        Text(
          name,
          style: textTheme.titleLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
