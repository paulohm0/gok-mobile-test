import 'package:flutter/material.dart';
import 'package:gok_mobile_test/widgets/repo_card_widget.dart';

class ReposListScreen extends StatefulWidget {
  const ReposListScreen({super.key});

  @override
  State<ReposListScreen> createState() => _ReposListScreenState();
}

class _ReposListScreenState extends State<ReposListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://fotografiamais.com.br/wp-content/uploads/2018/11/composicao-de-imagem-galeria-1.jpg'),
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
                  Expanded(
                    child: Container(
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
                      width: 287,
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
              //todo criar Lista de Repositórios abaixo
              const RepoCardWidget(
                projectName: 'Nome do Projeto',
                codeLanguage: 'Linguagem',
                projectDescription: 'Descrição',
                lastModified: '2 dias atras',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
