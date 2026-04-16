import 'package:evently/core/resources/StringsManager.dart';
import 'package:flutter/material.dart';

class BtnAppbar extends StatelessWidget {
  final bool isSkip;
  final void Function() onClick;

  const BtnAppbar({super.key, this.isSkip = false, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: isSkip
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Text(StringsManager.skip,style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14,fontWeight: .w600),),
              )
            : Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
      ),
    );
  }
}
