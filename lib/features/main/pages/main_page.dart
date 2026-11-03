import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/features/chat/presentation/chat_page.dart';
import 'package:ulin/features/home/presentation/pages/home_page.dart';
import 'package:ulin/features/profile/presentation/pages/profile_setup_step1_page.dart';
import 'package:ulin/features/saved/presentation/saved_page.dart';
import 'package:ulin/features/schedule/presentation/schedule_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  List<PersistentTabConfig> _tabs() => [
    PersistentTabConfig(
      screen: const HomePage(),
      item: ItemConfig(
        icon: const Icon(Icons.home_rounded),
        title: "Home",
        activeForegroundColor: WarnaApp.wrWhite,
        activeColorSecondary: WarnaApp.wrGreen3,
        inactiveForegroundColor: WarnaApp.wrGreen
      ),
    ),

    PersistentTabConfig(
      screen: const ChatPage(),
      item: ItemConfig(
        icon: const Icon(Icons.chat_outlined),
        title: "Chat",
        activeForegroundColor: WarnaApp.wrWhite,
        activeColorSecondary: WarnaApp.wrGreen3,
        inactiveForegroundColor: WarnaApp.wrGreen
      ),
    ),

    PersistentTabConfig(
      screen: const SchedulePage(),
      item: ItemConfig(
        icon: const Icon(Icons.calendar_month_rounded),
        title: "Schedule",
        activeForegroundColor: WarnaApp.wrWhite,
        activeColorSecondary: WarnaApp.wrGreen3,
        inactiveForegroundColor: WarnaApp.wrGreen
      ),
    ),

    PersistentTabConfig(
      screen: const SavedPage(),
      item: ItemConfig(
        icon: const Icon(Icons.favorite_rounded),
        title: "Saved",
        activeForegroundColor: WarnaApp.wrWhite,
        activeColorSecondary: WarnaApp.wrGreen3,
        inactiveForegroundColor: WarnaApp.wrGreen
      ),
    ),

    PersistentTabConfig(
      screen: const ProfileSetupStep1Page(),
      item: ItemConfig(
        icon: const Icon(Icons.person_rounded),
        title: "Profile",
        activeForegroundColor: WarnaApp.wrWhite,
        activeColorSecondary: WarnaApp.wrGreen3,
        inactiveForegroundColor: WarnaApp.wrGreen
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _tabs(),
      navBarBuilder: (navBarConfig) => Style8BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: WarnaApp.wrWhite,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          boxShadow: [
            BoxShadow(
              color: WarnaApp.wrBlack.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
      ),
    );
  }
}
