class Family {
  final int id;
  final String name;
  final User owner;
  final String createdAt;
  final String updatedAt;

  Family({
    required this.id,
    required this.name,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(
      id: json['id'],
      name: json['name'],
      owner: User.fromJson(json['owner']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class User {
  final int id;
  final String email;
  final String username;
  final String phone;
  final String avatar;
  final String createdAt;
  final String updatedAt;
  final int rank;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.phone,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
    required this.rank,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      avatar: json['avatar'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      rank: json['rank'],
    );
  }
}

class Device {
  final int id;
  final String mac;
  final String name;
  final String firmware;
  final Family family;

  Device({
    required this.id,
    required this.mac,
    required this.name,
    required this.firmware,
    required this.family,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      mac: json['mac'],
      name: json['name'],
      firmware: json['firmware'],
      family: Family.fromJson(json['family']), // Nested Family object
    );
  }
}
