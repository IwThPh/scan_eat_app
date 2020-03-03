import 'package:scaneat/features/home_page/data/models/allergen_model.dart';
import 'package:scaneat/features/home_page/data/models/diet_model.dart';
import 'package:scaneat/features/home_page/data/models/preference_model.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/login/data/models/auth_model.dart';
import 'package:scaneat/features/login/data/models/user_model.dart';
import 'package:scaneat/features/login/data/models/validator_model.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/entities/user.dart';
import 'package:scaneat/features/login/domain/entities/validator.dart';
import 'package:scaneat/features/scanning/data/models/product_model.dart';
import 'package:scaneat/features/scanning/domain/entities/product.dart';

class Samples {
  static final Product tProduct = Product(
      barcode: '0737628064502',
      name: 'Stir-Fry Rice Noodles',
      carbohydrate_100g: 70.5,
      energy_100g: 1660.0,
      fat_100g: 8.97,
      fibre_100g: 0.0,
      protein_100g: 8.97,
      salt_100g: 2.05,
      saturates_100g: 1.28,
      sodium_100g: 0.82,
      sugars_100g: 12.8,
      weight_g: 155.0);

  static final ProductModel tProductModel = ProductModel(
      barcode: tProduct.barcode,
      name: tProduct.name,
      carbohydrate_100g: tProduct.carbohydrate_100g,
      energy_100g: tProduct.energy_100g,
      fat_100g: tProduct.fat_100g,
      fibre_100g: tProduct.fibre_100g,
      protein_100g: tProduct.protein_100g,
      salt_100g: tProduct.salt_100g,
      saturates_100g: tProduct.saturates_100g,
      sodium_100g: tProduct.sodium_100g,
      sugars_100g: tProduct.sugars_100g,
      weight_g: tProduct.weight_g);

  static final String tProductJson =
      "{\"id\":105,\"barcode\":\"0737628064502\",\"name\":\"Stir-Fry Rice Noodles\",\"weight_g\":155,\"energy_100g\":1660,\"carbohydrate_100g\":70.5,\"protein_100g\":8.97,\"fat_100g\":8.97,\"fibre_100g\":0,\"salt_100g\":2.05,\"sugar_100g\":12.8,\"saturated_100g\":1.28,\"sodium_100g\":0.819,\"created_at\":\"2019-11-10T18:22:51.000000Z\",\"updated_at\":\"2019-11-10T18:22:51.000000Z\"}";

  static final Auth tAuth = Auth(
    tokenType: 'Bearer',
    accessToken:
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiOTM4YTVjNjAwZWYwM2UzMGIzNjI4OWViNzNhNDNkNDA4N2ZjOWQ0MTNjM2U0ZGI5ZGEwZGEyNzk4Y2I2NjcyZGQxNjdiZjJjMjMyZmFkZmYiLCJpYXQiOjE1ODA0NzM1MDMsIm5iZiI6MTU4MDQ3MzUwMywiZXhwIjoxNjEyMDk1OTAzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.omA1QeRZtwiwRKKda6Muz-H1xFhOvq6r7LF15lzct1tmJv2TG7ZlrpNdKDEu8EO2i9wDKx9YBuSheJ6C07lT8eLPmGRPt2aHu3HCCuXnalkicarvWG9iW9f-jaQisHcmP2NkjLIC7sJ05gTDGeCM5MQwmEMTBji4FVlwX13PEYF_ExALNHHNxqXRQmY31BjfzdQl1ZMjeuCssF0l5rNaLqv4TH5l9b_dfa3pYA54spnEg0zgUaJTQjeAfQwsHmLP3xEHLs9Ujk4RqxzQNEKOhJEsXMVWe3LGIb99bTSqHOpBAcpwGgXYT11g-NRtjBvlix168OMtMMSAKB6AOygWgSXknpcSF91tzCfy8XJ8FkMTsSayWvuM_bLBQHsDUKmQX_2jJqeMDnRxBiRJf2cpzsDkprYOYvFJY_JJVe6EpRV1P5jywGZASrbQNbCbmZz-Z4YMAwPeVwAR3JURLPVyS0C8Sgr7_W2L_0VOgmf2HCAFq41_DqogyzkMHck2kc4t8aMt0haxRnUtkF4Hu6ZgC0o89oc2eK-DY2nUIRhpFW6JjFLeXINt8C1d7DKlbTYXVdMXVW9IuUk6tBO0HMaPbgfMRZwYtCdxgSGmyFjgL0d0GTlPVHH1D-0NRVJ-IfdtmhJA0yMcFRNWZmMHAnkkcy3hlernEdKbMWgp-LvL4uk',
    refreshToken:
        'def50200ff637f779ac4be395ff7355a9d2fba4225d433cc856319873dcab654d9b5b29892b2350a51c39727d741a658467d88cdb450e504a5ac7b6d099027478bbd08719eff4cf9dcd2bfd222680ea7809db9200d3e2d7900ab63bbc16c880aef9260a40bc45f74ce36c2c9eca212ff2461d725665fcf8bd17e32b97b299dfe7a4155e77356686d7ba17ef5ba72b2bc9e6c6465ae9c2678933435d728e9cf6c4c8f359cc47296ef12fa1b16ac9de0c3fe38d40dec4c9439655dc496eb0d543c5e6b04efc141d4d9deffe086d8e536916447e7e146189a647310995c9d9e358f606408e1be8835af73e1e06eaa681bb41c942e7c65522981555e3214ef238371ccb5fe4e4e653dfdc62c2fec3af02f726255088679a6630d5ce0c40463ecac328ba4efa62cba5fccf6c7bdc0432c894ad82d5c2fb3f2599a59dccd3daba555e06271d7c6b1b822b7d5142815f66cdef34555b705e37b090488fa11d5ea7b167847',
  );

