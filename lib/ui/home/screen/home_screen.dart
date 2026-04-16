import 'package:evently/core/resources/StringsManager.dart';
import 'package:evently/ui/add_event/screen/add_event_screen.dart';
import 'package:evently/ui/home/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/AssetsManager.dart';
import '../../../providers/user_provider.dart';
import '../tabs/favorite_tab/favorite_tab.dart';
import '../tabs/home_tab/home_tab.dart';
import '../tabs/profile_tab/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];

  @override
  void initState() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddEventScreen.routeName);
          },
          child: SvgPicture.asset(AssetsManager.add),
        ),
      ),
      bottomNavigationBar: NavBar(
        selectedTab: selectedTab,
        onDestinationSelected: (value) {
          setState(() {
            selectedTab = value;
          });
        },
      ),
      body: tabs[selectedTab],
    );
  }
}
