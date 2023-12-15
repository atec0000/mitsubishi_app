import 'package:mitsubishi_app/model/device.dart';
import 'package:mitsubishi_app/service/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class ApiService {
  // final String _baseUrl = 'https://apitest.aifaremote.com';
  final String _baseUrl ='https://api.wificontrolbox.com';
  // final String _clientId = 'cfRwMJsPFWqTobZ5';
  final String _clientId = 'Ecp5TUQxtOjdQ24u';

  Dio _dio = Dio();
  final SecureStorageService _secureStorageService = SecureStorageService();

  ApiService() {
    _dio = Dio(BaseOptions(
        baseUrl: _baseUrl, connectTimeout: const Duration(seconds: 5)));
    _dio.interceptors
        .add(LogInterceptor(responseBody: true)); // For debugging purposes
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        // Add the access token to the headers
        final accessToken = await _secureStorageService
            .getAccessToken(); // Replace with your logic
        options.headers['Authorization'] = 'Bearer $accessToken';
        //print("accessToken:成功的$accessToken");
        return handler.next(options);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        if (e.response?.statusCode == 401) {
          final responseData = e.response?.data;
          if (responseData != null && responseData['name'] == 'JWT_EXPIRED') {
            // Token expired, trigger token refresh and retry the original request
            final newAccessToken = await _refreshTokenIfNeeded();
            e.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';
            //print("newAccessToken:刷新後$newAccessToken");
            return handler.resolve(await _dio.fetch(e.requestOptions));
          }
        }
        return handler.next(e);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // Do something with response data.
        // If you want to reject the request with a error message,
        // you can reject a `DioException` object using `handler.reject(dioError)`.
        return handler.next(response);
      },
    ));
  }

  Future<void>registration_check(String email) async{
    try {
      final respose = await _dio.post(
          '/v1/user/check',
          data: {
            'email': email,
          },
      );
      if (respose.statusCode == 400){
        print("email error，please input again");
      }
      else if(respose.statusCode == 404){
        print('OK');
      }
      else if(respose.statusCode == 409){
        print('email exits,please input new email');
      }
    }catch (error) {
      throw Exception('Failed to $error');
    }
  }

  Future<Response<dynamic>>registration(String email,String password,) async{
    try {
      final response = await _dio.post(
        '/v1/user/register',
        data: {
          "email": email,
          "password": password,
          "username": "Selina",
          "phone": "0966666666",
          "avatar": "",
        },
        options: Options(headers: null),
      );
      if (response.statusCode == 200){
        print("OK");
      }
      return response;
    }catch (error) {
      throw Exception('Failed to $error');
    }
  }

  Future<Response<dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        // '/oauth2/token',
      '/v1/user/auth',
        data: {
          'email': email,
          'password': password,
          'grant_type': 'password',
          'client_id': _clientId
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        _secureStorageService.saveAccessToken(responseData['access_token']);
        _secureStorageService.saveRefreshToken(responseData['refresh_token']);
        _secureStorageService.saveEmail(email);
        final accessToken = await _secureStorageService.getAccessToken();
        print("accessToken:登入後取出$accessToken");
      }

      return response;
    } catch (error) {
      throw Exception('Failed to login');
    }
  }

  bool isAccessTokenExpired(String accessToken) {
    if (accessToken == null) {
      return true; // If token is null, consider it expired
    }

    final decodedToken =
        JwtDecoder.decode(accessToken); // Assuming you're using JW

    final expirationTimestamp = decodedToken['exp'] as int;
    final currentTimestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000; // Convert to seconds

    return expirationTimestamp < currentTimestamp;
  }

  Future<String> _refreshTokenIfNeeded() async {
    final accessToken = await _secureStorageService.getAccessToken();
    // Simulate checking if token needs refreshing
    if (isAccessTokenExpired(accessToken)) {
      final refreshToken = await _secureStorageService
          .getRefreshToken(); // Replace with your logic

      try {
        final response = await _dio.post(
          // '/oauth2/token',
        '/v1/user/auth',
          data: {
            'refresh_token': refreshToken,
            'client_id': _clientId,
            'grant_type': 'refresh_token'
          },
        );

        if (response.statusCode == 200) {
          final responseData = response.data as Map<String, dynamic>;
          final newAccessToken = responseData['access_token'];
          final newRefreshToken = responseData['refresh_token'];

          // Update the access token for future requests
          _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';
          _secureStorageService.saveAccessToken(newAccessToken);
          _secureStorageService.saveRefreshToken(newRefreshToken);
          return newAccessToken;
        } else {
          throw Exception('Failed to refresh token');
        }
      } catch (error) {
        throw Exception('Failed to refresh token');
      }
    }
    return accessToken;
  }

  Future<void> addDevice(String inMac) async {
    final SecureStorageService _secureStorageService = SecureStorageService();
    final accessToken = await _secureStorageService.getAccessToken();
    if (accessToken != null) {
      final response = await _dio.post(
        '/devices',
        data: {
          'mac': inMac,
        },
        // options: Options(
        //   headers: {'Authorization':'Bearer $accessToken'}, // 手动添加头部
        // ),
      );
      if (response.statusCode == 201) {
        return response.data;
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to add device');
      }
    }
  }

  Future<List<Device>> getDevices() async {
    try {
      final response = await _dio.get('/devices');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        final List<dynamic> deviceList = data['devices'];
        final devices =
            deviceList.map((json) => Device.fromJson(json)).toList();
        return devices; //顯示模型裡面印射出來的列表
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to get devices');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get devices');
    }
  }

  Future<void> delDevice(int id) async {
    try {
      final response = await _dio.delete('/devices/$id');
      if (response.statusCode == 204) {
        print('Device deleted successfully');
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to del devices');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to del devices');
    }
  }

  Future<void> delsubDevice(int id) async {
    try {
      final response = await _dio.delete('/sub-devices/$id');
      if (response.statusCode == 200) {
        print('Device deleted successfully');
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to del sub-devices');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to del sub-devices');
    }
  }

  Future<void> addsubDevice(int subid) async {
    try {
      List<Device> devices = await getDevices();

      // 首先找到具有匹配 subid 的设备
      final targetDevice =
          devices.firstWhere((device) => device.subDeviceIds == subid);

      final postData = {
        'deviceId': subid,
        'name': targetDevice.subDevicesNames,
        'type': targetDevice.subDevicetype,
      };

      // 如果目标设备具有 subDevicesubtype，则将其添加到 postData 中
      if (targetDevice.subDevicesubtype.isNotEmpty) {
        postData['subType'] = targetDevice.subDevicesubtype;
      }

      final response = await _dio.post('/sub-devices', data: postData);

      if (response.statusCode == 201) {
        print('Subdevice added successfully');
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to add subdevice');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to add subdevice');
    }
  }

  // Future<void> addfunction(int id) async {
  //   final SecureStorageService _secureStorageService = SecureStorageService();
  //   final accessToken = await _secureStorageService.getAccessToken();
  //   if (accessToken != null) {
  //     final response = await _dio.post(
  //       '/functions',
  //       data: {
  //         'deviceId': id,
  //         'name':,
  //         'category':,
  //         'days':,
  //         'notification':,
  //         "active": true,
  //         "time": {
  //           "start": 650,
  //           "length": 60
  //         },
  //         "commands": [
  //         {
  //           "subDeviceId": 12,
  //           "command": "fff3f2f0",
  //         }
  //       ]
  //
  //
  //       },
  //     );
  //     if (response.statusCode == 201) {
  //       return response.data;
  //     } else {
  //       print('HTTP Status: ${response.statusCode}');
  //       throw Exception('Failed to add function');
  //     }
  //   }
  // }

}
