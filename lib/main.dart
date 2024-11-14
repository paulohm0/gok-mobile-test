import 'package:flutter/material.dart';
import 'package:gok_mobile_test/screens/repos_list_screen.dart';
import 'package:gok_mobile_test/screens/search_screen.dart';
import 'package:gok_mobile_test/screens/users_list_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gok Mobile Test',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/repos_list_screen',
      routes: {
        '/search_screen': (context) => const SearchScreen(),
        '/user_list_screen': (context) => const UsersListScreen(),
        '/repos_list_screen': (context) => const ReposListScreen(),
      },
    );
  }
}
