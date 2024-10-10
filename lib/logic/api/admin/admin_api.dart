import 'package:dio/dio.dart';
import 'package:pizza_striker/logic/api/admin/models/admin_device_token_model.dart';
import 'package:pizza_striker/logic/api/user/models/full_user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'admin_api.g.dart';

@RestApi()
abstract class AdminApi {
  factory AdminApi(Dio dio) = _AdminApi;

  @GET('/users/login')
  Future<FullUserModel> login(
    @Body() String phoneNumber,
    @Body() String hashedPassword,
  );

  @GET('/admin/login')
  Future<void> logout(
    @Body() AdminDeviceTokenModel userDeviceToken,
  );

  @GET('/users/leaderboard')
  Future<FullUserModel> getLeaderBoard(
    @Body() String phoneNumber,
    @Body() String hashedPassword,
  );
}
