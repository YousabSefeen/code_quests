import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String role,
  });


  Future<Either<Failure, String?>> getUserEmail();

  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>>   signInWithGoogle();
}