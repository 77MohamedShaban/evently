import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/StringsManager.dart';
import '../../../../../providers/user_provider.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              StringsManager.welcomeBack,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 14),
            )
            .animate()
            .fade(duration: 400.ms)
            .slideX(begin: -0.2, end: 0, curve: Curves.easeOutBack)
            .shimmer(delay: 400.ms, duration: 500.ms, color: Colors.white)
            .shake(delay: 400.ms, duration: 400.ms, hz: 6),
        Text(
              userProvider.currentUser?.name ?? "",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            )
            .animate()
            .fade(duration: 600.ms, delay: 200.ms)
            .slideX(begin: -0.1, end: 0, curve: Curves.easeOutQuad)
            .shimmer(
              delay: 800.ms,
              duration: 1500.ms,
              color: Theme.of(context).colorScheme.primaryContainer,
              stops: [0.0, 0.2, 0.4],
            ),
      ],
    );
  }
}
