import 'dart:async';

import 'package:bloc/bloc.dart';

import '/models/message_model.dart';
import '/services/firestore_service.dart';
import 'messages_event.dart';
import 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final FireStoreServices _storeServices = FireStoreServices();
  List<MessageModel> messages = [];

  MessagesBloc() : super(MessagesInitial()) {
    on<MessagesTrigger>(_onMessageTrigger);
  }

  FutureOr _onMessageTrigger(MessagesTrigger event, Emitter<MessagesState> emit) async {
    emit(MessagesLoading());
    final data = await _storeServices.getRoomMessages(event.roomID);

    messages = data.docs.map((event) => MessageModel.fromDocument(event))
        .toList()
        .reversed
        .toList();
    emit(MessagesLoaded(messages));
  }

}
