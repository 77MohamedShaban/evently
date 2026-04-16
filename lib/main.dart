import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/remote/local/prefs_manager.dart';
import 'package:evently/core/resources/AppTheme.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/fcm_service.dart';
import 'package:evently/ui/add_event/screen/add_event_screen.dart';
import 'package:evently/ui/details/screen/details_screen.dart';
import 'package:evently/ui/edit_event/screen/edit_event_screen.dart';
import 'package:evently/ui/forget_password/screen/forget_password_screen.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:evently/ui/my_events/screen/my_events_screen.dart';
import 'package:evently/ui/onboarding/screen/onboarding_screen.dart';
import 'package:evently/ui/signUp/screen/signUp_screen.dart';
import 'package:evently/ui/splash/screen/splash_screen.dart';
import 'package:evently/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseFirestore.instance.disableNetwork(); //todo: offline
  await EasyLocalization.ensureInitialized();
  await PrefsManager.init();
  await FcmService.initFcm();
  runApp(
    EasyLocalization(

      startLocale: Locale("en"),
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider()..init(),
        child: ChangeNotifierProvider(
         create: (context) => UserProvider() ,
            child: const MyApp()),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Evently',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.mode,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        StartScreen.routeName: (_) => StartScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        SignupScreen.routeName: (_) => SignupScreen(),
        ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
        AddEventScreen.routeName: (_) => AddEventScreen(),
        DetailsScreen.routeName: (_) => DetailsScreen(),
        EditEventScreen.routeName: (_) => EditEventScreen(),
        MyEventsScreen.routeName:(_)=>MyEventsScreen(),
      },
    );
  }
}
