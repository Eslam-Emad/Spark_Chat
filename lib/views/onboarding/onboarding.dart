import 'package:flutter/material.dart';

import '/constants/constants.dart';
import '/views/onboarding/components/sign_up.dart';
import 'components/logo_tile.dart';
import 'components/log_in.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool isLogin = true;

  changeState() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            isLogin ? const Login() : const SignUp(),
            TextButton(
                onPressed: changeState,
                child: Text(isLogin ? "Signup" : "Login",
                  style: AppTheme().aclonicaTextStyle.copyWith(fontSize: 14),
                )),
            const Spacer(),
            const LogoTile(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
