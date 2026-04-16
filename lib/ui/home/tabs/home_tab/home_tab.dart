import 'package:evently/core/resources/AppConstance.dart';
import 'package:evently/core/reusable_component/tab_item.dart';
import 'package:evently/model/tab_model.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/header.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/view_tabs.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/ColorsManager.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: AppConstance.tabHomeList.length,
      vsync: this,
    );

    _tabController.addListener(() {
      setState(() {
        selectedTab = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TabModel> tabHomeList = AppConstance.tabHomeList;

    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: heightScreen * 0.02,
          left: heightScreen * 0.02,
          right: heightScreen * 0.02,
        ),
        child: Column(
          spacing: heightScreen * 0.03,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            TabBar(
              controller: _tabController,
              onTap: (value) {
                setState(() {
                  selectedTab = value;
                });
              },
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
              dividerHeight: 0,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(
                horizontal: widthScreen * 0.02,
              ),
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.transparent,
              tabs: List.generate(tabHomeList.length, (index) {
                final eventData = tabHomeList[index];
                return TabItem(
                  selectedColor: Theme.of(context).colorScheme.primary,
                  unSelectedColor: Theme.of(context).colorScheme.onPrimary,
                  selectedBorderColor: Colors.transparent,
                  unSelectedBorderColor: Theme.of(context).colorScheme.outline,
                  isSelected: selectedTab == index,
                  eventName: eventData.text,
                  selectedTextStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.onPrimaryColor,
                  ),
                  unSelectedTextStyle:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ) ??
                      const TextStyle(),
                  iconPath: eventData.iconPath,
                );
              }).toList(),
            ),
            Expanded(child: ViewTabs(controller: _tabController)),
          ],
        ),
      ),
    );
  }
}
