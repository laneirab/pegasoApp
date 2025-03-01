import 'package:flutter/material.dart';
import '../widgets/subjectsCalendar.dart';
import '../widgets/botonAdd.dart';

class TabSection extends StatefulWidget {
  @override
  _TabSectionState createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> {
  int selectedTab = 0;

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
                /// Contenido de la pestaña "Clases"
                SingleChildScrollView(
                  child: Column(
                    children: [
                      MateriaContainer(
                        materia: 'Ecuaciones Diferenciales',
                        hora: '06:00 AM',
                        ubicacion: 'AULA TIPO AUDITORIO. 12-101. BLOQUE 12',
                      ),
                      MateriaContainer(
                        materia: 'Fundamentos de Economía',
                        hora: '10:00 AM',
                        ubicacion: 'AULA. 46-307. BLOQUE 46. SALON.',
                      ),
                    ],
                  ),
                ),

                /// Contenido de la pestaña "Pendientes"
                SingleChildScrollView(
                  child: Column(
                    children: [
                      MateriaContainer(
                        materia: 'Tarea de Álgebra',
                        hora: '8:00 PM',
                        ubicacion: 'Plataforma Virtual',
                      ),
                      MateriaContainer(
                        materia: 'Proyecto de Programación',
                        hora: '11:59 PM',
                        ubicacion: 'GitHub',
                      ),
                    ],
                  ),
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
