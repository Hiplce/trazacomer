

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trazacomer/confirmacion.dart';
import 'package:trazacomer/dniProvider.dart';
import 'package:trazacomer/listado.dart';
import 'package:trazacomer/login.dart';
import 'package:trazacomer/principal.dart';
import 'package:trazacomer/registro.dart';
import 'package:trazacomer/user_repository.dart';
import 'package:trazacomer/verificador.dart';
import 'manual.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserRepository userRepository = UserRepository();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(  create: (BuildContext context) => DniProvider())
      ],

      child: MaterialApp(

        title: 'Trazatic',
        initialRoute: "/",
        routes: {
          "/":(BuildContext context)=> Verificador(),
          "/principal":(BuildContext context)=> Principal(),
          "/registro":(BuildContext context)=> Registro(),
          "/confirm": (BuildContext context)=> Confirm(),
          "/listado": (BuildContext context)=> Listado(),
          "/login" : (BuildContext context)=> Login(),
          "/manual":(BuildContext context)=> Manual(),
        },
      ),
    );
  }




}
