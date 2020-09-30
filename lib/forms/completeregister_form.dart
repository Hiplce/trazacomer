import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trazacomer/bloc/authenticationbloc/authentication_bloc.dart';
import 'package:trazacomer/bloc/authenticationbloc/bloc.dart';
import 'package:trazacomer/bloc/dataregisterbloc/bloc.dart';
import 'package:trazacomer/respositories/user_repository.dart';
import 'package:trazacomer/screens/principal.dart';

class CompleteRegisterForm extends StatefulWidget {

  final String _nombre;
  final String _apellido;
  final String _dni;
  final String _email;
  final String _password;


  CompleteRegisterForm({Key key,@required String nombre,@required String email,@required String password, @required String apellido,@required String dni}):
        assert(nombre != null),
        assert(apellido != null),
        assert(dni != null),
        assert(email != null),
        assert(password != null),
        _nombre = nombre,
        _apellido = apellido,
        _dni = dni,
        _email = email,
        _password = password,
        super(key: key);
  @override
  _CompleteRegisterFormState createState() => _CompleteRegisterFormState();
}

class _CompleteRegisterFormState extends State<CompleteRegisterForm> {
  final TextEditingController _comercioController = TextEditingController();
  final TextEditingController _cuitController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _provinciaController = TextEditingController();

  String get _nombre => widget._nombre;
  String get _apellido => widget._apellido;
  String get _dni => widget._dni;
  String get _email => widget._email;
  String get _password => widget._password;
  //UserRepository get _userRepository => widget._userRepository;
  UserRepository _userRepository = UserRepository();

  DataRegisterBloc _dataRegisterBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataRegisterBloc = BlocProvider.of<DataRegisterBloc>(context);
    _phoneController.addListener(_onPhoneChanged);

  }

  bool isRegisterButtonEnabled(DataRegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  void _onPhoneChanged(){
    _dataRegisterBloc.add(PhoneChanged(phone: _phoneController.text));
  }

  bool get isPopulated => _provinciaController.text.isNotEmpty && _direccionController.text.isNotEmpty && _locationController.text.isNotEmpty && _cuitController.text.isNotEmpty &&_comercioController.text.isNotEmpty &&  _phoneController.text.isNotEmpty;

  @override
  void dispose() {
    // TODO: implement dispose
    _cuitController.dispose();
    _direccionController.dispose();
    _comercioController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _provinciaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocListener<DataRegisterBloc,DataRegisterState>(
          listener: (context,state){
            if(state.isSubmitting){
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Registering"),
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
                          Text("Register Failure"),
                          Icon(Icons.error)
                        ],
                      ),
                      backgroundColor: Colors.red,
                    )
                );
            }
            if(state.isSuccess){
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
              return Principal(userRepository: _userRepository,);}),
              (route) => false);

            }
          },
          child: BlocBuilder<DataRegisterBloc,DataRegisterState>(
            builder: (context,state) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  child: ListView(
                    children: [
                      Container(
                        child: Text("Nombre: " + _nombre + "\n"+"Apellido: "+ _apellido + "\n" + "DNI: " + _dni,style: TextStyle(fontSize: 24,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                      ),
                      TextFormField(
                        controller: _comercioController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.domain),
                            labelText: "Nombre del comercio"
                        ),
                        keyboardType: TextInputType.text,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isLocationValid? "Nombre Invalido" : null;
                        },
                      ),
                      TextFormField(
                        controller: _cuitController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.card_travel),
                            labelText: "CUIT de comercio(sin guiones)"
                        ),
                        keyboardType: TextInputType.number,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isLocationValid? "CUIT Invalido" : null;
                        },
                      ),
                      TextFormField(
                        controller: _direccionController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.business),
                            labelText: "Direccion"
                        ),

                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isDirectionValid? "Direccion Invalida" : null;
                        },
                      ),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.location_city),
                            labelText: "Localidad"
                        ),

                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isDirectionValid? "Direccion Invalida" : null;
                        },
                      ),
                      TextFormField(
                        controller: _provinciaController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.map),
                            labelText: "Provincia"
                        ),

                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isDirectionValid? "Direccion Invalida" : null;
                        },
                      ),

                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.phone),
                            labelText: "Telefono"
                        ),
                        keyboardType: TextInputType.number,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isPhoneValid? "Telefono Invalida" : null;
                        },
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                          ),
                        onPressed: isRegisterButtonEnabled(state) ? _onFormSubmitt : null,
                        child: Text("Register"),
                      )

                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );

  }

  void _onFormSubmitt() {
    print("nombre comercio");
    print(_comercioController.text);

    print("cuit");
    print(_cuitController.text);

    print("direccion comercio");
    print(_direccionController.text);

    print("localidad comercio");
    print(_locationController.text);

    print("provincia comercio");
    print(_provinciaController.text);
    _dataRegisterBloc.add(Submitted(
      email: _email,
      password: _password,
      comername: _comercioController.text,
      name: _nombre,
      lastname: _apellido,
      dni: _dni,
      location: _locationController.text,
      direction: _direccionController.text,
      provincia: _provinciaController.text,
      phone: _phoneController.text,
      cuit: _cuitController.text
    ));
  }
}
