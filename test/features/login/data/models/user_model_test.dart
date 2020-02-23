import 'package:flutter_test/flutter_test.dart';
import 'package:scaneat/features/login/domain/entities/user.dart';

import '../../../../samples.dart';

main() {
  final tUserModel = Samples.tUserModel;

  test('Should be a subclass of User entity', () async {
    expect(tUserModel, isA<User>());
  });
}