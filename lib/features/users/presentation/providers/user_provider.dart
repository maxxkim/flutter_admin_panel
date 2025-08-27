import 'package:clean_arch_app/core/constants/api_constants.dart';
import 'package:clean_arch_app/core/network/api_client.dart';
import 'package:clean_arch_app/features/users/data/datasources/user_remote_datasource.dart';
import 'package:clean_arch_app/features/users/data/repositories/user_repository_impl.dart';
import 'package:clean_arch_app/features/users/domain/entities/user.dart';
import 'package:clean_arch_app/features/users/domain/repositories/user_repository.dart';
import 'package:clean_arch_app/features/users/domain/usecases/get_user_by_id.dart';
import 'package:clean_arch_app/features/users/domain/usecases/get_users.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Dio Provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
  ));

  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
  ));

  return dio;
});

// API Client Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio, baseUrl: ApiConstants.baseUrl);
});

// Data Source Provider
final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserRemoteDataSourceImpl(apiClient: apiClient);
});

// Repository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  return UserRepositoryImpl(remoteDataSource: remoteDataSource);
});

// Use Cases Providers
final getUsersUseCaseProvider = Provider<GetUsers>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUsers(repository);
});

final getUserByIdUseCaseProvider = Provider<GetUserById>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserById(repository);
});

// State Providers with required parameters
class UsersListParams {
  final int page;
  final int perPage;
  final String? search;
  final String? status;
  final String? role;

  UsersListParams({
    this.page = 1,
    this.perPage = 10,
    this.search,
    this.status,
    this.role,
  });
}

final usersListProvider = FutureProvider.family<List<User>, UsersListParams>((ref, params) async {
  final getUsers = ref.watch(getUsersUseCaseProvider);
  final result = await getUsers(
    page: params.page,
    perPage: params.perPage,
    search: params.search,
    status: params.status,
    role: params.role,
  );

  return result.fold(
    (failure) => throw Exception(failure.message),
    (users) => users,
  );
});

final userDetailProvider = FutureProvider.family<User, int>((ref, id) async {
  final getUserById = ref.watch(getUserByIdUseCaseProvider);
  final result = await getUserById(id);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (user) => user,
  );
});