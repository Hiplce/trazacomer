import 'package:flutter/material.dart';
import 'package:trazacomer/Class_and_DAO/persona.dart';

class Manual extends StatefulWidget {
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  TextEditingController inputcontroll ;
  TextEditingController inputcontroll2 ;
  TextEditingController inputcontroll3 ;
  TextEditingController inputcontroll4 ;
  TextEditingController inputcontroll5 ;
  TextEditingController inputcontroll6 ;
  String nombre = "";
  String apellido = "";
  String dni = "";
  String domicilio= "";
  String telefono = "";
  String localidad;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingreso Manual"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              child: Text("Ingrese los datos del cliente",textAlign: TextAlign.left,
                style: new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), ),

            ),
            SizedBox(

              child:
              TextFormField(
                decoration: const
                InputDecoration(
                    hintText: "Ingrese Nombre del cliente",
                    labelText: "Nombre"),
                    validator: (value) {
                      if(value.isEmpty){
                        return "Ingrese Nombre";
                      }
                      return null;
                    },
                    controller: inputcontroll,
                    onSaved: (value){
                      nombre = value;
                      nombre = inputcontroll.text;
                      //print(nombre);
                },
              ),
            ),
            SizedBox(

              child:
              TextFormField(
                decoration: const
                InputDecoration(
                    hintText: "Ingrese Apellido del cliente",
                    labelText: "Apellido"),
                validator: (value) {
                  if(value.isEmpty){
                    return "Ingrese Apellido";
                  }
                  return null;
                },
                controller: inputcontroll2,
                onSaved: (value){
                  apellido = value;
                  apellido = inputcontroll2.text;
                  //print(apellido);
                },
              ),
            ),
            SizedBox(

              child:
              TextFormField(
                decoration: const
                InputDecoration(
                    hintText: "Ingrese DNI del cliente",
                    labelText: "DNI"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if(value.isEmpty){
                    return "Ingrese DNI";
                  }
                  return null;
                },
                controller: inputcontroll3,
                onSaved: (value){
                  dni = value;
                  dni = inputcontroll3.text;
                  //print(dni);
                },
              ),
            ),
            SizedBox(

              child:
              TextFormField(
                decoration: const
                InputDecoration(
                    hintText: "Ingrese domicilio del cliente",
                    labelText: "Domicilio"),
                validator: (value) {
                  if(value.isEmpty){
                    return "Ingrese domicilio";
                  }
                  return null;
                },
                controller: inputcontroll4,
                onSaved: (value){
                  domicilio = value;
                  domicilio = inputcontroll4.text;
                  //print(domicilio);
                },
              ),
            ),
            SizedBox(

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
                controller: inputcontroll6,
                onSaved: (value){
                  localidad = value;
                  localidad = inputcontroll6.text;
                  //print(domicilio);
                },
              ),
            ),
            SizedBox(

              child:
              TextFormField(
                decoration: const
                InputDecoration(
                    hintText: "Ingrese telefono del cliente",
                    labelText: "Telefono"),
                  keyboardType: TextInputType.number,
                validator: (value) {
                  if(value.isEmpty){
                    return "Ingrese Telefono";
                  }
                  return null;
                },
                controller: inputcontroll5,
                onSaved: (value){
                  telefono = value;
                  telefono = inputcontroll5.text;
                  //print(telefono);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child:
              RaisedButton(
                onPressed: (){
                  nombre = inputcontroll.text;
                  apellido = inputcontroll2.text;
                  dni = inputcontroll3.text;
                  domicilio = inputcontroll4.text;
                  telefono = inputcontroll5.text;
                  localidad = inputcontroll6.text;
                  print(nombre + " " + apellido+ " " + dni+ " " + domicilio+ " " + telefono+ " " + localidad);
                  Persona p = Persona(nombre: nombre,apellido: apellido,dni: dni,domicilio: domicilio,telefono: telefono,localidad:  localidad);
                  _showConfirmacion(context,p);
                },
                child:
                Text("Registrar"),
              ),
            )

          ],
        ),
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
    inputcontroll4 = TextEditingController();
    inputcontroll5 = TextEditingController();
    inputcontroll6 = TextEditingController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    inputcontroll.dispose();
    inputcontroll2.dispose();
    inputcontroll3.dispose();
    inputcontroll4.dispose();
    inputcontroll5.dispose();
    inputcontroll6.dispose();

  }
  void _showConfirmacion(BuildContext context,Persona p) {
    Navigator.of(context).pushNamed("/confirm",arguments: Persona(nombre: p.nombre,apellido: p.apellido,dni: p.dni,telefono: telefono,domicilio: domicilio,localidad: localidad));
  }
}
