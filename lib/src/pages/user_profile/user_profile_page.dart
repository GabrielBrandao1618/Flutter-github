import 'package:flutter/material.dart';
import './user_profile_args.dart';

import '../../controllers/user_profile_controller.dart';

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
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(user.avatarUrl),
                Text(
                  user.username,
                  style: const TextStyle(fontSize: 20),
                ),
                Text('Id: ${user.id}'),
                Text('Repositórios públicos: ${user.publicRepos}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Seguidores: ${user.followers}'),
                    Container(width: 4),
                    Text('Seguindo: ${user.following}'),
                  ],
                ),
                Container(height: 5),
                Text(
                  user.bio ?? 'Sem bio inserida',
                  textAlign: TextAlign.center,
                ),
                Container(height: 5),
                Text(
                    'Criado em ${user.createdAt!.day}/${user.createdAt!.month}/${user.createdAt!.day}'),
                Text(
                    'Atualizado em ${user.updatedAt!.day}/${user.updatedAt!.month}/${user.updatedAt!.day}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
