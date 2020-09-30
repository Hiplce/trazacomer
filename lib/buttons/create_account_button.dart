import 'package:flutter/material.dart';
import 'package:trazacomer/respositories/user_repository.dart';
import 'package:trazacomer/screens/register_screen.dart';

class CreateAcountButton extends StatelessWidget {

  final UserRepository _userRepository;

  CreateAcountButton({Key key, @required UserRepository userRepository}):
      assert(userRepository != null),
  _userRepository = userRepository,
  super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Crear una cuenta'),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(userRepository: _userRepository,);
          })
        );
      },
    );
  }
}
