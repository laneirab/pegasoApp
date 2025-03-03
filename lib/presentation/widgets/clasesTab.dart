import 'package:flutter/material.dart';
import '../widgets/subjectsCalendar.dart';

class ClasesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}