

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TrazaEvent extends Equatable{
  const TrazaEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SaveOnServer extends TrazaEvent {
  final String localid;
  final String dni;
  final String date;

  const SaveOnServer({@required this.localid,@required this.dni,@required this.date});

  @override
  // TODO: implement props
  List<Object> get props => [localid,dni,date];

  @override
  String toString() => "Save on server {localid: $localid , dni: $dni , date: $date }";

}

class SaveOnLocal extends TrazaEvent {
  final String localid;
  final String dni;
  final String date;

  const SaveOnLocal({@required this.localid,@required this.dni,@required this.date});

  @override
  // TODO: implement props
  List<Object> get props => [localid,dni,date];

  @override
  String toString() => "Save on local {localid: $localid , dni: $dni , date: $date }";

}

