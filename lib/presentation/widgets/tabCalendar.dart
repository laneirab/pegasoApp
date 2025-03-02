import 'package:flutter/material.dart';
import 'clasesTab.dart';
import 'pendientesTab.dart';

class TabSection extends StatefulWidget {
  @override
  _TabSectionState createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> {
  int selectedTab = 0;
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
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTab(0, "Clases"),
              buildTab(1, "Pendientes"),
            ],
          ),
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
