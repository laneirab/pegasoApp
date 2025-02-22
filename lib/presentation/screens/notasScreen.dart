import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/botonAdd.dart';
import '../widgets/formularioNota.dart';
import '../widgets/tablaNotas.dart';

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

  @override
  void initState() {
    super.initState();
    grades = widget.subject['grades'] ?? [];
  }

  void _addNote(String title, double grade, int percent) {
    setState(() {
      grades.add({
        "title": title,
        "grade": grade,
        "percentage": percent,
        "total": grade * percent / 100,
      });
    });
    _actualizarProgresoYNota();
  }

  void _onDeleteGrade(int index) {
    setState(() {
      grades.removeAt(index);
    });
    _actualizarProgresoYNota();
  }

  void _onEditGrade(int index, String title, double grade, int percent) {
    setState(() {
      grades[index]["title"] = title;
      grades[index]["grade"] = grade;
      grades[index]["percentage"] = percent;
      grades[index]["total"] = grade * percent / 100;
    });
    _actualizarProgresoYNota();
  }

  void _actualizarProgresoYNota() {
    double acumulado = grades.fold(0.0, (sum, grade) => sum + (grade["total"] as double));
    int porcentajeUsado = grades.fold(0, (sum, grade) => sum + (grade["percentage"] as int));

    double progreso = porcentajeUsado / 100;
    double notaFinal = progreso > 0 ? acumulado / progreso : 0.0;

    widget.actualizarMateria(widget.index, progreso, notaFinal);
  }

  String _calcularMensajeFaltante() {
    double acumulado = grades.fold(0.0, (sum, grade) => sum + (grade["total"] as double));
    int porcentajeUsado = grades.fold(0, (sum, grade) => sum + (grade["percentage"] as int));
    int porcentajeRestante = 100 - porcentajeUsado;

    if (acumulado >= 3.0 || porcentajeRestante == 0) {
      return "¡Felicidades! Ya tienes una nota suficiente.";
    }

    double notaNecesaria = (3.0 - acumulado) * 100 / porcentajeRestante;

    if (notaNecesaria > 5.0) {
      return "⚠️ No es posible aprobar con el porcentaje restante.";
    }

    return "Te falta sacar ${notaNecesaria.toStringAsFixed(2)} en el ${porcentajeRestante}% restante.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          _calcularMensajeFaltante(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
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
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AddNoteForm(onAddNote: _addNote),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
