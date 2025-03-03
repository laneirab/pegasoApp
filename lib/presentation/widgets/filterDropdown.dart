import 'package:flutter/material.dart';

class FilterDropdown extends StatelessWidget {
  final String hint;

  FilterDropdown({required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hint, style: TextStyle(color: Colors.grey)),
          Icon(Icons.arrow_drop_down, color: Colors.grey)
        ],
      ),
      height: 40,
    );
  }
}