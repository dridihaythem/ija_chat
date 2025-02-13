class ChatUser {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  final DateTime lastActive;

  const ChatUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.lastActive,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      lastActive: DateTime.parse(json['last_active']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'last_active': lastActive.toIso8601String(),
    };
  }

  String lastActiveDate() {
    return '${lastActive.day}/${lastActive.month}/${lastActive.year}';
  }

  bool recentlyActive() {
    final now = DateTime.now();
    final difference = now.difference(lastActive).inMinutes;
    return difference < 5;
  }
}
