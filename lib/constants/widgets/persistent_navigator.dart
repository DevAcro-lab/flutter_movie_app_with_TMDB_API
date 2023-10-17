import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/view/home/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../view/download/download_movies_screen.dart';
import '../../view/profile/profile_screen.dart';
import '../../view/saved/saved_movies_screen.dart';
import '../../view/search/search_screen.dart';

class PersistentNavigator extends StatefulWidget {
  const PersistentNavigator({Key? key}) : super(key: key);

  @override
  State<PersistentNavigator> createState() => _PersistentNavigatorState();
}

class _PersistentNavigatorState extends State<PersistentNavigator> {
  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> buildScreens() {
    return [
      const HomeScreen(),
      const SearchScreen(),
      const SavedMoviesScreen(),
      const DownloadMoviesScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home_filled,
        ),
        title: ("Home"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.forgotPassColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.search_outlined,
        ),
        title: ("Search"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.forgotPassColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.save,
        ),
        title: ("Saved"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.forgotPassColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.download,
        ),
        title: ("Downloads"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.forgotPassColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person,
        ),
        title: ("Profile"),
        inactiveColorSecondary: AppColors.forgotPassColor,
        // textStyle: TextStyle(fontSize: 1),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.forgotPassColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return PersistentTabView(
      context,
      screens: buildScreens(),
      items: navBarsItems(),
      navBarStyle: NavBarStyle.style3,
      decoration: const NavBarDecoration(
        border: Border.fromBorderSide(
          BorderSide(color: AppColors.black),
        ),
      ),
      backgroundColor: AppColors.scaffoldBacColor,
      stateManagement: true,
    );
  }
}
