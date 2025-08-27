import 'package:clean_arch_app/features/users/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  
  // ============ AUTH ============
  @POST('/api/login')
  Future<AuthResponse> login(@Body() LoginRequest request);
  
  @POST('/api/logout')
  Future<void> logout();
  
  @GET('/api/me')
  Future<UserModel> getCurrentUser();
  
  /* // ============ DASHBOARD ============
  @GET('/api/admin/dashboard/stats')
  Future<DashboardStats> getDashboardStats();
  
  @GET('/api/admin/dashboard/user-activity')
  Future<List<ActivityData>> getUserActivity(
    @Query('period') String period, // week, month, year
  );
  
  @GET('/api/admin/dashboard/top-shops')
  Future<List<ShopStats>> getTopShops();
  
  @GET('/api/admin/dashboard/recent-operations')
  Future<List<OperationModel>> getRecentOperations(
    @Query('limit') int limit,
  ); */
  
  // ============ USERS ============
  @GET('/api/admin/users')
  Future<PaginatedResponse<UserModel>> getUsers(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('search') String? search,
    @Query('status') String? status,
    @Query('role') String? role,
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
  );
  
  @GET('/api/admin/users/{id}')
  Future<UserModel> getUserById(@Path('id') int id);
  
  @POST('/api/admin/users')
  Future<UserModel> createUser(@Body() CreateUserRequest request);
  
  @PUT('/api/admin/users/{id}')
  Future<UserModel> updateUser(
    @Path('id') int id,
    @Body() UpdateUserRequest request,
  );
  
  @DELETE('/api/admin/users/{id}')
  Future<void> deleteUser(@Path('id') int id);
  
  @POST('/api/admin/users/{id}/block')
  Future<UserModel> blockUser(@Path('id') int id);
  
  @POST('/api/admin/users/{id}/unblock')
  Future<UserModel> unblockUser(@Path('id') int id);
  
  @POST('/api/admin/users/{id}/bonuses')
  Future<void> setBonuses(
    @Path('id') int id,
    @Body() SetBonusesRequest request,
  );
  
  @GET('/api/admin/users/export')
  Future<String> exportUsers(
    @Query('format') String format, // csv, xlsx
  );
  
 /* // ============ CHECKS ============
  @GET('/api/admin/checks')
  Future<PaginatedResponse<CheckModel>> getChecks(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('search') String? search,
    @Query('status') String? status,
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('user_id') int? userId,
    @Query('shop_id') int? shopId,
  );
  
  @GET('/api/admin/checks/{id}')
  Future<CheckModel> getCheckById(@Path('id') int id);
  
  @POST('/api/admin/checks')
  Future<CheckModel> createCheck(@Body() CreateCheckRequest request);
  
  @PUT('/api/admin/checks/{id}')
  Future<CheckModel> updateCheck(
    @Path('id') int id,
    @Body() UpdateCheckRequest request,
  );
  
  @POST('/api/admin/checks/{id}/approve')
  Future<CheckModel> approveCheck(@Path('id') int id);
  
  @POST('/api/admin/checks/{id}/reject')
  Future<CheckModel> rejectCheck(
    @Path('id') int id,
    @Body() RejectCheckRequest request,
  );
  
  @DELETE('/api/admin/checks/{id}')
  Future<void> deleteCheck(@Path('id') int id); 
  
  // ============ BONUSES ============
  @GET('/api/admin/bonuses')
  Future<PaginatedResponse<BonusModel>> getBonuses(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('search') String? search,
    @Query('is_active') bool? isActive,
    @Query('category_id') int? categoryId,
  );
  
  @GET('/api/admin/bonuses/{id}')
  Future<BonusModel> getBonusById(@Path('id') int id);
  
  @POST('/api/admin/bonuses')
  Future<BonusModel> createBonus(@Body() CreateBonusRequest request);
  
  @PUT('/api/admin/bonuses/{id}')
  Future<BonusModel> updateBonus(
    @Path('id') int id,
    @Body() UpdateBonusRequest request,
  );
  
  @DELETE('/api/admin/bonuses/{id}')
  Future<void> deleteBonus(@Path('id') int id);
  
  @POST('/api/admin/bonuses/set-order')
  Future<void> setBonusOrder(@Body() List<int> bonusIds);
  
  @POST('/api/admin/bonuses/charge')
  Future<void> chargeBonuses(@Body() ChargeBonusesRequest request); 
  
  // ============ OPERATIONS ============
  @GET('/api/admin/operations')
  Future<PaginatedResponse<OperationModel>> getOperations(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('type') String? type,
    @Query('status') String? status,
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('user_id') int? userId,
  );
  
  @GET('/api/admin/operations/{id}')
  Future<OperationModel> getOperationById(@Path('id') int id);
  
  @POST('/api/admin/operations/{id}/recreate')
  Future<OperationModel> recreateOperation(@Path('id') int id);
  
  @DELETE('/api/admin/operations')
  Future<void> deleteOperations(@Body() List<int> operationIds); 
  
  // ============ SHOPS ============
  @GET('/api/admin/shops')
  Future<PaginatedResponse<ShopModel>> getShops(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('search') String? search,
    @Query('category_id') int? categoryId,
  );
  
  @GET('/api/admin/shops/{id}')
  Future<ShopModel> getShopById(@Path('id') int id);
  
  @POST('/api/admin/shops')
  Future<ShopModel> createShop(@Body() CreateShopRequest request);
  
  @PUT('/api/admin/shops/{id}')
  Future<ShopModel> updateShop(
    @Path('id') int id,
    @Body() UpdateShopRequest request,
  );
  
  @DELETE('/api/admin/shops/{id}')
  Future<void> deleteShop(@Path('id') int id);
  
  @POST('/api/admin/shops/import')
  @Multipart()
  Future<void> importShops(@Part() File file); 
  
  // ============ PUSH NOTIFICATIONS ============
  @GET('/api/admin/push-notifications')
  Future<PaginatedResponse<PushNotificationModel>> getPushNotifications(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('is_personal') bool? isPersonal,
  );
  
  @GET('/api/admin/push-notifications/{id}')
  Future<PushNotificationModel> getPushNotificationById(@Path('id') int id);
  
  @POST('/api/admin/push-notifications')
  Future<PushNotificationModel> createPushNotification(
    @Body() CreatePushRequest request,
  );
  
  @POST('/api/admin/push-notifications/{id}/send')
  Future<void> sendPushNotification(@Path('id') int id);
  
  @DELETE('/api/admin/push-notifications/{id}')
  Future<void> deletePushNotification(@Path('id') int id); */
}

