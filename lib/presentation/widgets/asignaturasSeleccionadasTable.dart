import 'package:flutter/material.dart';
import '../../models/asignatura.dart';

class AsignaturasSeleccionadasTable extends StatefulWidget {
  final List<Asignatura> subjectsSelected;
  final Function(Asignatura) onRemove;
  final Function(Asignatura, String) onGroupChange;

  AsignaturasSeleccionadasTable({
    required this.subjectsSelected,
    required this.onRemove,
    required this.onGroupChange,
  });

  @override
  _AsignaturasSeleccionadasTableState createState() => _AsignaturasSeleccionadasTableState();
}

class _AsignaturasSeleccionadasTableState extends State<AsignaturasSeleccionadasTable> {
  Map<String, String> selectedGroups = {};

  @override
  void initState() {
    super.initState();
    for (var asignatura in widget.subjectsSelected) {
      selectedGroups[asignatura.id] = asignatura.grupos.isNotEmpty ? asignatura.grupos[0].numGrupo : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildAsignaturasSeleccionadasHeader(),
          ...widget.subjectsSelected.map((asignatura) => _buildAsignaturaSeleccionadaRow(asignatura)).toList(),
        ],
      ),
    );
  }

  Widget _buildAsignaturasSeleccionadasHeader() {
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
        children: [
          Container(width: 70, child: Text('Código', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Container(width: 90, child: Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
          Container(width: 50, child: Text('Créditos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.end)),
          Container(width: 80, child: Text('Grupo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
          Container(width: 50, child: Text('Eliminar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.end)),
        ],
      ),
    );
  }

  Widget _buildAsignaturaSeleccionadaRow(Asignatura asignatura) {
    String selectedGroup = selectedGroups[asignatura.id] ?? '';
    if (!asignatura.grupos.any((grupo) => grupo.numGrupo == selectedGroup)) {
      selectedGroup = asignatura.grupos.isNotEmpty ? asignatura.grupos[0].numGrupo : '';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 70, child: Text(asignatura.id, style: TextStyle(fontSize: 12), textAlign: TextAlign.start)),
              Container(width: 90, child: Text(asignatura.nombre, style: TextStyle(fontSize: 12))),
              Container(width: 50, child: Text('${asignatura.creditos}', style: TextStyle(fontSize: 12), textAlign: TextAlign.center)),
              Container(
                width: 90,
                child: DropdownButton<String>(
                  value: selectedGroup,
                  items: asignatura.grupos.map((grupo) {
                    return DropdownMenuItem<String>(
                      value: grupo.numGrupo,
                      child: Text(grupo.numGrupo, style: TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedGroups[asignatura.id] = newValue!;
                    });
                    widget.onGroupChange(asignatura, newValue!);
                  },
                ),
              ),
              Container(
                width: 30,
                child: IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.close, size: 20, color: Colors.red),
                  onPressed: () => widget.onRemove(asignatura),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Text('Docente: ${asignatura.grupos.firstWhere((grupo) => grupo.numGrupo == selectedGroup).nombreProfesor}', 
              style: TextStyle(fontSize: 11, color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}