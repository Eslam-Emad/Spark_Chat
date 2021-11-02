import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/chat/sendMessage/send_message_cubit.dart';
import '/bloc/messages/messages_bloc.dart';
import '/bloc/messages/messages_event.dart';
import '/bloc/messages/messages_state.dart';
import '/constants/constants.dart';
import '/models/message_model.dart';
import '/models/user_model.dart';
import '/services/fire_auth.dart';
import '/services/firestore_service.dart';
import '/utils/utils.dart';
import '/views/chat/components/chat_appbar.dart';
import '/views/widgets/custom_text_field.dart';
import 'components/message_view.dart';

class ChatScreen extends StatefulWidget {
  final UserModel userModel;

  const ChatScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FireAuthServices _auth = FireAuthServices();
  final FireStoreServices _storeServices = FireStoreServices();

  final TextEditingController? _messageController = TextEditingController();

  String? value = "";

  late final String senderId;
  late final String roomId;

  @override
  void initState() {
    super.initState();
    senderId = _auth.currentUser!.uid;
    roomId = FireHelper.generateRoomId(senderId, widget.userModel.id.toString());

    BlocProvider.of<MessagesBloc>(context).add(MessagesTrigger(roomId));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Palette.kBubbleLight,
      appBar: PreferredSize(
          child: ChatAppBar(
            title: widget.userModel.username,
            status: "Online",
            imgUrl: widget.userModel.photoUrl,
          ),
          preferredSize: const Size(double.infinity, 80)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<MessagesBloc, MessagesState>(
            builder: (context, state) {
              if (state is MessagesLoaded) {
                return Expanded(
                    child: MessagesView(messages: state.messages!));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Row(
            children: [
              CustomTextField(
                  width: size.width * 0.8,
                  controller: _messageController,
                  hint: "type something",
                  onChange: (v) => setState(() => value = v)),
              IconButton(
                  onPressed: value!.trim() == "" ? null : sendMessage,
                  icon: const Icon(Icons.send, color: Palette.kTheme))
            ],
          ),
        ],
      ),
    );
  }

  sendMessage() async {
    final message = MessageModel(
      idFrom: senderId,
      type: MessageType.text,
      idTo: widget.userModel.id!,
      content: _messageController!.text,
      timestamp: DateTime.now().toString(),
    );
    context.read<SendMessageCubit>().sendMessage(message, roomId);
    context.read<MessagesBloc>().add(MessagesTrigger(roomId));

    _messageController!.clear();
    Helper.closeKeyboard(context);
  }
}
