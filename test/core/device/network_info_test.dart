import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/device/network_info.dart';

class MockDataConncetionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConncetionChecker mockDataConncetionChecker;

  setUp(() {
    mockDataConncetionChecker = MockDataConncetionChecker();
    networkInfo = NetworkInfoImpl(mockDataConncetionChecker);
  });

  group('isConnected', () {
    test('Should call DataConnection Package', () async {
      final tHasConnection = Future.value(true);

      when(mockDataConncetionChecker.hasConnection).thenAnswer((_)=> tHasConnection);

      final response = networkInfo.isConnected;

      verify(mockDataConncetionChecker.hasConnection);
      expect(response, tHasConnection);
    });
  });
  
}