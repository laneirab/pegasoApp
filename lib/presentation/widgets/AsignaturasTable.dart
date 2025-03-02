import 'package:flutter/material.dart';
import '../../models/asignatura.dart';

class AsignaturasTable extends StatelessWidget {
  final List<Asignatura> asignaturas;
  final Function(Asignatura) onAdd;

  AsignaturasTable({required this.asignaturas, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    // Ordenar las asignaturas en orden alfabético por nombre
    asignaturas.sort((a, b) => a.nombre.compareTo(b.nombre));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildAsignaturasTableHeader(),
          ...asignaturas.map((asignatura) => _buildAsignaturaRow(asignatura)).toList(),
        ],
      ),
    );
  }

  Widget _buildAsignaturasTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Alinear las cabeceras a la derecha
        children: [
          Container(width: 80, child: Text('Código', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.start)),
          Container(width: 80, child: Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.justify)),
          Container(width: 80, child: Text('Créditos', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end)),
          Container(width: 80, child: Text('Añadir', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end)), // Cabecera para el botón
        ],
      ),
    );
  }

  Widget _buildAsignaturaRow(Asignatura asignatura) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(width: 80, child: Text(asignatura.id, style: TextStyle(fontSize: 12), textAlign: TextAlign.start)),
          Container(width: 80, child: Text(asignatura.nombre, style: TextStyle(fontSize: 12), textAlign: TextAlign.justify)),
          Container(width: 80, child: Text('${asignatura.creditos}', style: TextStyle(fontSize: 12), textAlign: TextAlign.center)),
          Container(
            width: 80,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.add, size: 20, color: Colors.green),
                onPressed: () => onAdd(asignatura),
              ),
            ),
          ),
        ],
      ),
    );
  }
}