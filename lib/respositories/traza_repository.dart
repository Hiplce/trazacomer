
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class TrazaRepository {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print("esta es la ruta");
    print(path);
    return File('$path/trazabilidad.txt');
  }
  Future<File> writeTraza(String counter) async {
    final file = await _localFile;

    return file.writeAsString(counter+'\n',mode: FileMode.append);
  }
  Future<List<String>> readTraza() async {
    try {
      final file = await _localFile;

      List<String> contents = await file.readAsLines();
      print(contents);

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return [];
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




  Future<void> insertTraza(String dni,String emaillocal,String date) async {

    String apiUrl = "http://qr.trazapoint.com.ar/trazapoint_trazabilidad.php";      // pruebas
    //String apiUrl = "http://www.track.trazapoint.com.ar/traza_trazabi.php";  //produccion
    Response resp;
    String body;

    body = emaillocal + "|" + dni + "|" + date;
    try{
      print("entre");
      resp = await http.post(apiUrl,body: body );
      print(resp.body);
      if (resp.statusCode == 200){
        print("tamo de vielta");
      }
      if ((resp.statusCode != 200 && resp.statusCode != 201) || resp.body == "false"){
        throw Exception();
      }
    }
    catch(e){
      print("pero exploto");
      throw Exception();
    }

  }

}