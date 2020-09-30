import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trazacomer/bloc/registerbloc/bloc.dart';
import 'package:trazacomer/forms/registe_form.dart';
import 'package:trazacomer/respositories/user_repository.dart';

class RegisterScreen extends StatelessWidget {

  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
  : assert (userRepository != null),
  _userRepository = userRepository,
  super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro"),),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),

          child: RegisterForm(userRepository: _userRepository,),
        ),
      ),
    );
  }
}