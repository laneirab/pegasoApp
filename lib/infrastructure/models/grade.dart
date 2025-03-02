import 'package:isar/isar.dart';

part 'grade.g.dart';

@collection
class Grade {
  Id id = Isar.autoIncrement;
  late int subjectId;
  late String title;
  late double grade;
  late int percentage;

  double get total => grade * percentage / 100;
}
