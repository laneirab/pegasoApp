import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../models/models.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AsignaturasScreen extends StatefulWidget {
  @override
  _AsignaturasScreenState createState() => _AsignaturasScreenState();
}

class _AsignaturasScreenState extends State<AsignaturasScreen> {
  final List<Asignatura> _selectedSubjects = [];
  List<Asignatura> _availableSubjects = [];
  List<Asignatura> _filteredSubjects = []; // Asignaturas filtradas
  List<String> _facultades = [];
  List<String> _planesEstudios = [];
  List<String> _tipologias = [];

  // Variables para almacenar los valores seleccionados en los dropdowns
  String? _selectedFacultad;
  String? _selectedPlanEstudios;
  String? _selectedTipologia;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final asignaturas = await loadAsignaturas();
    setState(() {
      _availableSubjects = asignaturas;
      _filteredSubjects = asignaturas; // Inicialmente, todas las asignaturas están visibles
      _facultades = _getUniqueFacultades(asignaturas);
      _planesEstudios = _getUniquePlanesEstudios(asignaturas);
      _tipologias = _getUniqueTipologias(asignaturas);
    });
  }

  // Método para cargar el JSON
  Future<List<Asignatura>> loadAsignaturas() async {
    String jsonString = await rootBundle.loadString('assets/tu_base_de_datos.json');
    final jsonResponse = json.decode(jsonString);
    return (jsonResponse as List).map((i) => Asignatura.fromJson(i)).toList();
  }

  // Métodos para obtener valores únicos
  List<String> _getUniqueFacultades(List<Asignatura> asignaturas) {
    return asignaturas.map((asignatura) => asignatura.facultad).toSet().toList();
  }

  List<String> _getUniquePlanesEstudios(List<Asignatura> asignaturas) {
    return asignaturas.expand((asignatura) => asignatura.planEstudios).toSet().toList();
  }

  List<String> _getUniqueTipologias(List<Asignatura> asignaturas) {
    return asignaturas.map((asignatura) => asignatura.tipologia).toSet().toList();
  }

  // Método para filtrar las asignaturas
  void _filterAsignaturas() {
    setState(() {
      _filteredSubjects = _availableSubjects.where((asignatura) {
        // Filtro por facultad
        final bool matchesFacultad = _selectedFacultad == null ||
            asignatura.facultad == _selectedFacultad;

        // Filtro por plan de estudios
        final bool matchesPlanEstudios = _selectedPlanEstudios == null ||
            asignatura.planEstudios.contains(_selectedPlanEstudios);

        // Filtro por tipología
        final bool matchesTipologia = _selectedTipologia == null ||
            asignatura.tipologia == _selectedTipologia;

        // La asignatura debe cumplir con todos los filtros seleccionados
        return matchesFacultad && matchesPlanEstudios && matchesTipologia;
      }).toList();
    });
  }

  void _addSubject(Asignatura asignatura) {
    setState(() {
      if (!_selectedSubjects.any((subject) => subject.id == asignatura.id)) {
        _selectedSubjects.add(asignatura);
      }
    });
  }

  void _removeSubject(Asignatura asignatura) {
    setState(() {
      _selectedSubjects.removeWhere((subject) => subject.id == asignatura.id);
    });
  }

  void _changeGroup(Asignatura asignatura, String newGroup) {
    setState(() {
      final index = _selectedSubjects.indexWhere((subject) => subject.id == asignatura.id);
      if (index != -1) {
        final selectedGroup = asignatura.grupos.firstWhere((grupo) => grupo.numGrupo == newGroup);
        _selectedSubjects[index] = Asignatura(
          id: asignatura.id,
          nombre: asignatura.nombre,
          creditos: asignatura.creditos,
          planEstudios: asignatura.planEstudios,
          tipologia: asignatura.tipologia,
          facultad: asignatura.facultad,
          grupos: asignatura.grupos.map((grupo) {
            return grupo.numGrupo == newGroup
                ? Grupo(
                    nombreProfesor: grupo.nombreProfesor,
                    numGrupo: grupo.numGrupo,
                    cupos: grupo.cupos,
                    horarios: grupo.horarios,
                  )
                : grupo;
          }).toList(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF0F0F0),
                  Color(0xFFF0F0F0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6, 0.3],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              children: [
                HeaderWidget(
                  title: "Organiza tu horario",
                  imageUrl: "https://i.pinimg.com/736x/b1/a6/1e/b1a61e29eaa57410058f1d671931f7a4.jpg",
                  subtitle: "Animo",
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFFD3AAFB),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: ListView(
                children: [
                  SizedBox(height: 15),
                  FilterDropdown(
                    hint: "Seleccionar Facultad",
                    items: _facultades,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedFacultad = value;
                      });
                      _filterAsignaturas();
                    },
                  ),
                  SizedBox(height: 10),
                  FilterDropdown(
                    hint: "Seleccionar Plan de Estudios",
                    items: _planesEstudios,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedPlanEstudios = value;
                      });
                      _filterAsignaturas();
                    },
                  ),
                  SizedBox(height: 10),
                  FilterDropdown(
                    hint: "Tipología",
                    items: _tipologias,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedTipologia = value;
                      });
                      _filterAsignaturas();
                    },
                  ),
                  SizedBox(height: 10),
                  FilterTextField(hint: "Buscar por código o nombre"),
                  SizedBox(height: 10),
                  SearchButton(),
                  SizedBox(height: 20),
                  _buildAsignaturasTitle(),
                  SizedBox(height: 10),
                  AsignaturasTable(
                    asignaturas: _filteredSubjects,
                    onAdd: _addSubject,
                  ),
                  SizedBox(height: 20),
                  _buildAsignaturasSeleccionadasTitle(),
                  SizedBox(height: 10),
                  AsignaturasSeleccionadasTable(
                    subjectsSelected: _selectedSubjects,
                    onRemove: _removeSubject,
                    onGroupChange: _changeGroup,
                  ),
                  SizedBox(height: 20),
                  _buildHorarioTitle(),
                  SizedBox(height: 10),
                  HorarioTable(selectedSubjects: _selectedSubjects),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAsignaturasTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Asignaturas",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAsignaturasSeleccionadasTitle() {
    return Row(
      children: [
        Text(
          "Asignaturas Seleccionadas (${_selectedSubjects.length})",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildHorarioTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Horario",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Text(
            "Guardar Horario →",
            style: TextStyle(
              fontSize: 14,
              color: Colors.purple[900],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// Widgets personalizados (simplificados para el ejemplo)
class FilterDropdown extends StatelessWidget {
  final String hint;
  final List<String> items;
  final Function(String?) onChanged;

  const FilterDropdown({
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
  decoration: InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  items: items.map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // 80% del ancho de la pantalla
        child: Text(value),
      ),
    );
  }).toList(),
  onChanged: onChanged,
);
  }
}

class FilterTextField extends StatelessWidget {
  final String hint;

  const FilterTextField({required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Lógica de búsqueda
      },
      child: Text("Buscar"),
    );
  }
}