import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gok_mobile_test/models/repos_user_github_model.dart';
import 'package:gok_mobile_test/repositories/repos_user_github_repository.dart';
import 'package:gok_mobile_test/screens/search_screen.dart';
import 'package:gok_mobile_test/widgets/repo_card_widget.dart';

class ReposListScreen extends StatefulWidget {
  const ReposListScreen({super.key});

  @override
  State<ReposListScreen> createState() => _ReposListScreenState();
}

class _ReposListScreenState extends State<ReposListScreen> {
  late UserListArgs userListArgs;
  final ReposUserGithubRepository reposUserGithubRepository =
      ReposUserGithubRepository(dio: Dio());

  Future<List<ReposUserGithubModel>> getUserListRepositories() async {
    return reposUserGithubRepository
        .getRepositoryUserInfo(userListArgs.userGithubModel.login);
  }

  @override
  Widget build(BuildContext context) {
    userListArgs = ModalRoute.of(context)!.settings.arguments as UserListArgs;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.06),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(userListArgs.userGithubModel.avatarUrl),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF7FF),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    height: 45,
                    width: 321,
                    child: const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Buscar um repositório...',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  SizedBox(
                    height: 45,
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: () {},
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: const Color(0xFFFEF7FF),
                      child: const Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: FutureBuilder<List<ReposUserGithubModel>>(
                  future: getUserListRepositories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final repositoryList = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: repositoryList.length,
                      itemBuilder: (context, index) {
                        final ReposUserGithubModel repository =
                            repositoryList[index];
                        return RepoCardWidget(
                          projectName: repository.name ?? 'Sem nome',
                          projectDescription:
                              repository.description ?? 'Sem descrição',
                          codeLanguage: repository.language ?? 'N/A',
                          lastModified: repository.updatedAt ?? '',
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
