import 'package:flutter/material.dart';
import '/constants/constants.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width * 0.22,
        child: AppTheme.isLightTheme(context)
            ? Image.asset('assets/flash_trans.png', fit: BoxFit.fill)
            : Image.asset('assets/flash.png', fit: BoxFit.fill));
  }
}
