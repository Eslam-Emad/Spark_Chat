import 'package:flutter/material.dart';
import '/constants/constants.dart';

class LogoBanner extends StatelessWidget {
  const LogoBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/flash_trans.png', fit: BoxFit.fill),
          Text("Spark", style: AppTheme().aclonicaTextStyle.copyWith(fontSize: 25)),
        ],
      ),
    );
  }
}
