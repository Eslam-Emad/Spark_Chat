import 'package:equatable/equatable.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object?> get props => [];
}

class MessagesTrigger extends MessagesEvent {
  final String roomID;

  const MessagesTrigger(this.roomID);

  @override
  List<Object?> get props => [roomID];
}
