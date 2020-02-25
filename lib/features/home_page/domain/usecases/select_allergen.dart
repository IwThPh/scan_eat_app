import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';

class SelectAllergen implements UseCase<String, Params> {
  final HomeRepository repo;

  SelectAllergen(this.repo);

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repo.selectAllergens(params.allergens);
  }
}

class Params extends Equatable {
  final List<Allergen> allergens;

  Params({
    @required this.allergens,
    });

  @override
  List<Object> get props => [allergens];
}