import 'package:flutter/material.dart';

class GradesTableWidget extends StatelessWidget {
  final List<Map<String, dynamic>> grades;
  final Function(int) onDelete;
  final Function(int, String, double, int) onEdit;

  GradesTableWidget({
    required this.grades,
    required this.onDelete,
    required this.onEdit,
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
        ...grades.asMap().entries.map((entry) {
          int index = entry.key;
          var grade = entry.value;
          return _buildTableRow(
            [
              grade["title"] ?? '',
              grade["grade"].toString(),
              grade["percentage"].toString(),
              (grade["grade"] * grade["percentage"] / 100).toStringAsFixed(2)
            ],
            index: index,
            context: context,
          );
        }).toList(),
        _buildTableRow(["Acumulado", "0.0", "00", "0.0"], isHighlight: true),
      ],
    );
  }

  TableRow _buildTableRow(List<String> cells,
      {bool isHeader = false, bool isHighlight = false, int? index, BuildContext? context}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader
            ? Colors.purple
            : isHighlight
            ? Colors.purple[800]
            : Colors.transparent,
      ),
      children: cells.map((cell) {
        return GestureDetector(
          onLongPress: index != null && context != null
              ? () => _showEditDeleteDialog(context, index)
              : null,
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

  void _showEditDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final titleController = TextEditingController(text: grades[index]["title"] ?? '');
        final gradeController = TextEditingController(text: (grades[index]["grade"] ?? 0.0).toString());
        final percentController = TextEditingController(text: (grades[index]["percentage"] ?? 0).toString());

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
                  index,
                  titleController.text,
                  double.tryParse(gradeController.text) ?? 0.0,
                  int.tryParse(percentController.text) ?? 0,
                );
                Navigator.of(context).pop();
              },
              child: Text('GUARDAR'),
            ),
            TextButton(
              onPressed: () {
                onDelete(index);
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
