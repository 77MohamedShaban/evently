import 'package:evently/model/onboarding_Model.dart';
import 'package:flutter/material.dart';

class IntroItem extends StatelessWidget {
  final OnboardingModel introData;
  final int currentIndex;

  const IntroItem({
    super.key,
    required this.introData,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Expanded(
          child: Center(
            child: Image.asset(
              introData.image,
              fit: BoxFit.fill,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            OnboardingModel.introData.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSecondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(introData.title, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        Text(
          introData.desc,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.5),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
