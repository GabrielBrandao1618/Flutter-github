import 'package:flutter/material.dart';
import 'package:projeto_github/src/components/load_screen.dart';
import 'package:projeto_github/src/pages/users_list/users_list_page.dart';
import './user_profile_args.dart';

import '../../controllers/user_profile_controller.dart';

import '../users_list/users_list_args.dart';
import '../user_repos/user_repos_args.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  var controller = UserProfileController();
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as UserProfileArgs;
    var username = args.username;

    controller.start(username);

    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: AnimatedBuilder(
        animation: controller.userInfo,
        builder: (BuildContext context, Widget? child) {
          var user = controller.userInfo.value;
          if (user.username.isEmpty) {
            return const LoadScreen();
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(user.avatarUrl),
                  Text(
                    user.username,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text('Id: ${user.id}'),
                  TextButton(
                    child: Text('Repositórios públicos: ${user.publicRepos}'),
                    onPressed: () => Navigator.of(context).pushNamed(
                        '/userRepos',
                        arguments: UserReposArgs(username: username)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/usersList',
                            arguments: UsersListArgs(
                              title: 'Seguidores',
                              sourceRoute: 'users/$username/followers',
                            ),
                          );
                        },
                        child: Text('Seguidores: ${user.followers}'),
                      ),
                      Container(width: 4),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/usersList',
                            arguments: UsersListArgs(
                              title: 'Seguindo',
                              sourceRoute: 'users/$username/following',
                            ),
                          );
                        },
                        child: Text('Seguindo: ${user.following}'),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  Text(
                    user.bio ?? 'Sem bio inserida',
                    textAlign: TextAlign.center,
                  ),
                  Container(height: 5),
                  Text(
                      'Criado em ${user.createdAt!.day}/${user.createdAt!.month}/${user.createdAt!.year}'),
                  Text(
                      'Atualizado em ${user.updatedAt!.day}/${user.updatedAt!.month}/${user.updatedAt!.year}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
