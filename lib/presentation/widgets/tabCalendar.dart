import 'package:flutter/material.dart';
import 'clasesTab.dart';
import 'pendientesTab.dart';

class TabSection extends StatefulWidget {
  // También un valor por defecto aquí
  final int initialTab;
  const TabSection({this.initialTab = 0, Key? key}) : super(key: key);

  @override
  _TabSectionState createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> {
  late int selectedTab;

  List<Map<String, String>> pendientes = [
    {
      'materia': 'Tarea de Álgebra',
      'hora': 'PM 12:00', // Formato de 24 horas
      'ubicacion': 'Plataforma Virtual',
    },
    {
      'materia': 'Proyecto de Programación',
      'hora': 'AM 5:00', // Formato de 24 horas
      'ubicacion': 'GitHub',
    },
  ];

  void _addPendiente(String materia, String hora, String ubicacion) {
    setState(() {
      pendientes.add({
        'materia': materia,
        'hora': hora,
        'ubicacion': ubicacion,
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Tomamos el valor que viene de Calendar
    selectedTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // Barra de pestañas
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTab(0, "Clases"),
              buildTab(1, "Pendientes"),
            ],
          ),
          // Contenido de cada pestaña
          Expanded(
            child: IndexedStack(
              index: selectedTab,
              children: [
                ClasesTab(),
                PendientesTab(
                  pendientes: pendientes,
                  onAddPendiente: _addPendiente,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTab(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selectedTab == index ? Colors.purple : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedTab == index ? Colors.purple : Colors.black,
          ),
        ),
      ),
    );
  }
}