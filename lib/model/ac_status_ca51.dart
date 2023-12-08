import 'dart:typed_data';

class AcStatusCa51 {
  final bool power;
  final AirConditionerMode mode;
  final int temperature;
  final AirConditionerSpeed windSpeed;
  final AirConditionerDirection windDirectionud;
  final AirConditionerDirection windDirectionlr;
  final int timer;
  final bool powerSaving;
  final bool sleep;

  AcStatusCa51({
    required this.power,
    required this.mode,
    required this.temperature,
    required this.windSpeed,
    required this.windDirectionud,
    required this.windDirectionlr,
    required this.timer,
    required this.powerSaving,
    required this.sleep,
  });

  factory AcStatusCa51.off({
    int timer = 0,
  }) {
    return AcStatusCa51(
      power: false,
      mode: AirConditionerMode.cool,
      temperature: 0,
      windSpeed: AirConditionerSpeed.auto,
      windDirectionud: AirConditionerDirection.off,
      windDirectionlr: AirConditionerDirection.off,
      timer: 0,
      powerSaving: false,
      sleep: false,
    );
  }

  factory AcStatusCa51.on({
    required int temperature,
    required AirConditionerMode mode,
    required AirConditionerSpeed windSpeed,
    required AirConditionerDirection windDirectionud,
    required AirConditionerDirection windDirectionlr,
    required int timer,
    required bool sleep,
    required bool turbo,
    required bool powerSaving,
  }) {
    return AcStatusCa51(
      power: true,
      mode: mode,
      temperature: temperature,
      windSpeed: windSpeed,
      windDirectionud: windDirectionud,
      windDirectionlr: windDirectionlr,
      timer: timer,
      powerSaving: powerSaving,
      sleep: sleep,
    );
  }

  factory AcStatusCa51.fromBytes(Uint8List bytes) {
    assert(bytes.length == 21);

    if (bytes.elementAt(4) == 0 && bytes.elementAt(6) == 0) {
      return AcStatusCa51.off(
        timer: int.parse(bytes.elementAt(4).toRadixString(16)),
      );
    }

    return AcStatusCa51.on(
      temperature: int.parse(bytes.elementAt(3).toRadixString(16)),
      mode: _modeFromByte(bytes.elementAt(5)),
      windDirectionud: _directionFromByte(bytes.elementAt(7)),
      windDirectionlr: _directionFromByte2(bytes.elementAt(8)),
      windSpeed: _speedFromByte(bytes.elementAt(6)),
      sleep: _testBit(bytes.elementAt(9), 4),
      turbo: _testBit(bytes.elementAt(11), 7),
      powerSaving: _testBit(bytes.elementAt(11), 3),
      timer: int.parse(bytes.elementAt(4).toRadixString(16)),
    );
  }

  factory AcStatusCa51.fromSingleByteResponse(AcStatusCa51 oldStatus, Uint8List bytes) {
    assert(bytes.length == 4);

    if (bytes.elementAt(2) == 0xa2) {
      return AcStatusCa51.off(
        timer: oldStatus.timer,
      );
    }
    return AcStatusCa51.on(
      temperature: oldStatus.temperature,
      mode: oldStatus.mode,
      windDirectionud: oldStatus.windDirectionud,
      windDirectionlr: oldStatus.windDirectionlr,
      windSpeed: oldStatus.windSpeed,
      sleep: oldStatus.sleep,
      turbo: false,
      powerSaving: oldStatus.powerSaving,
      timer: oldStatus.timer,
    );
  }

  factory AcStatusCa51.fromCommandBytes(Uint8List bytes) {
    assert(bytes.length == 15);

    return AcStatusCa51.fromBytes(
      Uint8List.fromList(
        [
          ...bytes.sublist(0, 2),
          ...bytes.sublist(3),
        ],
      ),
    );
  }

  factory AcStatusCa51.fromStringBytes(String bytes) {
    assert(bytes.length == 30);

    return AcStatusCa51.fromCommandBytes(
      Uint8List.fromList(
        List.generate(
          bytes.length ~/ 2,
              (index) {
            final byteString = bytes.substring(index * 2, index * 2 + 2);
            return int.parse(byteString, radix: 16);
          },
        ),
      ),
    );
  }
}

int _getModeByte(AirConditionerMode mode) {
  switch (mode) {
    case AirConditionerMode.auto:
      return 0x10;

    case AirConditionerMode.cool:
      return 0x20;

    case AirConditionerMode.dry:
      return 0x40;

    case AirConditionerMode.fan:
      return 0x80;

    case AirConditionerMode.heat:
      return 0x08;

    default:
      return 0;
  }
}

int _getSpeedByte(int speed) {
  switch (speed) {
    case AirConditionerSpeed.auto:
      return 0x01;

    case AirConditionerSpeed.quiet1:
      return 0x02;

    case AirConditionerSpeed.quiet2:
      return 0x03;

    case AirConditionerSpeed.slight1:
      return 0x04;

    case AirConditionerSpeed.slight2:
      return 0x05;

    case AirConditionerSpeed.weak1:
      return 0x06;

    case AirConditionerSpeed.weak2:
      return 0x07;

    case AirConditionerSpeed.middle1:
      return 0x08;

    case AirConditionerSpeed.middle2:
      return 0x09;

    case AirConditionerSpeed.strong1:
      return 0x0a;

    case AirConditionerSpeed.strong2:
      return 0x0b;

    default:
      return 0;
  }
}

