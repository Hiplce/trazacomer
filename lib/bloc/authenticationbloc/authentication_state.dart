import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable{
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState{
 @override
  String toString() =>    "No Autenticado";


}

class Authenticated extends AuthenticationState{
  final String displayName;

  const Authenticated(this.displayName);
  @override
  // TODO: implement props
  List<Object> get props => [displayName];

  @override
  String toString() => "Autenticado - Nombre: $displayName";
}
class Unauthenticated extends AuthenticationState{
  @override
  String toString() => "No Autenticado";
}