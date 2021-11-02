import 'package:flutter/material.dart';

import '/constants/constants.dart';

class ChatAppBar extends StatelessWidget {
  final String title;
  final String status;
  final String imgUrl;

  const ChatAppBar({
    Key? key,
    required this.title,
    required this.status,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      elevation: 2.0,
      title: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: Palette.kIconLight,
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(image: NetworkImage(imgUrl) ,  fit: BoxFit.cover)
            ),
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: AppTheme()
                      .aclonicaTextStyle
                      .copyWith(color: Colors.black, fontSize: 18)),
              Text(
                status,
                style: AppTheme().aclonicaTextStyle.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      color: Palette.kIconLight,
                    ),
              ),
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_outlined, color: Palette.kIconLight),
        ),
      ],
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_outlined,
            color: Palette.kIconLight),
      ),
    );
  }
}
