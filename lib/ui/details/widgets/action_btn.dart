import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionBtn extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final void Function() onClick;

  const ActionBtn({super.key, required this.iconPath, required this.iconColor, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap: onClick
    ,child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
