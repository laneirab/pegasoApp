import 'package:flutter/material.dart';

class Fotousuario extends StatelessWidget {
  final String imageUrl;

  Fotousuario({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
      Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: Colors.purple),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.4),
            blurRadius: 9,
            spreadRadius: 9,
          ),
        ],
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
      ),
      ),
      Positioned(
          top: -12,
          right: -9,
          child: Transform.rotate(
            angle: 0.6,
            child: Icon(
              Icons.school,
              color: Colors.black45,
              size: 25,
          ),
        ),
      ),
      ],
    );
  }
}
