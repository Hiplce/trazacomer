import 'package:trazacomer/bdconnect.dart';

import 'trazabilidad.dart';
import 'dart:async';

import 'package:sqflite/sqflite.dart';

class TrazabilidadDAO {


  Future<List<Trazabilidad>> getT() async {
    final bd = await Connection.connect;
    var response = await bd.query("Trazabilidad");
    List<Trazabilidad> list = response.map((e) => Trazabilidad.fromMap(e)).toList();
    return list;
  }
  Future<Trazabilidad> getTrazaWithDNI(String dni) async {
    final db = await Connection.connect;
    var response = await db.query("Trazabilidad", where: "pr_dni = ?", whereArgs: [dni]);
    return response.isNotEmpty ? Trazabilidad.fromMap(response.first) : null;
  }

  insertT(Trazabilidad t) async{
    final db = await Connection.connect;
    var raw = await db.insert("Trazabilidad", t.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return raw;
  }

  deleteAll() async {
    final db = await Connection.connect;
    db.delete("Trazabilidad");
  }

}