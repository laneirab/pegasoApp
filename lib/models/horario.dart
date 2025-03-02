class Horario {
  final String hora;
  final String aula;

  Horario({
    required this.hora,
    required this.aula,
  });

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      hora: json['hora'],
      aula: json['aula'],
    );
  }
}