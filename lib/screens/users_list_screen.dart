import 'package:flutter/material.dart';
import 'package:gok_mobile_test/screens/search_screen.dart';

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
    return Container();
  }
}
