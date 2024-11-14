import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gok_mobile_test/models/user_github_model.dart';
import 'package:gok_mobile_test/repositories/user_github_repository.dart';
import 'package:gok_mobile_test/viewmodel/main_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UserListArgs {
  final UserGithubModel userGithubModel;

  UserListArgs({required this.userGithubModel});
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late UserGithubModel userGithubModel;
  late MainViewModel mainViewModel;
  late TextEditingController username;
  late UserGithubRepository repository;

  @override
  void initState() {
    super.initState();
    mainViewModel = MainViewModel();
    username = TextEditingController();
    repository = UserGithubRepository(dio: Dio());
  }

  @override
  void dispose() {
    username.dispose();
    mainViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100.0),
                child: Image.asset('assets/github-logo.png'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Buscar usuário',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: username,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white30,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                      ),
                      hintText: '@username',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ListenableBuilder(
                      listenable: mainViewModel,
                      builder: (context, child) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 2,
                          ),
                          onPressed: mainViewModel.isLoading
                              ? () {} // botao não sera clicável durante o loading
                              : () async {
                                  mainViewModel.searchLoading();
                                  try {
                                    final userModel = await repository
                                        .getUserInfo(username.text);
                                    // addPostFrameCallback evita que algo seja executado antes do método build esta pronto
                                    WidgetsBinding.instance
                                        .addPostFrameCallback(
                                      (_) {
                                        Navigator.pushNamed(
                                            arguments: UserListArgs(
                                                userGithubModel: userModel),
                                            context,
                                            '/user_list_screen');
                                      },
                                    );
                                  } finally {
                                    await Future.delayed(
                                        const Duration(milliseconds: 300));
                                    mainViewModel.searchComplete();
                                  }
                                },
                          child: mainViewModel.isLoading == false
                              ? const Text(
                                  'Buscar',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )
                              : const Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  children: [
                    const TextSpan(text: 'Termos de '),
                    TextSpan(
                      text: 'politica',
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final url = Uri.parse(
                              'https://docs.github.com/pt/site-policy/acceptable-use-policies/github-acceptable-use-policies');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            throw 'Não foi possivel abrir $url';
                          }
                        },
                    ),
                    const TextSpan(text: ' e '),
                    TextSpan(
                      text: 'privacidade',
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final url = Uri.parse(
                              'https://docs.github.com/pt/site-policy/privacy-policies/github-general-privacy-statement');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            throw 'Não foi possivel abrir $url';
                          }
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
