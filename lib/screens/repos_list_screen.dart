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
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    height: 40,
                    width: 287,
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    width: 48,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ],
              ),
            ),
            //todo criar Lista de Repositórios abaixo
            const RepoCardWidget(),
          ],
        ),
      ),
    );
  }
}
