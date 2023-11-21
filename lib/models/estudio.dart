class Estudio {
  int? id;
  String? url;
  String? nombre;
  String? puntosrequeridos;

  Estudio({this.id, this.url, this.nombre, this.puntosrequeridos});

  factory Estudio.fromJson(Map<String, dynamic> json) {
    print(" dese el fromJson, name ${json['nombre']}");
    return Estudio(
      id: json['id'],
      url: json['url'],
      nombre: json['nombre'],
      puntosrequeridos: json['puntos_requerido'].toString(),
    );
  }
}
