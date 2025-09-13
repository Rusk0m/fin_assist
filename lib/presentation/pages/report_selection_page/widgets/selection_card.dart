import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SelectionCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Text(title, style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }
}
