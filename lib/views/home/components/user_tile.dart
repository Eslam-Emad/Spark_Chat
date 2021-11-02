import 'package:flutter/material.dart';

import '/constants/constants.dart';
import '/models/user_model.dart';
import '/views/chat/chat_screen.dart';

class UserTile extends StatelessWidget {
  final UserModel userModel;
  final String imgUrl;
  final String date;

  const UserTile({
    Key? key,
    required this.imgUrl,
    required this.date,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatScreen(userModel: userModel))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: double.infinity,
        height: size.height * 0.1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                  color: Palette.kIconLight,
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(image: NetworkImage(imgUrl) ,  fit: BoxFit.cover)
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                margin:  const EdgeInsets.all(5),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userModel.username,
                      style: AppTheme().aclonicaTextStyle.copyWith(fontSize: 15),
                    ),
                    Text(
                      "last message...",
                      style: AppTheme()
                          .aclonicaTextStyle
                          .copyWith(fontSize: 13, color: Palette.kIconLight),
                    )
                  ],
                ),
              ),
            ),
            Text(
              "May 21",
              style: AppTheme().aclonicaTextStyle.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.normal,
                color: Palette.kIconLight,
              ),
            )
          ],
        ),
      ),
    );
  }
}
