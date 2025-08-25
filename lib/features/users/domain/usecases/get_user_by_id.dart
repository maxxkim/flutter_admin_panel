import 'package:clean_arch_app/core/error/failures.dart';
import 'package:clean_arch_app/features/users/domain/entities/user.dart';
import 'package:clean_arch_app/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserById {
  final UserRepository repository;
  
  GetUserById(this.repository);
  
  Future<Either<Failure, User>> call(int id) async {
    return await repository.getUserById(id);
  }
}
