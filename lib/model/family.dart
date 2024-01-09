class Member {
  final int id;
  final String email;
  final String username;
  final String avatar;
  final bool isOwner;

  Member({
    required this.id,
    required this.email,
    required this.username,
    required this.avatar,
    required this.isOwner,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      avatar: json['avatar'],
      isOwner: json['isOwner'],
    );
  }
}

class Home {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final bool isOwner;
  final List<Member> members;

  Home({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.isOwner,
    required this.members,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    List<Member> membersList = [];
    if (json['members'] != null) {
      var membersJson = json['members'] as List;
      membersList =
          membersJson.map((member) => Member.fromJson(member)).toList();
    }

    return Home(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isOwner: json['isOwner'],
      members: membersList,
    );
  }
}
