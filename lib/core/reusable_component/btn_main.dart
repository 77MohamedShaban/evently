import 'package:flutter/material.dart';

import '../resources/ColorsManager.dart';

class BtnMain extends StatelessWidget {
  final String text;
  final double fontSize;
  final void Function()? onClick;

  const BtnMain({
    super.key,
    required this.text,
    required this.onClick,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: .circular(16)),
        foregroundColor: ColorsManager.onPrimaryColor,
        minimumSize: Size.fromHeight(50),
      ),
      onPressed: onClick,
      child: Text(
        text,
        style: TextStyle(fontWeight: .w500, fontSize: fontSize),
        textAlign: TextAlign.center,
      ),
    );
  }
}
