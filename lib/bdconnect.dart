
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Connection {
  static final database = null;

  static Future<Database> get connect async {
    if (database != null) {
      return database;
    } else {
      Directory path = await getApplicationDocumentsDirectory();
      final database = openDatabase(
        join(path.path, 'trazabil.db'),
        onCreate: (db, version) {
          //print("cree la bd");
          db.execute("CREATE TABLE Personas(p_nombre VARCHAR(50) NOT NULL,p_apellido VARCHAR(50) NOT NULL,p_dni VARCHAR(10) NOT NULL PRIMARY KEY,p_domicilio VARCHAR(50) NOT NULL, p_telefono VARCHAR(15) NOT NULL,p_localidad VARCHAR(30) NOT NULL);");
          db.execute("CREATE TABLE Local(l_id VARCHAR(10) PRIMARY KEY ,l_imei1 VARCHAR(30));");
          return db.execute("CREATE TABLE Trazabilidad(id INTEGER PRIMARY KEY AUTOINCREMENT,pr_dni VARCHAR(10),c_id VARCHAR(12),t_fecha VARCHAR(20),FOREIGN KEY(pr_dni) REFERENCES Persona(p_dni));");
        },

        version: 1,
      );
      return database;
    }
  }
}