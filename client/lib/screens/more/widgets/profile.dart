import 'package:heron/models/auth/types.dart';
import 'package:heron/widgets/list/items.dart';
import 'package:heron/widgets/list/list.dart';
import 'package:heron/widgets/profile/pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/signin/signin.dart';
import 'package:heron/widgets/theme/prefs.dart';

class MoreUserProfile extends StatelessWidget {
  const MoreUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getUser(context);

    if (user != null) {
      return MoreUserProfileHasUser(user: user);
    } else {
      return Column(
        children: [
          HeronListGroup(
            children: [
              HeronNavigationListItem(
                onPressed: () async {
                  showSignInSheet(context: context);
                },
                child: Text(AppLocalizations.of(context)!.moreProfileSignIn),
              ),
            ],
          ),
        ],
      );
    }
  }
}

class MoreUserProfileHasUser extends StatelessWidget {
  final UserInfo user;

  const MoreUserProfileHasUser({
    super.key,
    required this.user,
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
              HeronAvatar(user.avatar, size: 54.0),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    user.email,
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
  const MoreUserProfileSmall({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = getUser(context);

    return user != null
        ? Row(
            children: [
              HeronAvatar(user.avatar, size: 28.0),
              const SizedBox(width: 10.0),
              Text(
                user.name,
                style: textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
        : Text(AppLocalizations.of(context)!.navigationLabelMore);
  }
}
