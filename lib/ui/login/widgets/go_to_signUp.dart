import 'package:flutter/material.dart';
import '../../../core/resources/StringsManager.dart';
import '../../signUp/screen/signUp_screen.dart';

class GoToSignup extends StatelessWidget {
  const GoToSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text(StringsManager.dontHaveAcc,style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 14,fontWeight: .w600
        )),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            Navigator.pushNamed(context, SignupScreen.routeName);
          },
          child: Text(
            StringsManager.signUp,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        )
      ],);
  }
}
