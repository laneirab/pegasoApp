import 'package:flutter/material.dart';
import '../../models/models.dart';

class HorarioTable extends StatelessWidget {
  final List<Asignatura> selectedSubjects;

  HorarioTable({required this.selectedSubjects});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, // Aumentar la altura para acomodar el espacio adicional entre horas
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildHorarioHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHorasColumn(),
                  _buildDiaColumn("LUNES"),
                  _buildDiaColumn("MARTES"),
                  _buildDiaColumn("MIÉRCOLES"),
                  _buildDiaColumn("JUEVES"),
                  _buildDiaColumn("VIERNES"),
                  _buildDiaColumn("SÁBADO"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorarioHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Container(width: 40, child: Text('Hora', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(child: Text('L', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(child: Text('M', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(child: Text('X', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(child: Text('J', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(child: Text('V', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(child: Text('S', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildHorasColumn() {
    List<String> horas = [
      "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM", "12 PM",
      "1 PM", "2 PM", "3 PM", "4 PM", "5 PM", "6 PM", "7 PM"
    ];
    return Container(
      width: 40,
      child: Column(
        children: horas.map((hora) => Container(
          height: 40, // Aumentar la altura de cada celda para más espacio entre horas
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.grey.shade300),
              bottom: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Text(hora, style: TextStyle(fontSize: 11)),
        )).toList(),
      ),
    );
  }

  Widget _buildDiaColumn(String dia) {
    List<Widget> clasesWidgets = [];
    for (var asignatura in selectedSubjects) {
      for (var grupo in asignatura.grupos) {
        for (var horario in grupo.horarios) {
          if (horario.hora.toUpperCase().contains(dia)) {
            clasesWidgets.add(_buildClaseCell(asignatura, horario));
          }
        }
      }
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: List.generate(15, (index) => Container(
                height: 40, // Aumentar la altura de cada celda para más espacio entre horas
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              )),
            ),
            ...clasesWidgets,
          ],
        ),
      ),
    );
  }

  Widget _buildClaseCell(Asignatura asignatura, Horario horario) {
    // Convertir la hora a formato de 12 horas y calcular la posición y altura
    final startTime = _convertTo12HourFormat(horario.hora.split(' de ')[1].split(' a ')[0]);
    final endTime = _convertTo12HourFormat(horario.hora.split(' a ')[1].split('.')[0]);
    final topPosition = _calculateTopPosition(startTime);
    final height = _calculateHeight(startTime, endTime);

    // Verificar solapamientos
    bool isOverlapping = false;
    for (var otherAsignatura in selectedSubjects) {
      for (var otherGrupo in otherAsignatura.grupos) {
        for (var otherHorario in otherGrupo.horarios) {
          if (otherHorario != horario && _isOverlapping(startTime, endTime, _convertTo12HourFormat(otherHorario.hora.split(' de ')[1].split(' a ')[0]), _convertTo12HourFormat(otherHorario.hora.split(' a ')[1].split('.')[0]))) {
            isOverlapping = true;
            break;
          }
        }
      }
    }

    return Positioned(
      top: topPosition,
      left: 2,
      right: 2,
      height: height,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isOverlapping ? Colors.red[100] : Colors.blue[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(asignatura.id, textAlign: TextAlign.center, style: TextStyle(fontSize: 10)), // Mostrar solo el código de la asignatura
          ],
        ),
      ),
    );
  }

  String _convertTo12HourFormat(String time) {
    final hour = int.parse(time.split(':')[0]);
    final minute = time.split(':')[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour > 12 ? hour - 12 : hour;
    return '$formattedHour:$minute $period';
  }

  double _calculateTopPosition(String startTime) {
    final hour = int.parse(startTime.split(':')[0]);
    final minute = int.parse(startTime.split(':')[1].split(' ')[0]);
    final period = startTime.split(' ')[1];
    final totalMinutes = (period == 'PM' && hour != 12 ? hour + 12 : hour) * 60 + minute;
    return (totalMinutes - 360) / 60 * 40; // 360 minutos = 6 AM, 40 es la nueva altura de cada celda
  }

  double _calculateHeight(String startTime, String endTime) {
    final startHour = int.parse(startTime.split(':')[0]);
    final startMinute = int.parse(startTime.split(':')[1].split(' ')[0]);
    final startPeriod = startTime.split(' ')[1];
    final endHour = int.parse(endTime.split(':')[0]);
    final endMinute = int.parse(endTime.split(':')[1].split(' ')[0]);
    final endPeriod = endTime.split(' ')[1];
    final startTotalMinutes = (startPeriod == 'PM' && startHour != 12 ? startHour + 12 : startHour) * 60 + startMinute;
    final endTotalMinutes = (endPeriod == 'PM' && endHour != 12 ? endHour + 12 : endHour) * 60 + endMinute;
    return (endTotalMinutes - startTotalMinutes) / 60 * 40; // 40 es la nueva altura de cada celda
  }

  bool _isOverlapping(String startTime1, String endTime1, String startTime2, String endTime2) {
    final start1 = _convertToMinutes(startTime1);
    final end1 = _convertToMinutes(endTime1);
    final start2 = _convertToMinutes(startTime2);
    final end2 = _convertToMinutes(endTime2);
    return start1 < end2 && start2 < end1;
  }

  int _convertToMinutes(String time) {
    final hour = int.parse(time.split(':')[0]);
    final minute = int.parse(time.split(':')[1].split(' ')[0]);
    final period = time.split(' ')[1];
    return (period == 'PM' && hour != 12 ? hour + 12 : hour) * 60 + minute;
  }
}