import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trazacomer/Class_and_DAO/persona.dart';
import 'package:trazacomer/Class_and_DAO/personaDAO.dart';
import 'package:trazacomer/Class_and_DAO/trazabilidad.dart';
import 'package:trazacomer/Class_and_DAO/trazabilidadDAO.dart';
import 'package:trazacomer/respositories/traza_repository.dart';
import 'package:trazacomer/respositories/user_repository.dart';
import 'package:trazacomer/util/serverController.dart';

class Confirm extends StatefulWidget {

  const Confirm({Key key}) : super(key:key);
  @override
  _ConfirmState createState() => _ConfirmState();
}


class _ConfirmState extends State<Confirm> {

  @override
  Widget build(BuildContext context) {
    Persona p = ModalRoute.of(context).settings.arguments;
    PersonaDAO pDAO = PersonaDAO();
    TrazabilidadDAO tDAO = TrazabilidadDAO();
    UserRepository _userRepository = UserRepository();
    TrazaRepository _trazaRepository = TrazaRepository();
    var idequipo;
    double h = MediaQuery.of(context).textScaleFactor;
    var asd = MediaQuery.of(context).size.height;
    var asd2 = MediaQuery.of(context).size.width;
    print(asd);
    print(asd2);
    print(h);
    double tam;
    if(h<1){
      tam = h*50;
    }
    if(h==1){
      tam = h*30;
    }
    if(h>1){
      tam = h*16;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Confirmacion"),),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,


          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child:
              Text("Nombre: " + p.nombre + "\n"
                  +"Apellido: " + p.apellido + "\n"
                  +"DNI: " + p.dni + "\n"
                  +"Domicilio: " + p.domicilio + "\n"
                  +"Localidad: " + p.localidad + "\n"
                  +"Telefono: " + p.telefono
                ,style: TextStyle(fontSize: tam,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),

            ),

            Container(
              alignment: Alignment.center,
              child:
              RaisedButton(
                  onPressed: ()  async {
                    
                    try{
                      var conexion = await InternetAddress.lookup('google.com.ar');
                      String email = await _userRepository.getUser();
                      _trazaRepository.insertTraza(p.dni, email, DateTime.now().toString().substring(0, 19));
                      _userRepository.insertUserTraza( p.nombre, p.apellido, p.dni, p.localidad, p.domicilio, p.telefono);
                      _showConfirmAlert(context);
                    }
                    catch(e){
                      try {
                        String email = await _userRepository.readUser();
                        _userRepository.insertUserTrazaLocal(p.nombre, p.apellido, p.dni, p.localidad, p.domicilio, p.telefono);
                        String counter = email + "|" + p.dni + "|" + DateTime.now().toString().substring(0, 19);
                        _trazaRepository.writeTraza(counter);
                        _showLocalAlert(context);
                      }
                      catch(e){
                        _showErrorAlert(context);
                      }
                    }

                  },
                  child: Text("Confirmar"),
                ),
            )
          ],
          /* */
        ),
      ),

    );
  }

  void _goToMainAndSave(BuildContext context) {

    Navigator.of(context).pushNamedAndRemoveUntil("/principal",(Route <dynamic> route ) => false);
  }
  void _showConfirmAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: Text("Confirmado!"),
          content: Text("El Ingreso/Egreso fue confirmado!"),
          actions: <Widget>[
            FlatButton(
              child:
              Text("OK"),
              onPressed:(){
                Navigator.of(context).pop();
                _goToMainAndSave(context);
                },
            )
          ],
        )
    );
  }
  void _showLocalAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.yellow,
          title: Text("En el dispositivo!"),
          content: Text("La trazabilidad y datos del cliente estan guardados en el dispositivo, por favor sincronice cuando tenga internet"),
          actions: <Widget>[
            FlatButton(
              child:
              Text("OK"),
              onPressed:(){
                Navigator.of(context).pop();
                _goToMainAndSave(context);
              },
            )
          ],
        )
    );
  }
  void _showErrorAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.red,
          title: Text("Error!"),
          content: Text("No se pudo registrar los datos por favor intente nuevamente"),
          actions: <Widget>[
            FlatButton(
              child:
              Text("OK"),
              onPressed:(){
                Navigator.of(context).pop();
                _goToMainAndSave(context);
              },
            )
          ],
        )
    );
  }

  }



