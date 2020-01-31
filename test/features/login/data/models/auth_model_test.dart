import 'package:flutter_test/flutter_test.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';

import '../../../../samples.dart';

main() {
  final tAuthModel = Samples.tAuth;

  test('Should be a subclass of Auth entity', () async {
    expect(tAuthModel, isA<Auth>());
  });
}