import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_user_event.dart';
part 'fetch_user_state.dart';

class FetchUserBloc extends Bloc<FetchUserEvent, FetchUserState> {
  FetchUserBloc() : super(FetchUserInitial()) {
    on<FetchUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
