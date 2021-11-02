import 'package:flutter/material.dart';

import '/constants/constants.dart';

class OnboardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const OnboardButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Palette.kThemeSecond, shape: const StadiumBorder()),
          onPressed: onPressed,
          child: Container(
            height: 45.0,
            alignment: Alignment.center,
            child: Text(text,
            style: AppTheme().aclonicaTextStyle.copyWith(fontSize: 18),
            ),
          )),
    );
  }
}
