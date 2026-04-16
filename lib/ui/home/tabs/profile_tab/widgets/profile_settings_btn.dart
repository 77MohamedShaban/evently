import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileSettingsBtn extends StatelessWidget {
  final String text;
  final Widget child;
  final Function()? onTap;

  const ProfileSettingsBtn({
    super.key,
    required this.text,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child:
          Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.onPrimary,
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    child,
                  ],
                ),
              )
              .animate()
              .shimmer(
                duration: 600.ms,
                color: Theme.of(context).colorScheme.primaryContainer,
                angle: 45,
                stops: [0.4, 0.5, 0.6],
              )
              .shimmer(
                duration: 700.ms,
                delay: 600.ms,
                color: Theme.of(context).colorScheme.primaryContainer,
                angle: 45,
                stops: [0.4, 0.5, 0.6],
              ),
    );
  }
}
