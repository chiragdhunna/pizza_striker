import 'package:dio/dio.dart';
import 'package:pizza_striker/logic/api/admin/models/full_admin_model.dart';
import 'package:pizza_striker/logic/api/user/models/full_user_model.dart';
import 'package:pizza_striker/logic/api/user/models/login_user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'admin_api.g.dart';

@RestApi()
abstract class AdminApi {
  factory AdminApi(Dio dio) = _AdminApi;

  @GET('/users/login')
  Future<FullAdminModel> login(
    @Body() LoginUserModel loginUserModel,
  );

  @GET('/admin/logout')
  Future<void> logout();

  @GET('/users/leaderboard')
  Future<FullUserModel> getLeaderBoard(
    @Body() String phoneNumber,
    @Body() String hashedPassword,
  );
}
