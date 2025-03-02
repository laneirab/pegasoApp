import 'package:flutter/material.dart';

class AddNoteForm extends StatefulWidget {
  final Function(String, double, int) onAddNote;

  AddNoteForm({required this.onAddNote});

  @override
  _AddNoteFormState createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final _titleController = TextEditingController();
  final _gradeController = TextEditingController();
  final _percentController = TextEditingController();

  void _validateAndSave() {
    final title = _titleController.text.isEmpty ? " " : _titleController.text;
    final gradeText = _gradeController.text.replaceAll(',', '.');
    final grade = double.tryParse(gradeText);

    final percent = int.tryParse(_percentController.text);

    if (title.isEmpty || grade == null || grade < 0 || grade > 5 ||
        percent == null || percent < 0 || percent > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Datos inválidos. Nota: 0-5, Porcentaje: 0-100.")),
      );
      return;
    }

    widget.onAddNote(title, grade, percent);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Añadir Nota'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Título')),
          TextField(controller: _gradeController, decoration: InputDecoration(labelText: 'Nota'), keyboardType: TextInputType.number),
          TextField(controller: _percentController, decoration: InputDecoration(labelText: 'Porcentaje (%)'), keyboardType: TextInputType.number),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('CANCELAR')),
        TextButton(onPressed: _validateAndSave, child: Text('GUARDAR')),
      ],
    );
  }
}
