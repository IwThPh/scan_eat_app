import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);
}

///Represents ServerFailure.
///
///Occurs when a remote repository reports an unexpected error.
class ServerFailure extends Failure {
  @override
  List<Object> get props => null;
}

///Represents Local Cache Failure.
///
///Occurs when a local repository reports an unexpected error.
class CacheFailure extends Failure {
  @override
  List<Object> get props => null;
}