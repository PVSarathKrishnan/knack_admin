part of 'fetch_user_bloc.dart';

class FetchUserState extends Equatable {
  const FetchUserState();

  @override
  List<Object> get props => [];
}

final class FetchUserInitial extends FetchUserState {}

class FetchUserLoadedState extends FetchUserState {
  final List<UserModel> userList;
  FetchUserLoadedState({required this.userList});
}
