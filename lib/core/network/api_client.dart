import 'package:clean_arch_app/features/users/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  
  @GET('/users')
  Future<List<UserModel>> getUsers();
  
  @GET('/users/{id}')
  Future<UserModel> getUserById(@Path('id') int id);
  
  @POST('/users')
  Future<UserModel> createUser(@Body() UserModel user);
  
  @PUT('/users/{id}')
  Future<UserModel> updateUser(@Path('id') int id, @Body() UserModel user);
  
  @DELETE('/users/{id}')
  Future<void> deleteUser(@Path('id') int id);
}