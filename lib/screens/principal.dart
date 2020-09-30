import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:trazacomer/Class_and_DAO/persona.dart';
import 'package:trazacomer/Class_and_DAO/personaDAO.dart';
import 'package:trazacomer/Class_and_DAO/trazabilidad.dart';
import 'package:trazacomer/Class_and_DAO/trazabilidadDAO.dart';
import 'package:trazacomer/bloc/authenticationbloc/authentication_bloc.dart';
import 'package:trazacomer/bloc/authenticationbloc/bloc.dart';
import 'package:trazacomer/bloc/trazabloc/bloc.dart';
import 'package:trazacomer/respositories/user_repository.dart';
import 'package:trazacomer/util/serverController.dart';
//import 'package:firebase_admob/firebase_admob.dart';
import 'package:trazacomer/respositories/traza_repository.dart';

const String testDevice = "ca-app-pub-9585135398111126~8791308404";

class Principal extends StatefulWidget {

  final UserRepository _userRepository;
  Principal( {Key key, @required UserRepository userRepository,})
      : assert ( userRepository != null),
        _userRepository = userRepository,
        super(key:key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  /*static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,

  );*/

 /* BannerAd _bannerAd;

  BannerAd createBanner(){
    return BannerAd(
      adUnitId: "ca-app-pub-9585135398111126/8216593335",
      size: AdSize.banner,

      listener: (MobileAdEvent event){
        print ("Banner $event");
      }
    );
  }*/
  String intro = "Bienvenido al Software de Trazabilidad Trazapoint";
  String nombre = "";
  String apellido = "";
  String dni = "";
  String datos = "";
  String fnac = "";
  PersonaDAO pDAO = PersonaDAO();
  TrazabilidadDAO tDAO = TrazabilidadDAO();
  var idequipo;
  UserRepository get _userRepository => widget._userRepository;
  TrazaRepository _trazaRepository = TrazaRepository();
@override
  void initState() {
    // TODO: implement initState
    //FirebaseAdMob.instance.initialize(appId: "ca-app-pub-9585135398111126~8791308404");
   // _bannerAd = createBanner()..load()..show();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //_bannerAd.dispose();
    super.dispose();
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      //El titulo de la aplicación
      title: 'Trazapoint',
      home: Scaffold(
        appBar: AppBar(
          // El texto que aparecerá en la barra superior
          title: Text('Trazapoint'),
          actions: <Widget>[
            /*Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Icon(
                    Icons.replay,
                    size: 26.0,
                  ),
                )
            ),*/
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  _userRepository.deleteFile();
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());

                }
            )
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
              Image.asset("assets/fty.png",height: 200,),
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
                } ,
              label: "Scanear DNI",
              labelStyle: TextStyle(fontWeight: FontWeight.w500),
            ),
            SpeedDialChild(
              child: Icon(Icons.add,color: Colors.blueAccent[200],),
              backgroundColor: Colors.white,
              onTap:() {
                _ingresoManual();
                },
              label: "Ingresar Manualmente",
              labelStyle: TextStyle(fontWeight: FontWeight.w500),
            ),
            SpeedDialChild(
              child: Icon(Icons.loop,color: Colors.blueAccent[200],),
              backgroundColor: Colors.white,
                onTap: () async {
                  try {
                    final result = await InternetAddress.lookup(
                        'google.com.ar');
                    print(result);
                    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                      List<String> res = await _trazaRepository.readTraza();
                      int asd = 0;

                      List<String> resu = await _userRepository.readClients();
                      print(resu);
                      for(String s in resu){
                        var splitting = s.split('|');
                        Future.delayed(const Duration(milliseconds: 500), () async {
                          print(s);
                          if (splitting[1] == null && splitting[1] != "") {
                            _userRepository.insertUserTraza(splitting[0], splitting[1], splitting[2], splitting[3], splitting[4], splitting[5]);
                          }
                        });
                      }
                      _userRepository.deleteFile();
                      for (String s in res) {
                        var splitting = s.split('|');
                        Future.delayed(
                            const Duration(milliseconds: 500), () async {
                          print("iteracion numero: \n");
                          print(asd);
                          print(s);
                          print("dni");
                          print(splitting[1]);
                          print("email");
                          print(splitting[0]);
                          print("hora");
                          print(splitting[2]);

                            _trazaRepository.insertTraza(
                                splitting[1], splitting[0], splitting[2]);

                        });
                        asd++;
                      }
                      _trazaRepository.deleteFile();
                      return showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                backgroundColor: Colors.green,
                                title: Text("Sincronizado!!"),
                                content: Text(
                                    "La sincronizacion fue realizada con exito"),
                                actions: [
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              )
                      );
                    }
                  }
                  catch (e) {
                    return showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              backgroundColor: Colors.red,
                              title: Text("No se realizo la sincronizacion!!"),
                              content: Text(
                                  "Chequee su conectividad para realizar la sincronizacion de manera segura"),
                              actions: [
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            )
                    );
                  }
                },

              label: "Sincronizar",
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
      String user = await _userRepository.getUser();
      bool vrify = await _userRepository.vrfyUser(user);
      if(vrify == false){
        throw UnverifiedException();
      }
      ScanResult res = await BarcodeScanner.scan();
      String qrResult = res.rawContent;
      print(qrResult);
      if(qrResult.contains('cipe')){
        var splitting = qrResult.split('=');
        print(splitting);
      }else {
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
      _verificarIngreso(context);

      }
    }on UnverifiedException{

      return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                backgroundColor: Colors.red,
                title: Text("Comercio no verificado!"),
                content: Text(
                    "Su comercio aun no fue autorizado. Contactese con el soporte de Trazapoint"),
                actions: [
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )
      );
    }

      catch (e){
      
    }

  }

  // ignore: missing_return
   _showRegistro(BuildContext context){

    //print(fnac);
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
     try {
       var conexion = await InternetAddress.lookup('google.com.ar');
       String resp = await ServerController.searchDNI(dni);
       print("vuelve paca");
       print(resp);
       bool respuesta = resp.toLowerCase() == "1";
       print("cambia a ");
       print(respuesta);
       if (respuesta == true) {
         print("entroaca");
         var asd = DateTime.now();
         String email = await _userRepository.getUser();
         _trazaRepository.insertTraza(dni, email,DateTime.now().toString().substring(0, 19));
         /*BlocProvider.of<TrazaBloc>(context).add(SaveOnServer(localid: email,
             dni: resp,
             date: DateTime.now().toString().substring(0, 19)));*/
         print("no sale por aca");
         _showConfirmDial(context);
       }
       else{
         _showRegistro(context);
       }
     }catch(e){
       _showRegistro(context);
     }

   }


  _ingresoManual() async{
    try {
      String user = await _userRepository.getUser();
      bool vrify = await _userRepository.vrfyUser(user);
      if(vrify == false){
        throw UnverifiedException();
      }
      Navigator.of(context).pushNamed("/manual");
    }
    on UnverifiedException{
      return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                backgroundColor: Colors.red,
                title: Text("Comercio no verificado!"),
                content: Text(
                    "Su comercio aun no fue autorizado. Contactese con el soporte de Trazapoint"),
                actions: [
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )
      );
    }
  }

}
class UnverifiedException implements Exception {
  final String menssage;
  const UnverifiedException([this.menssage = "email no verificado"]);
  @override
  String toString() => "UnverifiedException: $menssage";
}
