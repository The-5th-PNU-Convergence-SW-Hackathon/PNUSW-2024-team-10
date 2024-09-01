import 'package:flutter/material.dart';
import 'package:heron/screens/more/widgets/dialog.dart';
import 'package:heron/widgets/button/text.dart';
import 'package:heron/widgets/list/items.dart';
import 'package:heron/widgets/list/list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/theme/prefs.dart';

class MoreEtcList extends StatelessWidget {
  const MoreEtcList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final user = getUser(context);

    return user != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeronListGroup(
                children: [
                  HeronPressableListItem(
                    onPressed: () {
                      showSignOutConfirmDialog(context);
                    },
                    child: Text(
                      l10n.moreEtcSignOut,
                      style: TextStyle(color: colorScheme.error),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: HeronTextButton(
                  onPressed: () {},
                  child: Text(l10n.moreEtcDeleteAccount),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
