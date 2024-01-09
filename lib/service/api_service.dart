import 'package:mitsubishi_app/model/device.dart';
import 'package:mitsubishi_app/model/family.dart';
import 'package:mitsubishi_app/service/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiService {
  // 单例写法
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final String _baseUrl = 'https://api.wificontrolbox.com';
  final String _clientId = 'Ecp5TUQxtOjdQ24u';

  Dio _dio = Dio();
  final SecureStorageService _secureStorageService = SecureStorageService();

  ApiService._internal();

  void init() {
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
        print("accessToken:成功的$accessToken");
        return handler.next(options);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        if (e.response?.statusCode == 401) {
          final responseData = e.response?.data;
          if (responseData != null && responseData['name'] == 'JWT_EXPIRED') {
            // Token expired, trigger token refresh and retry the original request
            final newAccessToken = await refreshTokenIfNeeded();
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

  Future<Response> get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Response response = await _dio.get(
      url,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.post(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  Future<int?> checkUser(String email) async {
    //驗證信箱
    try {
      final response = await _dio.post(
        '/v1/users/check',
        data: {'email': email},
      );
      return response.statusCode;
    } on DioException catch (error) {
      if (error.response != null) {
        return error.response?.statusCode;
      } else {
        throw Exception('Failed to check');
      }
    }
  }

  Future<Response<dynamic>> register(
    //註冊
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        '/v1/users/register',
        data: {
          "email": email,
          "password": password,
          "username": "",
          "phone": "",
          "avatar": "",
        },
        options: Options(headers: null),
      );
      if (response.statusCode == 200) {
        print("OK");
      }
      return response;
    } catch (error) {
      throw Exception('Failed to $error');
    }
  }

  Future<Response<dynamic>> login(String email, String password) async {
    //登入
    try {
      final response = await _dio.post(
        '/v1/users/auth',
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
        _secureStorageService.savePassword(password);
        final accessToken = await _secureStorageService.getAccessToken();
        //print("accessToken:登入後取出$accessToken");
      }

      return response;
    } catch (error) {
      throw Exception('Failed to login');
    }
  }

  bool isAccessTokenExpired(String accessToken) {
    final decodedToken =
        JwtDecoder.decode(accessToken); // Assuming you're using JW

    final expirationTimestamp = decodedToken['exp'] as int;
    final currentTimestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000; // Convert to seconds

    return expirationTimestamp < currentTimestamp;
  }

  Future<String> refreshTokenIfNeeded() async {
    final accessToken = await _secureStorageService.getAccessToken();
    // Simulate checking if token needs refreshing
    if (isAccessTokenExpired(accessToken)) {
      final refreshToken = await _secureStorageService
          .getRefreshToken(); // Replace with your logic

      try {
        final response = await _dio.post(
          '/v1/users/auth',
          data: {
            'grant_type': 'refresh_token',
            'client_id': _clientId,
            'refresh_token': refreshToken,
          },
        );

        if (response.statusCode == 200) {
          final responseData = response.data as Map<String, dynamic>;
          final newAccessToken = responseData['access_token'];
          final newRefreshToken = responseData['refresh_token'];

          // Update the access token for future requests
          _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';
          print("成功更新");
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

  Future<String> no_time_refreshTokenIfNeeded() async {
    final accessToken = await _secureStorageService.getAccessToken();
    // Simulate checking if token needs refreshing

    final refreshToken = await _secureStorageService
        .getRefreshToken(); // Replace with your logic

    try {
      final response = await _dio.post(
        '/v1/users/auth',
        data: {
          'grant_type': 'refresh_token',
          'client_id': _clientId,
          'refresh_token': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final newAccessToken = responseData['access_token'];
        final newRefreshToken = responseData['refresh_token'];

        // Update the access token for future requests
        _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';
        print("成功更新");
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

  Future<void> creatfamily(String name) async {
    //創建家庭
    try {
      final response = await _dio.post(
        '/v1/families',
        data: {
          'name': name,
        },
      );
      if (response.statusCode == 200) {
        _secureStorageService.saveFamily(name);
      }
    } on DioException catch (error) {
      throw Exception('Failed to $error');
    }
  }

  Future<List<Home>> getfamily() async {
    try {
      final response = await _dio.get('/v1/families');
      if (response.statusCode == 200) {
        final List<dynamic> familyList = response.data;

        if (familyList.isNotEmpty) {
          final home = familyList.map((json) => Home.fromJson(json)).toList();
          return home;
        } else {
          print('No families available.');
          return []; // Return an empty list if no families are available
        }
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to get families');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get families');
    }
  }

  Future<void> updateFamily(String familyId, String name) async {
    try {
      final response = await _dio.put('/v1/families/$familyId', data: {
        {
          "name": name,
        }
      });

      if (response.statusCode == 200) {
        print('Family updated successfully');
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to update family');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to update family');
    }
  }

  Future<void> deleteFamily(String familyId) async {
    try {
      final response = await _dio.delete('/v1/families/$familyId');

      if (response.statusCode == 204) {
        print('Family deleted successfully');
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to delete family');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to delete family');
    }
  }

  Future<void> adduser(String familyId, String userId) async {
    try {
      final response = await _dio.post('/v1/families/$familyId/user/$userId');

      if (response.statusCode == 204) {
        print('Add User to Family OK');
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to delete family');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to delete family');
    }
  }

  Future<void> delusertofamily(String familyId, String userId) async {
    try {
      final response = await _dio.delete('/v1/families/$familyId/user/$userId');

      if (response.statusCode == 204) {
        print('del user from family OK');
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to delete user from fmaily');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to delete user from fmaily');
    }
  }

  Future<List<Device>> getDevices() async {
    try {
      final response = await _dio.get('/v1/devices');
      if (response.statusCode == 200) {
        final List<dynamic> deviceList = response.data;
        final devices =
            deviceList.map((json) => Device.fromJson(json)).toList();
        return devices;
      } else {
        print('HTTP Status: ${response.statusCode}');
        throw Exception('Failed to get devices');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get devices');
    }
  }

  Future<void> addDevice(int familyId, String mac) async {
    final SecureStorageService secureStorageService = SecureStorageService();
    final accessToken = await secureStorageService.getAccessToken();
    final response = await _dio.post('/v1/families/$familyId/mac/$mac');
    if (response.statusCode == 204) {
      return response.data;
    } else {
      print('HTTP Status: ${response.statusCode}');
      throw Exception('Failed to add device');
    }
  }

  Future<void> delDevice(int familyId, String mac) async {
    try {
      final response = await _dio.delete('/v1/families/$familyId/mac/$mac');
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
}
