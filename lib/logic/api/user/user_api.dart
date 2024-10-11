import 'package:dio/dio.dart';
import 'package:pizza_striker/logic/api/user/models/full_user_model.dart';
import 'package:pizza_striker/logic/api/user/models/login_user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  @POST('/users/login')
  Future<FullUserModel> login(
    @Body() LoginUserModel loginUserModel,
  );

  @GET('/users/logout')
  Future<void> logout();

  @GET('/users/leaderboard')
  Future<FullUserModel> getLeaderBoard(
    @Body() String phoneNumber,
    @Body() String hashedPassword,
  );

  @GET('/users/leaderboard')
  Future<FullUserModel> getMe();
}
