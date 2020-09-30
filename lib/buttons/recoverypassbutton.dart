import 'package:flutter/material.dart';
import 'package:trazacomer/respositories/user_repository.dart';
import 'package:trazacomer/screens/recovery_screem.dart';

class RecoveryPassButton extends StatelessWidget {

  final UserRepository _userRepository;

  RecoveryPassButton({Key key, @required UserRepository userRepository}):
      assert(userRepository != null),
  _userRepository = userRepository,
  super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Recuperar Contraseña'),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RecoveryScreen(userRepository: _userRepository,);
          })
        );
      },
    );
  }
}