int _getDirectionByte(AirConditionerDirection direction) {
  switch (direction) {
    case AirConditionerDirection.auto:
      return 0x81;

    case AirConditionerDirection.T1:
      return 0x86;

    case AirConditionerDirection.T2:
      return 0x8a;

    case AirConditionerDirection.T3:
      return 0x92;

    case AirConditionerDirection.T4:
      return 0xa2;

    case AirConditionerDirection.T5:
      return 0xc2;

    case AirConditionerDirection.T123:
      return 0x9e;

    case AirConditionerDirection.T234:
      return 0xba;

    case AirConditionerDirection.T345:
      return 0xf2;

    case AirConditionerDirection.T1_5:
      return 0xfe;

    case AirConditionerDirection.T15:
      return 0xc6;

    case AirConditionerDirection.T45:
      return 0xe2;

    case AirConditionerDirection.T34:
      return 0xb2;

    case AirConditionerDirection.T125:
      return 0xce;

    case AirConditionerDirection.T12:
      return 0x8e;

    case AirConditionerDirection.T14:
      return 0xa6;

    case AirConditionerDirection.T25:
      return 0xca;

    case AirConditionerDirection.T1234:
      return 0xbe;

    case AirConditionerDirection.T2345:
      return 0xfa;

    case AirConditionerDirection.T135:
      return 0xd6;

    case AirConditionerDirection.off:
    default:
      return 0;
  }
}


enum AirConditionerMode {
  auto,
  cool,
  dry,
  fan,
  heat,
}
enum AirConditionerSpeed {
  auto,
  quiet1,
  quiet2,
  slight1,
  slight2,
  weak1,
  weak2,
  middle1,
  middle2,
  strong1,
  strong2,
}
enum AirConditionerDirection {
  off,
  auto,
  T5,
  T4,
  T3,
  T2,
  T1,
  T123,
  T234,
  T345,
  T1_5,
  T15,
  T34,
  T45,
  T125,
  T12,
  T14,
  T25,
  T1234,
  T2345,
  T135,
}
// enum AirConditionerDirection {
//   off,
//   auto,
//   one,
//   two,
//   three,
//   four,
//   five,
// }

bool _testBit(int byte, int position) {
  return (byte & (1 << position)) > 0;
}

AirConditionerMode _modeFromByte(int byte) {
  if (_testBit(byte, 3)) return AirConditionerMode.heat;
  if (_testBit(byte, 4)) return AirConditionerMode.auto;
  if (_testBit(byte, 5)) return AirConditionerMode.cool;
  if (_testBit(byte, 6)) return AirConditionerMode.dry;
  if (_testBit(byte, 7)) return AirConditionerMode.fan;
  return AirConditionerMode.auto;
}

// int _speedFromByte(int byte) {
//   if (_testBit(byte, 0)) return 0;
//   if (_testBit(byte, 5)) return 1;
//   if (_testBit(byte, 6)) return 2;
//   if (_testBit(byte, 7)) return 3;
//   return 0;
// }
Map<int, AirConditionerSpeed> speedByteMap = {
  0x02: AirConditionerSpeed.quiet1,
  0x03: AirConditionerSpeed.quiet2,
  0x04: AirConditionerSpeed.slight1,
  0x05: AirConditionerSpeed.slight2,
  0x06: AirConditionerSpeed.weak1,
  0x07: AirConditionerSpeed.weak2,
  0x08: AirConditionerSpeed.middle1,
  0x09: AirConditionerSpeed.middle2,
  0x0a: AirConditionerSpeed.strong1,
  0x0b: AirConditionerSpeed.strong2,
};

AirConditionerSpeed _speedFromByte(int byte) {
  if (speedByteMap.containsKey(byte)) {
    return speedByteMap[byte]!;
  } else {
    return AirConditionerSpeed.auto;
  }
}


Map<int, AirConditionerDirection> directionByteMap = {
  0x81: AirConditionerDirection.auto,
  0x86: AirConditionerDirection.T1,
  0x8a: AirConditionerDirection.T2,
  0x92: AirConditionerDirection.T3,
  0xa2: AirConditionerDirection.T4,
  0xc2: AirConditionerDirection.T5,
  0x9e: AirConditionerDirection.T123,
  0xba: AirConditionerDirection.T234,
  0xf2: AirConditionerDirection.T345,
  0xfe: AirConditionerDirection.T1_5,
  0xc6: AirConditionerDirection.T15,
  0xe2: AirConditionerDirection.T45,
  0xb2:AirConditionerDirection.T34,
  0xce:AirConditionerDirection.T125,
  0x8e:AirConditionerDirection.T12,
  0xa6:AirConditionerDirection.T14,
  0xca:AirConditionerDirection.T25,
  0xbe:AirConditionerDirection.T1234,
  0xfa:AirConditionerDirection.T2345,
  0xd6:AirConditionerDirection.T135,
  0x00:AirConditionerDirection.off,

};

AirConditionerDirection _directionFromByte(int byte) {
  if (directionByteMap.containsKey(byte)) {
    return directionByteMap[byte]!;
  } else {
    return AirConditionerDirection.off;
  }
}

AirConditionerDirection _directionFromByte2(int byte) {
  if (directionByteMap.containsKey(byte)) {
    return directionByteMap[byte]!;
  } else {
    return AirConditionerDirection.off;
  }
}


double getRealTemperatureV3(int temp) {
  double tempD = temp.toDouble();
  double realTemp = -45 + 175 * (tempD / 65536);

  //realTemp = -0.00322 * realTemp * realTemp + 1.05 * realTemp + 0.235;

  double truncated = (realTemp * 10).roundToDouble() / 10;


  return truncated;
}

double getRealHumidityV3(int humid) {
  double humidD = humid.toDouble();
  double realHumid = 125 * (humidD / 65535) -6 ;

  double truncated = (realHumid * 10).roundToDouble() / 10;


  return truncated;
}
