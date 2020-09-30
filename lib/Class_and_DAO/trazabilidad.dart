
class Trazabilidad {
  int id;
  String dni;
  String idCliente;
  String fecha;
  Trazabilidad({this.id,this.dni,this.idCliente,this.fecha});

  Map<String,dynamic> toMap(){
    return {
      "id": this.id,
      "pr_dni": this.dni,
      "c_id": this.idCliente,
      "t_fecha": this.fecha

    };
  }
  factory Trazabilidad.fromMap(Map<String,dynamic> json) => new Trazabilidad(
    id: json["id"],
    dni: json["pr_dni"],
    idCliente: json["c_id"],
    fecha: json["t_fecha"]
  );
}