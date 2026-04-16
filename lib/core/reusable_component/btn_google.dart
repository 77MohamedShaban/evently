import 'package:evently/core/resources/AssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BtnGoogle extends StatelessWidget {
  final String text;
  final void Function() onClick;

  const BtnGoogle({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(16),
          side: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        minimumSize: Size.fromHeight(50),
      ),
      onPressed: onClick,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center
      ,spacing: 16,children: [
        SvgPicture.asset(AssetsManager.googleIcon,width: 24,height: 24,),
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        )
      ],),
    );
  }
}
