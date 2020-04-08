import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../product/domain/entities/product.dart';
import '../repositories/scanning_repository.dart';

class GetProduct implements UseCase<Product,Params>{
  final ScanningRepository repo;  

  GetProduct(this.repo);

@override
  Future<Either<Failure,Product>> call(Params params) async {
    return await repo.getProduct(params.barcode);
  }
  
}

class Params extends Equatable {
  final String barcode;

  Params({@required this.barcode});

  @override
  List<Object> get props => [barcode];
}