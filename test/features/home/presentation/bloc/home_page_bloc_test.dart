import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_allergen.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_diet.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/bloc.dart';

class MockGetAllergen extends Mock implements GetAllergen {}

class MockGetDiet extends Mock implements GetDiet {}

main() {
  HomePageBloc bloc;
  MockGetAllergen mockGetAllergen;
  MockGetDiet mockGetDiet;

  setUp(() {
    mockGetAllergen = MockGetAllergen();
    mockGetDiet = MockGetDiet();
    bloc = HomePageBloc();
  });

  test('Initial state should be UnHomePageState, version: 0', () {
    expect(bloc.initialState, equals(UnHomePageState(0)));
  });

  test(
      'Initialising Bloc from initial state should return InLoginPageState, version: 1',
      () {
    final expected = [
      UnHomePageState(0),
      InHomePageState(0),
    ];
    expectLater(bloc, emitsInOrder(expected));

    bloc.add(LoadHomePageEvent());
  });
}
