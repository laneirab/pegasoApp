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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Añadir Nota'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _gradeController,
            decoration: InputDecoration(labelText: 'Nota'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _percentController,
            decoration: InputDecoration(labelText: 'Porcentaje (%)'),
            keyboardType: TextInputType.number,
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
            final title = _titleController.text;
            final grade = double.tryParse(_gradeController.text) ?? 0.0;
            final percent = int.tryParse(_percentController.text) ?? 0;
            widget.onAddNote(title, grade, percent);
            Navigator.of(context).pop();
          },
          child: Text('GUARDAR'),
        ),
      ],
    );
  }
}
