import 'package:clean_arch_app/core/error/failures.dart';
import 'package:clean_arch_app/features/users/domain/entities/user.dart';
import 'package:clean_arch_app/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUsers {
  final UserRepository repository;
  
  GetUsers(this.repository);
  
  Future<Either<Failure, List<User>>> call() async {
    return await repository.getUsers();
  }
}