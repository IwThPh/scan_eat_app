import 'package:dartz/dartz.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Allergen>>> getAllergens();
  Future<Either<Failure, List<Diet>>> getDiets();
  Future<Either<Failure, String>> selectAllergens(List<Allergen> allergens);
  Future<Either<Failure, String>> selectDiets(List<Diet> diets);
}