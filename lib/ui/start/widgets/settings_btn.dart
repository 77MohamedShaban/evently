import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/resources/ColorsManager.dart';

class SettingsBtn extends StatelessWidget {
  final String? text;
  final String? icon;
  final bool isSelected;
  final Function() onTap;


  const SettingsBtn({
    super.key,
    this.text,
    this.icon,
    required this.isSelected, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap
      ,child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: text != null
            ? Text(
                text!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: .w600,
                  color: isSelected
                      ? ColorsManager.onPrimaryColor
                      : Theme.of(context).colorScheme.secondary,
                ),textAlign: TextAlign.center,
              )
            : SvgPicture.asset(
                icon!,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? ColorsManager.onPrimaryColor
                      : Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }
}
