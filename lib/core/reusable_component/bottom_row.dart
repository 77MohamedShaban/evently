import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomRow extends StatelessWidget {
  final String iconPath;
  final String titleText;
  final String chooseText;
  final Function() onPress;


  const BottomRow({super.key, required this.iconPath, required this.titleText, required this.chooseText, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        Text(
          titleText,
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
          ,onPressed: onPress, child: Text(
          chooseText,
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(fontWeight: FontWeight.w400),
        ),)
      ],
    );
  }
}
