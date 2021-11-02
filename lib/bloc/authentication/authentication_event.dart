import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent([List props = const []]) : super();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class AuthChanged extends AuthenticationEvent {
  const AuthChanged(this.user);

  final dynamic user;

  @override
  List<Object> get props => [user != null];
}

class LoggedOut extends AuthenticationEvent {}
