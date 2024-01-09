class Member {
  int? id;
  String? email;
  String? username;
  dynamic avatar;
  bool? isOwner;

  Member({this.id, this.email, this.username, this.avatar, this.isOwner});

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json['id'] as int?,
        email: json['email'] as String?,
        username: json['username'] as String?,
        avatar: json['avatar'] as dynamic,
        isOwner: json['isOwner'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'username': username,
        'avatar': avatar,
        'isOwner': isOwner,
      };
}
