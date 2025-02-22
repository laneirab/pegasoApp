import 'package:flutter/material.dart';
import '../widgets/controlSubjects.dart';
import '../screens/notasScreen.dart';
import '../widgets/header.dart';

class Subjects extends StatefulWidget {
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  List<Map<String, dynamic>> subjects = [
    {
      "name": "Ecuaciones Diferenciales",
      "professor": "Carlos Vélez",
      "progress": 0.0,
      "grade": 0.0,
    },
    {
      "name": "Cátedra APUN",
      "professor": "Miguel Ángel Sierra",
      "progress": 0.0,
      "grade": 0.0
    },
    {
      "name": "Fundamentos de Economía",
      "professor": "Óscar Manrique",
      "progress": 0.0,
      "grade": 0.0
    },
    {
      "name": "Estadística II",
      "professor": "Jonathan Cardona",
      "progress": 0.0,
      "grade": 0.0
    },
  ];

  // Función para actualizar los datos cuando se vuelve de Notasmateria
  void actualizarMateria(int index, double nuevoProgreso, double nuevaNota) {
    setState(() {
      subjects[index]["progress"] = nuevoProgreso;
      subjects[index]["grade"] = nuevaNota;
    });
  }

  double calcularPromedio() {
    List<double> notas = subjects
        .map((subject) => subject["grade"] as double)
        .where((grade) => grade > 0.0)
        .toList();

    if (notas.isEmpty) return 0.0;

    return notas.reduce((a, b) => a + b) / notas.length;
  }

  @override
  Widget build(BuildContext context) {
    double promedioSemestral = calcularPromedio();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF0F0F0), Color(0xFFF0F0F0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6, 0.3],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              children: [
                HeaderWidget(
                  title: "2024-2",
                  imageUrl:
                  "https://i.pinimg.com/736x/b1/a6/1e/b1a61e29eaa57410058f1d671931f7a4.jpg",
                ),
              ],
            ),
          ),

          Positioned(
            top: 185,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                color: Color(0xFFD3AAFB),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        final subject = subjects[index];
                        return Controlsubjects(
                          subjectName: subject["name"]!,
                          professorName: subject["professor"]!,
                          progress: subject["progress"] ?? 0.0,
                          grade: subject["grade"] ?? 0.0,
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Notasmateria(
                                      subject: subject,
                                      index: index,
                                      actualizarMateria: actualizarMateria,
                                    ),
                              ),
                            );

                            if (result != null) {
                              actualizarMateria(
                                  index, result["progress"], result["grade"]);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "Promedio Semestral   ${promedioSemestral.toStringAsFixed(
                      2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}