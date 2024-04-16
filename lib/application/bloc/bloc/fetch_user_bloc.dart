import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:knack_admin/Domain/infrastructure/user_repository.dart';
import 'package:knack_admin/Domain/model/user_model.dart';
import 'package:meta/meta.dart';

part 'fetch_user_event.dart';
part 'fetch_user_state.dart';

class FetchUserBloc extends Bloc<FetchUserEvent, FetchUserState> {
  UserRepo userRepo = UserRepo();
  FetchUserBloc(this.userRepo) : super(FetchUserInitial()) {
    on<FetchUserLoadEvent>(getUsersfunction);
  }
  FutureOr<void> getUsersfunction(
      FetchUserLoadEvent event, Emitter<FetchUserState> emit) async {
    emit(FetchUserInitial());
    final users = await userRepo.getUsers();
    if (users.isEmpty) {
      emit(FetchUserInitial());
    }
    emit(FetchUserLoadedState(userList: users));
  }
}
