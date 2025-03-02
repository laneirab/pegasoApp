import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/botonAdd.dart';
import '../widgets/formularioNota.dart';
import '../widgets/tablaNotas.dart';
import '/infrastructure/datasources/grade_datasource.dart';
import '/infrastructure/models/grade.dart';
import '../screens/subjectsScreen.dart';

class Notasmateria extends StatefulWidget {
  final Map<String, dynamic> subject;
  final int index;
  final Function(int, double, double) actualizarMateria;

  Notasmateria({
    required this.subject,
    required this.index,
    required this.actualizarMateria,
  });

  @override
  _NotasState createState() => _NotasState();
}

class _NotasState extends State<Notasmateria> {
  List<Map<String, dynamic>> grades = [];
  final GradeDataSource _gradeDataSource = GradeDataSource();

  @override
  void initState() {
    super.initState();
    loadGrades();
  }

  Future<void> loadGrades() async {
    final subjectId = widget.subject["id"];
    final storedGrades = await _gradeDataSource.getGradesBySubject(subjectId);

    setState(() {
      grades = storedGrades.map((grade) =>
      {
        "id": grade.id,
        "title": grade.title,
        "grade": grade.grade,
        "percentage": grade.percentage,
        "total": grade.total,
      }).toList();
    });
  }

  Future<void> _addNote(String title, dynamic grade, dynamic percent) async {
    double? parsedGrade = double.tryParse(
        grade.toString().replaceAll(',', '.'));
    int? parsedPercent = int.tryParse(percent.toString());

    if (parsedGrade == null || parsedPercent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
            "Introduce valores válidos para la nota y el porcentaje.")),
      );
      return;
    }

    if (parsedGrade < 0 || parsedGrade > 5 || parsedPercent < 0 ||
        parsedPercent > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
            "La nota debe estar entre 0 y 5 y el porcentaje entre 0 y 100.")),
      );
      return;
    }

    final subjectId = widget.subject["id"];
    await _gradeDataSource.addGrade(
        subjectId, title, parsedGrade, parsedPercent);
    loadGrades();
  }

  Future<void> _onDeleteGrade(int id) async {
    await _gradeDataSource.deleteGrade(id);
    loadGrades();
  }

  Future<void> _onEditGrade(int id, String title, dynamic grade,
      dynamic percent) async {
    double? parsedGrade = double.tryParse(grade.toString().replaceAll(
        ',', '.')); // Maneja formatos con coma o punto
    int? parsedPercent = int.tryParse(percent.toString());

    if (parsedGrade == null || parsedPercent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
            "Introduce valores válidos para la nota y el porcentaje.")),
      );
      return;
    }

    if (parsedGrade < 0 || parsedGrade > 5 || parsedPercent < 0 ||
        parsedPercent > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
            "La nota debe estar entre 0 y 5 y el porcentaje entre 0 y 100.")),
      );
      return;
    }

    await _gradeDataSource.updateGrade(id, title, parsedGrade, parsedPercent);
    loadGrades();
  }

  void _actualizarMateria() {
    double acumulado = grades.fold(
        0.0, (sum, grade) => sum + (grade["total"] as double));
    int porcentajeUsado = grades.fold(
        0, (sum, grade) => sum + (grade["percentage"] as int));

    double progreso = porcentajeUsado / 100.0;
    double notaAcumulada = acumulado;

    widget.actualizarMateria(widget.index, progreso, notaAcumulada);
  }


  String _calcularMensajeFaltante() {
    double acumulado = grades.fold(
        0.0, (sum, grade) => sum + (grade["total"] as double));
    int porcentajeUsado = grades.fold(
        0, (sum, grade) => sum + (grade["percentage"] as int));
    int porcentajeRestante = 100 - porcentajeUsado;

    if (acumulado >= 3.0) {
      return "¡Felicidades! Ya tienes una nota suficiente.";
    }

    double notaNecesaria = (3.0 - acumulado) * 100 / porcentajeRestante;

    if (notaNecesaria > 5.0) {
      return "El próximo semestre seguro pasas la materia, este ya no 🫂";
    }

    return "Te falta sacar ${notaNecesaria.toStringAsFixed(
        2)} en el ${porcentajeRestante}% restante.";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _actualizarMateria(); // Actualizar datos antes de salir
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFD3AAFB),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWidget(
                        title: widget.subject['name']!,
                        imageUrl:
                        "https://i.pinimg.com/736x/b1/a6/1e/b1a61e29eaa57410058f1d671931f7a4.jpg",
                        titleSize: 28,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFD3AAFB),
                    ),
                    child: Column(
                      children: [
                        GradesTableWidget(
                          grades: grades,
                          onDelete: _onDeleteGrade,
                          onEdit: _onEditGrade,
                          acumulado: grades.fold(
                              0.0, (sum, grade) => sum + grade["total"]),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            _calcularMensajeFaltante(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButtonWidget(
                onPressed: () =>
                    showDialog(
                      context: context,
                      builder: (context) => AddNoteForm(onAddNote: _addNote),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}