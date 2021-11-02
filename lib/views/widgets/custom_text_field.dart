import 'package:flutter/material.dart';
import '/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final bool enabled;
  final double? width;
  final double height;
  final Widget? suffixIcon;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Function(String value)? onChange;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    Key? key,
    this.validator,
    this.controller,
    this.suffixIcon,
    this.height = 54,
    required this.hint,
    this.enabled = true,
    required this.onChange,
    this.width = double.infinity,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextFormField(
          onChanged: widget.onChange,
          validator: widget.validator,
          cursorColor: Palette.kTheme,
          controller: widget.controller,
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          obscureText: widget.inputType == TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: widget.hint,
            enabled: widget.enabled,
            border: InputBorder.none,
            suffixIcon: widget.suffixIcon,
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            enabledBorder: AppTheme.mainOutLinedBorder(context),
            focusedBorder: AppTheme.mainOutLinedBorder(context).copyWith(
            borderSide: const BorderSide(width: 1.7, color: Palette.kTheme),
            ),
            errorBorder: AppTheme.mainOutLinedBorder(context).copyWith(
            borderSide: const BorderSide(width: 1.7, color: Palette.kIcon),
            ),
            disabledBorder: AppTheme.mainOutLinedBorder(context).copyWith(
            borderSide: const BorderSide(width: 0, color: Palette.kIconLight),
            ),
          ),
        ),
      ),
    );
  }
}
