import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trazacomer/bloc/recoverypassbloc/bloc.dart';
import 'package:trazacomer/forms/recovery_form.dart';
import 'package:trazacomer/respositories/user_repository.dart';

class RecoveryScreen extends StatelessWidget {

  final UserRepository _userRepository;

  RecoveryScreen({Key key, @required UserRepository userRepository})
  : assert (userRepository != null),
  _userRepository = userRepository,
  super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recuperar Contraseña"),),
      body: Center(
        child: BlocProvider<RecoveryBloc>(
          create: (context) => RecoveryBloc(userRepository: _userRepository),

          child: RecoveryForm(userRepository: _userRepository,),
        ),
      ),
    );
  }
}