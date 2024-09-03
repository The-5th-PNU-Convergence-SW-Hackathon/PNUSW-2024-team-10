import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heron/widgets/other/sheet.dart';
import 'package:heron/widgets/signin/apple.dart';
import 'package:heron/widgets/signin/google.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/theme/prefs.dart';
import 'package:snapping_bottom_sheet/snapping_bottom_sheet.dart';

void showSignInSheet({
  required BuildContext context,
}) {
  final user = getUser(context);
  if (user != null) {
    return;
  }

  final l10n = AppLocalizations.of(context)!;
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  final bottomPadding =
      MediaQueryData.fromView(View.of(context)).padding.bottom;

  final backgroundColor = colorScheme.brightness == Brightness.light
      ? colorScheme.primaryContainer
      : colorScheme.surfaceBright;

  showSnappingBottomSheet(
    context,
    builder: (context) => SnappingBottomSheetDialog(
      duration: const Duration(milliseconds: 300),
      snapSpec: const SnapSpec(
        snap: true,
        initialSnap: 0.9,
        snappings: [0.9],
      ),
      scrollSpec: const ScrollSpec(
        overscroll: false,
        physics: ClampingScrollPhysics(),
      ),
      color: backgroundColor,
      cornerRadius: 10.0,
      builder: (context, _) => Column(
        children: [
          HeronSheetHandle(
            handleColor: colorScheme.onPrimaryContainer.withOpacity(0.2),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 24.0 + bottomPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    l10n.signInToContinue,
                    style: textTheme.headlineMedium!.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 36.0),
                const GoogleSignInButton(),
                if (Platform.isIOS) ...[
                  const SizedBox(height: 16.0),
                  const AppleSignInButton(),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
