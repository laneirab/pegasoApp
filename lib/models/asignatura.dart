import 'grupo.dart';

class Asignatura {
  String id;
  String nombre;
  int creditos;
  List<String> planEstudios;
  String tipologia;
  String facultad;
  List<Grupo> grupos;

  Asignatura({
    required this.id,
    required this.nombre,
    required this.creditos,
    required this.planEstudios,
    required this.tipologia,
    required this.facultad,
    required this.grupos,
  });

  factory Asignatura.fromJson(Map<String, dynamic> json) {
    return Asignatura(
      id: json['_id'],
      nombre: json['nombre'],
      creditos: json['creditos'],
      planEstudios: List<String>.from(json['planEstudios']),
      tipologia: json['tipologia'],
      facultad: json['facultad'],
      grupos: List<Grupo>.from(json['grupos'].map((x) => Grupo.fromJson(x))),
    );
  }
}