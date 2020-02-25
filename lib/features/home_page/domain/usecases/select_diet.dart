import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';

class SelectDiet implements UseCase<String, Params> {
  final HomeRepository repo;

  SelectDiet(this.repo);

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repo.selectDiets(params.diets);
  }
}

class Params extends Equatable {
  final List<Diet> diets;

  Params({
    @required this.diets,
    });

  @override
  List<Object> get props => [diets];
}