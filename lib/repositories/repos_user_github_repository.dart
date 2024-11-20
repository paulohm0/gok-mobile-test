import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gok_mobile_test/models/repos_user_github_model.dart';

class ReposUserGithubRepository {
  final Dio dio;

  ReposUserGithubRepository({required this.dio});

  Future<List<ReposUserGithubModel>> getRepositoryUserInfo(String user) async {
    try {
      final apiResponse =
          await dio.get('https://api.github.com/users/$user/repos');
      return List.from(apiResponse.data)
          .map((userRepo) => ReposUserGithubModel.fromJson(userRepo))
          .toList();
    } catch (error, stacktrace) {
      log(
        'Ocorreu um erro ao buscar os dados do repositório do usuário',
        error: error,
        stackTrace: stacktrace,
      );
      rethrow;
    }
  }
}
