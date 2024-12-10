import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/repos_user_github_model.dart';
import '../repositories/repos_user_github_repository.dart';

class ReposViewModel extends ChangeNotifier {
  bool isLoading = true;
  final ReposUserGithubRepository reposUserGithubRepository =
      ReposUserGithubRepository(dio: Dio());
  List<ReposUserGithubModel> listRepositories = [];
  List<ReposUserGithubModel> filteredListRepositories = [];

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> loadRepositories(login) async {
    setLoading(true);
    notifyListeners();
    try {
      final repositories =
          await reposUserGithubRepository.getRepositoryUserInfo(login);
      listRepositories = repositories;
      filteredListRepositories = List.from(repositories);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void filterRepositories(String query) {
    if (query.isEmpty) {
      filteredListRepositories = List.from(listRepositories);
    } else {
      filteredListRepositories = listRepositories
          .where((repo) => repo.name?.toLowerCase().contains(query) ?? false)
          .toList();
    }
    notifyListeners();
  }
}
