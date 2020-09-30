import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trazacomer/forms/login_form.dart';
import 'package:trazacomer/respositories/user_repository.dart';

import '../bloc/loginbloc/login_bloc.dart';

class LogginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LogginScreen({Key key, @required UserRepository userRepository})
  : assert(userRepository != null),
  _userRepository = userRepository,
  super(key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}
