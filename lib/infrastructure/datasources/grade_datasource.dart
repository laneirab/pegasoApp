import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/grade.dart';

class GradeDataSource {
  static final GradeDataSource _instance = GradeDataSource._internal();
  static late Isar _isar;

  factory GradeDataSource() {
    return _instance;
  }

  GradeDataSource._internal();

  // Inicializa Isar solo una vez
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([GradeSchema], directory: dir.path);
  }

  Future<List<Grade>> getGradesBySubject(int subjectId) async {
    return await _isar.grades.filter().subjectIdEqualTo(subjectId).findAll();
  }

  Future<void> addGrade(int subjectId, String title, double grade, int percentage) async {
    final newGrade = Grade()
      ..subjectId = subjectId // Asigna la materia correspondiente
      ..title = title
      ..grade = grade
      ..percentage = percentage;

    await _isar.writeTxn(() async {
      await _isar.grades.put(newGrade);
    });
  }

  Future<void> deleteGrade(int id) async {
    await _isar.writeTxn(() async {
      await _isar.grades.delete(id);
    });
  }

  Future<void> updateGrade(int id, String title, double grade, int percentage) async {
    final gradeToUpdate = await _isar.grades.get(id);
    if (gradeToUpdate != null) {
      gradeToUpdate.title = title;
      gradeToUpdate.grade = grade;
      gradeToUpdate.percentage = percentage;

      await _isar.writeTxn(() async {
        await _isar.grades.put(gradeToUpdate);
      });
    }
  }
}
