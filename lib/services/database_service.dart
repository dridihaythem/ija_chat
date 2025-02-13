import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ija_chat/models/chat_user.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<ChatUser> getUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await _db.collection('users').doc(uid).get();

    return ChatUser.fromJson(data.data()!);
  }

  Future<void> updateUserLastActive(String uid) async {
    await _db.collection('users').doc(uid).update({
      'last_active': DateTime.now().toUtc(),
    });
  }

  Future<void> createUser(ChatUser user) async {
    await _db.collection('users').doc(user.uid).set(user.toJson());
  }
}
