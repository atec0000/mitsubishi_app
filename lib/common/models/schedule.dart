/// 排程
class ScheduleModel {
  int? id;
  bool isOn = true;
  String? name;
  String? mac;

  ScheduleModel({this.id, required this.isOn, this.name, this.mac});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json['id'] as int?,
        isOn: json['isOn'] as bool,
        name: json['name'] as String?,
        mac: json['slug'] as String?, 
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mac': mac,
      };
}
