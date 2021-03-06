import 'package:flutter/material.dart';
import './pages/home_page.dart';
import './pages/users_search/users_search_page.dart';
import './pages/user_profile/user_profile_page.dart';
import './pages/users_list/users_list_page.dart';
import './pages/user_repos/user_repos_page.dart';

import './controllers/app_controller.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'App github',
          theme: ThemeData(
            primarySwatch:
                AppController.instance.isDarkTheme ? Colors.blue : Colors.red,
            brightness: AppController.instance.isDarkTheme
                ? Brightness.dark
                : Brightness.light,
          ),
          routes: {
            '/': (BuildContext context) => const HomePage(),
            '/search': (BuildContext context) => const UsersSearchPage(),
            '/userProfile': (BuildContext context) => const UserProfilePage(),
            '/usersList': (BuildContext context) => const UserListPage(),
            '/userRepos': (BuildContext context) => const UserReposPage(),
          },
        );
      },
    );
  }
}
