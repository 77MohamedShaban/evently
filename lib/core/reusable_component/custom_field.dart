import 'package:evently/core/resources/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/AssetsManager.dart';

class CustomField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String hintText;
  final String prefixPath;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool isConfirmPassword;
  final bool isSearch;
  final int maxLines;

  const CustomField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
    required this.hintText,
    this.prefixPath="",
    this.isPassword = false,
    this.validator,
    this.isConfirmPassword = false,
    this.isSearch = false,this.maxLines=1,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late bool isShowPassword = widget.isPassword;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines
      ,focusNode: _focusNode,
      enableInteractiveSelection: !widget.isConfirmPassword,
      autocorrect: !widget.isPassword,
      enableSuggestions: !widget.isPassword,
      controller: widget.controller,
      onTapUpOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: isShowPassword,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(fontSize: 16, fontWeight: .w500),

      decoration: InputDecoration(
        prefixIcon:widget.isSearch? null : Padding(
          padding: const EdgeInsetsDirectional.only(start: 16,end: 8),
          child: SvgPicture.asset(widget.prefixPath),
        ),
        prefixIconColor: ColorsManager.unselectedTab,
        prefixIconConstraints: BoxConstraints(maxHeight: 40, maxWidth: 50),
        suffixIcon: widget.isSearch?
        IconButton(onPressed: (){
          _focusNode.requestFocus();
        }, icon: SvgPicture.asset(AssetsManager.search))
            :widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              isShowPassword = !isShowPassword;
            });
          },
          icon: SvgPicture.asset(
            !isShowPassword
                ? AssetsManager.visibleOn
                : AssetsManager.visibleOff,
            height: 24,
            width: 24,
          ),
        )
            : null,
        suffixIconColor: ColorsManager.unselectedTab,
        hintText: widget.hintText,
        hintStyle: Theme.of(
          context,
        ).textTheme.titleSmall,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1.5,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onPrimary,
      ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
