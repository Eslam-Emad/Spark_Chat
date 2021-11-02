import 'dart:async';

import 'package:bloc/bloc.dart';

import '/services/fire_auth.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FireAuthServices _auth = FireAuthServices();

  AuthenticationBloc()
      : super(FireAuthServices().isAuthenticated
            ? Authenticated()
            : Unauthenticated()) {
    on<LoggedOut>(_onLoggedOut);
    on<AuthChanged>(_onAuthChanged);
    _auth.authState.listen((user) {
      add(AuthChanged(user));
    });
  }

  FutureOr<void> _onLoggedOut(LoggedOut event, Emitter<AuthenticationState> emit) {
    unawaited(_auth.signOut());
    emit(Unauthenticated());
    add(const AuthChanged(null));
  }

  FutureOr<void> _onAuthChanged(
      AuthChanged event, Emitter<AuthenticationState> emit) {
    emit(event.user != null ? Authenticated() : Unauthenticated());
  }
}
