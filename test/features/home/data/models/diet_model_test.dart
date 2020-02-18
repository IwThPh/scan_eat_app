import 'package:flutter_test/flutter_test.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';

import '../../../../samples.dart';

main() {
  final tDietModel = Samples.tDietModel;

  test('Should be a subclass of Diet entity', () async {
    expect(tDietModel, isA<Diet>());
  });
}