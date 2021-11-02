import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/authentication/authentication_bloc.dart';
import '/bloc/authentication/authentication_event.dart';
import '/services/fire_auth.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final FireAuthServices _authServices;

  LoginBloc(this._authenticationBloc, this._authServices)
      : super(LoginInitial()) {
    on<LoginIn>(_onLogIn);
  }

  FutureOr<void> _onLogIn(LoginIn event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final user = await _authServices.login(event.email, event.password);
      if (user != null) {
        _authenticationBloc.add(AuthChanged(user));
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: '..Oops'));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
