import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/services/fire_auth.dart';
import '/utils/helper.dart';
import '/bloc/home/home_cubit.dart';
import 'components/logo_banner.dart';
import 'components/search_text_field.dart';
import 'components/user_tile.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final FireAuthServices _authServices = FireAuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => Helper.closeKeyboard(context),
            child: SafeArea(
              child: Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Column(
                  children: [
                    Row(
                      children: const [Expanded(child: LogoBanner())],
                    ),
                    const SearchTextField(),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Divider(indent: 1, thickness: 0.2)),
                    BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is GetUsersSuccessfully) {
                            final users = state.users;
                            return ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: users.length,
                                itemBuilder: (context, index) {
                                  if (users[index].id ==
                                      _authServices.currentUser!.uid) {
                                    return const Text("");
                                  }
                                  return UserTile(
                                    userModel: users[index],
                                    imgUrl: users[index].photoUrl,
                                    date: "",
                                  );
                                });
                          } else if (state is HomeLoading) {
                            return const LinearProgressIndicator();
                          } else {
                            return const Text("No Data...");
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
