import 'package:flutter/material.dart';

class SelectionTitle extends StatelessWidget {
  final String title;
  final String selection;
  final VoidCallback onTap;

  const SelectionTitle({
    super.key,
    required this.title,
    required this.selection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: [
                    TextSpan(
                      text: "$title: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: selection, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5),
            IconButton(onPressed: () => onTap(), icon: Icon(Icons.edit)),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
