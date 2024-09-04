import 'package:heron/screens/more/widgets/app.dart';
import 'package:heron/screens/more/widgets/etc.dart';
import 'package:heron/screens/more/widgets/profile.dart';
import 'package:heron/screens/more/widgets/prefs.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:heron/widgets/scroll/scroll.dart';
import 'package:heron/widgets/theme/prefs.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    final user = getUser(context);

    return ScrollOffsetProvider(
      builder: (context, scrollOffset, scrollController) => Scaffold(
        appBar: HeronAppBar(
          hasBackButton: false,
          scrollOffset: scrollOffset,
          largeTitle: user == null,
          title: Opacity(
            opacity:
                user != null ? ((scrollOffset - 52) / 12).clamp(0.0, 1.0) : 1.0,
            child: const MoreUserProfileSmall(),
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
          slivers: const [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MoreUserProfile(),
                ],
              ),
            ),
            SliverToBoxAdapter(
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
