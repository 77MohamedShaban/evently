import 'package:evently/core/resources/StringsManager.dart';
import 'package:evently/core/reusable_component/btn_main.dart';
import 'package:evently/core/reusable_component/btn_appbar.dart';
import 'package:evently/model/onboarding_Model.dart';
import 'package:flutter/material.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../login/screen/login_screen.dart';
import '../widgets/intro_item.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/onboard";
  static  List<OnboardingModel> introData = OnboardingModel.introData;

  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 80,
        leading: currentIndex!=0? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: BtnAppbar(
              onClick: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeInOut);
              },
            ),
          ),
        ):null,
        title: Image.asset(
          AssetsManager.logo,
          width: widthScreen * 0.4,
          color: Theme.of(context).colorScheme.primary,
        ),
        actions: [
          if (currentIndex != OnboardingScreen.introData.length - 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BtnAppbar(onClick: () {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            }, isSkip: true),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return IntroItem(
                    introData: OnboardingScreen.introData[index],
                    currentIndex: currentIndex,
                  );
                },
                itemCount: OnboardingScreen.introData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                controller: _pageController,
              ),
            ),
            BtnMain(
              text: currentIndex == OnboardingScreen.introData.length - 1
                  ? StringsManager.getStarted
                  : StringsManager.next,
              onClick: () {
                if (currentIndex < OnboardingScreen.introData.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
