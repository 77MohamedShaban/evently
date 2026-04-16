import 'package:evently/core/resources/StringsManager.dart';
import 'package:evently/core/resources/UiUtils.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/tabs/profile_tab/widgets/profile_image.dart';
import 'package:evently/ui/home/tabs/profile_tab/widgets/profile_settings_btn.dart';
import 'package:evently/ui/my_events/screen/my_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/resources/AssetsManager.dart';
import '../../../../providers/user_provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImage(),
              const SizedBox(height: 16),
              Text(
                    userProvider.currentUser?.name ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                  .animate()
                  .fade(duration: 800.ms, delay: 200.ms)
                  .slideY(begin: 0.2, end: 0, duration: 800.ms)
                  .shimmer(
                    delay: 800.ms,
                    duration: 1500.ms,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    stops: [0.0, 0.2, 0.4],
                  ),
              const SizedBox(height: 4),
              Text(
                    userProvider.currentUser?.email ?? "",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                  .animate()
                  .fade(duration: 800.ms, delay: 200.ms)
                  .slideY(begin: 0.2, end: 0, duration: 800.ms)
                  .shimmer(
                    delay: 800.ms,
                    duration: 1500.ms,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    stops: [0.0, 0.2, 0.4],
                  ),
              const SizedBox(height: 32),
              Column(
                spacing: 16,
                children: [
                  ProfileSettingsBtn(
                    text: StringsManager.myEvents,
                    child: Icon(
                      Icons.library_books_rounded,
                      size: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, MyEventsScreen.routeName);
                    },
                  ),
                  ProfileSettingsBtn(
                    text: StringsManager.darkMode,
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: themeProvider.mode == ThemeMode.dark,
                          onChanged: (value) {
                            if (themeProvider.mode == ThemeMode.dark) {
                              themeProvider.changhMode(ThemeMode.light);
                            } else {
                              themeProvider.changhMode(ThemeMode.dark);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  ProfileSettingsBtn(
                    text: StringsManager.language,
                    child: SvgPicture.asset(
                      AssetsManager.arrowRight,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    onTap: () {
                      UIUtils.openLanguageBottomSheet(context);
                    },
                  ),
                  ProfileSettingsBtn(
                    text: StringsManager.logout,
                    child: SvgPicture.asset(AssetsManager.logout),
                    onTap: () {
                      UIUtils.openLogoutBottomSheet(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
