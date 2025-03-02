import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  FloatingActionButtonWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 30,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Icon(Icons.add),
      ),
    );
  }
}
