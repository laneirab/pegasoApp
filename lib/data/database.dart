import 'package:mongo_dart/mongo_dart.dart';
import '../models/models.dart';

class DatabaseService {
  static Db? _db;

  static Future<void> connect() async {
    _db = await Db.create('mongodb://192.168.20.89:27017/tu_base_de_datos');
    await _db!.open();
  }

  static Future<List<Asignatura>> getAsignaturas() async {
    final collection = _db!.collection('asignaturas');
    final asignaturasData = await collection.find().toList();
    return asignaturasData.map((data) => Asignatura.fromJson(data)).toList();
  }

  static Future<List<String>> getDistinctValues(String field) async {
    final collection = _db!.collection('asignaturas');
    final distinctValues = await collection.distinct(field);
    return List<String>.from(distinctValues['values']);
  }
}