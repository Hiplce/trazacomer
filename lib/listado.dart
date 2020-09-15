import 'package:flutter/cupertino.dart';
import 'package:trazacomer/personaDAO.dart';
import 'package:trazacomer/trazabilidadDAO.dart';
import 'trazabilidad.dart';
import 'persona.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Listado extends StatefulWidget {
  @override
  _ListadoState createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  TrazabilidadDAO tDAO = TrazabilidadDAO();
  PersonaDAO pDAO = PersonaDAO();

  Future<List> _trazas ;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _trazas = tDAO.getT();
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(

      appBar: AppBar(title: Text("Listado de Personas",)),
      body: Container(
        padding: EdgeInsets.all(12),
        child:
        FutureBuilder(
          future: _trazas,
          builder: (BuildContext context,AsyncSnapshot<List> snapshot){

            if(snapshot.hasData){
              return Column(
                children: <Widget>[
                Row(
                  children: <Widget>[
                    new Expanded(child: new Text("Nombre")),
                    new Expanded(child: new Text("Apellido")),
                    new Expanded(child: new Text("Hora")),
                    new Expanded(child: new Text("I/E")),
                   ]
                  ),

                  
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                            Trazabilidad t = snapshot.data[index];
                            //Persona veri = await pDAO.getPersonWithDNI(dni);
                            return ListTile(
                              title: Row(
                                children: <Widget>[
                                  Expanded(child: Text(t.dni),),
                                  Expanded(child: Text(t.idCliente),),
                                  Expanded(child: Text(t.fecha),),
                                  Expanded(child: Text("futuro"),)
                                ],
                              ),

                              onTap: (){},
                            );
                          }),
                    ),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),

    );
  }





 /* _getDataRow(Trazabilidad traza) async {
    Persona pp = await pDAO.getPersonWithDNI(traza.dni);
    return DataRow(cells: <DataCell>[
      DataCell(Text(pp.nombre)),
      DataCell(Text(pp.apellido)),
      DataCell(Text(traza.fecha.toString())),
      DataCell(Text("futuro")),
    ]);
    
  }
  Widget body (List<Trazabilidad> data) {
    //print(data['results']);
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container( child: DataTable(
          columns: <DataColumn>[
            DataColumn(label: Text("Nombre")),
            DataColumn(label: Text("Apellido")),
            DataColumn(label: Text("Hora")),
            DataColumn(label: Text("I/E")),
          ],
          rows: List.generate(data.length, (index) => _getDataRow(data[index])),
        ),
        ),
    );
  }*/

}

