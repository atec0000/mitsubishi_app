import 'dart:convert';

import 'package:mitsubishi_app/service/tcp_service.dart';

import '../model/ac_status_ca51.dart';
import '../model/temp_hum.dart';

final TcpService _tcpService = TcpService();

double _temp = 0;
double _hum = 0;
int _AirtemperatureValue = 16;
double _newAirtemperatureValue = 16.0;

double get temperature => _temp;
double get humidity => _hum;

int get AirtemperatureValue => _AirtemperatureValue;
double get newAirtemperatureValue => _newAirtemperatureValue;

AcStatusCa51 _acStatusCa51 = AcStatusCa51.off();
AcStatusCa51 get acstatus => _acStatusCa51;

set newAirtemperatureValue(double value) {
  _newAirtemperatureValue = value;
}

set AirtemperatureValue(int value) {
  _AirtemperatureValue = value;
}

class DataProcessing {
  void initCallback() {
    _tcpService.addResponseListener((response) {
      // AC Status response
      try {
        if (response.length == 21 &&
            response[0] == 0xfa &&
            response[1] == 0x14) {
          AcStatusCa51 newStatus = AcStatusCa51.fromBytes(response);
          final temperature = newStatus.temperature;
          _AirtemperatureValue = temperature;
          _newAirtemperatureValue = temperature.toDouble();

          if (_newAirtemperatureValue > 16.0) {
            _newAirtemperatureValue;
          }
        }
        // 数据是 JSON，可以進一步處理
      } catch (e) {
        // print("Error decoding JSON: $e");
      }
    });

    _tcpService.addResponseListener((response) {
      try {
        final jsonString = utf8.decode(response);
        final cleanedJsonString = jsonString.replaceFirst('SENSOR', '');
        final jsonResponse = json.decode(cleanedJsonString);
        final myResponse = MyJsonResponse.fromJson(jsonResponse);

        // json數據

        _temp = getRealTemperatureV3(myResponse.temp);
        _hum = getRealHumidityV3(myResponse.hum);

        //    completer.complete([_temp, _hum]); // 完成 Future 並傳遞结果
      } catch (e) {
        // 處理錯誤
      }
    });
  }
}
