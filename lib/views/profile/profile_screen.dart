import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/authentication/authentication_bloc.dart';
import '/bloc/authentication/authentication_event.dart';
import '/bloc/profile/profile_bloc.dart';
import '/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              final user = state.user;

              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                          flex: 2, child: Container(color: Palette.kTheme)),
                      Expanded(
                          flex: 3,
                          child: Container(color: Palette.kBubbleLight)),
                    ],
                  ),
                  Positioned(
                      top: size.width * 0.2,
                      left: size.width * 0.39,
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(45),
                              image: DecorationImage(
                                  image: NetworkImage(user!.photoUrl)),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.all(8),
                              child: Text(user.username.split(" ").first,
                                  style: AppTheme()
                                      .aclonicaTextStyle
                                      .copyWith(color: Colors.white))),
                        ],
                      )),
                  Positioned(
                      top: size.width * 0.6,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: size.width * 0.2,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "AboutMe",
                                style: TextStyle(
                                  color: Palette.kIconLight,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: '',
                                  fontSize: 12,
                                ),
                              ),
                              Center(
                                  child: Text(
                                user.aboutMe,
                                style: AppTheme().aclonicaTextStyle.copyWith(
                                    color: Palette.kAppBarDark,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200),
                              ))
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                    top: size.width * 0.9,
                    left: 40,
                    right: 40,
                    child: SizedBox(
                      height: size.height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.email, color: Palette.kTheme),
                              const SizedBox(width: 5),
                              Text(user.email)
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.phone_android, color: Palette.kTheme),
                              SizedBox(width: 5),
                              Text("+2022555551")
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.group_add, color: Palette.kTheme),
                              SizedBox(width: 5),
                              Text("Add to group")
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.comment, color: Palette.kTheme),
                              SizedBox(width: 5),
                              Text("Chats"),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Palette.kTheme,
                                        shape: const StadiumBorder()),
                                    onPressed: () =>
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(LoggedOut()),
                                    child: Container(
                                      height: 40.0,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'signOut',
                                        style: AppTheme()
                                            .aclonicaTextStyle
                                            .copyWith(fontSize: 18),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileFailed) {
              return const Center(child: Text("...error"));
            } else {
              return Center(child: Text("...Oops $state"));
            }
          },
        ),
      ),
    );
  }
}
