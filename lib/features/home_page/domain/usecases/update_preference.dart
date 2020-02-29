import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';

class UpdatePreference implements UseCase<Preference, Params> {
  final HomeRepository repo;

  UpdatePreference(this.repo);

  @override
  Future<Either<Failure, Preference>> call(Params params) async {
    return await repo.updatePreference(params.pref);
  }
}

class Params extends Equatable {
  final Preference pref;

  Params({
    @required this.pref,
    });

  @override
  List<Object> get props => [pref];
}