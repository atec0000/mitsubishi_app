import 'package:mitsubishi_app/service/tcp_service.dart';

final TcpService _tcpService = TcpService();

List<int> toCheck(List<int> inCheck) {
  int checksum = 0;

  for (int i = 0; i < inCheck.length; i++) {
    checksum ^= inCheck[i];
  }

  inCheck.add(checksum);
  return inCheck;
} //解校驗碼

final Map<int, int> _temperatureTo = {
  16: 0x10,
  17: 0x11,
  18: 0x12,
  19: 0x13,
  20: 0x14,
  21: 0x15,
  22: 0x16,
  23: 0x17,
  24: 0x18,
  25: 0x19,
  26: 0x1a,
  27: 0x1b,
  28: 0x1c,
  29: 0x1d,
  30: 0x1e,
  31: 0x1f,
  32: 0x20,
};
List<int> get_temperature(int value) {
  List<int> command = [0x06, 0x01, 0x83, 0x00, 0x00];
  command[4] = _temperatureTo[value]!;
  return toCheck(command);
}

List<int> get_temperature2(int value) {
  List<int> command = [0x06, 0xa1, 0x83, 0x00, 0x00];
  command[4] = _temperatureTo[value]!;
  return toCheck(command);
} //TaiSEIA_01溫度 :16-32度

final Map<int, int> _windspeedto = {
  1: 0x00,
  2: 0x05,
  3: 0x07,
  4: 0x09,
  5: 0x11,
};
List<int> get_windspeed(int value) {
  List<int> command = [0x06, 0x01, 0x82, 0x00, 0x00];
  command[4] = _windspeedto[value]!;
  return toCheck(command);
}

List<int> get_windspeed2(int value) {
  List<int> command = [0x06, 0xa1, 0x82, 0x00, 0x00];
  command[4] = _windspeedto[value]!;
  return toCheck(command);
} //TaiSEIA_01風量 :1-6段

final Map<int, int> _winddirection_updownto = {
  1: 0x00,
  2: 0x01,
  3: 0x02,
  4: 0x03,
  5: 0x04,
  6: 0x05,
  7: 0x06,
  8: 0x07,
  9: 0x08,
  10: 0x09,
  11: 0x0a,
  12: 0x0b,
  13: 0x0c,
  14: 0x0d,
  15: 0x0e,
  16: 0x0f,
  17: 0x11,
};
List<int> get_winddirection_updown(int value) {
  List<int> command = [0x06, 0x01, 0x8f, 0x00, 0x00];
  command[4] = _winddirection_updownto[value]!;
  return toCheck(command);
}

List<int> get_winddirection_updown2(int value) {
  List<int> command = [0x06, 0xa1, 0x8f, 0x00, 0x00];
  command[4] = _winddirection_updownto[value]!;
  return toCheck(command);
} //TaiSEIA_01上下風向 :1-16段

final Map<int, int> _winddirection_leftrightto = {
  1: 0x00,
  2: 0x01,
  3: 0x02,
  4: 0x03,
  5: 0x04,
  6: 0x05,
  7: 0x06,
  8: 0x07,
  9: 0x08,
  10: 0x09,
  11: 0x0a,
  12: 0x0b,
  13: 0x0c,
  14: 0x0d,
  15: 0x0e,
  16: 0x0f,
  17: 0x11,
};
List<int> get_winddirection_leftright(int value) {
  List<int> command = [0x06, 0x01, 0x91, 0x00, 0x00];
  command[4] = _winddirection_leftrightto[value]!;
  return toCheck(command);
}

List<int> get_winddirection_leftright2(int value) {
  List<int> command = [0x06, 0xa1, 0x91, 0x00, 0x00];
  command[4] = _winddirection_leftrightto[value]!;
  return toCheck(command);
} //TaiSEIA_01左右風向 :1-16段

final Map<int, int> _TaiSEIAbyte4 = {
  1: 00,
  2: 02,
};

List<int> get_TaiSEIA_other(String key, int value, String status) {
  String keyeHex = '0x$key';
  String byte5Hex = '0x$status';
  List<int> command = [
    0x06,
    0x01,
    int.parse(keyeHex),
    0x00,
    int.parse(byte5Hex)
  ];
  command[3] = _TaiSEIAbyte4[value]!;
  return toCheck(command);
}

List<int> get_TaiSEIA_other2(String key, int value, String status) {
  String keyeHex = '0x$key';
  String byte5Hex = '0x$status';
  List<int> command = [
    0x06,
    0xa1,
    int.parse(keyeHex),
    0x00,
    int.parse(byte5Hex)
  ];
  command[3] = _TaiSEIAbyte4[value]!;
  return toCheck(command);
}

