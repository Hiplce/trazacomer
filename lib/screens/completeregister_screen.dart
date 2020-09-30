import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trazacomer/bloc/dataregisterbloc/bloc.dart';
import 'package:trazacomer/forms/completeregister_form.dart';
import 'package:trazacomer/respositories/user_repository.dart';

class CompleteRegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final String _email;
  final String _password;
  final String _name;
  final String _lastname;
  final String _dni;

  CompleteRegisterScreen({Key key,@required UserRepository userRepository,@required String email,@required String password, @required String name, @required String lastname,@required String dni})
  :assert (userRepository != null),
   assert (name != null),
   assert (lastname != null),
   assert (dni != null),
   assert (email != null),
   assert (password != null),
  _userRepository = userRepository,
  _name = name,
  _lastname = lastname,
  _dni = dni,
  _email = email,
  _password = password,
  super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completar Registro"),
      ),
      body: Center(
        child: BlocProvider(
          create: (context) => DataRegisterBloc(userRepository: _userRepository),
          child: CompleteRegisterForm(nombre: _name,apellido: _lastname,dni: _dni,email: _email,password: _password,),
        ),
      ),
    );
  }
}
