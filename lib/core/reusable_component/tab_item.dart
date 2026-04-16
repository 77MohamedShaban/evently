import 'package:evently/core/resources/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/AssetsManager.dart';

class TabItem extends StatelessWidget {
  final Color selectedColor;
  final Color unSelectedColor;
  final Color selectedBorderColor;
  final Color unSelectedBorderColor;
  final bool isSelected;
  final String eventName;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final String iconPath;


  const TabItem({
    super.key,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.selectedBorderColor,
    required this.unSelectedBorderColor,
    required this.isSelected,
    required this.eventName,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle, required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected ? selectedColor : unSelectedColor,
        border: Border.all(
          color: isSelected ? selectedBorderColor : unSelectedBorderColor,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:heightScreen* 0.01
          ,horizontal: widthScreen*0.02)
        ,child: Row(
        spacing: 8
          ,children: [
            SvgPicture.asset(
              iconPath,height: 24,width: 24,colorFilter: ColorFilter.mode(isSelected ? ColorsManager.onPrimaryColor : Theme.of(context).colorScheme.primary, BlendMode.srcIn),
            )
            ,Text(
              eventName,
              style: isSelected ? selectedTextStyle : unSelectedTextStyle,
            ),
          ],
        ),
      ),

        );
  }
}
