import 'grupo.dart';

class Asignatura {
  final String id;
  final String nombre;
  final int creditos;
  final List<String> planEstudios;
  final String tipologia;
  final String facultad;
  final List<Grupo> grupos;

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
    var list = json['grupos'] as List;
    List<Grupo> gruposList = list.map((i) => Grupo.fromJson(i)).toList();

    return Asignatura(
      id: json['_id'],
      nombre: json['nombre'],
      creditos: json['creditos'],
      planEstudios: List<String>.from(json['planEstudios']),
      tipologia: json['tipologia'],
      facultad: json['facultad'],
      grupos: gruposList,
    );
  }
}