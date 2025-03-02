import 'horario.dart';

class Grupo {
  final String nombreProfesor;
  final String numGrupo;
  final int cupos;
  final List<Horario> horarios;

  Grupo({
    required this.nombreProfesor,
    required this.numGrupo,
    required this.cupos,
    required this.horarios,
  });

  factory Grupo.fromJson(Map<String, dynamic> json) {
    var list = json['horarios'] as List;
    List<Horario> horariosList = list.map((i) => Horario.fromJson(i)).toList();

    return Grupo(
      nombreProfesor: json['nombreProfesor'],
      numGrupo: json['numGrupo'],
      cupos: json['cupos'],
      horarios: horariosList,
    );
  }
}