  static final AuthModel tAuthModel = AuthModel(
    tokenType: 'Bearer',
    accessToken:
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiOTM4YTVjNjAwZWYwM2UzMGIzNjI4OWViNzNhNDNkNDA4N2ZjOWQ0MTNjM2U0ZGI5ZGEwZGEyNzk4Y2I2NjcyZGQxNjdiZjJjMjMyZmFkZmYiLCJpYXQiOjE1ODA0NzM1MDMsIm5iZiI6MTU4MDQ3MzUwMywiZXhwIjoxNjEyMDk1OTAzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.omA1QeRZtwiwRKKda6Muz-H1xFhOvq6r7LF15lzct1tmJv2TG7ZlrpNdKDEu8EO2i9wDKx9YBuSheJ6C07lT8eLPmGRPt2aHu3HCCuXnalkicarvWG9iW9f-jaQisHcmP2NkjLIC7sJ05gTDGeCM5MQwmEMTBji4FVlwX13PEYF_ExALNHHNxqXRQmY31BjfzdQl1ZMjeuCssF0l5rNaLqv4TH5l9b_dfa3pYA54spnEg0zgUaJTQjeAfQwsHmLP3xEHLs9Ujk4RqxzQNEKOhJEsXMVWe3LGIb99bTSqHOpBAcpwGgXYT11g-NRtjBvlix168OMtMMSAKB6AOygWgSXknpcSF91tzCfy8XJ8FkMTsSayWvuM_bLBQHsDUKmQX_2jJqeMDnRxBiRJf2cpzsDkprYOYvFJY_JJVe6EpRV1P5jywGZASrbQNbCbmZz-Z4YMAwPeVwAR3JURLPVyS0C8Sgr7_W2L_0VOgmf2HCAFq41_DqogyzkMHck2kc4t8aMt0haxRnUtkF4Hu6ZgC0o89oc2eK-DY2nUIRhpFW6JjFLeXINt8C1d7DKlbTYXVdMXVW9IuUk6tBO0HMaPbgfMRZwYtCdxgSGmyFjgL0d0GTlPVHH1D-0NRVJ-IfdtmhJA0yMcFRNWZmMHAnkkcy3hlernEdKbMWgp-LvL4uk',
    refreshToken:
        'def50200ff637f779ac4be395ff7355a9d2fba4225d433cc856319873dcab654d9b5b29892b2350a51c39727d741a658467d88cdb450e504a5ac7b6d099027478bbd08719eff4cf9dcd2bfd222680ea7809db9200d3e2d7900ab63bbc16c880aef9260a40bc45f74ce36c2c9eca212ff2461d725665fcf8bd17e32b97b299dfe7a4155e77356686d7ba17ef5ba72b2bc9e6c6465ae9c2678933435d728e9cf6c4c8f359cc47296ef12fa1b16ac9de0c3fe38d40dec4c9439655dc496eb0d543c5e6b04efc141d4d9deffe086d8e536916447e7e146189a647310995c9d9e358f606408e1be8835af73e1e06eaa681bb41c942e7c65522981555e3214ef238371ccb5fe4e4e653dfdc62c2fec3af02f726255088679a6630d5ce0c40463ecac328ba4efa62cba5fccf6c7bdc0432c894ad82d5c2fb3f2599a59dccd3daba555e06271d7c6b1b822b7d5142815f66cdef34555b705e37b090488fa11d5ea7b167847',
  );

