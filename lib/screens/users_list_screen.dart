import 'package:flutter/material.dart';
import 'package:gok_mobile_test/screens/search_screen.dart';
import 'package:gok_mobile_test/widgets/user_card_widget.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({
    super.key,
  });

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late UserListArgs userListArgs;

  @override
  Widget build(BuildContext context) {
    userListArgs = ModalRoute.of(context)!.settings.arguments as UserListArgs;
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Spacer(),
          Image.asset(
            'assets/github-logo.png',
          ),
          const Spacer(),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.06),
        child: Column(
          children: [
            UserCardWidget(
              username: userListArgs.userGithubModel.name ??
                  userListArgs.userGithubModel.login,
              image: userListArgs.userGithubModel.avatarUrl,
              company: userListArgs.userGithubModel.company,
              followers: userListArgs.userGithubModel.followers,
              following: userListArgs.userGithubModel.following,
              handle: userListArgs.userGithubModel.login,
              location: userListArgs.userGithubModel.location,
            ),
          ],
        ),
      ),
    );
  }
}
