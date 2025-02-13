import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:ija_chat/models/chat_user.dart';
import 'package:ija_chat/services/database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);

    await GetIt.instance
        .get<DatabaseService>()
        .updateUserLastActive(_auth.currentUser!.uid);
  }

  Future<void> register(String name, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      ChatUser user = ChatUser(
        uid: _auth.currentUser!.uid,
        name: name,
        email: email,
        imageUrl: 'imageUrl',
        lastActive: DateTime.now().toUtc(),
      );

      await GetIt.instance.get<DatabaseService>().createUser(user);
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case "invalid-email":
          throw Exception("Invalid Email");
        case "weak-password":
          throw Exception("Weak Password");
        case "email-already-in-use":
          throw Exception("User already exist");
        default:
          rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
