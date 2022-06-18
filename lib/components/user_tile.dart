// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  // ignore: use_key_in_widget_constructors
  const UserTile(this.user);
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        // ignore: prefer_const_constructors
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),

      // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              // ignore: prefer_const_constructors
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
            ),
            IconButton(
              // ignore: prefer_const_constructors
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    // ignore: prefer_const_constructors
                    title: Text('Excluir Usuário'),
                    // ignore: prefer_const_constructors
                    content: Text('Tem Certeza?'),
                    actions: <Widget>[
                      FlatButton(
                        // ignore: prefer_const_constructors
                        child: Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      FlatButton(
                        // ignore: prefer_const_constructors
                        child: Text('Sim'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed) {
                    Provider.of<Users>(context, listen: false).remove(user);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
