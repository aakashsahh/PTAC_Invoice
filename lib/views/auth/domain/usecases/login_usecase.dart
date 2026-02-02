import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, User>> call({
    required String username,
    required String password,
  }) async {
    // Validate inputs
    if (username.isEmpty) {
      return const Left(ValidationFailure('Username is required'));
    }

    if (password.isEmpty) {
      return const Left(ValidationFailure('Password is required'));
    }

    if (username.length < 3) {
      return const Left(
        ValidationFailure('Username must be at least 3 characters'),
      );
    }

    if (password.length < 4) {
      return const Left(
        ValidationFailure('Password must be at least 4 characters'),
      );
    }

    return await _repository.login(username: username, password: password);
  }
}
