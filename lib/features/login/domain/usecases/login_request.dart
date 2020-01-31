import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';

class LoginRequest implements UseCase<Auth, Params> {
  final LoginRepository repo;

  LoginRequest(this.repo);

  @override
  Future<Either<Failure, Auth>> call(Params params) async {
    return await repo.attemptLogin(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({
    @required this.email,
    @required this.password,
    });

  @override
  List<Object> get props => [email, password];
}
