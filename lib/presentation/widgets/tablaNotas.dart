import 'package:flutter/material.dart';

class GradesTableWidget extends StatelessWidget {
  final List<Map<String, dynamic>> grades;
  final Function(int) onDelete;
  final Function(int, String, double, int) onEdit;
  final double acumulado;

  GradesTableWidget({
    required this.grades,
    required this.onDelete,
    required this.onEdit,
    required this.acumulado,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.white, width: 2),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        _buildTableRow(["Detalles", "Nota", "%", "Total"], isHeader: true),
        ...grades.map((grade) {
          int id = grade['id'];
          return _buildTableRow(
            [
              grade["title"] ?? '',
              grade["grade"].toString(),
              grade["percentage"].toString(),
              (grade["grade"] * grade["percentage"] / 100).toStringAsFixed(2)
            ],
            id: id,
            context: context,
          );
        }).toList(),
        _buildTableRow(["Acumulado", "", "", acumulado.toStringAsFixed(2)], isHighlight: true),
      ],
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false, bool isHighlight = false, int? id, BuildContext? context}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? Colors.purple : isHighlight ? Colors.purple[800] : Colors.transparent,
      ),
      children: cells.map((cell) {
        return GestureDetector(
          onLongPress: id != null && context != null ? () => _showEditDeleteDialog(context, id) : null,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              cell,
              style: TextStyle(
                fontSize: isHeader ? 16 : 14,
                fontWeight: isHeader || isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHeader || isHighlight ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showEditDeleteDialog(BuildContext context, int id) {
    final grade = grades.firstWhere((g) => g['id'] == id);
    final titleController = TextEditingController(text: grade["title"] ?? '');
    final gradeController = TextEditingController(text: (grade["grade"] ?? 0.0).toString());
    final percentController = TextEditingController(text: (grade["percentage"] ?? 0).toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar/Eliminar Nota'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: gradeController,
                decoration: InputDecoration(labelText: 'Nota'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: percentController,
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
                onEdit(
                  id,
                  titleController.text,
                    double.tryParse(gradeController.text.replaceAll(',', '.')) ?? 0.0,
                  int.tryParse(percentController.text) ?? 0,
                );
                Navigator.of(context).pop();
              },
              child: Text('GUARDAR'),
            ),
            TextButton(
              onPressed: () {
                onDelete(id);
                Navigator.of(context).pop();
              },
              child: Text('ELIMINAR'),
            ),
          ],
        );
      },
    );
  }
}
