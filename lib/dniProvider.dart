

import 'package:flutter/material.dart';
import 'package:trazacomer/LocalDAO.dart';
import 'package:trazacomer/local.dart';
import 'package:trazacomer/persona.dart';
import 'package:trazacomer/personaDAO.dart';
import 'package:trazacomer/serverController.dart';

class DniProvider with ChangeNotifier{
  List<String> _dnis = [];
  String _idequipo;

  /*DniProvider(){
    this._dnis = ServerController.getPersonas();
  }*/


  fetchDNI() async{
    try{
      final response = ServerController.getPersonas();
      for(String s in response){
        _dnis.add(s);
      }
    }
    catch(e){
      print("no pudimo");
    }
  }
  getIdcom() async{
    LocalDAO dao = LocalDAO();
    Local l = await dao.getT();
    _idequipo = l.local_imei;
  }
  fetchDNIlite() async{
    try{
      PersonaDAO pdao = PersonaDAO();
      var personas = await pdao.getP();
      print(_dnis);
      _dnis = [];
      for(Persona p  in personas){

        _dnis.add(p.dni);
        print(_dnis);
      }

    }
    catch(e){
      print("no pudimo");
      print(e);
    }
  }

  get idequipo {
    return this._idequipo;
  }
  set idequipo(String a ) {
    this._idequipo = a;
    notifyListeners();
  }
  get dnis {
    return this._dnis;
  }
  set dnis(String dni) {
    _dnis.add(dni);
    notifyListeners();
  }

}