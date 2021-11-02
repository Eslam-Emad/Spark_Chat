import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState([List props = const []]) : super();

  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object?> get props => [message];
}
