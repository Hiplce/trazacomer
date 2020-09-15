import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'persona.dart';

class Registro extends StatefulWidget {

  const Registro({Key key}) : super(key:key);
  @override
  _RegistroState createState() => _RegistroState();
}


class _RegistroState extends State<Registro> {


  TextEditingController inputcontroll ;
  TextEditingController inputcontroll2 ;
  TextEditingController inputcontroll3;
  String nombre = "";
  String apellido = "";
  String dni = "";
  String domicilio= "";
  String telefono = "";
  String localidad;
  MediaQueryData queryData;



  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of((context));

    Persona p = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Registro"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(

                child: Container(

                  child: inputs(p),
                ),
              ),


            ],
           /* */
          ),
        ),
      ),

    );

  }

  Widget inputs(Persona p){


    return Container(
      margin: EdgeInsets.all(5),
      alignment: Alignment.center,
      child: Form(
          child: ListView(

            shrinkWrap: true,
            padding: EdgeInsets.all(15),
            children: <Widget>[
              Container(
                //alignment: Alignment.topLeft,
                child:
                Text("Nombre: " + p.nombre + "\n"+"Apellido: "+ p.apellido + "\n" + "DNI: " + p.dni,style: TextStyle(fontSize: 24,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),

              ),
              SizedBox(
                height: 100,
                child:
                TextFormField(

                decoration: const
                InputDecoration(

                    hintText: "Ingrese Domicilio del cliente",
                    labelText: "Domicilio"),
                validator: (value) {
                  if(value.isEmpty){
                    return "Ingrese Domicilio";
                  }
                  return null;
                },
                controller: inputcontroll,
                onSaved: (value){
                  domicilio = value;
                  domicilio = inputcontroll.text;
                  //print(domicilio);

                },
              ),
              ),
              SizedBox(
                height: 100,
                child:
                TextFormField(

                  decoration: const
                  InputDecoration(

                      hintText: "Ingrese Localidad del cliente",
                      labelText: "Localidad"),
                  validator: (value) {
                    if(value.isEmpty){
                      return "Ingrese Localidad";
                    }
                    return null;
                  },
                  controller: inputcontroll3,
                  onSaved: (value){
                    localidad = value;
                    localidad = inputcontroll3.text;
                    //print(domicilio);

                  },
                ),
              ),
          SizedBox(
            height: 100,
            child:
              TextFormField(
                decoration: const
                InputDecoration(
                    hintText: "Ingrese Telefono del cliente",
                    labelText: "Telefono"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if(value.isEmpty){
                    return "Ingrese Telefono";
                  }
                  return null;
                },
                controller: inputcontroll2,
                onSaved: (value){
                  telefono = value.toString();
                  //print(telefono);
                },

              ),
          ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child:
                RaisedButton(
                  onPressed: (){
                    domicilio = inputcontroll.text;
                    telefono = inputcontroll2.text;
                    localidad = inputcontroll3.text;
                    _showConfirmacion(context,p);

                  },
                  child:
                  Text("Registrar"),
                ),
              )
            ],)
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputcontroll = TextEditingController();
    inputcontroll2 = TextEditingController();
    inputcontroll3 = TextEditingController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    inputcontroll.dispose();
    inputcontroll2.dispose();
    inputcontroll3.dispose();
  }

  void _showConfirmacion(BuildContext context,Persona p) {
    Navigator.of(context).pushNamed("/confirm",arguments: Persona(nombre: p.nombre,apellido: p.apellido,dni: p.dni,telefono: telefono,domicilio: domicilio,localidad: localidad));
  }
}

