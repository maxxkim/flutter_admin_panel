import 'package:clean_arch_app/core/error/failures.dart';
import 'package:clean_arch_app/features/users/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, User>> getUserById(int id);
}
