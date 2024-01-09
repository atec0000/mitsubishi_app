import 'member.dart';

class FamilyModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? devices;
  Member? owner;
  bool? isOwner;
  List<Member>? members;

  FamilyModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.devices,
    this.owner,
    this.isOwner,
    this.members,
  });

  factory FamilyModel.fromJson(Map<String, dynamic> json) => FamilyModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        devices: json['devices'] as List<dynamic>?,
        owner: json['owner'] == null
            ? null
            : Member.fromJson(json['owner'] as Map<String, dynamic>),
        isOwner: json['isOwner'] as bool?,
        members: (json['members'] as List<dynamic>?)
            ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'devices': devices,
        'owner': owner?.toJson(),
        'isOwner': isOwner,
        'members': members?.map((e) => e.toJson()).toList(),
      };
}
