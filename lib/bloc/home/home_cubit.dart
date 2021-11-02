import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/services/firestore_service.dart';
import '/models/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FireStoreServices _storeServices = FireStoreServices();

  HomeCubit() : super(HomeInitial()){
    getUsers();
  }

  Future<List<UserModel>?> getUsers() async {
    emit(HomeLoading());
    try {
      final users = await _storeServices.allUsers();
      final usersList = users.docs.map((user) => UserModel.fromDocument(user)).toList();
      emit(GetUsersSuccessfully(usersList));
      return usersList;
    } on Exception {
      emit(const HomeFailure("..Oops"));
    }
  }
}
