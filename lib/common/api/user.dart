import 'package:mitsubishi_app/service/api_service.dart';

import '../index.dart';

/// 用户 api
class UserApi {
  /// 注册
  // static Future<bool> register(UserRegisterReq? req) async {
  //   var res = await WPHttpService.to.post(
  //     '/users/register',
  //     data: req,
  //   );

  //   if (res.statusCode == 201) {
  //     return true;
  //   }
  //   return false;
  // }

  /// 登录
  // static Future<UserTokenModel> login(UserLoginReq? req) async {
  //   var res = await WPHttpService.to.post(
  //     '/users/login',
  //     data: req,
  //   );
  //   return UserTokenModel.fromJson(res.data);
  // }

  /// overview
  static Future<Map<String, dynamic>> overveiw() async {
    var res = await ApiService().get(
      '/v1/overview',
    );
    final responseData = res.data as Map<String, dynamic>;
    return responseData;
  }

  /// Profile
  static Future<UserProfileModel> profile() async {
    var res = await ApiService().get(
      '/v1/profile',
    );
    return UserProfileModel.fromJson(res.data);
  }

  /// 大陆国家洲省列表
  // static Future<List<ContinentsModel>> continents() async {
  //   var res = await WPHttpService.to.get(
  //     '/users/continents',
  //   );

  //   List<ContinentsModel> continents = [];
  //   for (var item in res.data) {
  //     continents.add(ContinentsModel.fromJson(item));
  //   }
  //   return continents;
  // }

  /// 保存用户 first name 、 last name 、 email
  // static Future<UserProfileModel> saveBaseInfo(UserProfileModel req) async {
  //   var res = await WPHttpService.to.put(
  //     '/users/me',
  //     data: {
  //       "first_name": req.firstName,
  //       "last_name": req.lastName,
  //       "email": req.email,
  //     },
  //   );
  //   return UserProfileModel.fromJson(res.data);
  // }
}
