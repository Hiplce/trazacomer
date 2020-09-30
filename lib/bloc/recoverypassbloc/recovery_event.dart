import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RecoveryEvent extends Equatable {
  const RecoveryEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EmailChanged extends RecoveryEvent{
  final String email;

  const EmailChanged({@required this.email});

  @override
  // TODO: implement props
  List<Object> get props => [email];

  @override
  String toString() => "EmailCHanged {email: $email}";

}



class Submitted extends RecoveryEvent{
  final String email;


  const Submitted({@required this.email});

  @override
  // TODO: implement props
  List<Object> get props => [email];

  @override
  String toString() => "Submitted {email: $email}";

}

