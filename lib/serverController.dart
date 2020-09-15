import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ServerController{

  insertPersona(String idequipo,String nombre,String apellido,String dni,String domicilio,String telefono, String localidad) async{
    //var client = http.Client();
    Response resp;
    String apiUrl = "http://www.track.trazapoint.com.ar/traza_ciudadano.php";
    String datos = idequipo+ "|" + dni + "|" + telefono + "|" + apellido + "|" + nombre + "|" + domicilio + "|" + localidad;
    try{
      print("ingresa personas");
      print(datos);
       resp = await http.post(apiUrl,body: datos );
       print("respuesta ciudadana");
       print(resp.body);
    }
    catch(e){

    }
    finally{

    }


    if(resp.statusCode == 200){
      print("mandamos");
    }
  }

  updateLocal(String idlocal,String idcel) async{
    String apiUrl = "http://www.track.trazapoint.com.ar/traza_equipo.php";
    String datos = idcel + "|" + idlocal;
    http.Response resp;
    //var client = http.Client();
    try{
      print(datos);
      resp = await http.post(apiUrl,body: datos );
      print("updateamo");
      print(resp.body);
    }
    catch(e){

    }
    finally{
      //client.close();
    }
  }

  insertTraza(String idequipo,String dni,String hora) async{
    String apiUrl = "http://www.track.trazapoint.com.ar/traza_traza.php";
    String datos = idequipo + "|" +dni + "|" + hora;
    Response resp;
    //var client = http.Client();
    try{
      print("entre");
      resp = await http.post(apiUrl,body: datos );
      print(resp.body);
      if (resp.statusCode == 200){
        print("tamo de vielta");
      }
    }
    catch(e){
      print("pero exploto");
    }
    finally{
     //client.close();
    }
  }
  static getPersonas() async{

    String apiUrl = "http://trazapoint.com.ar/track/traza_registrados.php";
    //var client = http.Client();
    Response resp;
    var lista;
    try{

      resp = await http.get(apiUrl);
      print(resp.body);
      if(resp.statusCode == 200) {
        lista = resp.body.split('|');
        print(lista);
        return lista;
      }
    }
    catch(e){

    }
    finally{
      //client.close();
    }

  }
  static getEquipos() async{

    String apiUrl = "http://trazapoint.com.ar/track/traza_idequipos.php";
    //var client = http.Client();
    Response resp;
    var lista;
    try{

      resp = await http.get(apiUrl);
      print(resp.body);
      if(resp.statusCode == 200) {
        lista = resp.body.split('|');
        print(lista);
        return lista;
      }
    }
    catch(e){

    }
    finally{
      //client.close();
    }

  }

  }





