import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../models/models.dart';
import '../../data/database.dart';


class AsignaturasScreen extends StatefulWidget {
  @override
  _AsignaturasScreenState createState() => _AsignaturasScreenState();
}

class _AsignaturasScreenState extends State<AsignaturasScreen> {
  // Lista para mantener las asignaturas seleccionadas
  final List<Asignatura> _selectedSubjects = [];
  
  // Lista de asignaturas disponibles
  List<Asignatura> _availableSubjects = [];
  List<String> _facultades = [];
  List<String> _planesEstudio = [];
  List<String> _tipologias = [];
  String _searchQuery = '';
  String? _selectedFacultad;
  String? _selectedPlanEstudio;
  String? _selectedTipologia;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await DatabaseService.connect();
    _loadAsignaturas();
    _loadDistinctValues();
  }

  Future<void> _loadAsignaturas() async {
    final asignaturas = await DatabaseService.getAsignaturas();
    setState(() {
      _availableSubjects = asignaturas;
    });
  }

  Future<void> _loadDistinctValues() async {
    final facultades = await DatabaseService.getDistinctValues('facultad');
    final planesEstudio = await DatabaseService.getDistinctValues('planEstudios');
    final tipologias = await DatabaseService.getDistinctValues('tipologia');
    setState(() {
      _facultades = facultades;
      _planesEstudio = planesEstudio;
      _tipologias = tipologias;
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

  void _filterAsignaturas() {
    setState(() {
      _availableSubjects = _availableSubjects.where((asignatura) {
        final query = _searchQuery.toLowerCase();
        final matchesQuery = asignatura.nombre.toLowerCase().contains(query) || asignatura.id.toLowerCase().contains(query);
        final matchesFacultad = _selectedFacultad == null || asignatura.facultad == _selectedFacultad;
        final matchesPlanEstudio = _selectedPlanEstudio == null || asignatura.planEstudios.contains(_selectedPlanEstudio);
        final matchesTipologia = _selectedTipologia == null || asignatura.tipologia == _selectedTipologia;
        return matchesQuery && matchesFacultad && matchesPlanEstudio && matchesTipologia;
      }).toList();
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
                stops: [0.6, 0.3]
              )
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              children: [
                HeaderWidget(
                  title: "Organiza tu horario",
                  imageUrl: "https://i.pinimg.com/736x/b1/a6/1e/b1a61e29eaa57410058f1d671931f7a4.jpg",
                  subtitle: "Animo"
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
                  topLeft: Radius.circular(30)
                ),
              ),
              child: ListView(
                children: [
                  SizedBox(height: 15),
                  FilterDropdown(
                    hint: "Seleccionar Facultad",
                    items: _facultades,
                    onChanged: (value) {
                      setState(() {
                        _selectedFacultad = value;
                      });
                      _filterAsignaturas();
                    },
                  ),
                  SizedBox(height: 10),
                  FilterDropdown(
                    hint: "Seleccionar Plan de Estudios",
                    items: _planesEstudio,
                    onChanged: (value) {
                      setState(() {
                        _selectedPlanEstudio = value;
                      });
                      _filterAsignaturas();
                    },
                  ),
                  SizedBox(height: 10),
                  FilterDropdown(
                    hint: "Tipología",
                    items: _tipologias,
                    onChanged: (value) {
                      setState(() {
                        _selectedTipologia = value;
                      });
                      _filterAsignaturas();
                    },
                  ),
                  SizedBox(height: 10),
                  FilterTextField(
                    hint: "Buscar por nombre o código",
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                      _filterAsignaturas();
                    },
                  ),
                  SizedBox(height: 10),
                  SearchButton(),
                  SizedBox(height: 20),
                  _buildAsignaturasTitle(),
                  SizedBox(height: 10),
                  AsignaturasTable(asignaturas: _availableSubjects, onAdd: _addSubject),
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
          )
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