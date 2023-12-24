/// 排程
class ScheduleModel {
  int? id;
  String? name;
  String? mac;

  ScheduleModel({this.id, this.name, this.mac});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        mac: json['slug'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mac': mac,
      };
}
