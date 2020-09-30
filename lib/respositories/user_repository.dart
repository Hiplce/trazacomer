import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;


  Future<void> signInWithEmail(String email, String password) async {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> singUp(String email, String password) async{
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> singOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }
  Future<bool> vrfyUser(String email) async {
    String verificado = await readVry();
    bool vry = verificado.toLowerCase() == "true";

    print("el booleando");
    print(vry);
    if(vry == false){
      String apiUrl = "http://www.qr.trazapoint.com.ar/trazapoint_vrfy_comercio.php";
      Response resp;
      try{
        print("prueba verificar");
        resp = await http.post(apiUrl,body: email );

        if (resp.statusCode == 200){
          print("trae esta respuesta");
          print(resp.body);
          bool respuesta = resp.body.toLowerCase() == "1";
          await writeVry(respuesta.toString());
          return respuesta;
        }
        /*if ((resp.statusCode != 200 && resp.statusCode != 201) || resp.body == "false"){
          throw Exception();
        }*/
      }
      catch(e){
        print("pero exploto");
        throw Exception();
      }
    }
    else{
      return vry;
    }
  }
  Future<String> getUser() async {
    return await _firebaseAuth.currentUser.email;
  }
  Future resetPass(String email) async{
    
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> insertUser(String cuit,String namecomer,String email, String password,String name,String lastname,String dni,String location,String direction,String phone,String provincia) async {
    //var client = TrazaService.getClient();
    String body = cuit + '|' + namecomer + '|' + email + '|' + password + '|' + name + '|' + lastname + '|' + dni + '|' + location + '|' + direction + '|' + provincia + '|' + phone;
    //return await client.insertPersona(body);
    String apiUrl = "http://qr.trazapoint.com.ar/trazapoint_comercio.php";  //pruebas
    //String apiUrl = "http://www.track.trazapoint.com.ar/traza_ciuda.php"; // produccion
    Response response;

    try{
      print("entre");
      print("le pase body");
      print(body);
      response = await http.post(apiUrl,body: body );
      print("responde");
      print(response.body);

      if (response.statusCode == 200){
        print("tamo de vielta");
      }
      /*if ((response.statusCode != 200 && response.statusCode != 201) || response.body == "false"){
        throw Exception();
      }*/
    }
    catch(e){
      print(e);
      print("pero exploto");
      throw Exception();
    }
  }
  Future<void> insertUserTraza(String name,String lastname,String dni,String location,String direction,String phone) async {
    //var client = TrazaService.getClient();
    String body = name + '|' + lastname + '|' + dni + '|' + location + '|' + direction + '|' + phone;
    //return await client.insertPersona(body);
    //String apiUrl = "www.qr.trazapoint.com.ar/test_traza_ciuda.php";  //pruebas
    String apiUrl = "http://qr.trazapoint.com.ar/trazapoint_ciudadano.php"; // produccion
    Response response;
    print(body);
    try{
      print("entre");
      response = await http.post(apiUrl,body: body );
      print(response.body);
      if (response.statusCode == 200){
        print("tamo de vielta");
      }
      if ((response.statusCode != 200 && response.statusCode != 201) || response.body == "false"){
        throw Exception();
      }
    }
    catch(e){
      print("pero exploto");
      throw Exception();
    }
  }
  Future<void> insertUserTrazaLocal(String name,String lastname,String dni,String location,String direction,String phone) async {
    //var client = TrazaService.getClient();
    String body = name + '|' + lastname + '|' + dni + '|' + location + '|' + direction + '|' + phone;
    final file = await _localFileFC;
    return file.writeAsString(body+'\n',mode: FileMode.append);
  }
  Future<List<String>> readClients() async {
    try {
      final file = await _localFileFC;

      List<String> contents = await file.readAsLines();
      print(contents);

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return [];
    }
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/usuario.txt');
  }
  Future<File> get _localFileFC async {
    final path = await _localPath;

    return File('$path/clientes.txt');
  }
  Future<File> get _localFileVry async {
    final path = await _localPath;

    return File('$path/verificado.txt');
  }

  Future<File> writeVry(String counter) async {
    final file = await _localFileVry;
    return file.writeAsString(counter);
  }
  Future<String> readVry() async {
    try {
      final file = await _localFileVry;

      String contents = await file.readAsString();
      print(contents);

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return "";
    }
  }

  Future<File> writeUser(String counter) async {
    final file = await _localFile;
    return file.writeAsString(counter);
  }
  Future<String> readUser() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();
      print(contents);

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return "";
    }
  }
  Future<int> deleteFile() async {
    try {
      final file = await _localFile;

      await file.delete();
    } catch (e) {
      return 0;
    }
  }

}