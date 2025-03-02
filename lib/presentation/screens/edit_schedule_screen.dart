import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../models/models.dart';

class AsignaturasScreen extends StatefulWidget {
  @override
  _AsignaturasScreenState createState() => _AsignaturasScreenState();
}

class _AsignaturasScreenState extends State<AsignaturasScreen> {
  // Lista para mantener las asignaturas seleccionadas
  final List<Asignatura> _selectedSubjects = [];
  
  // Lista de ejemplo de asignaturas disponibles
  final List<Asignatura> _availableSubjects = [
    Asignatura(
      id: '3010319',
      nombre: 'Construcción I',
      creditos: 3,
      planEstudios: ['3501 ARQUITECTURA', '3503 CONSTRUCCIÓN'],
      tipologia: 'DISCIPLINAR OPTATIVA',
      facultad: '3064 FACULTAD DE ARQUITECTURA',
      grupos: [
        Grupo(
          nombreProfesor: 'ANDRES FERNANDO URREGO HIGUITA.',
          numGrupo: '(1) Grupo 1',
          cupos: 0,
          horarios: [
            Horario(hora: 'LUNES de 06:00 a 08:00.', aula: 'AULA ESPECIAL. 24-411. BLOQUE 24. SALON.'),
            Horario(hora: 'MIÉRCOLES de 06:00 a 08:00.', aula: 'AULA ESPECIAL. 24-411. BLOQUE 24. SALON.'),
          ],
        ),
        Grupo(
          nombreProfesor: 'JAIRO URREGO HIGUITA.',
          numGrupo: '(2) Grupo 2',
          cupos: 0,
          horarios: [
            Horario(hora: 'MARTES de 06:00 a 12:00.', aula: 'AULA ESPECIAL. 24-411. BLOQUE 24. SALON.'),
            Horario(hora: 'JUEVES de 06:00 a 08:00.', aula: 'AULA ESPECIAL. 24-411. BLOQUE 24. SALON.'),
          ],
        ),
      ],
    ),
    Asignatura(
      id: '3010283',
      nombre: 'Construcción II',
      creditos: 3,
      planEstudios: ['3501 ARQUITECTURA', '3503 CONSTRUCCIÓN'],
      tipologia: 'DISCIPLINAR OPTATIVA',
      facultad: '3064 FACULTAD DE ARQUITECTURA',
      grupos: [
        Grupo(
          nombreProfesor: 'Edison Aldemar Hincapie Atehortua.',
          numGrupo: '(1) Grupo 1',
          cupos: 2,
          horarios: [
            Horario(hora: 'MARTES de 10:00 a 12:00.', aula: 'AULA DE DIBUJO. 24-203. BLOQUE 24. SALON.'),
            Horario(hora: 'JUEVES de 10:00 a 12:00.', aula: 'AULA ESPECIAL. 24-406. BLOQUE 24. SALON.'),
          ],
        ),
      ],
    ),
    Asignatura(
      id: '3006719',
      nombre: 'Construcción III',
      creditos: 3,
      planEstudios: ['3501 ARQUITECTURA', '3503 CONSTRUCCIÓN'],
      tipologia: 'DISCIPLINAR OPTATIVA',
      facultad: '3064 FACULTAD DE ARQUITECTURA',
      grupos: [
        Grupo(
          nombreProfesor: 'John Jairo Agudelo .',
          numGrupo: '(1) Grupo 1',
          cupos: 2,
          horarios: [
            Horario(hora: 'MIÉRCOLES de 06:00 a 08:00.', aula: 'AULA ESPECIAL. 24-403. BLOQUE 24. SALON.'),
            Horario(hora: 'VIERNES de 06:00 a 08:00.', aula: 'AULA ESPECIAL. 24-403. BLOQUE 24. SALON.'),
          ],
        ),
      ],
    ),
  ];
  
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
                  FilterDropdown(hint: "Seleccionar Facultad"),
                  SizedBox(height: 10),
                  FilterDropdown(hint: "Seleccionar Plan de Estudios"),
                  SizedBox(height: 10),
                  FilterTextField(hint: "Tipología"),
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