import 'package:sqflite/sqflite.dart';

import 'local.dart';
import 'bdconnect.dart';

class LocalDAO {


  Future<Local> getT() async {
    final bd = await Connection.connect;
    var response = await bd.query("Local");
    List<Local> list = response.map((e) => Local.fromMap(e)).toList();
    return response.isNotEmpty ? Local.fromMap(response.first) : null;
  }


  insertT(Local t) async{
    final db = await Connection.connect;
    var raw = await db.insert("Local", t.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return raw;
  }

  deleteAll() async {
    final db = await Connection.connect;
    db.delete("Local");
  }

}