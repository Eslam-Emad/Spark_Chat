part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class GetUsersSuccessfully extends HomeState {
    final List<UserModel> users;

    const GetUsersSuccessfully(this.users);

    @override
    List<Object> get props => [users];
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object> get props => [message];
}
