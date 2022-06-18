import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';


class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {
    'id': '',
    'name': '',
    'telefone': '',
    'email': '',
    'empresa': '',
    'observacoes': '',
    'avatarUrl': '',
  };

  void _loadFormData(User user) {
    // ignore: unnecessary_null_comparison
    if(user != null) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['telefone'] = user.telefone;
    _formData['email'] = user.email;
    _formData['empresa'] = user.empresa;
    _formData['observacoes'] = user.observacoes;
    _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = ModalRoute.of(context)!.settings.arguments as User;
    _loadFormData(user);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Formulário de Usuários'),
        actions: <Widget>[
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState?.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id']!,
                    name: _formData['name']!,
                    telefone: _formData['telefone']!,
                    email: _formData['email']!,
                    empresa: _formData['empresa']!,
                    observacoes: _formData['observacoes']!,
                    avatarUrl: _formData['avatarUrl']!,
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                // ignore: prefer_const_constructors
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome inválido';
                  }

                  if (value.trim().length < 3) {
                    return 'Nome muito pequeno. No mínimo 3 letras.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: _formData['telefone'],

                // ignore: prefer_const_constructors
                decoration: InputDecoration(labelText: 'Telefone'),
                onSaved: (value) => _formData['telefone'] = value!,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Telefone obrigatório';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['email'],
                // ignore: prefer_const_constructors
                decoration: InputDecoration(labelText: 'E-mail'),
                onSaved: (value) => _formData['email'] = value!,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'E-mail obrigatório';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['empresa'],
                // ignore: prefer_const_constructors
                decoration: InputDecoration(labelText: 'Empresa'),
                onSaved: (value) => _formData['empresa'] = value!,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Empresa obrigatório';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['observacoes'],
                // ignore: prefer_const_constructors
                decoration: InputDecoration(labelText: 'Obeservações'),
                onSaved: (value) => _formData['observacoes'] = value!,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Observações obrigatório';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                // ignore: prefer_const_constructors
                decoration: InputDecoration(labelText: 'Url do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value!,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Url do Avatar é obrigatório';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
