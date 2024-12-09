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
  List<ReposUserGithubModel> listRepositories = [];
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  Future<void> loadRepositories() async {
    setState(() {
      isLoading = true;
    });
    try {
      final repositories = await reposUserGithubRepository
          .getRepositoryUserInfo(userListArgs.userGithubModel.login);
      setState(() {
        listRepositories = repositories;
      });
    } catch (e) {
      rethrow;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<ReposUserGithubModel> get filteredRepositories {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      return listRepositories;
      // se a barra de pesquisa estiver vazia, retornará a lista completa
    }
    return listRepositories
        .where((repo) => repo.name?.toLowerCase().contains(query) ?? false)
        .toList();
  }

  @override
  void initState() {
    // searchController é configurado com um listener.
    // Esse listener chama setState sempre que o texto no campo de busca é alterado.
    // Isso força o widget a ser reconstruído, atualizando a lista exibida.
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userListArgs = ModalRoute.of(context)!.settings.arguments as UserListArgs;
    loadRepositories();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.06),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage(userListArgs.userGithubModel.avatarUrl),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.06),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Buscar um repositório...',
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
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
                      child: filteredRepositories.isEmpty
                          ? const Center(
                              child: Text('Nenhum repositório encontrado'),
                            )
                          : ListView.builder(
                              itemCount: filteredRepositories.length,
                              itemBuilder: (context, index) {
                                final repository = filteredRepositories[index];
                                return RepoCardWidget(
                                  projectName: repository.name ?? 'Sem nome',
                                  projectDescription:
                                      repository.description ?? 'Sem descrição',
                                  codeLanguage: repository.language ?? 'N/A',
                                  lastModified: repository.updatedAt ?? '',
                                  projectHtmlUrl: repository.htmlUrl ?? '',
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
