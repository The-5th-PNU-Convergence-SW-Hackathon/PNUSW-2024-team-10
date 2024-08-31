import 'package:heron/screens/more/app.dart';
import 'package:heron/screens/more/etc.dart';
import 'package:heron/screens/more/profile.dart';
import 'package:heron/screens/more/prefs.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:heron/widgets/scroll/scroll.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final profileKey = GlobalKey();
  double _profileHeight = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final RenderBox profileRenderBox =
          profileKey.currentContext!.findRenderObject() as RenderBox;

      setState(() {
        _profileHeight = profileRenderBox.size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    // TODO: Implement ProfileScreen
    final String name = "홍길동";
    final String email = "gildong1557@gmail.com";
    final UserPlatformType platform = UserPlatformType.google;
    final ImageProvider<Object>? image = null;
    final int courses = 3;
    final int missions = 12;

    return ScrollOffsetProvider(
      builder: (context, scrollOffset, scrollController) => Scaffold(
        appBar: HeronAppBar(
          hasBackButton: false,
          scrollOffset: scrollOffset,
          title: Opacity(
            opacity: ((scrollOffset - _profileHeight) / 12).clamp(0.0, 1.0),
            child: MoreUserProfileSmall(
              name: name,
              image: image,
            ),
          ),
          // actions: [
          // 추후 알림 기능 구현 시 사용
          // HeronIconButton(
          //   icon: const Icon(HugeIcons.strokeRoundedNotification03),
          //   onPressed: () {},
          // ),
          // ],
        ),
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MoreUserProfile(
                    key: profileKey,
                    name: name,
                    email: email,
                    platform: platform,
                    image: image,
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  MoreUserSettingsList(),
                  MoreAppInfoList(),
                  MoreEtcList(),
                  SizedBox(height: 40.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
