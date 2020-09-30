import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trazacomer/bloc/recoverypassbloc/bloc.dart';
import 'package:trazacomer/respositories/user_repository.dart';
import 'package:trazacomer/screens/LoginScreen.dart';
class RecoveryForm extends StatefulWidget {
  final UserRepository _userRepository;

  RecoveryForm({Key key,@required UserRepository userRepository}):
        assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _RecoveryFormState createState() => _RecoveryFormState();
}

class _RecoveryFormState extends State<RecoveryForm> {
  final TextEditingController _emailController = TextEditingController();

  UserRepository get _userRepository => widget._userRepository;

  RecoveryBloc _recoveryBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recoveryBloc = BlocProvider.of<RecoveryBloc>(context);
    _emailController.addListener(_onEmailChanged);

  }
  bool get isPopulated => _emailController.text.isNotEmpty ;

  bool isRegisterButtonEnabled(RecoveryState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  void _onEmailChanged(){
    _recoveryBloc.add(EmailChanged(email: _emailController.text));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<RecoveryBloc,RecoveryState>(
      listener: (context,state){
         if(state.isSubmitting){
           Scaffold.of(context)
               ..hideCurrentSnackBar()
               ..showSnackBar(
                 SnackBar(
                   content: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Enviando confirmacion..."),
                       CircularProgressIndicator()
                     ],
                   ),
                 )
               );
         }
         if(state.isFailure){
           Scaffold.of(context)
             ..hideCurrentSnackBar()
             ..showSnackBar(
                 SnackBar(
                   content: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Recuperacion fallida"),
                       Icon(Icons.error)
                     ],
                   ),
                   backgroundColor: Colors.red,
                 )
             );
         }
         if(state.isSuccess){
           //BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());

           Navigator.of(context).pop();
           showDialog(
               context: context,
               builder: (context) => AlertDialog(
                 backgroundColor: Colors.yellow,
                 title: Text("Recuperada!"),
                 content: Text("Se ha enviado un email a ${_emailController.text} para recuperar su contraseña revise su casilla de correos"),
                 actions: [
                   FlatButton(
                     child: Text("OK"),
                     onPressed:(){
                       Navigator.of(context).pop();
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                         return LogginScreen(userRepository: _userRepository,);
                       }),(Route<dynamic> route) => false);
                       },
                   )
                 ],
               )
           );


         }
      },
      child: BlocBuilder<RecoveryBloc,RecoveryState>(
        builder: (context,state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: "Email"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid? "Email invalido" : null;
                    },
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    onPressed: _onFormSubmitted,
                    child: Text("Recuperar"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onFormSubmitted() {
    _recoveryBloc.add(
        Submitted(
          email: _emailController.text,
        ));
  }
}

