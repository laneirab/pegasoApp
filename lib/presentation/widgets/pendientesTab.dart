import 'package:flutter/material.dart';
import '../widgets/subjectsCalendar.dart';

class PendientesTab extends StatelessWidget {
  final List<Map<String, String>> pendientes;
  final Function(String, String, String) onAddPendiente;

  PendientesTab({required this.pendientes, required this.onAddPendiente});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: pendientes.map((pendiente) {
                return MateriaContainer(
                  materia: pendiente['materia']!,
                  hora: pendiente['hora']!,
                  ubicacion: pendiente['ubicacion']!,
                );
              }).toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () => _showAddPendienteDialog(context),
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  void _showAddPendienteDialog(BuildContext context) {
    final materiaController = TextEditingController();
    final horaController = TextEditingController();
    final ubicacionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Pendiente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: materiaController,
                decoration: InputDecoration(labelText: 'Materia'),
              ),
              TextField(
                controller: horaController,
                decoration: InputDecoration(labelText: 'Hora'),
              ),
              TextField(
                controller: ubicacionController,
                decoration: InputDecoration(labelText: 'Ubicación'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('CANCELAR'),
            ),
            TextButton(
              onPressed: () {
                onAddPendiente(
                  materiaController.text,
                  horaController.text,
                  ubicacionController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('AGREGAR'),
            ),
          ],
        );
      },
    );
  }
}