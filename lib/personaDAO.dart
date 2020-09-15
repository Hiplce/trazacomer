import 'package:trazacomer/bdconnect.dart';

import 'persona.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class PersonaDAO {


  Future<List<Persona>> getP() async {
    final bd = await Connection.connect;
    var response = await bd.query("Personas");
    List<Persona> list = response.map((e) => Persona.fromMap(e)).toList();
    return list;
  }
  Future<Persona> getPersonWithDNI(String dni) async {
    final db = await Connection.connect;
    var response = await db.query("Personas", where: "p_dni = ?", whereArgs: [dni]);
    return response.isNotEmpty ? Persona.fromMap(response.first) : null;
  }

  insertP(Persona p) async{
    final db = await Connection.connect;
    var raw = await db.insert("Personas", p.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    print("hice el insert kpo");
    return raw;
  }

  deleteAll() async {
    final db = await Connection.connect;
    db.delete("Personas");
  }

}