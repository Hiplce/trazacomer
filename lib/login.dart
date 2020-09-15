


import 'package:device_id/device_id.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trazacomer/LocalDAO.dart';
import 'package:trazacomer/dniProvider.dart';
import 'package:trazacomer/local.dart';
import 'package:trazacomer/serverController.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var intro;
  var imei;
  TelephonyInfo _info;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTelephonyInfo();
    getIMEI();
  }
  getIMEI() async {
    String aux;

    aux = await DeviceId.getID;
    imei = aux;

    print("el id");

    print(imei);
   /* setState(() {
      print(aux);
      imei = aux;
    });*/
  }
  Future<void> getTelephonyInfo() async{
    TelephonyInfo info;
    try{

      info = await FltTelephonyInfo.info;
      _info = info;
    } catch(e) {

    }
  }
  @override
  Widget build(BuildContext context) {
    final dniInfo = Provider.of<DniProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio de sesion"),

      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 60,horizontal: 10),
            decoration: BoxDecoration(
                  gradient:  LinearGradient(

                      colors: [Colors.green[800],
                        Colors.green[600],
                        Colors.green[400]]
                  ),
            ),
            //child: Image.asset("assets/trazapoint.jpg",height: 200,),
          ),
          Transform.translate(
            offset: Offset(0,-20),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  margin: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 30),
                    child: Column(

                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        Text("Scanee el codigo QR provisto",style: TextStyle(
                          fontSize: 24,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 20,),
                        RaisedButton(
                          textColor: Colors.white,
                          color: Colors.green[600],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onPressed: (){


                            print("no te estoy pasando boludeces");
                            print(imei);
                            dniInfo.idequipo = imei;
                            print("id del provider");
                            print(dniInfo.idequipo);
                            dniInfo.fetchDNIlite();
                            _scanQR();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.camera_alt),
                              SizedBox(width: 20,),
                              Text("Iniciar Sesion"),

                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _scanQR() async{

    try {
      ScanResult res = await BarcodeScanner.scan();
      String qrResult = res.rawContent;
      ServerController server = ServerController();
      //print("lo que lee el qr");
      //print(qrResult);
      LocalDAO dao = LocalDAO();

      //
      //dniInfo.idequipo = imei;
      print("el id del equipo por provider");
      //print(dniInfo.idequipo);
      Local l = Local(local_id: qrResult,local_imei: imei);
      server.updateLocal(qrResult, imei);
      dao.insertT(l);



      //String imei = await DeviceId.getIMEI;

      //print(aux);


    }on PlatformException catch(e){
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
    }catch (e){
      setState(() {
        intro = "Error desconocido ";
      });
    }
    Navigator.of(context).pushReplacementNamed("/principal");
  }
}
