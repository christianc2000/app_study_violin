class Ejercicio {
  int? id;
  String? nombre;
  String? descripcion;
  String? puntos;


  Ejercicio({this.id, this.nombre, this.descripcion, this.puntos});

  factory Ejercicio.fromJson(Map<String, dynamic> json) {
    print(" dese el fromJson, name ${json['nombre']}");
    return Ejercicio(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'].toString(),
      puntos:json['puntos'].toString(),
    );
  }
}
