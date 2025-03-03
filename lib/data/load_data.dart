import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/asignatura.dart';

Future<List<Asignatura>> loadAsignaturas() async {
  String jsonString = await rootBundle.loadString('assets/tu_base_de_datos.json');
  final jsonResponse = json.decode(jsonString);
  return (jsonResponse as List).map((i) => Asignatura.fromJson(i)).toList();
}