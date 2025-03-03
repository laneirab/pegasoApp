import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Asegúrate de tener este paquete en tu pubspec.yaml
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
                  hora: pendiente['hora']!.split(' ')[1], // Solo muestra la hora
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
    final fechaController = TextEditingController();
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
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: fechaController,
                      decoration: InputDecoration(labelText: 'Fecha'),
                      readOnly: true,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        fechaController.text = formattedDate;
                      }
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: horaController,
                      decoration: InputDecoration(labelText: 'Hora'),
                      readOnly: true,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        String formattedTime = pickedTime.format(context);
                        horaController.text = formattedTime;
                      }
                    },
                  ),
                ],
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
                  '${fechaController.text} ${horaController.text}',
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