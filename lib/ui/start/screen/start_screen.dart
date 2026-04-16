import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/remote/local/prefs_manager.dart';
import 'package:evently/core/resources/StringsManager.dart';
import 'package:evently/core/reusable_component/btn_main.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/onboarding/screen/onboarding_screen.dart';
import 'package:evently/ui/start/widgets/settings_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/resources/AssetsManager.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = "/start";

  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          width: size.width* 0.4,

          color: Theme.of(context).colorScheme.primary,
        )
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              /// Image (Responsive)
              Flexible(
                flex: 3,
                child: Image.asset(
                  AssetsManager.beingCreative,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),


              /// Title
              Text(
                StringsManager.startTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 8),

              /// Description
              Text(
                StringsManager.startDesc,
                style: Theme.of(context).textTheme.bodySmall,
              ),

              SizedBox(height: size.height * 0.03),

              /// Language Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsManager.language,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      SettingsBtn(
                        text: StringsManager.english,
                        isSelected:
                        context.locale.languageCode == "en",
                        onTap: () {
                          context.setLocale(const Locale("en"));
                        },
                      ),
                      const SizedBox(width: 8),
                      SettingsBtn(
                        text: StringsManager.arabic,
                        isSelected:
                        context.locale.languageCode == "ar",
                        onTap: () {
                          context.setLocale(const Locale("ar"));
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Theme Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsManager.theme,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      SettingsBtn(
                        icon: AssetsManager.sun,
                        isSelected:
                        themeProvider.mode == ThemeMode.light,
                        onTap: () {
                          themeProvider.changhMode(ThemeMode.light);
                        },
                      ),
                      const SizedBox(width: 8),
                      SettingsBtn(
                        icon: AssetsManager.moon,
                        isSelected:
                        themeProvider.mode == ThemeMode.dark,
                        onTap: () {
                          themeProvider.changhMode(ThemeMode.dark);
                        },
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.06),


              /// Button
              BtnMain(
                text: StringsManager.letsStart,
                onClick: () {
                  PrefsManager.startScreenBuild(true);
                  Navigator.pushReplacementNamed(
                    context,
                    OnboardingScreen.routeName,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}