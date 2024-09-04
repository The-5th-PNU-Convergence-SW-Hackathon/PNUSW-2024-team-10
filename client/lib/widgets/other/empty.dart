import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeronEmpty extends StatelessWidget {
  const HeronEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Text(
        l10n.commonEmpty,
        style: textTheme.bodyLarge!.copyWith(color: colorScheme.outline),
      ),
    );
  }
}
