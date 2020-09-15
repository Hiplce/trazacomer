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

  Future<String> getUser() async {
    return await _firebaseAuth.currentUser.email;
  }
  Future resetPass(String email) async{
    
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> insertUser(String email, String password,String name,String lastname,String dni,String location,String direction,String phone) async {
    //var client = TrazaService.getClient();
    String body = email + '|' + password + '|' + name + '|' + lastname + '|' + dni + '|' + location + '|' + direction + '|' + phone;
    //return await client.insertPersona(body);
    //String apiUrl = "www.qr.trazapoint.com.ar/test_traza_ciuda.php";  //pruebas
    String apiUrl = "http://www.track.trazapoint.com.ar/traza_ciuda.php"; // produccion
    Response response;

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
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print("esta es la ruta");
    print(path);
    return File('$path/usuario.txt');
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