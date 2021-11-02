import 'package:equatable/equatable.dart';
import '/models/message_model.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class MessagesInitial extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<MessageModel>? messages;

  const MessagesLoaded(this.messages);

  @override
  List<Object> get props => [messages!];
}

class MessagesLoading extends MessagesState {}

class MessagesFailure extends MessagesState {
  final String message;

  const MessagesFailure(this.message);

  @override
  List<Object> get props => [message];
}