  static final String tAuthJson =
      "{\"token_type\": \"Bearer\",\"expires_in\": 31622400,\"access_token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiOTM4YTVjNjAwZWYwM2UzMGIzNjI4OWViNzNhNDNkNDA4N2ZjOWQ0MTNjM2U0ZGI5ZGEwZGEyNzk4Y2I2NjcyZGQxNjdiZjJjMjMyZmFkZmYiLCJpYXQiOjE1ODA0NzM1MDMsIm5iZiI6MTU4MDQ3MzUwMywiZXhwIjoxNjEyMDk1OTAzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.omA1QeRZtwiwRKKda6Muz-H1xFhOvq6r7LF15lzct1tmJv2TG7ZlrpNdKDEu8EO2i9wDKx9YBuSheJ6C07lT8eLPmGRPt2aHu3HCCuXnalkicarvWG9iW9f-jaQisHcmP2NkjLIC7sJ05gTDGeCM5MQwmEMTBji4FVlwX13PEYF_ExALNHHNxqXRQmY31BjfzdQl1ZMjeuCssF0l5rNaLqv4TH5l9b_dfa3pYA54spnEg0zgUaJTQjeAfQwsHmLP3xEHLs9Ujk4RqxzQNEKOhJEsXMVWe3LGIb99bTSqHOpBAcpwGgXYT11g-NRtjBvlix168OMtMMSAKB6AOygWgSXknpcSF91tzCfy8XJ8FkMTsSayWvuM_bLBQHsDUKmQX_2jJqeMDnRxBiRJf2cpzsDkprYOYvFJY_JJVe6EpRV1P5jywGZASrbQNbCbmZz-Z4YMAwPeVwAR3JURLPVyS0C8Sgr7_W2L_0VOgmf2HCAFq41_DqogyzkMHck2kc4t8aMt0haxRnUtkF4Hu6ZgC0o89oc2eK-DY2nUIRhpFW6JjFLeXINt8C1d7DKlbTYXVdMXVW9IuUk6tBO0HMaPbgfMRZwYtCdxgSGmyFjgL0d0GTlPVHH1D-0NRVJ-IfdtmhJA0yMcFRNWZmMHAnkkcy3hlernEdKbMWgp-LvL4uk\",\"refresh_token\": \"def50200ff637f779ac4be395ff7355a9d2fba4225d433cc856319873dcab654d9b5b29892b2350a51c39727d741a658467d88cdb450e504a5ac7b6d099027478bbd08719eff4cf9dcd2bfd222680ea7809db9200d3e2d7900ab63bbc16c880aef9260a40bc45f74ce36c2c9eca212ff2461d725665fcf8bd17e32b97b299dfe7a4155e77356686d7ba17ef5ba72b2bc9e6c6465ae9c2678933435d728e9cf6c4c8f359cc47296ef12fa1b16ac9de0c3fe38d40dec4c9439655dc496eb0d543c5e6b04efc141d4d9deffe086d8e536916447e7e146189a647310995c9d9e358f606408e1be8835af73e1e06eaa681bb41c942e7c65522981555e3214ef238371ccb5fe4e4e653dfdc62c2fec3af02f726255088679a6630d5ce0c40463ecac328ba4efa62cba5fccf6c7bdc0432c894ad82d5c2fb3f2599a59dccd3daba555e06271d7c6b1b822b7d5142815f66cdef34555b705e37b090488fa11d5ea7b167847\"}";

  static final String tName = "name";
  static final String tEmail = "test@example.test";
  static final String tPassword = "password";

  static final Validator tValidator = Validator(
    nameError: 'NameError',
    emailError: 'EmailError',
    passwordError: 'PasswordError',
  );
  static final ValidatorModel tValidatorModel = ValidatorModel(
    nameError: tValidator.nameError,
    emailError: tValidator.emailError,
    passwordError: tValidator.passwordError,
  );

  static final String tValidatorJson =
      "{\"name\": \[\"name error\"\],\"email\": \[\"email error\"\],\"password\": \[\"password error\"\]}";

  static final tAllergen = Allergen(
    id: 0,
    name: "name",
    description: "description",
    selected: false,
  );

  static final tAllergenModel = AllergenModel(
    id: 0,
    name: "name",
    description: "description",
    selected: false,
  );

  static final List<Allergen> tAllergenList = [tAllergen, tAllergen, tAllergen];
  static final List<AllergenModel> tAllergenModelList = [
    tAllergenModel,
    tAllergenModel,
    tAllergenModel
  ];

