import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
// ignore: unused_import
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Lista de Usuários'),
        actions: <Widget>[
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.add),
            onPressed: () {
              // ignore: prefer_const_constructors
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