final Map<int, int> _tvnumber = {
  1: 0x01,
  2: 0x02,
  3: 0x03,
  4: 0x04,
  5: 0x05,
  6: 0x06,
  7: 0x07,
  8: 0x08,
  9: 0x09,
  0: 0x0a,
  100: 0x0b,
};
List<int> get_tvnumber(int value) {
  List<int> command = [0xff, 0x06, 0x20, 0x05, 0x00, 0x00];
  command[5] = _tvnumber[value]!;
  return toCheck(command);
} //tv_05號碼

List<int> get_tv2number(int value) {
  List<int> command = [0xff, 0x06, 0x20, 0xa5, 0x00, 0x00];
  command[5] = _tvnumber[value]!;
  return toCheck(command);
} //tv_a5號碼

final Map<String, int> _tvkey = {
  'power': 0x00,
  'back': 0x0c,
  'input': 0x0d,
  'quite': 0x0e,
  'choose_increase': 0x0f,
  'choose_decrease': 0x10,
  'volume_increase': 0x11,
  'volume_decrease': 0x12,
  'up': 0x13,
  'down': 0x14,
  'left': 0x15,
  'right': 0x16,
  'ok': 0x17,
  'menu': 0x18,
  'menu_back': 0x19,
  'set': 0x1a,
  'exit': 0x1b,
  'red': 0x1c,
  'green': 0x1d,
  'yellow': 0x1e,
  'blue': 0x1f,
  'play': 0x20,
  'pause': 0x21,
  'stop': 0x22,
  'rec': 0x23,
  'rew': 0x24,
  'f.f': 0x25,
  'last': 0x26,
  'next': 0x27,
  'sleep': 0x28,
  'pip': 0x29,
  'choose': 0x2a,
  'pip.av': 0x2b,
  'pip_ch+': 0x2c,
  'pip_ch-': 0x2d,
  'normal': 0x2e,
  'standard': 0x2f,
  'screen display': 0x30,
  'voice': 0x31,
  'collect': 0x32,
  'hdtv': 0x33,
  'widescreen': 0x34,
  '16:9': 0x35,
  'scan': 0x36,
  'love': 0x37,
  'game': 0x38,
  'static': 0x39,
  'sound': 0x3a,
  'home': 0x3b,
  'dtv': 0x3c,
  'record list': 0x3d,
  'guide': 0x3e,
  'info': 0x3f,
  '?': 0x40,
  'ppy': 0x41,
  'del': 0x42,
  'radio': 0x43,
  'search': 0x44,
  'cc': 0x45,
  'bilingual': 0x46,
  'catv': 0x47,
  'show': 0x48,
  'submenu': 0x49,
  'scenario': 0x4a,
  'widescreen2': 0x4b,
  'color difference': 0x4c,
  'surround': 0x4d,
  'pop menu': 0x4e,
  'big': 0x4f,
  'small': 0x50,
};
List<int> get_tvcommand(String functionName) {
  final int functionCode = _tvkey[functionName] ?? 0;
  final List<int> command = [0xff, 0x06, 0x20, 0x05, 0x00, functionCode];
  return toCheck(command);
} //tv_05 key

List<int> get_tv2command(String functionName) {
  final int functionCode = _tvkey[functionName] ?? 0;
  final List<int> command = [0xff, 0x06, 0x20, 0xa5, 0x00, functionCode];
  return toCheck(command);
} //tv_a5 key

final Map<String, int> _fankey = {
  'power': 0x00,
  'windDirection': 0x02,
  'windSpeed+': 0x03,
  'windSpeed-': 0x04,
  'temperature+': 0x06,
  'temperature-': 0x07,
  'auto': 0x08,
  'cold wind': 0x09,
  'wide wind': 0x0a,
  'Concentrated wind': 0x0b,
  'natural wind': 0x0c,
  'auto hum': 0x0e,
  'set': 0x0f,
  'time+': 0x11,
  'time-': 0x12,
  'timestart': 0x13,
  'timeclose': 0x14,
  'LED': 0x15,
  'Photocatalyst': 0x1a,
  'night light': 0x1b,
  'poweroff': 0x21,
};
List<int> get_fancommand(String functionName) {
  final int functionCode = _fankey[functionName] ?? 0;
  final List<int> command = [0xff, 0x06, 0x20, 0x0f, 0x00, functionCode];
  return toCheck(command);
}

List<int> get_fan2command(String functionName) {
  final int functionCode = _fankey[functionName] ?? 0;
  final List<int> command = [0xff, 0x06, 0x20, 0xaf, 0x00, functionCode];
  return toCheck(command);
}