  static final tAllergenListJson =
      "[{\"id\":1,\"name\":\"name\",\"description\":\"description\",\"created_at\":\"2020-02-08 14:24:19\",\"updated_at\":\"2020-02-08 14:24:19\"}," +
          "{\"id\":2,\"name\":\"name\",\"description\":\"description\",\"created_at\":\"2020-02-08 14:24:19\",\"updated_at\":\"2020-02-08 14:24:19\"}," +
          "{\"id\":3,\"name\":\"name\",\"description\":\"description\",\"created_at\":\"2020-02-08 14:24:19\",\"updated_at\":\"2020-02-08 14:24:19\"}" +
          "]";

  static final tDiet = Diet(
    id: 0,
    name: "name",
    description: "description",
    selected: false,
  );

  static final tDietModel = DietModel(
    id: 0,
    name: "name",
    description: "description",
    selected: false,
  );

  static final List<Diet> tDietList = [tDiet, tDiet, tDiet];
  static final List<DietModel> tDietModelList = [
    tDietModel,
    tDietModel,
    tDietModel
  ];

  static final tDietListJson =
      "[{\"id\":1,\"name\":\"name\",\"description\":\"description\",\"created_at\":\"2020-02-08 14:24:19\",\"updated_at\":\"2020-02-08 14:24:19\"}," +
          "{\"id\":2,\"name\":\"name\",\"description\":\"description\",\"created_at\":\"2020-02-08 14:24:19\",\"updated_at\":\"2020-02-08 14:24:19\"}," +
          "{\"id\":3,\"name\":\"name\",\"description\":\"description\",\"created_at\":\"2020-02-08 14:24:19\",\"updated_at\":\"2020-02-08 14:24:19\"}" +
          "]";

  static final User tUser = User(name: tName, email: tEmail);

  static final UserModel tUserModel = UserModel(name: tName, email: tEmail);

  static final String tUserJson =
      "{\"name\": \"$tName\",\"email\": \"$tEmail\"}";

  static final String tSuccessJson = "{\"message\":\"Success\"}";
  static final String tSuccess = "{\"message\":\"Success\"}";

  static final Preference tPreference = Preference(
    user_id: 1,
    energy_max: 2000,
    carbohydrate_1: 0.5,
    carbohydrate_2: 0.5,
    carbohydrate_max: 100,
    protein_1: 0.5,
    protein_2: 0.5,
    protein_max: 100,
    fat_1: 0.5,
    fat_2: 0.5,
    fat_max: 100,
    sodium_1: 0.5,
    sodium_2: 0.5,
    sodium_max: 100,
    saturated_1: 0.5,
    saturated_2: 0.5,
    saturated_max: 100,
    fibre_1: 0.5,
    fibre_2: 0.5,
    fibre_max: 100,
    salt_1: 0.5,
    salt_2: 0.5,
    salt_max: 100,
    sugar_1: 0.5,
    sugar_2: 0.5,
    sugar_max: 100,
  );

  static final PreferenceModel tPreferenceModel = PreferenceModel(
    user_id: 1,
    energy_max: 2000,
    carbohydrate_1: 0.5,
    carbohydrate_2: 0.5,
    carbohydrate_max: 100,
    protein_1: 0.5,
    protein_2: 0.5,
    protein_max: 100,
    fat_1: 0.5,
    fat_2: 0.5,
    fat_max: 100,
    sodium_1: 0.5,
    sodium_2: 0.5,
    sodium_max: 100,
    saturated_1: 0.5,
    saturated_2: 0.5,
    saturated_max: 100,
    fibre_1: 0.5,
    fibre_2: 0.5,
    fibre_max: 100,
    salt_1: 0.5,
    salt_2: 0.5,
    salt_max: 100,
    sugar_1: 0.5,
    sugar_2: 0.5,
    sugar_max: 100,
  );

  static final String tPreferenceJson =
      '\{\"user_id\":1,\"energy_max\":2000,\"carbohydrate_max\":325,\"protein_max\":50,\"fat_max\":70,\"fibre_max\":30,\"salt_max\":6,\"sugar_max\":90,\"saturated_max\":20,\"sodium_max\":2.3,\"carbohydrate_1\":0.5,\"carbohydrate_2\":0.7,\"protein_1\":0.5,\"protein_2\":0.7,\"fat_1\":0.5,\"fat_2\":0.7,\"fibre_1\":null,\"fibre_2\":null,\"salt_1\":0.5,\"salt_2\":0.7,\"sugar_1\":0.5,\"sugar_2\":0.7,\"saturated_1\":0.5,\"saturated_2\":0.7,\"sodium_1\":0.5,\"sodium_2\":0.7\}';
}
