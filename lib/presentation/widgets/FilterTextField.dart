import 'package:flutter/material.dart';

class FilterTextField extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;

  FilterTextField({required this.hint, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300)
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        onChanged: onChanged,
      ),
      height: 40,
    );
  }
}