import 'package:flutter/material.dart';

class ReportListPage extends StatelessWidget {
  const ReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/settings_page');
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBar(),
          Expanded(child: ListView()),
        ],
      ),
    );
  }
}
