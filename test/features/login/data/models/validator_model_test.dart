import 'package:flutter_test/flutter_test.dart';
import 'package:scaneat/features/login/domain/entities/validator.dart';

import '../../../../samples.dart';

main() {
  final tValidatorModel = Samples.tValidator;

  test('Should be a subclass of Auth entity', () async {
    expect(tValidatorModel, isA<Validator>());
  });
}