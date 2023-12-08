class Device {
  final String name;
  final String mac;
  final int deviceid;
  late final List<String> subDevicesNames;
  final List<int> subDevicetype;
  final Map<String, int> subDeviceIds; // Map to store subDeviceName -> subDeviceid
  final List<int> subDevicesubtype;
  final double? temperature;
  final double? humidity;

  Device({
    required this.name,
    required this.mac,
    required this.deviceid,
    required this.subDevicesNames,
    required this.subDevicetype,
    required this.subDeviceIds,
    required this.subDevicesubtype,
    required this.temperature,
    required this.humidity,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    final subDevices =
    json['subDevices'] as List<dynamic>?; // Extract subDevices as a list
    final subDevicesNames = <String>[]; // Initialize an empty list of strings
    final subDeviceIds = <String, int>{}; // Initialize an empty map

    final subDevicetype = <int>[];
    final subDevicesubtype = <int>[];
    int subDeviceid = 0;

    if (subDevices != null) {
      for (final subDevice in subDevices) {
        if (subDevice is Map<String, dynamic> &&
            subDevice.containsKey('name') &&
            subDevice.containsKey('type')) {
          String subDeviceName = subDevice['name'] as String;
          subDevicesNames.add(subDeviceName); // Add the name as a string
          subDeviceIds[subDeviceName] = subDevice['id'] as int; // Map subDeviceName to subDeviceid
          subDevicetype.add(subDevice['type']);
          subDeviceid = subDevice['id'] as int;
        }
        if (subDevice is Map<String, dynamic> &&
            subDevice.containsKey('subType')) {
          subDevicesubtype.add(subDevice['subType']);
        }
      }
    }

    return Device(
      name: json['name'],
      mac: json['mac'],
      deviceid: json['id'],
      subDevicesNames: subDevicesNames,
      subDevicetype: subDevicetype,
      subDeviceIds: subDeviceIds,
      subDevicesubtype: subDevicesubtype,
      temperature: (json['sensors']['temperature'] is int)
          ? (json['sensors']['temperature'] as int).toDouble()
          : json['sensors']['temperature'],
      humidity: (json['sensors']['humidity'] is int)
          ? (json['sensors']['humidity'] as int).toDouble()
          : json['sensors']['humidity'],
    );
  }
}