import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:ija_chat/models/chat_user.dart';
import 'package:ija_chat/services/auth_service.dart';
import 'package:ija_chat/services/database_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  ChatUser? user;

  AuthCubit() : super(AuthInitial()) {
    FirebaseAuth.instance.authStateChanges().listen((u) {
      if (u != null) {
        GetIt.I.get<DatabaseService>().getUser(u.uid).then((value) {
          user = value;
        });
      }
    });
  }

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
