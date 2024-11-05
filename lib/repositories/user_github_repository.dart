import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gok_mobile_test/models/user_github_model.dart';

class UserGithubRepository {
  final Dio dio;

  UserGithubRepository({required this.dio});

  Future<UserGithubModel> getUserInfo(String user) async {
    try {
      final apiResponse = await dio.get('https://api.github.com/users/$user');
      return UserGithubModel.fromJson(apiResponse.data);
    } catch (error, stacktrace) {
      log(
        'Ocorreu um erro ao buscar as informações do usuário',
        error: error,
        stackTrace: stacktrace,
      );
      rethrow;
    }
  }
}
