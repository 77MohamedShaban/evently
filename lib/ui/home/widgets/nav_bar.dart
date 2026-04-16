import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/StringsManager.dart';

class NavBar extends StatelessWidget {
  final int selectedTab;

  final Function(int) onDestinationSelected;

  const NavBar({
    super.key,
    required this.selectedTab,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: NavigationBar(
        elevation: 0,
        selectedIndex: selectedTab,
        onDestinationSelected: onDestinationSelected,
        destinations: [
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              AssetsManager.home_selected,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(AssetsManager.home),
            label: StringsManager.home,
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              AssetsManager.heart_selected,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(AssetsManager.heart),
            label: StringsManager.favorite,
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              AssetsManager.profile_selected,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(AssetsManager.profile),
            label: StringsManager.profile,
          ),
        ],
      ),
    );
  }
}
