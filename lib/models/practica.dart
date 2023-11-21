class Practica {
  int? id;
  String? url;
  String? nombre;
  String? cantidadejercicio;
  String? cantidadevaluacion;
    String? cantidadpuntos;

  Practica({this.id, this.url, this.nombre, this.cantidadejercicio, this.cantidadevaluacion, this.cantidadpuntos});

  factory Practica.fromJson(Map<String, dynamic> json) {
    print(" dese el fromJson, name ${json['nombre']}");
    return Practica(
      id: json['id'],
      url: json['url'],
      nombre: json['nombre'],
      cantidadejercicio: json['cantidad_ejercicio'].toString(),
      cantidadevaluacion:json['cantidad_evaluacion'].toString(),
      cantidadpuntos: json['cantidad_puntos'].toString(),
    );
  }
}
