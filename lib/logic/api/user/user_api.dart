import 'package:dio/dio.dart';
import 'package:pizza_striker/logic/api/devices/models/user_device_token_model.dart';
import 'package:pizza_striker/logic/api/user/models/full_user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  @GET('/users/login')
  Future<FullUserModel> login(
    @Body() String phoneNumber,
    @Body() String hashedPassword,
  );

  @GET('/users/login')
  Future<void> logout(
    @Body() UserDeviceTokenModel userDeviceToken,
  );

  @GET('/users/leaderboard')
  Future<FullUserModel> getLeaderBoard(
    @Body() String phoneNumber,
    @Body() String hashedPassword,
  );
}
