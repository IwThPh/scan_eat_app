import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scaneat/features/scanning/domain/usecases/get_product.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../samples.dart';

class MockGetProduct extends Mock implements GetProduct {}

void main() {
  ScanningBloc bloc;
  MockGetProduct mockGetProduct;

  setUp(() {
    mockGetProduct = MockGetProduct();
    bloc = ScanningBloc(product: mockGetProduct);
  });

  test('initial state should be scanning', () {
    expect(bloc.initialState, equals(UnScanningState(0)));
  });

  group('GetProduct', () {
    final tProduct = Samples.tProduct;
    final tBarcode = tProduct.barcode;

    test('should retrieve product from use case', () async {
      when(mockGetProduct(any)).thenAnswer((_) async => Right(tProduct));

      bloc.add(RetrieveProduct(tBarcode));
      await untilCalled(mockGetProduct(any));

      verify(mockGetProduct(Params(barcode: tBarcode)));
    });

    test('should emit [UnScanningState, LoadedScanningState] on success', () async {
      when(mockGetProduct(any)).thenAnswer((_) async => Right(tProduct));

      //Expected Emit Order.
      final expected = [
        UnScanningState(0),
        LoadedScanningState(1, product: tProduct),
      ];
      expectLater(bloc, emitsInOrder(expected));

      bloc.add(RetrieveProduct(tBarcode));
    });
  });

  group('ScanProduct', () {
    test('should emit [UnScanningState],[ScanScanningState]', () async {
      when(mockGetProduct(any)).thenAnswer((_) async => Right(null));

      //Expected Emit Order.
      final expected = [
        UnScanningState(0),
        ScanScanningState(1),
      ];
      expectLater(bloc, emitsInOrder(expected));

      bloc.add(ScanProduct());
    });
  });

  group('ManualInput', () {
    test('should emit [UnScanningState, ScanScanningState, UserInputScanningState]', () async {
      when(mockGetProduct(any)).thenAnswer((_) async => Right(null));

      //Expected Emit Order.
      final expected = [
        UnScanningState(0),
        UserInputScanningState(1),
      ];
      expectLater(bloc, emitsInOrder(expected));

      bloc.add(ManualInput());
    });
  });
}
