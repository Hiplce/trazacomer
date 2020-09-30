import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent{
  final String email;

  const EmailChanged({@required this.email});

  @override
  // TODO: implement props
  List<Object> get props => [email];

  @override
  String toString() => "EmailCHanged {email: $email}";

}

class PasswordChanged extends LoginEvent {
  final password;

  const PasswordChanged({@required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [password];

  @override
  String toString() => "PasswordCHanged {password: $password}";

}

class Submitted extends LoginEvent{
  final String email;
  final String password;

  const Submitted({@required this.email, @required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email,password];

  @override
  String toString() => "Submitted {email: $email, password: $password}";

}

class LogginWhithCreddentialsPressed extends LoginEvent {

  final String email;
  final String password;

  const LogginWhithCreddentialsPressed({@required this.email, @required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email,password];

  @override
  String toString() => "Submitted {email: $email, password: $password}";

}