import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';

class FechaActual extends StatefulWidget {
  @override
  _FechaActualState createState() => _FechaActualState();
}

class _FechaActualState extends State<FechaActual> {
  final CalendarWeekController _calendarController = CalendarWeekController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          DateFormat.yMMMM().format(DateTime.now()),
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),

        SizedBox(
          height: 120,
          child: CalendarWeek(
            controller: _calendarController,
            height: 100,
            minDate: DateTime.now().subtract(Duration(days: 365)),
            maxDate: DateTime.now().add(Duration(days: 365)),
            dayOfWeekStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            todayDateStyle: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            dateStyle: TextStyle(color: Colors.black),
            pressedDateBackgroundColor: Colors.purple,
            pressedDateStyle: TextStyle(color: Colors.white),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
