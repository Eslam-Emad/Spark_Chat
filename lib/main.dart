import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/views/wrapper.dart';
import '/bloc/authentication/authentication_bloc.dart';
import '/bloc/authentication/authentication_state.dart';
import '/services/firestore_service.dart';
import '/views/onboarding/onboarding.dart';
import 'bloc/chat/sendMessage/send_message_cubit.dart';
import 'bloc/image_uploader/image_upload_cubit.dart';
import 'bloc/messages/messages_bloc.dart';
import 'constants/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider<SendMessageCubit>(
          create: (context) => SendMessageCubit(FireStoreServices()),
        ),
        BlocProvider<MessagesBloc>(
          create: (context) => MessagesBloc(),
        ),
        BlocProvider<ImageUploadCubit>(
          create: (context) => ImageUploadCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        home: const ComposeUi(),
      ),
    );
  }
}

class ComposeUi extends StatelessWidget {
  const ComposeUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) => state is Authenticated
          ? const Wrapper()
          : const OnBoarding());
}
