import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

/// Presents the Base Usecase.
/// 
/// To be used in the domain layers of feature implementation.
/// The [NoParams] object is used by usecases that require no parametres.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => null;
}