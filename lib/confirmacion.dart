import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trazacomer/personaDAO.dart';
import 'package:trazacomer/serverController.dart';
import 'package:trazacomer/trazabilidadDAO.dart';
import 'persona.dart';
import 'trazabilidad.dart';
import 'package:provider/provider.dart';
import 'dniProvider.dart';

class Confirm extends StatefulWidget {

  const Confirm({Key key}) : super(key:key);
  @override
  _ConfirmState createState() => _ConfirmState();
}


class _ConfirmState extends State<Confirm> {

  @override
  Widget build(BuildContext context) {
    Persona p = ModalRoute.of(context).settings.arguments;
    final dniInfo = Provider.of<DniProvider>(context);
    PersonaDAO pDAO = PersonaDAO();
    TrazabilidadDAO tDAO = TrazabilidadDAO();
    var idequipo;

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
                ,style: TextStyle(fontSize: 22,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),

            ),

            Container(
              alignment: Alignment.center,
              child:
              RaisedButton(
                  onPressed: () {
                    ServerController server = ServerController();
                    dniInfo.getIdcom();
                    idequipo = dniInfo.idequipo;
                    print("cuando lo tomo de otro lado");
                    print(idequipo);
                    server.insertPersona(idequipo, p.nombre,p.apellido,p.dni, p.domicilio,p.telefono,p.localidad);
                    server.insertTraza(idequipo, p.dni, DateTime.now().toString());
                    pDAO.insertP(p);
                    tDAO.insertT(Trazabilidad(idCliente: idequipo,dni: p.dni,fecha: DateTime.now().toString()));
                    setState(() {
                      _showAlert(context);
                    });
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
  void _showAlert(BuildContext context) {
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

  }



