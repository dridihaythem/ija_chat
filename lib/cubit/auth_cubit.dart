import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ija_chat/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoginLoading());
    try {
      await GetIt.I.get<AuthService>().login(email, password);
      emit(AuthLoginSuccess());
    } catch (e) {
      emit(AuthLoginError("Failed to login"));
    }
  }
}
