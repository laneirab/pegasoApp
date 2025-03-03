import 'horario.dart';

class Grupo {
  String nombreProfesor;
  String numGrupo;
  int cupos;
  List<Horario> horarios;

  Grupo({
    required this.nombreProfesor,
    required this.numGrupo,
    required this.cupos,
    required this.horarios,
  });

  factory Grupo.fromJson(Map<String, dynamic> json) {
    return Grupo(
      nombreProfesor: json['nombreProfesor'],
      numGrupo: json['numGrupo'],
      cupos: json['cupos'],
      horarios: List<Horario>.from(json['horarios'].map((x) => Horario.fromJson(x))),
    );
  }
}