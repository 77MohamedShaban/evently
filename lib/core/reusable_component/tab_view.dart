import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../resources/AssetsManager.dart';

class TabView extends StatelessWidget {
  final TabController tabController;

  const TabView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return TabBarView(
      controller: tabController,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            (themeProvider.mode == ThemeMode.dark)
                ? AssetsManager.sport_dark
                : AssetsManager.sport_light,
            fit: BoxFit.fill,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            (themeProvider.mode == ThemeMode.dark)
                ? AssetsManager.birthday_dark
                : AssetsManager.birthday_light,
            fit: BoxFit.fill,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            (themeProvider.mode == ThemeMode.dark)
                ? AssetsManager.meeting_dark
                : AssetsManager.meeting_light,
            fit: BoxFit.fill,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            (themeProvider.mode == ThemeMode.dark)
                ? AssetsManager.book_dark
                : AssetsManager.book_light,
            fit: BoxFit.fill,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            (themeProvider.mode == ThemeMode.dark)
                ? AssetsManager.exhibition_dark
                : AssetsManager.exhibition_light,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
