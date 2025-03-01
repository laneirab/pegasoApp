import 'package:flutter/material.dart';
import '../widgets/headerCalendar.dart';
import '../widgets/tabCalendar.dart';
import '../widgets/fotoUsuario.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 45),
            child: Fotousuario(
              imageUrl: "https://i.pinimg.com/736x/b1/a6/1e/b1a61e29eaa57410058f1d671931f7a4.jpg",
            ),
          ),

          FechaActual(),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD3AAFB),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  TabSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
