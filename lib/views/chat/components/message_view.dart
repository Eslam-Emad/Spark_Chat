import 'package:flutter/material.dart';

import '/constants/constants.dart';
import '/models/message_model.dart';
import '/services/fire_auth.dart';

class MessagesView extends StatelessWidget {
  final List<MessageModel> messages;

  const MessagesView({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageTile(message: messages[index]);
        });
  }
}

class MessageTile extends StatelessWidget {
  final MessageModel message;

  MessageTile({Key? key, required this.message}) : super(key: key);
  final FireAuthServices _authServices = FireAuthServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentUser = _authServices.currentUser;
    isMe() => currentUser!.uid == message.idFrom;

    return Column(
      crossAxisAlignment:
          isMe() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: size.width * 0.5),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color:
                isMe() ? Palette.kTheme : Palette.kIconLight.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                bottomRight: isMe()
                    ? const Radius.circular(25)
                    : const Radius.circular(0),
                topLeft: isMe()
                    ? const Radius.circular(25)
                    : const Radius.circular(0),
                bottomLeft: isMe()
                    ? const Radius.circular(0)
                    : const Radius.circular(25),
                topRight: isMe()
                    ? const Radius.circular(0)
                    : const Radius.circular(25)),
          ),
          child: Text(message.content),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            " ${DateTime.parse(message.timestamp).day} - ${DateTime.parse(message.timestamp).month} - ${DateTime.parse(message.timestamp).hour}",
            style: AppTheme().aclonicaTextStyle.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Palette.kIconLight,
                  fontSize: 11,
                ),
          ),
        ),
      ],
    );
  }
}
