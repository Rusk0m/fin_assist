import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
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
      body: Center(
        child: Text('Analytics page'),
      ),
    );
  }
}
