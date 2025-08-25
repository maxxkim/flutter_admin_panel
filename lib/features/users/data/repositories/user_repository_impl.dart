import 'package:clean_arch_app/core/error/exceptions.dart';
import 'package:clean_arch_app/core/error/failures.dart';
import 'package:clean_arch_app/features/users/data/datasources/user_remote_datasource.dart';
import 'package:clean_arch_app/features/users/domain/entities/user.dart';
import 'package:clean_arch_app/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  
  UserRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final userModels = await remoteDataSource.getUsers();
      final users = userModels.map((model) => model.toEntity()).toList();
      return Right(users);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }
  
  @override
  Future<Either<Failure, User>> getUserById(int id) async {
    try {
      final userModel = await remoteDataSource.getUserById(id);
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }
}