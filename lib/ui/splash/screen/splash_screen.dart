import 'package:evently/core/remote/local/prefs_manager.dart';
import 'package:evently/core/resources/AssetsManager.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:evently/ui/start/screen/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../home/screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // لسه بيحمل
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildSplash(context);
          }

          // فيه user
          if (snapshot.hasData) {
            Future.microtask(() {
              Navigator.pushReplacementNamed(
                context,
                HomeScreen.routeName,
              );
            });
          }
          // مفيش user
          else {
            Future.microtask(() {
              Navigator.pushReplacementNamed(
                context,
                PrefsManager.getStartScreenBuild()
                    ? LoginScreen.routeName
                    : StartScreen.routeName,
              );
            });
          }

          return _buildSplash(context);
        },
      ),
    );
  }

  Widget _buildSplash(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              AssetsManager.logo,
              color: Theme.of(context).colorScheme.primary,
              width: MediaQuery.sizeOf(context).width * 0.5,
            ),
          ),
          const Spacer(),
          Image.asset(
            AssetsManager.brand_splash,
            color: Theme.of(context).colorScheme.primary,
            width: MediaQuery.sizeOf(context).width * 0.45,
          ),
        ],
      ),
    );
  }
}