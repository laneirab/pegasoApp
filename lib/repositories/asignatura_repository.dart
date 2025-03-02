// lib/repositories/asignatura_repository.dart
import 'package:mongo_dart/mongo_dart.dart';
import '../models/asignatura.dart';
import '../services/database_service.dart';

class AsignaturaRepository {
  static const String collectionName = 'asignaturas';

  Future<List<Asignatura>> getAsignaturas({
    String? facultad,
    String? planEstudios,
    String? tipologia
  }) async {
    try {
      final db = await DatabaseService.database;
      final collection = db.collection(collectionName);
      
      // Construir filtro basado en parámetros proporcionados
      final query = where;
      
      if (facultad != null && facultad.isNotEmpty) {
        query.eq('facultad', facultad);
      }
      
      if (planEstudios != null && planEstudios.isNotEmpty) {
        query.eq('planEstudios', planEstudios);
      }
      
      if (tipologia != null && tipologia.isNotEmpty) {
        // Usar match para búsqueda insensible a mayúsculas/minúsculas
        query.match('tipologia', tipologia, caseInsensitive: true);
      }
      
      final cursor = await collection.find(query);
      final List<Map<String, dynamic>> documents = await cursor.toList();
      
      return documents.map((doc) => Asignatura.fromMap(doc)).toList();
    } catch (e) {
      print('Error al obtener asignaturas: $e');
      return [];
    }
  }

  Future<List<String>> getFacultades() async {
    try {
      final db = await DatabaseService.database;
      final collection = db.collection(collectionName);
      
      final cursor = await collection.distinct('facultad');
      final List<String> facultades = cursor.map<String>((item) => item.toString()).toList();
      
      return facultades;
    } catch (e) {
      print('Error al obtener facultades: $e');
      return [];
    }
  }

  Future<List<String>> getPlanesEstudio() async {
    try {
      final db = await DatabaseService.database;
      final collection = db.collection(collectionName);
      
      // Como planEstudios es un array, necesitamos un enfoque diferente
      final pipeline = [
        {
          '\$unwind': '\$planEstudios'
        },
        {
          '\$group': {
            '_id': null,
            'planes': {'\$addToSet': '\$planEstudios'}
          }
        }
      ];
      
      final result = await collection.aggregateToStream(pipeline).toList();
      
      if (result.isNotEmpty && result.first.containsKey('planes')) {
        return List<String>.from(result.first['planes']);
      }
      
      return [];
    } catch (e) {
      print('Error al obtener planes de estudio: $e');
      return [];
    }
  }

  Future<List<String>> getTipologias() async {
    try {
      final db = await DatabaseService.database;
      final collection = db.collection(collectionName);
      
      final cursor = await collection.distinct('tipologia');
      final List<String> tipologias = cursor.map<String>((item) => item.toString()).toList();
      
      return tipologias;
    } catch (e) {
      print('Error al obtener tipologías: $e');
      return [];
    }
  }
}