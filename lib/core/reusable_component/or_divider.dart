import 'package:flutter/material.dart';

import '../resources/StringsManager.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Theme.of(context).colorScheme.primary, thickness: 1, endIndent: 16)),
        Text(
          StringsManager.or,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16,fontWeight: FontWeight.w500),
        ),
        Expanded(child: Divider(color: Theme.of(context).colorScheme.primary, thickness: 1, indent: 16)),
      ],
    );
  }
}
