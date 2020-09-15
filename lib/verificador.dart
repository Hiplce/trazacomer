import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trazacomer/LocalDAO.dart';
import 'package:trazacomer/principal.dart';
import 'package:trazacomer/serverController.dart';
import 'dniProvider.dart';
import 'login.dart';

class Verificador extends StatefulWidget {
  @override
  _VerificadorState createState() => _VerificadorState();
}

class _VerificadorState extends State<Verificador> {
  var locales;
  LocalDAO dao = LocalDAO();
  ServerController server = ServerController();
  String imei;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locales = ServerController.getEquipos();
    getIMEI();
  }

  getIMEI() async {
    String aux;

    aux = await DeviceId.getID;
    setState(() {
      imei = aux;
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: locales,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

              for(String s in snapshot.data) {
                if (s == imei) {
                  final dniInfo = Provider.of<DniProvider>(context);
                  dniInfo.getIdcom();
                  return Principal();
                }
              }
              return Login();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }


}