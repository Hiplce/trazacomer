

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trazacomer/bloc/simplebloc_delegate.dart';
import 'package:trazacomer/respositories/user_repository.dart';
import 'package:trazacomer/screens/LoginScreen.dart';
import 'package:trazacomer/screens/confirmacion.dart';
import 'package:trazacomer/screens/principal.dart';
import 'package:trazacomer/screens/registro_personatraza.dart';
import 'package:trazacomer/screens/splash_screen.dart';
import 'bloc/authenticationbloc/bloc.dart';
import 'screens/manual.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AuthenticationBlocDelegate();
  await Firebase.initializeApp();
  UserRepository userRepository = UserRepository();
  runApp(BlocProvider(
    create: (context) => AuthenticationBloc(userRepository: userRepository)
      ..add(AppStarted()),
    child: MyApp(userRepository : userRepository),
  ));
}
class MyApp extends StatefulWidget {
  final UserRepository _userRepository;

  MyApp( {Key key, @required UserRepository userRepository,})
      : assert ( userRepository != null),
        _userRepository = userRepository,
        super(key:key);
  @override
  _MyAppState createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {

  UserRepository get _userRepository => widget._userRepository;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        title: 'Trazapoint',
        home: BlocBuilder<AuthenticationBloc,AuthenticationState>(
          builder:  (context,state){

            if(state is Uninitialized){
              return SplashScreen();
            }
            if(state is Authenticated){

              return Principal(userRepository: _userRepository,);
            }
            if(state is Unauthenticated){
              return LogginScreen(userRepository: _userRepository,);
            }
            return Container();
          },

        ),
        //initialRoute: "/",
        routes: {
          "/principal":(BuildContext context)=> Principal(userRepository: _userRepository,),
          "/registro":(BuildContext context)=> Registro(),
          "/confirm": (BuildContext context)=> Confirm(),
          "/manual":(BuildContext context)=> Manual(),
        },
      );
  }




}
