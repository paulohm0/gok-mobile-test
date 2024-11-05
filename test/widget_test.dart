// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gok_mobile_test/repositories/user_github_repository.dart';

void main() {
  late UserGithubRepository repository;
  late Dio dio;

  // funcao que configura tudo que for necessário antes de executar o teste
  // inicializando dio e rep dentro do setUp, garante que cada teste tenha uma
  // nova instancia de dio e rep fazendo com que cada teste seja independente.
  setUp(
    () {
      dio = Dio();
      repository = UserGithubRepository(dio: dio);
    },
  );
  test(
    'Deve retornar as informações do usuário',
    () async {
      try {
        final apiResponse = await repository.getUserInfo('paulohm0');
        expect(apiResponse, isNotNull);
        print('deu certo');
      } catch (error) {
        fail('$error');
      }
    },
  );
}
