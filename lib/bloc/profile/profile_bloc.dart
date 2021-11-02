import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/models/user_model.dart';
import '/services/fire_auth.dart';
import '/services/firestore_service.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<GetProfileEvent, ProfileState> {
  final FireStoreServices _store = FireStoreServices();
  final FireAuthServices _auth = FireAuthServices();

  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfileEvent);
    add(GetProfileEvent());
  }

  FutureOr<void> _onGetProfileEvent(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final currentUser = _auth.currentUser!.uid;
      final data = await _store.currentUser(currentUser);
      final user = UserModel.fromDocument(data);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileFailed());
    }
  }
}
