part of 'send_message_cubit.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

class SendMessageInitial extends SendMessageState {}

class SendMessageLoading extends SendMessageState {}

class SendMessageLoaded extends SendMessageState {}

class SendMessageFailed extends SendMessageState {}
