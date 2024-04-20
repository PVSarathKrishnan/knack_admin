part of 'fetch_user_bloc.dart';

@immutable
sealed class FetchUserEvent {
  const FetchUserEvent();
}

class FetchUserLoadEvent extends FetchUserEvent {}
