class Contenido {
  int? id;
  String? url;
  String? descripcion;
  String? posicion;

  Contenido({this.id, this.url, this.descripcion, this.posicion});

  factory Contenido.fromJson(Map<String, dynamic> json) {
    print(" dese el fromJson, name ${json['url']}");
    return Contenido(
        id: json['id'],
        url: json['url'],
        descripcion: json['descripcion'].toString(),
        posicion: json['posicion'].toString());
  }
}