// ============ REQUEST/RESPONSE MODELS ============

class LoginRequest {
  final String email;
  final String password;
  
  LoginRequest({required this.email, required this.password});
  
  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class AuthResponse {
  final String token;
  final UserModel user;
  
  AuthResponse({required this.token, required this.user});
  
  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    token: json['token'],
    user: UserModel.fromJson(json['user']),
  );
}

class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  
  PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });
  
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse<T>(
      data: (json['data'] as List).map((e) => fromJsonT(e)).toList(),
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }
}

// тут будут остальные request модели...
class CreateUserRequest {
  final String name;
  final String email;
  final String phone;
  final String? password;
  final String role;
  
  CreateUserRequest({
    required this.name,
    required this.email,
    required this.phone,
    this.password,
    this.role = 'user',
  });
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    if (password != null) 'password': password,
    'role': role,
  };
}

class UpdateUserRequest {
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? status;
  
  UpdateUserRequest({
    this.name,
    this.email,
    this.phone,
    this.role,
    this.status,
  });
  
  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (email != null) 'email': email,
    if (phone != null) 'phone': phone,
    if (role != null) 'role': role,
    if (status != null) 'status': status,
  };
}

class SetBonusesRequest {
  final int amount;
  final String reason;
  
  SetBonusesRequest({required this.amount, required this.reason});
  
  Map<String, dynamic> toJson() => {
    'amount': amount,
    'reason': reason,
  };
}

// и так далее для остальных request моделей...