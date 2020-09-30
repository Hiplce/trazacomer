class Local{
  String local_id;

  String local_imei;


  Local({this.local_id,this.local_imei});
  Map<String,dynamic> toMap(){
    return {
      "l_id": this.local_id,
      "l_imei1": this.local_imei,


    };
  }
  factory Local.fromMap(Map<String,dynamic> json) => new Local(
      local_id: json["l_id"],
      local_imei: json["l_imei1"],

  );

}