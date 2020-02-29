import 'package:flutter_test/flutter_test.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';

import '../../../../samples.dart';

main() {
  final tPreferenceModel = Samples.tPreferenceModel;

  test('Should be a subclass of Allergen entity', () async {
    expect(tPreferenceModel, isA<Preference>());
  });
}