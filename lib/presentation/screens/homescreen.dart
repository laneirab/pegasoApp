import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../screens/calendarscreen.dart'; // Ajusta la ruta si tu archivo se llama distinto
import '../widgets/clasesTab.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  List<Map<String, String>> pendientes = [
    {
      'materia': 'Tarea de Álgebra',
      'hora': '8:00 PM',
      'ubicacion': 'Plataforma Virtual',
    },
    {
      'materia': 'Proyecto de Programación',
      'hora': '11:59 PM',
      'ubicacion': 'GitHub',
    },
    {
      'materia': 'Examen de Física',
      'hora': '7:00 AM',
      'ubicacion': 'Aula 12',
    },
    {
      'materia': 'Reporte de Laboratorio',
      'hora': '3:00 PM',
      'ubicacion': 'Plataforma Virtual',
    },
  ];

  // Navega al calendario con la pestaña indicada:
  // 0 para 'Clases', 1 para 'Pendientes'
  void _navigateToCalendar(int initialTab) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Calendar(initialTab: initialTab),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // FONDO
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF0F0F0),
                Color(0xFFF0F0F0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 0.3],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              HeaderWidget(
                title: "¡Ten un lindo día!",
                imageUrl:
                    "https://i.pinimg.com/736x/b1/a6/1e/b1a61e29eaa57410058f1d671931f7a4.jpg",
                subtitle: "Hola",
              ),
            ],
          ),
        ),

        // CONTENEDOR PRINCIPAL
        Positioned(
          top: 200,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height - 230,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFD3AAFB), // Color pastel de fondo
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: ListView(
              children: [
                buildTitleRow("CLASES DE HOY", 2, 0),
                SizedBox(height: 20),
                ClasesTab(),

                SizedBox(height: 25),
                buildTitleRow("PENDIENTES", pendientes.length, 1),
                SizedBox(height: 20),

                // SCROLL HORIZONTAL PARA LOS PENDIENTES
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: pendientes
                        .map((pendiente) => Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: buildPendienteCard(pendiente),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildTitleRow(String title, int number, int tabIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: "($number)",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _navigateToCalendar(tabIndex),
          child: Text(
            "Ver todo",
            style: TextStyle(
              fontSize: 13,
              color: Color(0XFF3E3993),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPendienteCard(Map<String, String> pendiente) {
    return Container(
      width: 180,
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFFFE4EC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            pendiente['materia']!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            pendiente['hora']!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 4),
          Text(
            pendiente['ubicacion']!,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
