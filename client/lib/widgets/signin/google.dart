import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heron/models/auth/google.dart';
import 'package:heron/widgets/button/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heron/widgets/theme/prefs.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final googleSignIn = GoogleSignIn(scopes: ["email", "profile"]);

    return HeronButton(
      isLoading: _isLoading,
      variant: HeronButtonVariant.outline,
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });

        final result = await googleSignIn.signIn();
        if (result != null) {
          final idToken = (await result.authentication).idToken;
          if (idToken != null) {
            final result = await apiAuthGoogleGet(idToken);
            if (result == false) {
              await googleSignIn.signOut();
            }

            if (context.mounted) {
              updateUser(context);
              Navigator.of(context).pop();
            }
          }
        }

        setState(() {
          _isLoading = false;
        });
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
