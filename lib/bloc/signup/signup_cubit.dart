import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/bloc/authentication/authentication_bloc.dart';
import '/bloc/authentication/authentication_event.dart';
import '/models/user_model.dart';
import '/services/fire_auth.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final FireAuthServices _authServices;
  final AuthenticationBloc _authenticationBloc;

  SignupCubit(this._authenticationBloc, this._authServices)
      : super(SignupInitial());

  Future<void> signUp(UserModel user, String password) async {
    emit(SignupLoading());
    try {
      final userCredential = await _authServices.signup(user, password);
      _authenticationBloc.add(AuthChanged(userCredential));
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailed(e.toString()));
      _authenticationBloc.add(const AuthChanged(null));

    }
  }
}
