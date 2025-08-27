// В файле user_remote_datasource.dart
import 'package:clean_arch_app/core/error/exceptions.dart';
import 'package:clean_arch_app/core/network/api_client.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers({
    required int page,
    required int perPage,
    String? search,
    String? status,
    String? role,
    String? dateFrom,
    String? dateTo,
  });
  Future<UserModel> getUserById(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<UserModel>> getUsers({
    required int page,
    required int perPage,
    String? search,
    String? status,
    String? role,
    String? dateFrom,
    String? dateTo,
  }) async {
    try {
      final response = await apiClient.getUsers(
        page,
        perPage,
        search,
        status,
        role,
        dateFrom,
        dateTo,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Connection timeout');
      }
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    try {
      return await apiClient.getUserById(id);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Connection timeout');
      }
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }
}