import 'package:flutter/material.dart';
import 'package:gok_mobile_test/screens/search_screen.dart';
import 'package:gok_mobile_test/viewmodel/repos_view_model.dart';
import 'package:gok_mobile_test/widgets/repo_card_widget.dart';

class ReposListScreen extends StatefulWidget {
  const ReposListScreen({super.key});

  @override
  State<ReposListScreen> createState() => _ReposListScreenState();
}

class _ReposListScreenState extends State<ReposListScreen> {
  final TextEditingController searchController = TextEditingController();
  final ReposViewModel reposViewModel = ReposViewModel();
  late UserListArgs userListArgs;

  // searchController é configurado com um listener.
  // Esse listener chama setState sempre que o texto no campo de busca é alterado.
  // Isso força o widget a ser reconstruído, atualizando a lista exibida.
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      reposViewModel.filterRepositories(searchController.text);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userListArgs = ModalRoute.of(context)!.settings.arguments as UserListArgs;
    reposViewModel.loadRepositories(userListArgs.userGithubModel.login);
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
      body: ListenableBuilder(
        listenable: reposViewModel,
        builder: (context, child) => Container(
          color: const Color.fromRGBO(0, 0, 0, 0.06),
          child: reposViewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
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
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                      child: Text(
                                          "Opções de Filtro (Em Desenvolvimento)"),
                                    );
                                  },
                                );
                              },
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
                        child: reposViewModel.listRepositories.isEmpty
                            ? const Center(
                                child: Text('Nenhum repositório encontrado'),
                              )
                            : ListView.builder(
                                itemCount: reposViewModel
                                    .filteredListRepositories.length,
                                itemBuilder: (context, index) {
                                  final repository = reposViewModel
                                      .filteredListRepositories[index];
                                  return RepoCardWidget(
                                    projectName: repository.name ?? 'Sem nome',
                                    projectDescription:
                                        repository.description ??
                                            'Sem descrição',
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
      ),
    );
  }
}
