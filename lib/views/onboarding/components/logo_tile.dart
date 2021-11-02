import 'package:flutter/material.dart';
import '/constants/constants.dart';
import 'logo.dart';

class LogoTile extends StatelessWidget {
  const LogoTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Logo(),
          Text("Spark", style: AppTheme().aclonicaTextStyle,
          ),
        ],
      ),
    );
  }
}
