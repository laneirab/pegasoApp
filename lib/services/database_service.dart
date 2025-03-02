// lib/services/database_service.dart
import 'package:mongo_dart/mongo_dart.dart';

class DatabaseService {
  static Db? _db;
  static const String host = 'localhost';
  static const int port = 27017;
  static const String dbName = 'tu_base_de_datos';
  
  static Future<Db> get database async {
    if (_db == null || !_db!.isConnected) {
      await connect();
    }
    return _db!;
  }

  static Future<void> connect() async {
    try {
      final connectionString = 'mongodb://$host:$port/$dbName';
      _db = await Db.create(connectionString);
      await _db!.open();
      print('Conexión a MongoDB establecida correctamente');
    } catch (e) {
      print('Error al conectar a MongoDB: $e');
      rethrow;
    }
  }

  static Future<void> disconnect() async {
    if (_db != null && _db!.isConnected) {
      await _db!.close();
      print('Conexión a MongoDB cerrada');
    }
  }
}