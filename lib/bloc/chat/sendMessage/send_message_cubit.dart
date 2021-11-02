import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/models/message_model.dart';
import '/services/firestore_service.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final FireStoreServices _store;

  SendMessageCubit(this._store) : super(SendMessageInitial());

  Future sendMessage(MessageModel message, String roomId) async {
    emit(SendMessageLoading());
    try {
      await _store.sendMessage(message, roomId);
      emit(SendMessageLoaded());
    } on Exception {
      emit(SendMessageFailed());
    }
  }
}
