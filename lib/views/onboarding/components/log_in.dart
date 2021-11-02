import 'package:flutter/material.dart';

import '/bloc/authentication/authentication_bloc.dart';
import '/bloc/login/login_bloc.dart';
import '/bloc/login/login_event.dart';
import '/services/fire_auth.dart';
import '/utils/utils.dart';
import '/views/widgets/custom_text_field.dart';
import 'onboard_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final LoginBloc _loginBloc;
  late final FireAuthServices _authServices;
  late final AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authServices = FireAuthServices();
    _authenticationBloc = AuthenticationBloc();
    _loginBloc = LoginBloc(_authenticationBloc, _authServices);
  }

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  save() async {
    if (_formKey.currentState!.validate()) {
      Helper.closeKeyboard(context);

      _loginBloc.add(LoginIn(email: _emailController.text, password: _passwordController.text));

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Login...')));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            hint: "email",
            width: double.infinity,
            controller: _emailController,
            inputAction: TextInputAction.next,
            onChange: (value) => value,
            inputType: TextInputType.emailAddress,
            validator: (value) => value!.trim().length > 3 ? null : "validation error",
          ),
          CustomTextField(
            hint: "password",
            width: double.infinity,
            controller: _passwordController,
            inputAction: TextInputAction.done,
            onChange: (value) => value,
            inputType: TextInputType.visiblePassword,
            validator: (value) => value!.trim().length > 5 ? null : "validation error",
          ),
          OnboardButton(onPressed: save, text: 'Login'),
        ],
      ),
    );
  }
}
