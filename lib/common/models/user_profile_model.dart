class UserProfileModel {
  int? id;
  String? email;
  String? username;
  dynamic phone;
  dynamic avatar;
  String? createdAt;
  String? updatedAt;
  int? rank;

  UserProfileModel({
    this.id,
    this.email,
    this.username,
    this.phone,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.rank,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      phone: json['phone'] as dynamic,
      avatar: json['avatar'] as dynamic,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      rank: json['rank'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'username': username,
        'phone': phone,
        'avatar': avatar,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'rank': rank,
      };
}
