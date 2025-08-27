// In file: user_repository.dart
import 'package:dartz/dartz.dart';
import 'package:clean_arch_app/core/error/failures.dart';
import 'package:clean_arch_app/features/users/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers({
    required int page,
    required int perPage,
    String? search,
    String? status,
    String? role,
    String? dateFrom,
    String? dateTo,
  });
  Future<Either<Failure, User>> getUserById(int id);
}