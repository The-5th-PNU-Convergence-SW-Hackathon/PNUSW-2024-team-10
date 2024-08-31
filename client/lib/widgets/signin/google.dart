import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heron/widgets/button/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return HeronButton(
      variant: HeronButtonVariant.outline,
      onPressed: () {

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/google_logo.svg",
            width: 17.0,
            height: 17.0,
          ),
          const SizedBox(width: 8.0),
          Text(l10n.signInWithGoogle),
        ],
      ),
    );
  }
}
