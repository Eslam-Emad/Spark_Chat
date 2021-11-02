import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/authentication/authentication_bloc.dart';
import '/bloc/image_uploader/image_upload_cubit.dart';
import '/bloc/signup/signup_cubit.dart';
import '/models/user_model.dart';
import '/services/fire_auth.dart';
import '/utils/utils.dart';
import '/views/onboarding/components/onboard_button.dart';
import '/views/widgets/custom_text_field.dart';
import 'profile_image.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final AuthenticationBloc _authenticationBloc;
  late final FireAuthServices _authServices;
  late final SignupCubit _signupCubit;

  @override
  void initState() {
    super.initState();
    _authServices = FireAuthServices();
    _authenticationBloc = AuthenticationBloc();
    _signupCubit = SignupCubit(_authenticationBloc, _authServices);
  }

  final _formKey = GlobalKey<FormState>();

  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  save() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      Helper.closeKeyboard(context);
      final image = await BlocProvider.of<ImageUploadCubit>(context).uploadImage();
      if (image == null) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('image can\'t be null...')));
      }
      final user = UserModel(
        aboutMe: "aboutMe",
        photoUrl: image ?? "",
        email: _emailController.text,
        username: _userController.text,
        authorization: Authorization.user,
      );

      _signupCubit.signUp(user, _passwordController.text);

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('done...')));
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.6,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120, child: ProfileImage()),
            const Spacer(),
            CustomTextField(
              hint: "username",
              width: double.infinity,
              controller: _userController,
              inputAction: TextInputAction.next,
              onChange: (value) => value,
              inputType: TextInputType.emailAddress,
              validator: (value) => value!.trim().length > 3 ? null : "validation error",
            ),
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
            OnboardButton(onPressed: save, text: "SignUp"),
          ],
        ),
      ),
    );
  }
}
