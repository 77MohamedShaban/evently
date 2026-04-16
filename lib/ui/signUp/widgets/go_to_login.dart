import 'package:flutter/material.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/resources/UiUtils.dart';

class GoToLogin extends StatelessWidget {
  const GoToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text(StringsManager.alreadyHaveAccount,style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 14,fontWeight: .w600
        )),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            StringsManager.login,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        )
      ],);
  }
}
