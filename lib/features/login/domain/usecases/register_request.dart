import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/entities/validator.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';

class RegisterRequest implements UseCase<Either<Validator, Auth>, Params> {
  final LoginRepository repo;

  RegisterRequest(this.repo);

  @override
  Future<Either<Failure, Either<Validator, Auth>>> call(Params params) async {
    return await repo.attemptRegister(params.name, params.email, params.password, params.cPassword);
  }
}

class Params extends Equatable {
  final String name;
  final String email;
  final String password;
  final String cPassword;

  Params({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.cPassword,
    });

  @override
  List<Object> get props => [name, email, password, cPassword];
}
