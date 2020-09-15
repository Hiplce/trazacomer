class Persona{
  String nombre;
  String apellido;
  String dni;
  String domicilio;
  String telefono;

  String localidad;
  Persona({this.nombre,this.apellido,this.dni,this.domicilio,this.telefono,this.localidad});

  Map<String,dynamic> toMap(){
    return {
      "p_nombre": this.nombre,
      "p_apellido": this.apellido,
      "p_dni": this.dni,
      "p_domicilio": this.domicilio,
      "p_telefono": this.telefono,
      "p_localidad":this.localidad

    };
  }
  factory Persona.fromMap(Map<String,dynamic> json) => new Persona(
      nombre: json["p_nombre"],
      apellido: json["p_apellido"],
      dni: json["p_dni"],
      domicilio: json["p_domicilio"],
      telefono: json["p_telefono"],
  );

}