final Map<String, int> _lightkey = {
  'daily': 0x00,
  'full light': 0x01,
  'dimming+': 0x02,
  'dimming-': 0x03,
  'night light': 0x04,
  'turn off': 0x05,
  'timer_30': 0x06,
  'timer_60': 0x07,
  'white+': 0x08,
  'warm+': 0x09,
  'white color': 0x0a,
  'warm color': 0x0b,
  'no glare': 0x1d,
  'study': 0x1e,
  'outside': 0x1f,
  'meal': 0x20,
  'appointment cancell': 0x2d,
};

List<int> get_lightcommand(String functionName) {
  final int functionCode = _lightkey[functionName] ?? 0;
  final List<int> command = [0xff, 0x06, 0x20, 0x11, 0x00, functionCode];
  return toCheck(command);
}

List<int> get_light2command(String functionName) {
  final int functionCode = _lightkey[functionName] ?? 0;
  final List<int> command = [0xff, 0x06, 0x20, 0xb1, 0x00, functionCode];
  return toCheck(command);
}

final Map<int, int> _lightDimming = {
  1: 0x11,
  2: 0x12,
  3: 0x13,
  4: 0x14,
  5: 0x15,
  6: 0x16,
  7: 0x17,
  8: 0x18,
  9: 0x19,
  10: 0x1a,
};
List<int> get_lightDimming(int value) {
  List<int> command = [0xff, 0x06, 0x20, 0x11, 0x00, 0x00];
  command[5] = _lightDimming[value]!;
  return toCheck(command);
}

List<int> get_light2Dimming(int value) {
  List<int> command = [0xff, 0x06, 0x20, 0xb1, 0x00, 0x00];
  command[5] = _lightDimming[value]!;
  return toCheck(command);
}

final Map<int, int> _lightColor = {
  1: 0x21,
  2: 0x22,
  3: 0x23,
  4: 0x24,
  5: 0x25,
  6: 0x26,
  7: 0x27,
  8: 0x28,
  9: 0x29,
  10: 0x2a,
};
List<int> get_lightColor(int value) {
  List<int> command = [0xff, 0x06, 0x20, 0x11, 0x00, 0x00];
  command[5] = _lightColor[value]!;
  return toCheck(command);
}

List<int> get_light2Color(int value) {
  List<int> command = [0xff, 0x06, 0x20, 0xb1, 0x00, 0x00];
  command[5] = _lightColor[value]!;
  return toCheck(command);
}

final Map<String, int> _cleanerkey = {
  'power': 0x00,
  'doking': 0x01,
  'UV': 0x02,
  'up': 0x03,
  'down': 0x04,
  'left': 0x05,
  'right': 0x06,
  'start': 0x07,
  'stop': 0x08,
  'spot': 0x09,
  'time': 0x0a,
  'vac': 0x0b,
  'mode': 0x0c,
  'auto': 0x0d,
  'cycle': 0x0e,
  'mute': 0x0f,
  'dark': 0x10,
  'speed': 0x11,
};
List<int> get_cleanercommand(String functionName) {
  final int functionCode = _cleanerkey[functionName] ?? 0;
  final List<int> command = [0xff, 0x06, 0x20, 0x0e, 0x00, functionCode];
  return toCheck(command);
}

List<int> get_cleaner2command(String functionName) {
  final int functionCode = _cleanerkey[functionName] ?? 0;
  final List<int> command = [0xff, 0x06, 0x20, 0xae, 0x00, functionCode];
  return toCheck(command);
}

const List<int> airinformation = [0xff, 0x06, 0x14, 0x01, 0x00, 0x00, 0xec];

List<int> idToCode(int device, int id) {
  int a = (id ~/ 100);
  int b = (id % 100);
  a = int.parse(a.toString(), radix: 16);
  b = int.parse(b.toString(), radix: 16);
  List<int> ret = [0xFF, 0x06, 0x15, device, a, b];
  return toCheck(ret);
}

const List<int> air_poweroff = [
  0xAA,
  0x00,
  0x07,
  0xB2,
  0x99,
  0xB6,
  0xFF,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0x0F,
  0x02,
  0x07,
  0xC2,
  0x00,
  0x11,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xA2
];

const List<int> air_poweron = [
  0xAA,
  0x00,
  0x07,
  0xB3,
  0x99,
  0xB6,
  0xFF,
  0x00,
  0x00,
  0x80,
  0x00,
  0x00,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0x0F,
  0x02,
  0x08,
  0x43,
  0x00,
  0x11,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xA5
];

const List<int> air_updown = [
  0xAA,
  0x00,
  0x07,
  0xE7,
  0x88,
  0xB2,
  0xFF,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0x0F,
  0x06,
  0x07,
  0xE2,
  0x00,
  0x10,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xF8
];
