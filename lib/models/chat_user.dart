class ChatUser {
  ChatUser({
    required this.id,
    required this.image,
    required this.lastActive,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.isOnline,
    required this.email,
    required this.pushToken,
  });
  late final String id;
  late final String image;
  late final String lastActive;
  late final String about;
  late final String name;
  late final String createdAt;
  late final bool isOnline;
  late final String email;
  late final String pushToken;
  
  ChatUser.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? '';
    image = json['image'] ?? '';
    lastActive = json['last_active'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    isOnline = json['is_online'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['last_active'] = lastActive;
    _data['about'] = about;
    _data['name'] = name;
    _data['created_at'] = createdAt;
    _data['is_online'] = isOnline;
    _data['email'] = email;
    _data['push_token'] = pushToken;
    return _data;
  }
}
