import 'package:flutter/material.dart';

import '/constants/constants.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Palette.kTheme,
        child: Center(
            child: Text("Video Calls",
                style: AppTheme()
                    .aclonicaTextStyle
                    .copyWith(color: Colors.white))));
  }
}
