import 'package:flutter/material.dart';

class MateriaContainer extends StatelessWidget {
  final String materia;
  final String hora;
  final String ubicacion;

  MateriaContainer({required this.materia, required this.hora, required this.ubicacion});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hora,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
        title: Text(materia, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(ubicacion),
      ),
    );
  }
}
