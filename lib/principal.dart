import 'package:device_id/device_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:trazacomer/dniProvider.dart';
import 'package:trazacomer/personaDAO.dart';
import 'package:trazacomer/serverController.dart';
import 'package:trazacomer/trazabilidadDAO.dart';
import 'persona.dart';
import 'trazabilidad.dart';
import 'package:provider/provider.dart';


class Principal extends StatefulWidget {

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

  String intro = "Bienvenido al Software de Trazabilidad Trazapoint";
  String nombre = "";
  String apellido = "";
  String dni = "";
  String datos = "";
  String fnac = "";
  PersonaDAO pDAO = PersonaDAO();
  TrazabilidadDAO tDAO = TrazabilidadDAO();
  var idequipo;


  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dniInfo = Provider.of<DniProvider>(context);

    return MaterialApp(
      //El titulo de la aplicación
      title: 'Trazapoint',
      home: Scaffold(
        appBar: AppBar(
          // El texto que aparecerá en la barra superior
          title: Text('Trazapoint'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    ServerController.getPersonas();
                  },
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )
            ),
          ],

        ),
        body: Container(
          /*decoration: BoxDecoration(
            gradient:  LinearGradient(
                colors: [Colors.green[800],
                  Colors.green[600],
                  Colors.green[400]]
            ),
          ),*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/trazapoint.jpg",height: 200,),
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child:
                Text(intro,textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold), ),
              ),

            ],
          ),
        ),

        floatingActionButton: SpeedDial(
          marginBottom: 45,
          marginRight: 40,
          animatedIcon:  AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22),
          visible: true,
          curve: Curves.bounceIn,
          children: [
            SpeedDialChild(
              child: Icon(Icons.camera_alt,color: Colors.green[400],),
              backgroundColor: Colors.white,
              onTap:() {
                _scanQR();
                dniInfo.fetchDNIlite();
                var asd = dniInfo.dnis;
                print("ahora desde principal");
                print(asd);
                idequipo = dniInfo.idequipo;
                } ,
              label: "Scanear DNI",
              labelStyle: TextStyle(fontWeight: FontWeight.w500),
            ),
            SpeedDialChild(
              child: Icon(Icons.add,color: Colors.blueAccent[200],),
              backgroundColor: Colors.white,
              onTap:() {
                dniInfo.getIdcom();
                idequipo = dniInfo.idequipo;
                _ingresoManual();
                },
              label: "Ingresar Manualmente",
              labelStyle: TextStyle(fontWeight: FontWeight.w500),
            )

        ],


        ),

        /*Container(
          height: 70,
          width: 160,
          margin: const EdgeInsets.only(bottom: 30),
          child: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt),
            label: Text('Scan'),
            onPressed: _scanQR,
          ),
        ),*/
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        //drawer: _getDrawer(context),

      ),
    );
  }


  bool isNumeric(String str) {
    try{
      int value = int.parse(str);
      //print(value);
      return true;
    } catch(e) {
      return false;
    } /*finally {
      // ignore: control_flow_in_finally
      return true;
    }*/
  }

  Future _scanQR() async{

    try {
      ScanResult res = await BarcodeScanner.scan();
      String qrResult = res.rawContent;
      var aux = qrResult.split('@');
      //print(aux);
      var algo = isNumeric(aux[1]);
      //print(algo);
      if (!isNumeric(aux[1])) {
        datos = "Apellido: " + aux[1] + "\n" +
            "Nombre: " + aux[2] + "\n" +
            "Documento: " + aux[4] + "\n";
        nombre = aux[2];
        apellido = aux[1];
        dni = aux[4];
        fnac = aux[6];
      }
      else {
        datos = "Apellido: " + aux[4] + "\n" +
            "Nombre: " + aux[5] + "\n" +
            "Documento: " + aux[1] + "\n";
        nombre = aux[5];
        apellido = aux[4];
        dni = aux[1];
        fnac = aux[7];
      }
      idequipo = await DeviceId.getID;
      _verificarIngreso(context);

    }


      /*setState(() {
        intro = datos;
      });*/

 /*   }on PlatformException catch(e){
      if(e.code == BarcodeScanner.cameraAccessDenied){
        setState(() {
          intro = "Permiso de camara denegado";
        });

      }
      else{
        setState(() {
          intro = "Error desconocido ";
        });
      }
    } on FormatException{
      setState(() {
        intro = " Presiono volver atras antes del Scaneo";
      });
    }*/
      catch (e){
      
    }

  }

  /*Widget _getDrawer(BuildContext contex){
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.cyan),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlutterLogo(size: 50,),
                Text("Aplicacion de Trazabilidad")
              ],
            ),
          ),
          ListTile(
            title: Text("Registro de Personas"),
            leading: Icon(Icons.assignment_ind),
            onTap: ()=> showPersons(context) ,
          ),

        ],
      ),

    );
  }*/
 /* void showPersons(BuildContext context){
    setState(() {
      Navigator.pop(context);
    });
    Navigator.of(context).pushNamed("/listado");

  }*/
  // ignore: missing_return
   _showRegistro(BuildContext context){

    print(fnac);
    Navigator.of(context).pushNamed("/registro",arguments: Persona(nombre: nombre,apellido: apellido,dni: dni));
  }

   _showConfirmDial(BuildContext context) {
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

               },
             )
           ],
         )
     );
   }

   void _verificarIngreso(BuildContext context) async {
     //Persona veri = await pDAO.getPersonWithDNI(dni);
     ServerController server = ServerController();
     List<String> lista = await ServerController.getPersonas();
     //if(veri != null && dni == veri.dni ){
     bool encontro = false;
     for (String s in lista) {
       if (s == dni) {
         var asd = DateTime.now();
         print("normal");
         print(asd.toString());
         print("ISO");
         print(asd.toIso8601String());
         print("recortada");
         print(asd.toString().substring(0, 19));
         print("id del equipo que nose como sale");
         print(idequipo);
         server.insertTraza(idequipo, dni, asd.toString());
         tDAO.insertT(Trazabilidad(idCliente: idequipo,
             dni: dni,
             fecha: DateTime.now().toString().substring(0, 19)));
         //print("metimo");
         _showConfirmDial(context);
         encontro = true;
       }
     }
     if(encontro == false) {
       _showRegistro(context);
     }
   }


  _ingresoManual() {

    Navigator.of(context).pushReplacementNamed("/manual");
  }

}
